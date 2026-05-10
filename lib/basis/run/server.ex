defmodule Basis.Run.Server do
  @moduledoc """
  Live run owner for LLM reducer orchestration.

  This process owns run state, context packets, job lifecycle, server-side
  actions, and the event stream exposed to the browser. It does not accept
  reducer semantics; all lens output remains proposal evidence.
  """

  use GenServer

  alias Basis.LLM.{ContextPacket, LensSpec}

  @terminal_statuses MapSet.new(["completed", "failed", "stopped"])
  @retained_event_tail 800
  @projection_event_tail 250
  @projection_stream_tail 80
  @projection_result_text_limit 8_000
  @projection_raw_limit 2_000
  @projection_tool_raw_limit 16_000

  defstruct run_id: nil,
            mode: "reducer",
            status: "idle",
            provider: nil,
            source: nil,
            targets: [],
            reasoning_effort: "low",
            implementation_target: nil,
            sections: [],
            section_limit: 4,
            max_concurrency: 10,
            branch_count: 3,
            max_depth: 4,
            focused_branch: nil,
            steering_notes: [],
            rejected_paths: [],
            events: [],
            next_event: 1,
            next_job: 1,
            jobs: [],
            results: %{},
            streams: %{},
            subscribers: MapSet.new(),
            started_at: nil,
            updated_at: nil

  def start_link(_opts), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def snapshot, do: GenServer.call(__MODULE__, :snapshot)
  def subscribe, do: GenServer.call(__MODULE__, {:subscribe, self()})
  def start_run(opts), do: GenServer.call(__MODULE__, {:start_run, opts}, 30_000)
  def action(action), do: GenServer.call(__MODULE__, {:action, action}, 30_000)

  @impl true
  def init(_opts), do: {:ok, %__MODULE__{provider: provider_name(provider_module())}}

  @impl true
  def handle_call(:snapshot, _from, state), do: {:reply, projection(state), state}

  def handle_call({:subscribe, pid}, _from, state) do
    Process.monitor(pid)
    {:reply, projection(state), %{state | subscribers: MapSet.put(state.subscribers, pid)}}
  end

  def handle_call({:start_run, opts}, _from, old_state) do
    stop_existing_jobs(old_state)

    state =
      case Map.get(opts, "mode", "reducer") do
        "imaginer" -> start_imaginer_state(opts)
        _ -> start_reducer_state(opts)
      end
      |> carry_runtime_channels(old_state)

    state =
      append_event(
        state,
        "thread_pool_started",
        "system",
        "Started isolated Codex thread pool for this source.",
        %{
          source_path: Map.get(state.source || %{}, :path),
          target_projections: state.targets,
          model_effort: state.reasoning_effort
        }
      )

    {:reply, projection(state), schedule_jobs(state)}
  rescue
    exception ->
      state =
        %__MODULE__{
          provider: provider_name(provider_module()),
          subscribers: old_state.subscribers
        }
        |> append_event("run_start_failed", "system", Exception.message(exception), %{})

      {:reply, projection(state), state}
  end

  def handle_call({:action, action}, _from, state) do
    {reply, state} = apply_action(state, action)
    {:reply, projection(reply), schedule_jobs(state)}
  end

  defp start_reducer_state(opts) do
    source_path = Map.get(opts, "source_path", "components/spec-basis-reducer/spec.md")
    targets = normalize_targets(Map.get(opts, "targets", ["code", "schema", "proof", "runbook"]))

    reasoning_effort =
      normalize_model_effort(
        Map.get(opts, "model_effort", Map.get(opts, "reasoning_effort", "low"))
      )

    section_limit = opts |> Map.get("section_limit", 4) |> clamp_integer(1, 24)
    max_concurrency = opts |> Map.get("max_concurrency", 10) |> clamp_integer(1, 10)
    source = Basis.Source.read!(source_path)
    sections = Enum.take(source.sections, section_limit)
    run_id = "run-#{System.system_time(:millisecond)}"
    provider = provider_module()

    root_job =
      build_root_job(%{
        run_id: run_id,
        job_number: 1,
        source: source,
        targets: targets,
        model_effort: reasoning_effort
      })

    %__MODULE__{
      run_id: run_id,
      mode: "reducer",
      status: "running",
      provider: provider_name(provider),
      source: Map.take(source, [:path, :hash, :line_count]),
      targets: targets,
      reasoning_effort: reasoning_effort,
      sections: Enum.map(sections, &Map.delete(&1, :text)),
      section_limit: section_limit,
      max_concurrency: max_concurrency,
      next_job: 2,
      jobs: [root_job],
      started_at: Basis.Run.Clock.now(),
      updated_at: Basis.Run.Clock.now()
    }
    |> append_event("run_started", "system", "Started live LLM reducer run.", %{
      mode: "reducer",
      source_path: source.path,
      source_hash: source.hash,
      target_projections: targets,
      model_effort: reasoning_effort,
      provider: provider_name(provider)
    })
    |> append_event("source_loaded", "system", "Loaded source and source topology.", %{
      line_count: source.line_count,
      section_count: length(source.sections),
      scheduled_sections: length(sections)
    })
    |> append_event("lens_queued", "orchestrator", "Queued root read lens.", %{
      job_id: root_job.id
    })
  end

  defp start_imaginer_state(opts) do
    source_path = Map.get(opts, "source_path", "components/implementation-imaginer/spec.md")
    targets = normalize_targets(Map.get(opts, "targets", ["implementation_plan"]))
    implementation_target = implementation_target(opts)
    section_limit = opts |> Map.get("section_limit", 4) |> clamp_integer(1, 24)
    max_concurrency = opts |> Map.get("max_concurrency", 2) |> clamp_integer(1, 8)
    branch_count = opts |> Map.get("branch_count", 3) |> clamp_integer(1, 6)
    max_depth = opts |> Map.get("max_depth", 4) |> clamp_integer(1, 6)
    source = Basis.Source.read!(source_path)
    sections = Enum.take(source.sections, section_limit)
    run_id = "imaginer-#{System.system_time(:millisecond)}"
    provider = provider_module()

    decision_job =
      build_imaginer_decision_mining_job(%{
        run_id: run_id,
        job_number: 1,
        source: source,
        targets: targets,
        implementation_target: implementation_target
      })

    baseline_job =
      build_imaginer_baseline_job(%{
        run_id: run_id,
        job_number: 2,
        source: source,
        targets: targets,
        implementation_target: implementation_target
      })

    %__MODULE__{
      run_id: run_id,
      mode: "imaginer",
      status: "running",
      provider: provider_name(provider),
      source: Map.take(source, [:path, :hash, :line_count]),
      targets: targets,
      implementation_target: implementation_target,
      sections: Enum.map(sections, &Map.delete(&1, :text)),
      section_limit: section_limit,
      max_concurrency: max_concurrency,
      branch_count: branch_count,
      max_depth: max_depth,
      next_job: 3,
      jobs: [decision_job, baseline_job],
      started_at: Basis.Run.Clock.now(),
      updated_at: Basis.Run.Clock.now()
    }
    |> append_event(
      "imaginer_run_started",
      "system",
      "Started live Implementation Imaginer search.",
      %{
        mode: "imaginer",
        source_path: source.path,
        source_hash: source.hash,
        target_projections: targets,
        implementation_target: implementation_target,
        provider: provider_name(provider),
        branch_count: branch_count,
        max_depth: max_depth
      }
    )
    |> append_event("source_loaded", "system", "Loaded source and source topology.", %{
      line_count: source.line_count,
      section_count: length(source.sections),
      scheduled_sections: length(sections)
    })
    |> append_event(
      "decision_mining_queued",
      "orchestrator",
      "Queued decision-space mining lens.",
      %{
        job_id: decision_job.id
      }
    )
    |> append_event("baseline_queued", "orchestrator", "Queued ordinary-plan baseline lens.", %{
      job_id: baseline_job.id
    })
  end

  @impl true
  def handle_cast({:provider_stream, job_id, stream}, state) do
    stream =
      stream
      |> Map.put(:job_id, job_id)
      |> Map.put_new(:id, "stream-#{System.unique_integer([:positive])}")

    state =
      state
      |> update_stream(job_id, stream)
      |> maybe_attach_thread(job_id, stream)
      |> append_event(
        "codex_thread_stream",
        "provider",
        Map.get(stream, :summary, "Codex stream event."),
        %{
          job_id: job_id,
          provider_type: Map.get(stream, :type),
          thread_id: Map.get(stream, :thread_id),
          turn_id: Map.get(stream, :turn_id),
          raw: Map.get(stream, :raw)
        }
      )

    {:noreply, state}
  end

  @impl true
  def handle_info({ref, {:ok, result}}, state) do
    Process.demonitor(ref, [:flush])
    {:noreply, complete_job(state, ref, "completed", result) |> schedule_jobs()}
  end

  def handle_info({ref, {:error, result}}, state) do
    Process.demonitor(ref, [:flush])
    {:noreply, complete_job(state, ref, "failed", result) |> schedule_jobs()}
  end

  def handle_info({:DOWN, ref, :process, _pid, reason}, state) do
    if Enum.any?(state.jobs, &(&1.task_ref == ref)) do
      {:noreply,
       complete_job(state, ref, "failed", %{
         provider: state.provider,
         provider_status: "failed",
         error: inspect(reason),
         raw_text: "",
         console_excerpt: "",
         summary: "Lens process exited before returning a result.",
         findings: [],
         proposed_records: [],
         questions: []
       })
       |> schedule_jobs()}
    else
      {:noreply, state}
    end
  end

  defp apply_action(state, %{"type" => "pause"}) do
    state =
      state
      |> Map.put(:status, "paused")
      |> append_event("run_paused", "human", "Paused run scheduling.", %{})

    {state, state}
  end

  defp apply_action(state, %{"type" => "resume"}) do
    state =
      state
      |> Map.put(:status, "running")
      |> append_event("run_resumed", "human", "Resumed run scheduling.", %{})

    {state, state}
  end

  defp apply_action(state, %{"type" => "stop_lens", "job_id" => job_id}) do
    state = update_job(state, job_id, fn job -> stop_job(job) end)

    state =
      append_event(
        state,
        "lens_stop_requested",
        "human",
        "Stopped or cancelled lens job #{job_id}.",
        %{
          job_id: job_id
        }
      )

    {state, state}
  end

  defp apply_action(state, %{"type" => "rerun_lens", "job_id" => job_id}) do
    case Enum.find(state.jobs, &(&1.id == job_id)) do
      nil ->
        state =
          append_event(state, "action_rejected", "system", "Unknown lens job #{job_id}.", %{})

        {state, state}

      job ->
        {rerun, state} = rerun_job(state, job)

        state =
          append_event(
            state,
            "lens_rerun_queued",
            "human",
            "Queued rerun #{rerun.id} for #{job_id}.",
            %{
              original_job_id: job_id,
              job_id: rerun.id
            }
          )

        {state, state}
    end
  end

  defp apply_action(state, %{"type" => "request_synthesis"} = action) do
    {state, queued?} =
      if state.mode == "imaginer" do
        enqueue_imaginer_synthesis(state, true)
      else
        enqueue_synthesis(state, true)
      end

    subject_kind = Map.get(action, "subject_kind", "run")
    subject_id = Map.get(action, "subject_id", state.run_id)
    body = action |> Map.get("body", "") |> to_string() |> String.slice(0, 1_000)

    state =
      append_event(
        state,
        "synthesis_requested",
        "human",
        if(queued?,
          do: "Queued synthesis lens.",
          else: "Synthesis lens was already queued or running."
        ),
        %{
          subject_kind: subject_kind,
          subject_id: subject_id,
          body: body
        }
      )

    {state, state}
  end

  defp apply_action(state, %{"type" => "line_feedback"} = action) do
    state =
      append_event(
        state,
        "human_line_feedback",
        "human",
        action |> Map.get("body", "") |> to_string() |> String.slice(0, 1_000),
        %{
          mode: Map.get(action, "mode", "additive"),
          section_id: Map.get(action, "section_id"),
          line_number: action |> Map.get("line_number") |> to_integer_or_nil(),
          source_text: Map.get(action, "source_text", ""),
          preview_effect:
            action |> Map.get("preview_effect", "") |> to_string() |> String.slice(0, 1_000),
          feedback_kind: Map.get(action, "feedback_kind", "guidance"),
          target_projection: normalize_targets(Map.get(action, "target_projection", []))
        }
      )

    {state, state}
  end

  defp apply_action(
         %{mode: "imaginer"} = state,
         %{"type" => "steer_search", "body" => body} = action
       ) do
    note = %{
      id: "steer-#{length(state.steering_notes) + 1}",
      body: String.slice(to_string(body), 0, 1_000),
      branch_id: Map.get(action, "branch_id"),
      subject_id: Map.get(action, "subject_id"),
      timestamp: Basis.Run.Clock.now()
    }

    state =
      %{state | steering_notes: state.steering_notes ++ [note]}
      |> append_event("search_steering_added", "human", note.body, %{
        note_id: note.id,
        branch_id: note.branch_id,
        subject_id: note.subject_id
      })

    {state, state}
  end

  defp apply_action(%{mode: "imaginer"} = state, %{"type" => "queue_imaginer_branch"} = action) do
    bias_title =
      action
      |> Map.get("title", "Human-Steered Branch")
      |> to_string()
      |> String.slice(0, 120)

    bias_stance =
      action
      |> Map.get(
        "body",
        "Follow the latest human steering note while preserving Basis boundaries."
      )
      |> to_string()
      |> String.slice(0, 1_000)

    branch_index =
      state.jobs
      |> Enum.map(&Map.get(&1, :branch_id))
      |> Enum.reject(&is_nil/1)
      |> Enum.uniq()
      |> length()
      |> Kernel.+(1)

    bias = %{id: "branch-human-#{branch_index}", title: bias_title, stance: bias_stance}

    {job, state} =
      enqueue_imaginer_engineer(state, %{
        branch_id: bias.id,
        depth: 1,
        bias: bias,
        parent_world_id: nil,
        prior_result_refs: []
      })

    state =
      state
      |> Map.put(:branch_count, max(state.branch_count, branch_index))
      |> Map.put(:focused_branch, bias.id)
      |> append_event(
        "candidate_path_queued",
        "human",
        "Queued human-steered imaginer branch.",
        %{
          branch_id: bias.id,
          job_id: job.id,
          bias_title: bias.title
        }
      )

    {state, state}
  end

  defp apply_action(%{mode: "imaginer"} = state, %{
         "type" => "focus_branch",
         "branch_id" => branch_id
       }) do
    state =
      state
      |> Map.put(:focused_branch, branch_id)
      |> append_event("branch_focused", "human", "Focused branch #{branch_id}.", %{
        branch_id: branch_id
      })

    {state, state}
  end

  defp apply_action(%{mode: "imaginer"} = state, %{"type" => "reject_path"} = action) do
    rejected = %{
      id: "rejected-path-#{length(state.rejected_paths) + 1}",
      branch_id: Map.get(action, "branch_id"),
      reason:
        action
        |> Map.get("body", "Rejected by human steering.")
        |> to_string()
        |> String.slice(0, 1_000),
      timestamp: Basis.Run.Clock.now()
    }

    state =
      %{state | rejected_paths: state.rejected_paths ++ [rejected]}
      |> append_event("path_rejected", "human", rejected.reason, %{
        rejected_path_id: rejected.id,
        branch_id: rejected.branch_id
      })

    {state, state}
  end

  defp apply_action(state, %{"type" => "note", "body" => body} = action) do
    state =
      append_event(state, "human_note", "human", String.slice(to_string(body), 0, 1_000), %{
        subject_kind: Map.get(action, "subject_kind", "run"),
        subject_id: Map.get(action, "subject_id", state.run_id)
      })

    {state, state}
  end

  defp apply_action(state, %{"type" => decision, "record_id" => record_id})
       when decision in ["accept_record", "reject_record", "defer_record"] do
    state =
      append_event(state, "human_record_decision", "human", "#{decision} #{record_id}.", %{
        decision: decision,
        record_id: record_id
      })

    {state, state}
  end

  defp apply_action(state, %{"type" => "pressure_decision", "decision" => decision} = action)
       when decision in [
              "keep_pressure",
              "defer_pressure",
              "reject_pressure",
              "merge_pressure"
            ] do
    subject_id = Map.get(action, "subject_id", "pressure")

    state =
      append_event(state, "human_pressure_decision", "human", "#{decision} #{subject_id}.", %{
        decision: decision,
        subject_kind: Map.get(action, "subject_kind", "semantic_row"),
        subject_id: subject_id,
        body: action |> Map.get("body", "") |> to_string() |> String.slice(0, 1_000)
      })

    {state, state}
  end

  defp apply_action(state, action) do
    state =
      append_event(state, "action_rejected", "system", "Unsupported action.", %{
        action: action
      })

    {state, state}
  end

  defp schedule_jobs(%__MODULE__{status: status} = state) when status != "running", do: state

  defp schedule_jobs(state) do
    running = Enum.count(state.jobs, &(&1.status == "running"))
    available = max(state.max_concurrency - running, 0)

    if available == 0 do
      state
    else
      queued =
        state.jobs
        |> Enum.filter(&(&1.status == "queued"))
        |> queue_architecture_state_lenses_last()
        |> Enum.take(available)

      Enum.reduce(queued, state, &start_job/2)
    end
  end

  defp queue_architecture_state_lenses_last(jobs) do
    {architecture, primary} =
      Enum.split_with(jobs, &(&1.kind == "imaginer_architecture_state"))

    primary ++ architecture
  end

  defp start_job(job, state) do
    provider = provider_module()

    task =
      Task.Supervisor.async_nolink(Basis.LLM.TaskSupervisor, fn ->
        provider.complete(job.context_packet, fn stream ->
          GenServer.cast(__MODULE__, {:provider_stream, job.id, stream})
        end)
      end)

    now = Basis.Run.Clock.now()

    state
    |> update_job(job.id, fn existing ->
      %{
        existing
        | status: "running",
          task_ref: task.ref,
          task_pid: task.pid,
          started_at: now,
          provider: provider_name(provider)
      }
    end)
    |> append_event("lens_started", "orchestrator", "Started #{job.lens_role}.", %{
      job_id: job.id,
      lens_role: job.lens_role,
      provider: provider_name(provider),
      context_packet_id: job.context_packet.id
    })
  end

  defp complete_job(state, ref, status, result) do
    case Enum.find(state.jobs, &(&1.task_ref == ref)) do
      nil ->
        state

      job ->
        result_id = "result-#{job.id}"
        result = normalize_result(result, job, result_id)

        state
        |> update_job(job.id, fn existing ->
          %{
            existing
            | status: status,
              task_ref: nil,
              task_pid: nil,
              completed_at: Basis.Run.Clock.now(),
              result_id: result_id,
              error: if(status == "failed", do: Map.get(result, :error), else: nil)
          }
        end)
        |> put_in([Access.key(:results), result_id], result)
        |> append_event(
          if(status == "completed", do: "lens_completed", else: "lens_failed"),
          "orchestrator",
          "#{job.lens_role} #{status}.",
          %{
            job_id: job.id,
            lens_role: job.lens_role,
            result_id: result_id,
            summary: result.summary,
            error: Map.get(result, :error)
          }
        )
        |> maybe_enqueue_after_job(job, status)
        |> maybe_finalize_run()
    end
  end

  defp maybe_enqueue_after_job(%{mode: "imaginer"} = state, job, status) do
    state
    |> maybe_enqueue_imaginer_jobs(job, status)
    |> maybe_enqueue_architecture_state_jobs()
    |> then(fn state ->
      {state, _queued?} = maybe_enqueue_imaginer_synthesis(state, false)
      state
    end)
  end

  defp maybe_enqueue_after_job(state, job, status) do
    state
    |> maybe_enqueue_section_jobs(job, status)
    |> maybe_enqueue_synthesis()
  end

  defp maybe_enqueue_section_jobs(state, %{kind: "root_read"}, "completed") do
    if Enum.any?(state.jobs, &(&1.kind == "section_lens")) do
      state
    else
      source = Basis.Source.read!(state.source.path)
      selected_sections = Enum.take(source.sections, state.section_limit)

      {jobs, next_job} =
        selected_sections
        |> Enum.flat_map(fn section ->
          LensSpec.section_lenses()
          |> Enum.map(fn lens -> {section, lens} end)
        end)
        |> Enum.map_reduce(state.next_job, fn {section, lens}, next ->
          job =
            build_section_job(%{
              run_id: state.run_id,
              job_number: next,
              source: source,
              section: section,
              lens: lens,
              targets: state.targets,
              model_effort: state.reasoning_effort
            })

          {job, next + 1}
        end)

      Enum.reduce(jobs, %{state | next_job: next_job, jobs: state.jobs ++ jobs}, fn job, acc ->
        append_event(acc, "lens_queued", "orchestrator", "Queued #{job.lens_role}.", %{
          job_id: job.id,
          lens_role: job.lens_role,
          section_id: job.section_id
        })
      end)
    end
  end

  defp maybe_enqueue_section_jobs(state, _job, _status), do: state

  defp maybe_enqueue_synthesis(state) do
    section_jobs = Enum.filter(state.jobs, &(&1.kind == "section_lens"))

    if section_jobs != [] and
         Enum.all?(section_jobs, &MapSet.member?(@terminal_statuses, &1.status)) do
      {state, _queued?} = enqueue_synthesis(state, false)
      state
    else
      state
    end
  end

  defp enqueue_synthesis(state, forced?) do
    existing =
      if forced? do
        Enum.any?(
          state.jobs,
          &(&1.kind == "synthesis_lens" and &1.status in ["queued", "running"])
        )
      else
        Enum.any?(state.jobs, &(&1.kind == "synthesis_lens"))
      end

    if existing do
      {state, false}
    else
      source = Basis.Source.read!(state.source.path)

      completed_results =
        state.results
        |> Map.values()
        |> Enum.filter(&(&1.status == "completed"))

      if completed_results == [] and not forced? do
        {state, false}
      else
        job =
          build_synthesis_job(%{
            run_id: state.run_id,
            job_number: state.next_job,
            source: source,
            targets: state.targets,
            results: completed_results,
            forced?: forced?,
            model_effort: state.reasoning_effort
          })

        state =
          %{state | jobs: state.jobs ++ [job], next_job: state.next_job + 1}
          |> append_event("lens_queued", "orchestrator", "Queued synthesis lens.", %{
            job_id: job.id,
            forced: forced?
          })

        {state, true}
      end
    end
  end

  defp maybe_enqueue_imaginer_jobs(state, _job, _status) do
    cond do
      ready_for_initial_branches?(state) ->
        enqueue_initial_imaginer_branches(state)

      true ->
        state
        |> maybe_enqueue_reality_after_engineer()
        |> maybe_enqueue_next_engineer_after_reality()
    end
  end

  defp ready_for_initial_branches?(state) do
    init_jobs =
      Enum.filter(state.jobs, &(&1.kind in ["imaginer_decision_mining", "imaginer_baseline"]))

    branch_jobs = Enum.filter(state.jobs, &String.starts_with?(&1.kind, "imaginer_branch_"))

    length(init_jobs) == 2 and branch_jobs == [] and
      Enum.all?(init_jobs, &MapSet.member?(@terminal_statuses, &1.status))
  end

  defp enqueue_initial_imaginer_branches(state) do
    profiles = Enum.take(LensSpec.imaginer_bias_profiles(), state.branch_count)

    Enum.reduce(profiles, state, fn bias, acc ->
      {job, acc} =
        enqueue_imaginer_engineer(acc, %{
          branch_id: bias.id,
          depth: 1,
          bias: bias,
          parent_world_id: nil,
          prior_result_refs: completed_init_result_refs(acc)
        })

      append_event(acc, "candidate_path_queued", "orchestrator", "Queued #{bias.title}.", %{
        branch_id: bias.id,
        job_id: job.id,
        bias_title: bias.title
      })
    end)
  end

  defp maybe_enqueue_reality_after_engineer(state) do
    completed_engineers =
      state.jobs
      |> Enum.filter(&(&1.kind == "imaginer_branch_engineer" and &1.status == "completed"))
      |> Enum.reject(fn engineer ->
        Enum.any?(
          state.jobs,
          &(&1.kind == "imaginer_branch_reality" and &1.branch_id == engineer.branch_id and
              &1.depth == engineer.depth)
        )
      end)

    Enum.reduce(completed_engineers, state, fn engineer, acc ->
      bias = engineer.bias_profile || bias_profile_for(engineer.branch_id)

      {job, acc} =
        enqueue_imaginer_reality(acc, %{
          branch_id: engineer.branch_id,
          depth: engineer.depth,
          bias: bias,
          parent_world_id: engineer.world_id,
          prior_result_refs: [engineer.result_id]
        })

      append_event(acc, "reality_check_queued", "orchestrator", "Queued Reality check.", %{
        branch_id: engineer.branch_id,
        depth: engineer.depth,
        job_id: job.id,
        engineer_job_id: engineer.id
      })
    end)
  end

  defp maybe_enqueue_next_engineer_after_reality(state) do
    completed_reality =
      state.jobs
      |> Enum.filter(&(&1.kind == "imaginer_branch_reality" and &1.status == "completed"))
      |> Enum.reject(fn reality ->
        reality.depth >= state.max_depth or
          Enum.any?(
            state.jobs,
            &(&1.kind == "imaginer_branch_engineer" and &1.branch_id == reality.branch_id and
                &1.depth == reality.depth + 1)
          )
      end)

    Enum.reduce(completed_reality, state, fn reality, acc ->
      bias = reality.bias_profile || bias_profile_for(reality.branch_id)

      {job, acc} =
        enqueue_imaginer_engineer(acc, %{
          branch_id: reality.branch_id,
          depth: reality.depth + 1,
          bias: bias,
          parent_world_id: reality.world_id,
          prior_result_refs: [reality.result_id]
        })

      append_event(acc, "engineer_move_queued", "orchestrator", "Queued next Engineer move.", %{
        branch_id: reality.branch_id,
        depth: reality.depth + 1,
        job_id: job.id,
        reality_job_id: reality.id
      })
    end)
  end

  defp maybe_enqueue_imaginer_synthesis(state, forced?) do
    existing =
      if forced? do
        Enum.any?(
          state.jobs,
          &(&1.kind == "imaginer_synthesis" and &1.status in ["queued", "running"])
        )
      else
        Enum.any?(state.jobs, &(&1.kind == "imaginer_synthesis"))
      end

    branch_jobs = Enum.filter(state.jobs, &String.starts_with?(&1.kind, "imaginer_branch_"))
    active_branch_jobs = Enum.filter(branch_jobs, &(&1.status in ["queued", "running"]))

    cond do
      existing ->
        {state, false}

      forced? or (branch_jobs != [] and active_branch_jobs == []) ->
        enqueue_imaginer_synthesis_job(state, forced?)

      true ->
        {state, false}
    end
  end

  defp enqueue_imaginer_synthesis(state, forced?) do
    maybe_enqueue_imaginer_synthesis(state, forced?)
  end

  defp enqueue_imaginer_synthesis_job(state, forced?) do
    source = Basis.Source.read!(state.source.path)

    completed_results =
      state.results
      |> Map.values()
      |> Enum.filter(&(&1.status == "completed"))

    job =
      build_imaginer_synthesis_job(%{
        run_id: state.run_id,
        job_number: state.next_job,
        source: source,
        targets: state.targets,
        implementation_target: state.implementation_target,
        results: completed_results,
        forced?: forced?,
        steering_notes: render_steering_notes(state, nil)
      })

    state =
      %{state | jobs: state.jobs ++ [job], next_job: state.next_job + 1}
      |> append_event(
        "plan_synthesis_queued",
        "orchestrator",
        "Queued imaginer synthesis lens.",
        %{
          job_id: job.id,
          forced: forced?
        }
      )

    {state, true}
  end

  defp maybe_enqueue_architecture_state_jobs(state) do
    subjects =
      state.jobs
      |> Enum.filter(&architecture_state_subject?/1)
      |> Enum.reject(&architecture_state_job_exists?(state, &1.id))

    case subjects do
      [] ->
        state

      _ ->
        source = Basis.Source.read!(state.source.path)

        Enum.reduce(subjects, state, fn subject, acc ->
          enqueue_imaginer_architecture_state(acc, source, subject)
        end)
    end
  end

  defp architecture_state_subject?(job) do
    job.status == "completed" and is_binary(job.result_id) and
      job.kind in [
        "imaginer_decision_mining",
        "imaginer_baseline",
        "imaginer_branch_engineer",
        "imaginer_branch_reality",
        "imaginer_synthesis"
      ]
  end

  defp architecture_state_job_exists?(state, subject_job_id) do
    Enum.any?(
      state.jobs,
      &(&1.kind == "imaginer_architecture_state" and
          Map.get(&1, :architecture_subject_job_id) == subject_job_id)
    )
  end

  defp enqueue_imaginer_architecture_state(state, source, subject_job) do
    subject_result = Map.fetch!(state.results, subject_job.result_id)

    job =
      build_imaginer_architecture_state_job(%{
        run_id: state.run_id,
        job_number: state.next_job,
        source: source,
        targets: state.targets,
        implementation_target: state.implementation_target,
        subject_job: subject_job,
        subject_result: subject_result
      })

    %{state | jobs: state.jobs ++ [job], next_job: state.next_job + 1}
    |> append_event(
      "architecture_state_queued",
      "orchestrator",
      "Queued low-effort architecture state projection.",
      %{
        job_id: job.id,
        subject_job_id: subject_job.id,
        subject_lens_role: subject_job.lens_role
      }
    )
  end

  defp maybe_finalize_run(%{status: "running"} = state) do
    jobs = state.jobs

    if jobs != [] and Enum.all?(jobs, &MapSet.member?(@terminal_statuses, &1.status)) do
      %{state | status: "complete", updated_at: Basis.Run.Clock.now()}
    else
      state
    end
  end

  defp maybe_finalize_run(state), do: state

  defp build_root_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "root_read",
        lens_role: "root_orientation_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt: LensSpec.root_prompt(attrs.source, attrs.targets),
        source_excerpt: String.slice(attrs.source.text, 0, 24_000),
        prior_result_refs: [],
        excluded_context: ["section-specific conclusions", "sibling section interpretations"],
        budget: %{max_source_chars: 24_000, model_effort: attrs.model_effort}
      })

    base_job(id, "root_read", "root_orientation_lens", "Root Orientation", nil, nil, packet)
  end

  defp build_section_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "section_lens",
        lens_role: attrs.lens.role,
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        section_id: attrs.section.id,
        section_title: attrs.section.title,
        source_range: "#{attrs.section.start_line}-#{attrs.section.end_line}",
        target_projections: attrs.targets,
        prompt: LensSpec.section_prompt(attrs.lens, attrs.source, attrs.section, attrs.targets),
        source_excerpt: attrs.section.text,
        prior_result_refs: ["result-job-0001"],
        excluded_context: ["sibling section conclusions unless supplied by synthesis"],
        budget: %{
          max_source_chars: String.length(attrs.section.text),
          model_effort: attrs.model_effort
        }
      })

    base_job(
      id,
      "section_lens",
      attrs.lens.role,
      attrs.lens.title,
      attrs.section.id,
      attrs.section.title,
      packet
    )
  end

  defp build_synthesis_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "synthesis_lens",
        lens_role: "synthesis_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt: LensSpec.synthesis_prompt(attrs.source, attrs.targets, attrs.results),
        source_excerpt: "",
        prior_result_refs: Enum.map(attrs.results, & &1.id),
        excluded_context: [
          "unstated acceptance decisions",
          "raw sibling context not named in lens results"
        ],
        budget: %{
          completed_result_count: length(attrs.results),
          forced: attrs.forced?,
          model_effort: attrs.model_effort
        }
      })

    base_job(id, "synthesis_lens", "synthesis_lens", "Synthesis", nil, nil, packet)
  end

  defp build_imaginer_decision_mining_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_decision_mining",
        lens_role: "decision_mining_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt:
          LensSpec.imaginer_decision_mining_prompt(
            attrs.source,
            attrs.implementation_target,
            attrs.targets
          ),
        source_excerpt: String.slice(attrs.source.text, 0, 24_000),
        prior_result_refs: [],
        excluded_context: ["unstated acceptance decisions", "raw transcript authority"],
        expected_output_schema: "decision_space_graph_delta",
        budget: %{max_source_chars: 24_000}
      })

    base_job(
      id,
      "imaginer_decision_mining",
      "decision_mining_lens",
      "Decision Mining",
      nil,
      nil,
      packet
    )
  end

  defp build_imaginer_baseline_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_baseline",
        lens_role: "ordinary_plan_baseline_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt:
          LensSpec.imaginer_baseline_prompt(
            attrs.source,
            attrs.implementation_target,
            attrs.targets
          ),
        source_excerpt: String.slice(attrs.source.text, 0, 20_000),
        prior_result_refs: [],
        excluded_context: ["recursive search results", "unstated acceptance decisions"],
        expected_output_schema: "ordinary_plan_baseline",
        budget: %{max_source_chars: 20_000}
      })

    base_job(
      id,
      "imaginer_baseline",
      "ordinary_plan_baseline_lens",
      "Ordinary Baseline",
      nil,
      nil,
      packet
    )
  end

  defp enqueue_imaginer_engineer(state, attrs) do
    source = Basis.Source.read!(state.source.path)
    id = job_id(state.next_job)

    job =
      build_imaginer_engineer_job(
        Map.merge(attrs, %{
          job_number: state.next_job,
          id: id,
          run_id: state.run_id,
          source: source,
          targets: state.targets,
          implementation_target: state.implementation_target,
          steering_notes: render_steering_notes(state, attrs.branch_id)
        })
      )

    {job, %{state | jobs: state.jobs ++ [job], next_job: state.next_job + 1}}
  end

  defp enqueue_imaginer_reality(state, attrs) do
    source = Basis.Source.read!(state.source.path)
    id = job_id(state.next_job)

    job =
      build_imaginer_reality_job(
        Map.merge(attrs, %{
          job_number: state.next_job,
          id: id,
          run_id: state.run_id,
          source: source,
          targets: state.targets,
          implementation_target: state.implementation_target,
          steering_notes: render_steering_notes(state, attrs.branch_id)
        })
      )

    {job, %{state | jobs: state.jobs ++ [job], next_job: state.next_job + 1}}
  end

  defp build_imaginer_engineer_job(attrs) do
    id = job_id(attrs.job_number)
    world_id = world_id(attrs.branch_id, attrs.depth, "engineer")
    packet_id = "ctx-#{id}"
    bias = attrs.bias

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_branch_engineer",
        lens_role: "engineer_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt:
          LensSpec.imaginer_engineer_prompt(attrs.source, %{
            implementation_target: attrs.implementation_target,
            branch_id: attrs.branch_id,
            depth: attrs.depth,
            bias_title: bias.title,
            bias_stance: bias.stance,
            prior_result_refs: attrs.prior_result_refs,
            steering_notes: attrs.steering_notes,
            targets: attrs.targets
          }),
        source_excerpt: String.slice(attrs.source.text, 0, 16_000),
        prior_result_refs: attrs.prior_result_refs,
        excluded_context: ["sibling branch conclusions unless supplied by synthesis"],
        world_id: world_id,
        parent_world_id: attrs.parent_world_id,
        candidate_path_id: attrs.branch_id,
        branch_id: attrs.branch_id,
        depth: attrs.depth,
        search_role: "engineer_lens",
        agent_bias_profile: bias,
        prior_world_refs: Enum.reject([attrs.parent_world_id], &is_nil/1),
        expected_output_schema: "engineer_move_delta",
        budget: %{max_source_chars: 16_000}
      })

    base_job(
      id,
      "imaginer_branch_engineer",
      "engineer_lens",
      "#{bias.title} Engineer d#{attrs.depth}",
      nil,
      nil,
      packet,
      %{
        branch_id: attrs.branch_id,
        branch_title: bias.title,
        depth: attrs.depth,
        world_id: world_id,
        parent_world_id: attrs.parent_world_id,
        search_role: "engineer_lens",
        bias_profile: bias
      }
    )
  end

  defp build_imaginer_reality_job(attrs) do
    id = job_id(attrs.job_number)
    world_id = world_id(attrs.branch_id, attrs.depth, "reality")
    packet_id = "ctx-#{id}"
    bias = attrs.bias

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_branch_reality",
        lens_role: "reality_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt:
          LensSpec.imaginer_reality_prompt(attrs.source, %{
            implementation_target: attrs.implementation_target,
            branch_id: attrs.branch_id,
            depth: attrs.depth,
            bias_title: bias.title,
            prior_result_refs: attrs.prior_result_refs,
            steering_notes: attrs.steering_notes,
            targets: attrs.targets
          }),
        source_excerpt: String.slice(attrs.source.text, 0, 16_000),
        prior_result_refs: attrs.prior_result_refs,
        excluded_context: ["generic skepticism without evidence", "sibling branch conclusions"],
        world_id: world_id,
        parent_world_id: attrs.parent_world_id,
        candidate_path_id: attrs.branch_id,
        branch_id: attrs.branch_id,
        depth: attrs.depth,
        search_role: "reality_lens",
        agent_bias_profile: bias,
        prior_world_refs: Enum.reject([attrs.parent_world_id], &is_nil/1),
        expected_output_schema: "reality_check_delta",
        budget: %{max_source_chars: 16_000}
      })

    base_job(
      id,
      "imaginer_branch_reality",
      "reality_lens",
      "#{bias.title} Reality d#{attrs.depth}",
      nil,
      nil,
      packet,
      %{
        branch_id: attrs.branch_id,
        branch_title: bias.title,
        depth: attrs.depth,
        world_id: world_id,
        parent_world_id: attrs.parent_world_id,
        search_role: "reality_lens",
        bias_profile: bias
      }
    )
  end

  defp build_imaginer_synthesis_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_synthesis",
        lens_role: "imaginer_synthesis_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: attrs.targets,
        prompt:
          LensSpec.imaginer_synthesis_prompt(
            attrs.source,
            attrs.implementation_target,
            attrs.targets,
            attrs.results,
            attrs.steering_notes
          ),
        source_excerpt: "",
        prior_result_refs: Enum.map(attrs.results, & &1.id),
        excluded_context: ["unstated acceptance decisions", "prose compression without records"],
        expected_output_schema: "implementation_plan_packet_delta",
        budget: %{completed_result_count: length(attrs.results), forced: attrs.forced?}
      })

    base_job(
      id,
      "imaginer_synthesis",
      "imaginer_synthesis_lens",
      "Plan Synthesis",
      nil,
      nil,
      packet
    )
  end

  defp build_imaginer_architecture_state_job(attrs) do
    id = job_id(attrs.job_number)
    packet_id = "ctx-#{id}"
    subject = attrs.subject_job

    packet =
      ContextPacket.new(%{
        id: packet_id,
        run_id: attrs.run_id,
        job_id: id,
        kind: "imaginer_architecture_state",
        lens_role: "architecture_state_lens",
        source_path: attrs.source.path,
        source_hash: attrs.source.hash,
        source_range: "1-#{attrs.source.line_count}",
        target_projections: Enum.uniq(attrs.targets ++ ["architecture_state_diagram"]),
        prompt:
          LensSpec.imaginer_architecture_state_prompt(attrs.source, %{
            implementation_target: attrs.implementation_target,
            targets: attrs.targets,
            subject_job: subject,
            subject_result: attrs.subject_result
          }),
        source_excerpt: "",
        prior_result_refs: [attrs.subject_result.id],
        excluded_context: ["new decisions", "search deepening", "accepted state mutation"],
        world_id: Map.get(subject, :world_id),
        parent_world_id: Map.get(subject, :parent_world_id),
        candidate_path_id: Map.get(subject, :branch_id),
        branch_id: Map.get(subject, :branch_id),
        depth: Map.get(subject, :depth),
        search_role: "architecture_state_lens",
        agent_bias_profile: Map.get(subject, :bias_profile),
        prior_world_refs: Enum.reject([Map.get(subject, :world_id)], &is_nil/1),
        expected_output_schema: "architecture_state_projection_delta",
        budget: %{
          completed_result_count: 1,
          model_effort: "low",
          architecture_subject_job_id: subject.id,
          source_lens_role: subject.lens_role
        }
      })

    base_job(
      id,
      "imaginer_architecture_state",
      "architecture_state_lens",
      "Name Architecture State From #{subject.title || subject.lens_role}",
      nil,
      nil,
      packet,
      %{
        branch_id: Map.get(subject, :branch_id),
        branch_title: Map.get(subject, :branch_title),
        depth: Map.get(subject, :depth),
        world_id: Map.get(subject, :world_id),
        parent_world_id: Map.get(subject, :parent_world_id),
        search_role: "architecture_state_lens",
        architecture_subject_job_id: subject.id,
        architecture_subject_result_id: attrs.subject_result.id,
        architecture_subject_lens_role: subject.lens_role
      }
    )
  end

  defp base_job(id, kind, lens_role, title, section_id, section_title, packet, extra \\ %{}) do
    %{
      id: id,
      kind: kind,
      lens_role: lens_role,
      title: title,
      section_id: section_id,
      section_title: section_title,
      status: "queued",
      attempt: 1,
      provider: nil,
      task_ref: nil,
      task_pid: nil,
      context_packet: packet,
      codex_thread_id: nil,
      codex_thread_url: nil,
      codex_turn_id: nil,
      queued_at: Basis.Run.Clock.now(),
      started_at: nil,
      completed_at: nil,
      result_id: nil,
      error: nil
    }
    |> Map.merge(extra)
  end

  defp rerun_job(state, job) do
    id = job_id(state.next_job)
    packet = %{job.context_packet | id: "ctx-#{id}", job_id: id}

    rerun =
      job
      |> Map.merge(%{
        id: id,
        status: "queued",
        attempt: job.attempt + 1,
        task_ref: nil,
        task_pid: nil,
        context_packet: packet,
        queued_at: Basis.Run.Clock.now(),
        started_at: nil,
        completed_at: nil,
        result_id: nil,
        error: nil,
        codex_thread_id: nil,
        codex_thread_url: nil,
        codex_turn_id: nil,
        rerun_of: job.id
      })

    {rerun, %{state | jobs: state.jobs ++ [rerun], next_job: state.next_job + 1}}
  end

  defp stop_job(%{status: "running", task_pid: pid} = job) when is_pid(pid) do
    Process.exit(pid, :kill)
    %{job | status: "stopped", task_ref: nil, task_pid: nil, completed_at: Basis.Run.Clock.now()}
  end

  defp stop_job(%{status: "queued"} = job),
    do: %{job | status: "stopped", completed_at: Basis.Run.Clock.now()}

  defp stop_job(job), do: job

  defp stop_existing_jobs(%__MODULE__{jobs: jobs}) do
    Enum.each(jobs, &stop_job/1)
  end

  defp carry_runtime_channels(state, old_state) do
    %{state | subscribers: old_state.subscribers}
  end

  defp normalize_result(result, job, result_id) do
    %{
      id: result_id,
      job_id: job.id,
      lens_role: job.lens_role,
      kind: job.kind,
      branch_id: Map.get(job, :branch_id),
      branch_title: Map.get(job, :branch_title),
      depth: Map.get(job, :depth),
      world_id: Map.get(job, :world_id),
      parent_world_id: Map.get(job, :parent_world_id),
      search_role: Map.get(job, :search_role),
      section_id: job.section_id,
      section_title: job.section_title,
      context_packet_id: job.context_packet.id,
      context_hash: job.context_packet.context_hash,
      status: if(Map.get(result, :provider_status) == "failed", do: "failed", else: "completed"),
      provider: Map.get(result, :provider, job.provider),
      provider_status: Map.get(result, :provider_status, "completed"),
      started_at: Map.get(result, :started_at),
      completed_at: Map.get(result, :completed_at),
      summary: Map.get(result, :summary, ""),
      findings: Map.get(result, :findings, []),
      proposed_records: stamp_records(Map.get(result, :proposed_records, []), job, result_id),
      questions: stamp_questions(Map.get(result, :questions, []), job, result_id),
      confidence: Map.get(result, :confidence),
      codex_thread_id: Map.get(result, :codex_thread_id),
      codex_thread_url: Map.get(result, :codex_thread_url),
      codex_turn_id: Map.get(result, :codex_turn_id),
      raw_text: Map.get(result, :raw_text, ""),
      console_excerpt: Map.get(result, :console_excerpt, ""),
      error: Map.get(result, :error)
    }
  end

  defp stamp_records(records, job, result_id) when is_list(records) do
    records
    |> Enum.with_index(1)
    |> Enum.map(fn {record, index} ->
      record
      |> Map.put_new("id", "#{result_id}-record-#{index}")
      |> Map.put("producer_job_id", job.id)
      |> Map.put("producer_lens_role", job.lens_role)
      |> Map.put("branch_id", Map.get(job, :branch_id))
      |> Map.put("depth", Map.get(job, :depth))
      |> Map.put("world_id", Map.get(job, :world_id))
      |> Map.put("section_id", job.section_id)
      |> Map.put("acceptance_boundary", "proposal_not_basis_state")
    end)
  end

  defp stamp_records(_, _job, _result_id), do: []

  defp stamp_questions(questions, job, result_id) when is_list(questions) do
    questions
    |> Enum.with_index(1)
    |> Enum.map(fn {question, index} ->
      question
      |> Map.put_new("id", "#{result_id}-question-#{index}")
      |> Map.put("producer_job_id", job.id)
      |> Map.put("producer_lens_role", job.lens_role)
      |> Map.put("branch_id", Map.get(job, :branch_id))
      |> Map.put("depth", Map.get(job, :depth))
    end)
  end

  defp stamp_questions(_, _job, _result_id), do: []

  defp update_job(state, job_id, fun) do
    %{
      state
      | jobs: Enum.map(state.jobs, fn job -> if job.id == job_id, do: fun.(job), else: job end)
    }
  end

  defp update_stream(state, job_id, stream) do
    streams =
      Map.update(state.streams, job_id, [stream], fn existing ->
        Enum.take(existing ++ [stream], -300)
      end)

    %{state | streams: streams}
  end

  defp maybe_attach_thread(state, job_id, stream) do
    thread_id = Map.get(stream, :thread_id) || Map.get(stream, "thread_id")
    turn_id = Map.get(stream, :turn_id) || Map.get(stream, "turn_id")

    if present?(thread_id) or present?(turn_id) do
      update_job(state, job_id, fn job ->
        resolved_thread_id = present_or_existing(thread_id, job.codex_thread_id)

        %{
          job
          | codex_thread_id: resolved_thread_id,
            codex_thread_url: codex_thread_url(resolved_thread_id),
            codex_turn_id: present_or_existing(turn_id, job.codex_turn_id)
        }
      end)
    else
      state
    end
  end

  defp append_event(state, type, actor, message, payload) do
    event = %{
      id: "evt-#{String.pad_leading(to_string(state.next_event), 6, "0")}",
      type: type,
      actor: actor,
      message: message,
      payload: payload,
      timestamp: Basis.Run.Clock.now()
    }

    state = %{
      state
      | events: retain_events(state.events ++ [event]),
        next_event: state.next_event + 1,
        updated_at: event.timestamp
    }

    Enum.each(state.subscribers, fn pid -> send(pid, {:basis_run_event, event}) end)
    state
  end

  defp projection(state) do
    result_values = Map.values(state.results)
    records = Enum.flat_map(result_values, & &1.proposed_records)
    questions = Enum.flat_map(result_values, & &1.questions)

    %{
      run_id: state.run_id,
      mode: state.mode,
      status: state.status,
      provider: state.provider,
      started_at: state.started_at,
      updated_at: state.updated_at,
      source: state.source,
      target_projections: state.targets,
      reasoning_effort: state.reasoning_effort,
      implementation_target: state.implementation_target,
      section_limit: state.section_limit,
      max_concurrency: state.max_concurrency,
      branch_count: state.branch_count,
      max_depth: state.max_depth,
      focused_branch: state.focused_branch,
      steering_notes: state.steering_notes,
      rejected_paths: state.rejected_paths,
      counts: %{
        events: state.next_event - 1,
        sections: length(state.sections),
        jobs: length(state.jobs),
        queued: Enum.count(state.jobs, &(&1.status == "queued")),
        running: Enum.count(state.jobs, &(&1.status == "running")),
        completed: Enum.count(state.jobs, &(&1.status == "completed")),
        failed: Enum.count(state.jobs, &(&1.status == "failed")),
        stopped: Enum.count(state.jobs, &(&1.status == "stopped")),
        codex_threads:
          state.jobs
          |> Enum.map(& &1.codex_thread_id)
          |> Enum.reject(&is_nil/1)
          |> Enum.uniq()
          |> length(),
        active_codex_turns:
          Enum.count(state.jobs, &(&1.status == "running" and is_binary(&1.codex_turn_id))),
        records: length(records),
        questions: length(questions)
      },
      sections: state.sections,
      document_sections: document_sections(state),
      jobs: Enum.map(state.jobs, &project_job/1),
      context_packets: Enum.map(state.jobs, &project_packet(&1.context_packet)),
      streams: project_streams(state.streams),
      results: Enum.map(result_values, &project_result/1),
      proposed_records: records,
      questions: questions,
      imaginer: imaginer_projection(state, result_values, records),
      interventions: interventions(state.events),
      events: Enum.take(state.events, -@projection_event_tail)
    }
  end

  defp retain_events(events) do
    {important, disposable} = Enum.split_with(events, &important_event?/1)

    (important ++ Enum.take(disposable, -@retained_event_tail))
    |> Enum.uniq_by(& &1.id)
    |> Enum.sort_by(&event_number/1)
  end

  defp important_event?(%{type: type}) do
    type in [
      "run_started",
      "source_loaded",
      "run_completed",
      "run_failed",
      "human_line_feedback",
      "human_note",
      "human_record_decision",
      "human_pressure_decision",
      "synthesis_requested"
    ]
  end

  defp important_event?(_event), do: false

  defp event_number(%{id: "evt-" <> number}) do
    case Integer.parse(number) do
      {value, _rest} -> value
      :error -> 0
    end
  end

  defp event_number(_event), do: 0

  defp project_streams(streams) do
    Map.new(streams, fn {job_id, stream} ->
      {job_id, stream |> Enum.take(-@projection_stream_tail) |> Enum.map(&project_stream_item/1)}
    end)
  end

  defp project_stream_item(item) do
    item
    |> Map.update(:summary, "", &truncate_text(&1, 800))
    |> project_stream_raw()
  end

  defp project_stream_raw(%{type: "item/agentMessage/delta"} = item), do: Map.delete(item, :raw)

  defp project_stream_raw(%{type: "item/reasoning/summaryTextDelta"} = item),
    do: Map.delete(item, :raw)

  defp project_stream_raw(%{type: "item/reasoning/textDelta"} = item), do: Map.delete(item, :raw)
  defp project_stream_raw(%{type: "item/plan/delta"} = item), do: Map.delete(item, :raw)

  defp project_stream_raw(%{type: "item/tool/call"} = item) do
    Map.update(item, :raw, "", &truncate_text(&1, @projection_tool_raw_limit))
  end

  defp project_stream_raw(item) do
    Map.update(item, :raw, "", &truncate_text(&1, @projection_raw_limit))
  end

  defp project_result(result) do
    result
    |> Map.update(:raw_text, "", &truncate_text(&1, @projection_result_text_limit))
    |> Map.update(:console_excerpt, "", &truncate_text(&1, @projection_result_text_limit))
  end

  defp truncate_text(nil, _limit), do: ""

  defp truncate_text(value, limit) when is_binary(value) do
    String.slice(value, 0, limit)
  end

  defp truncate_text(value, limit) do
    value
    |> to_string()
    |> String.slice(0, limit)
  end

  defp interventions(events) do
    Enum.filter(
      events,
      &(&1.type in [
          "human_line_feedback",
          "human_note",
          "human_record_decision",
          "human_pressure_decision",
          "synthesis_requested"
        ])
    )
  end

  defp imaginer_projection(%{mode: "imaginer"} = state, results, records) do
    trace_jobs = Enum.filter(state.jobs, &String.starts_with?(&1.kind, "imaginer_"))
    branch_jobs = Enum.filter(trace_jobs, &String.starts_with?(&1.kind, "imaginer_branch_"))
    decision_records = Enum.filter(records, &(Map.get(&1, "kind") in decision_record_kinds()))

    %{
      implementation_target: state.implementation_target,
      decision_graph: %{
        status: if(decision_records == [], do: "empty", else: "proposal"),
        candidates: Enum.filter(decision_records, &(Map.get(&1, "kind") == "decision_candidate")),
        alternatives:
          Enum.filter(decision_records, &(Map.get(&1, "kind") == "decision_alternative")),
        rationales: Enum.filter(decision_records, &(Map.get(&1, "kind") == "decision_rationale")),
        edges: Enum.filter(decision_records, &(Map.get(&1, "kind") == "decision_edge")),
        conflicts:
          records
          |> Enum.filter(
            &(Map.get(&1, "kind") in ["decision_conflict", "missing_acceptance_record"])
          )
      },
      counterfactual_worlds: Enum.map(branch_jobs, &project_world/1),
      plan_trace: Enum.map(trace_jobs, &project_trace_node(&1, results)),
      branch_rollups: branch_rollups(branch_jobs, results),
      architecture_states: architecture_states(state, results),
      metrics: imaginer_metrics(state, branch_jobs, records),
      synthesis:
        results
        |> Enum.filter(&(&1.kind == "imaginer_synthesis"))
        |> List.last(),
      steering_notes: state.steering_notes,
      rejected_paths: state.rejected_paths
    }
  end

  defp imaginer_projection(_state, _results, _records), do: nil

  defp decision_record_kinds do
    [
      "decision_candidate",
      "decision_alternative",
      "decision_rationale",
      "decision_edge",
      "decision_conflict",
      "missing_acceptance_record"
    ]
  end

  defp project_world(job) do
    %{
      id: job.world_id,
      parent_world_id: job.parent_world_id,
      branch_id: job.branch_id,
      branch_title: job.branch_title,
      depth: job.depth,
      role: job.search_role,
      job_id: job.id,
      status: job.status,
      codex_thread_id: job.codex_thread_id,
      codex_thread_url: job.codex_thread_url
    }
  end

  defp project_trace_node(job, results) do
    result = Enum.find(results, &(&1.job_id == job.id))

    %{
      id: Map.get(job, :world_id) || job.id,
      job_id: job.id,
      kind: job.kind,
      role: Map.get(job, :search_role) || job.lens_role,
      branch_id: Map.get(job, :branch_id),
      branch_title: Map.get(job, :branch_title),
      depth: Map.get(job, :depth),
      parent_world_id: Map.get(job, :parent_world_id),
      status: job.status,
      summary: result && result.summary,
      finding_count: result && length(result.findings || []),
      record_count: result && length(result.proposed_records || []),
      question_count: result && length(result.questions || []),
      context_packet_id: job.context_packet.id,
      context_hash: job.context_packet.context_hash,
      codex_thread_id: job.codex_thread_id,
      codex_thread_url: job.codex_thread_url,
      codex_turn_id: job.codex_turn_id
    }
  end

  defp architecture_states(state, results) do
    state.jobs
    |> Enum.filter(&(&1.kind == "imaginer_architecture_state"))
    |> Enum.map(&project_architecture_state(&1, state.jobs, results))
  end

  defp project_architecture_state(job, jobs, results) do
    result = Enum.find(results, &(&1.job_id == job.id))
    subject = Enum.find(jobs, &(&1.id == Map.get(job, :architecture_subject_job_id)))
    records = (result && result.proposed_records) || []
    state_record = Enum.find(records, &(Map.get(&1, "kind") == "architecture_state")) || %{}

    diagram_record =
      Enum.find(records, &(Map.get(&1, "kind") == "architecture_state_diagram")) || %{}

    components =
      Enum.uniq(
        list_value(state_record, "components") ++
          list_value(diagram_record, "components") ++
          fallback_architecture_components(subject)
      )

    relations =
      Enum.uniq(
        list_value(state_record, "relations") ++
          list_value(diagram_record, "relations") ++
          fallback_architecture_relations(subject)
      )

    title = Map.get(state_record, "title")
    lens_named? = present?(title)

    %{
      id: Map.get(state_record, "state_id") || "arch-state-#{(subject && subject.id) || job.id}",
      title:
        title ||
          architecture_subject_title(job, subject, Map.get(job, :architecture_subject_lens_role)),
      title_source: if(lens_named?, do: "architecture_state_lens", else: "pending_lens"),
      status: job.status,
      summary:
        (result && result.summary) ||
          Map.get(state_record, "body") ||
          "Architecture state projection is waiting on a low-effort lens.",
      job_id: job.id,
      source_job_id: Map.get(job, :architecture_subject_job_id),
      source_result_id: Map.get(job, :architecture_subject_result_id),
      source_lens_role: Map.get(job, :architecture_subject_lens_role),
      branch_id: Map.get(job, :branch_id),
      branch_title: Map.get(job, :branch_title),
      depth: Map.get(job, :depth),
      world_id: Map.get(job, :world_id),
      authority_boundary:
        Map.get(state_record, "authority_boundary") ||
          "proposal projection over completed imaginer result",
      diagram: %{
        kind: Map.get(diagram_record, "diagram_kind") || "architecture_state",
        text: Map.get(diagram_record, "diagram") || Map.get(state_record, "diagram"),
        components: components,
        relations: relations,
        impacts: list_value(state_record, "impacts"),
        validation_gates: list_value(state_record, "validation_gates")
      },
      records: records
    }
  end

  defp architecture_subject_title(job, nil, lens_role) do
    if Map.get(job, :status) in ["queued", "running"] do
      "Architecture lens naming state"
    else
      "#{lens_role || "Imaginer"} projection state"
    end
  end

  defp architecture_subject_title(job, subject, _lens_role) do
    if Map.get(job, :status) in ["queued", "running"] do
      "Architecture lens naming state"
    else
      completed_architecture_subject_title(subject)
    end
  end

  defp completed_architecture_subject_title(subject) do
    cond do
      subject.lens_role == "ordinary_plan_baseline_lens" ->
        "Baseline Proposal Runtime"

      subject.lens_role == "decision_mining_lens" ->
        "Decision-Mined Planning Surface"

      subject.lens_role == "imaginer_synthesis_lens" ->
        "Synthesized Implementation Core"

      present?(Map.get(subject, :branch_title)) ->
        "#{subject.branch_title} Architecture Surface"

      true ->
        "#{subject.title || subject.lens_role} Projection Surface"
    end
  end

  defp fallback_architecture_components(nil),
    do: ["Completed imaginer result", "Projected architecture state"]

  defp fallback_architecture_components(%{lens_role: "ordinary_plan_baseline_lens"}),
    do: [
      "Source spec",
      "Basis.Run.Server",
      "ContextPacket",
      "Basis.Imaginer.PlanPacket",
      "Basis.Imaginer.ArchitectureState",
      "StateMapProjection",
      "mix test gate"
    ]

  defp fallback_architecture_components(%{lens_role: "decision_mining_lens"}),
    do: [
      "Codex thread evidence",
      "DecisionMiner",
      "DecisionCandidate records",
      "Impact facet records",
      "Branch seed queue",
      "StateMapProjection"
    ]

  defp fallback_architecture_components(%{lens_role: "engineer_lens"}),
    do: [
      "Prior ArchitectureState",
      "EngineerLens worker",
      "Implementation delta records",
      "Basis.Imaginer.PlanPacket",
      "Candidate ArchitectureState",
      "Validation gate list",
      "StateMapProjection"
    ]

  defp fallback_architecture_components(%{lens_role: "reality_lens"}),
    do: [
      "Candidate ArchitectureState",
      "RealityLens worker",
      "How did you do that probe",
      "Repository evidence",
      "Risk and blocker records",
      "Revised ArchitectureState",
      "Validation gates"
    ]

  defp fallback_architecture_components(%{lens_role: "imaginer_synthesis_lens"}),
    do: [
      "Explored ArchitectureStates",
      "Stable decision constraints",
      "Rejected path records",
      "ImplementationPlan packet",
      "Work-slice queue",
      "Acceptance gates"
    ]

  defp fallback_architecture_components(_subject),
    do: ["Completed imaginer result", "Projected architecture state"]

  defp fallback_architecture_relations(nil),
    do: [
      %{
        "from" => "Completed imaginer result",
        "to" => "Projected architecture state",
        "label" => "projects"
      }
    ]

  defp fallback_architecture_relations(%{lens_role: "ordinary_plan_baseline_lens"}),
    do: [
      %{"from" => "Source spec", "to" => "ContextPacket", "label" => "grounds"},
      %{"from" => "ContextPacket", "to" => "Basis.Imaginer.PlanPacket", "label" => "fills"},
      %{
        "from" => "Basis.Run.Server",
        "to" => "Basis.Imaginer.ArchitectureState",
        "label" => "records proposal"
      },
      %{
        "from" => "Basis.Imaginer.ArchitectureState",
        "to" => "StateMapProjection",
        "label" => "renders"
      },
      %{"from" => "mix test gate", "to" => "Basis.Imaginer.PlanPacket", "label" => "checks"}
    ]

  defp fallback_architecture_relations(%{lens_role: "decision_mining_lens"}),
    do: [
      %{"from" => "Codex thread evidence", "to" => "DecisionMiner", "label" => "feeds"},
      %{"from" => "DecisionMiner", "to" => "DecisionCandidate records", "label" => "proposes"},
      %{
        "from" => "DecisionCandidate records",
        "to" => "Impact facet records",
        "label" => "explains"
      },
      %{"from" => "DecisionCandidate records", "to" => "Branch seed queue", "label" => "queues"},
      %{"from" => "Impact facet records", "to" => "StateMapProjection", "label" => "prioritizes"}
    ]

  defp fallback_architecture_relations(%{lens_role: "engineer_lens"}),
    do: [
      %{"from" => "Prior ArchitectureState", "to" => "EngineerLens worker", "label" => "prompts"},
      %{
        "from" => "EngineerLens worker",
        "to" => "Implementation delta records",
        "label" => "proposes"
      },
      %{
        "from" => "Implementation delta records",
        "to" => "Basis.Imaginer.PlanPacket",
        "label" => "packs"
      },
      %{
        "from" => "Basis.Imaginer.PlanPacket",
        "to" => "Candidate ArchitectureState",
        "label" => "becomes"
      },
      %{
        "from" => "Validation gate list",
        "to" => "Candidate ArchitectureState",
        "label" => "constrains"
      },
      %{
        "from" => "Candidate ArchitectureState",
        "to" => "StateMapProjection",
        "label" => "renders"
      }
    ]

  defp fallback_architecture_relations(%{lens_role: "reality_lens"}),
    do: [
      %{
        "from" => "Candidate ArchitectureState",
        "to" => "RealityLens worker",
        "label" => "challenges"
      },
      %{"from" => "RealityLens worker", "to" => "How did you do that probe", "label" => "asks"},
      %{
        "from" => "How did you do that probe",
        "to" => "Repository evidence",
        "label" => "requires"
      },
      %{
        "from" => "Repository evidence",
        "to" => "Risk and blocker records",
        "label" => "supports"
      },
      %{
        "from" => "Risk and blocker records",
        "to" => "Revised ArchitectureState",
        "label" => "revises"
      },
      %{"from" => "Validation gates", "to" => "Revised ArchitectureState", "label" => "guards"}
    ]

  defp fallback_architecture_relations(%{lens_role: "imaginer_synthesis_lens"}),
    do: [
      %{
        "from" => "Explored ArchitectureStates",
        "to" => "Stable decision constraints",
        "label" => "extracts"
      },
      %{
        "from" => "Rejected path records",
        "to" => "Stable decision constraints",
        "label" => "filters"
      },
      %{
        "from" => "Stable decision constraints",
        "to" => "ImplementationPlan packet",
        "label" => "packs"
      },
      %{
        "from" => "ImplementationPlan packet",
        "to" => "Work-slice queue",
        "label" => "schedules"
      },
      %{"from" => "Acceptance gates", "to" => "ImplementationPlan packet", "label" => "checks"}
    ]

  defp fallback_architecture_relations(_subject),
    do: [
      %{
        "from" => "Completed imaginer result",
        "to" => "Projected architecture state",
        "label" => "projects"
      }
    ]

  defp branch_rollups(branch_jobs, results) do
    branch_jobs
    |> Enum.group_by(& &1.branch_id)
    |> Enum.map(fn {branch_id, jobs} ->
      records =
        jobs
        |> Enum.flat_map(fn job ->
          results
          |> Enum.find(&(&1.job_id == job.id))
          |> case do
            nil -> []
            result -> result.proposed_records || []
          end
        end)

      title_job = Enum.find(jobs, & &1.branch_title)

      %{
        branch_id: branch_id,
        title: title_job && title_job.branch_title,
        max_depth: jobs |> Enum.map(&(&1.depth || 0)) |> Enum.max(fn -> 0 end),
        queued: Enum.count(jobs, &(&1.status == "queued")),
        running: Enum.count(jobs, &(&1.status == "running")),
        completed: Enum.count(jobs, &(&1.status == "completed")),
        failed: Enum.count(jobs, &(&1.status == "failed")),
        reality_checks: Enum.count(jobs, &(&1.search_role == "reality_lens")),
        records: length(records),
        blockers:
          Enum.filter(
            records,
            &(Map.get(&1, "kind") in ["risk", "missing_spec_dimension", "validation_gap"])
          )
      }
    end)
  end

  defp imaginer_metrics(state, branch_jobs, records) do
    reality_jobs = Enum.filter(branch_jobs, &(&1.search_role == "reality_lens"))
    evidence_backed = Enum.count(records, &evidence_backed?/1)
    total_records = length(records)

    %{
      branch_count:
        branch_jobs
        |> Enum.map(& &1.branch_id)
        |> Enum.reject(&is_nil/1)
        |> Enum.uniq()
        |> length(),
      configured_branch_count: state.branch_count,
      max_depth: branch_jobs |> Enum.map(&(&1.depth || 0)) |> Enum.max(fn -> 0 end),
      configured_max_depth: state.max_depth,
      evidence_density: ratio(evidence_backed, total_records),
      reality_rejection_rate:
        ratio(
          Enum.count(
            records,
            &(Map.get(&1, "kind") in ["rejected_path", "risk", "validation_gap"])
          ),
          max(length(reality_jobs), 1)
        ),
      baseline_delta:
        Enum.count(records, &(Map.get(&1, "kind") in ["baseline_delta", "stabilized_constraint"])),
      common_mode_risk: Enum.count(records, &(Map.get(&1, "evidence_kind") == "model_prior")),
      steering_note_count: length(state.steering_notes),
      architecture_state_count:
        Enum.count(records, &(Map.get(&1, "kind") == "architecture_state"))
    }
  end

  defp evidence_backed?(record) do
    evidence = Map.get(record, "evidence") || Map.get(record, "source_obligation")
    kind = Map.get(record, "evidence_kind")
    is_binary(evidence) and String.trim(evidence) != "" and kind != "model_prior"
  end

  defp ratio(_count, 0), do: 0.0
  defp ratio(count, total), do: Float.round(count / total, 3)

  defp list_value(map, key) do
    case Map.get(map, key) do
      values when is_list(values) -> values
      value when is_binary(value) and value != "" -> [value]
      _ -> []
    end
  end

  defp project_job(job) do
    job
    |> Map.drop([:task_ref, :task_pid])
    |> Map.update!(:context_packet, & &1.id)
  end

  defp project_packet(%ContextPacket{} = packet) do
    packet
    |> Map.from_struct()
    |> Map.update!(:prompt, &String.slice(&1, 0, 4_000))
    |> Map.update!(:source_excerpt, &String.slice(&1, 0, 4_000))
  end

  defp document_sections(%{source: nil}), do: []

  defp document_sections(state) do
    state.source.path
    |> Basis.Source.read!()
    |> Map.fetch!(:sections)
    |> Enum.take(state.section_limit)
  rescue
    _ -> []
  end

  defp implementation_target(opts) do
    opts
    |> Map.get(
      "implementation_target",
      "Implement live Implementation Imaginer plan-space search with decision mining and user steering."
    )
    |> to_string()
    |> String.trim()
    |> case do
      "" -> "Implement live Implementation Imaginer plan-space search."
      value -> value
    end
  end

  defp completed_init_result_refs(state) do
    state.results
    |> Map.values()
    |> Enum.filter(&(&1.kind in ["imaginer_decision_mining", "imaginer_baseline"]))
    |> Enum.map(& &1.id)
  end

  defp bias_profile_for(branch_id) do
    LensSpec.imaginer_bias_profiles()
    |> Enum.find(&(&1.id == branch_id))
    |> case do
      nil ->
        %{id: branch_id || "branch-unknown", title: branch_id || "Unknown Branch", stance: ""}

      profile ->
        profile
    end
  end

  defp render_steering_notes(state, branch_id) do
    state.steering_notes
    |> Enum.filter(fn note ->
      is_nil(note.branch_id) or is_nil(branch_id) or note.branch_id == branch_id
    end)
    |> Enum.map(fn note -> "#{note.id}: #{note.body}" end)
    |> Enum.join("\n")
    |> case do
      "" -> "No human steering notes yet."
      rendered -> rendered
    end
  end

  defp world_id(branch_id, depth, role) do
    branch =
      branch_id
      |> to_string()
      |> String.replace(~r/[^a-zA-Z0-9_-]+/, "-")

    "#{branch}-d#{depth}-#{role}"
  end

  defp normalize_targets(targets) when is_list(targets) do
    targets
    |> Enum.map(&to_string/1)
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> case do
      [] -> ["code"]
      values -> values
    end
  end

  defp normalize_targets(targets), do: normalize_targets([targets])

  defp normalize_model_effort(value) do
    value
    |> to_string()
    |> String.trim()
    |> String.downcase()
    |> case do
      effort when effort in ["low", "medium", "high", "xhigh"] -> effort
      _other -> "low"
    end
  end

  defp clamp_integer(value, min, max) when is_integer(value), do: value |> max(min) |> min(max)

  defp clamp_integer(value, min, max) when is_binary(value) do
    case Integer.parse(value) do
      {number, _rest} -> clamp_integer(number, min, max)
      :error -> min
    end
  end

  defp clamp_integer(_value, min, _max), do: min

  defp to_integer_or_nil(value) when is_integer(value), do: value

  defp to_integer_or_nil(value) when is_binary(value) do
    case Integer.parse(value) do
      {number, _rest} -> number
      :error -> nil
    end
  end

  defp to_integer_or_nil(_value), do: nil

  defp provider_module do
    Application.get_env(:basis, :llm_provider, Basis.LLM.AppServerProvider)
  end

  defp provider_name(module), do: module |> inspect() |> String.replace_prefix("Basis.LLM.", "")

  defp job_id(number), do: "job-#{String.pad_leading(to_string(number), 4, "0")}"

  defp present?(value), do: is_binary(value) and value != ""

  defp present_or_existing(value, _existing) when is_binary(value) and value != "", do: value
  defp present_or_existing(_value, existing), do: existing

  defp codex_thread_url(nil), do: nil
  defp codex_thread_url(""), do: nil
  defp codex_thread_url(thread_id), do: "codex://threads/#{thread_id}"
end
