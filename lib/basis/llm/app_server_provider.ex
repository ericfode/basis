defmodule Basis.LLM.AppServerProvider do
  @moduledoc """
  Codex app-server adapter for live reducer lenses.

  The reducer owns Basis run state. This module owns only the Codex app-server
  protocol boundary: launch, initialize, start a thread, start one turn, emit
  protocol notifications, and return the assistant's proposed JSON payload.
  """

  @initialize_id 1
  @thread_start_id 2
  @turn_start_id 3
  @thread_read_id 4
  @port_line_bytes 10 * 1024 * 1024
  @read_timeout 5_000
  @turn_timeout 600_000

  def complete(packet), do: complete(packet, fn _event -> :ok end)

  def complete(%Basis.LLM.ContextPacket{} = packet, emit) when is_function(emit, 1) do
    started_at = Basis.Run.Clock.now()

    case start_session(packet, emit) do
      {:ok, session} ->
        try do
          run_turn(session, packet, emit, started_at)
        after
          stop_session(session)
        end

      {:error, reason} ->
        failure(started_at, "app-server startup failed: #{format_reason(reason)}")
    end
  rescue
    exception ->
      failure(Basis.Run.Clock.now(), Exception.message(exception))
  end

  defp run_turn(session, packet, emit, started_at) do
    with {:ok, turn_id} <- start_turn(session, packet, emit),
         {:ok, acc} <- await_turn_completion(session, emit) do
      raw_text = read_turn_text(session, turn_id, emit) || accumulated_text(acc)
      decoded = decode_response(raw_text)

      {:ok,
       %{
         provider: "codex_app_server",
         provider_status: "completed",
         started_at: started_at,
         completed_at: Basis.Run.Clock.now(),
         raw_text: raw_text,
         console_excerpt: raw_excerpt(acc),
         codex_thread_id: session.thread_id,
         codex_thread_url: "codex://threads/#{session.thread_id}",
         codex_turn_id: turn_id,
         summary: Map.get(decoded, "summary", fallback_summary(raw_text)),
         findings: list_field(decoded, "findings"),
         build_shape: map_field(decoded, "build_shape"),
         proposed_records: list_field(decoded, "proposed_records"),
         questions: list_field(decoded, "questions"),
         confidence: Map.get(decoded, "confidence", nil)
       }}
    else
      {:error, reason} ->
        {:error,
         %{
           provider: "codex_app_server",
           provider_status: "failed",
           started_at: started_at,
           completed_at: Basis.Run.Clock.now(),
           raw_text: "",
           console_excerpt: "",
           codex_thread_id: session.thread_id,
           codex_thread_url: "codex://threads/#{session.thread_id}",
           codex_turn_id: nil,
           error: format_reason(reason)
         }}
    end
  end

  defp start_session(packet, emit) do
    project_root = File.cwd!()
    workspace = start_workspace(packet, project_root)

    with {:ok, port} <- start_port(workspace) do
      session = %{
        port: port,
        workspace: workspace,
        project_root: project_root,
        thread_id: nil,
        app_server_pid: app_server_pid(port),
        approval_policy: approval_policy(),
        thread_sandbox: thread_sandbox(),
        turn_sandbox_policy: turn_sandbox_policy(workspace)
      }

      emit.(%{
        type: "app_server_launched",
        provider: "codex_app_server",
        at: Basis.Run.Clock.now(),
        thread_id: nil,
        turn_id: nil,
        summary: "Launched Codex app-server process #{session.app_server_pid || "unknown"}.",
        raw: ""
      })

      with :ok <- initialize(session, emit),
           {:ok, thread_id} <- start_thread(session, packet, emit) do
        {:ok, %{session | thread_id: thread_id}}
      else
        {:error, reason} ->
          stop_session(session)
          {:error, reason}
      end
    end
  end

  defp start_port(workspace) do
    executable = System.find_executable("bash")

    if executable do
      port =
        Port.open(
          {:spawn_executable, String.to_charlist(executable)},
          [
            :binary,
            :exit_status,
            :stderr_to_stdout,
            args: [~c"-lc", String.to_charlist(app_server_command())],
            cd: String.to_charlist(workspace),
            line: @port_line_bytes
          ]
        )

      {:ok, port}
    else
      {:error, :bash_not_found}
    end
  end

  defp initialize(session, emit) do
    send_message(session.port, %{
      "id" => @initialize_id,
      "method" => "initialize",
      "params" => %{
        "capabilities" => %{"experimentalApi" => true},
        "clientInfo" => %{
          "name" => "basis-live-reducer",
          "title" => "Basis Live Reducer",
          "version" => "0.1.0"
        }
      }
    })

    with {:ok, _result} <- await_response(session, @initialize_id, emit) do
      send_message(session.port, %{"method" => "initialized", "params" => %{}})
      :ok
    end
  end

  defp start_thread(session, packet, emit) do
    send_message(session.port, %{
      "id" => @thread_start_id,
      "method" => "thread/start",
      "params" => %{
        "approvalPolicy" => session.approval_policy,
        "sandbox" => session.thread_sandbox,
        "cwd" => session.workspace,
        "title" => "#{packet.job_id} #{packet.lens_role}",
        "persistExtendedHistory" => true
      }
    })

    case await_response(session, @thread_start_id, emit) do
      {:ok, %{"thread" => %{"id" => thread_id}}} ->
        emit.(%{
          type: "thread/started",
          provider: "codex_app_server",
          at: Basis.Run.Clock.now(),
          thread_id: thread_id,
          turn_id: nil,
          summary: "Created Codex app-server thread #{thread_id}.",
          raw:
            Basis.Json.encode!(%{
              "method" => "thread/started",
              "params" => %{"thread" => %{"id" => thread_id}}
            })
        })

        {:ok, thread_id}

      {:ok, result} ->
        {:error, {:invalid_thread_start_response, result}}

      other ->
        other
    end
  end

  defp start_turn(%{thread_id: thread_id} = session, packet, emit) when is_binary(thread_id) do
    params =
      %{
        "threadId" => thread_id,
        "cwd" => session.workspace,
        "title" => "#{packet.job_id}: #{packet.lens_role}",
        "input" => [%{"type" => "text", "text" => adapter_scoped_prompt(packet, session)}],
        "approvalPolicy" => session.approval_policy,
        "sandboxPolicy" => session.turn_sandbox_policy
      }
      |> maybe_put_budget(packet, "model", :model)
      |> maybe_put_budget(packet, "effort", :model_effort)
      |> maybe_put_env("model", "BASIS_CODEX_MODEL")
      |> maybe_put_env("effort", "BASIS_CODEX_EFFORT")

    send_message(session.port, %{
      "id" => @turn_start_id,
      "method" => "turn/start",
      "params" => params
    })

    case await_response(session, @turn_start_id, emit) do
      {:ok, %{"turn" => %{"id" => turn_id}}} ->
        emit.(%{
          type: "turn/started",
          provider: "codex_app_server",
          at: Basis.Run.Clock.now(),
          thread_id: thread_id,
          turn_id: turn_id,
          summary: "Started Codex app-server turn #{turn_id}.",
          raw:
            Basis.Json.encode!(%{
              "method" => "turn/started",
              "params" => %{"threadId" => thread_id, "turn" => %{"id" => turn_id}}
            })
        })

        {:ok, turn_id}

      {:ok, result} ->
        {:error, {:invalid_turn_start_response, result}}

      other ->
        other
    end
  end

  defp await_turn_completion(session, emit) do
    receive_turn(session, emit, empty_acc(), "")
  end

  defp receive_turn(session, emit, acc, pending_line) do
    receive do
      {port, {:data, {:eol, chunk}}} when port == session.port ->
        line = pending_line <> to_string(chunk)
        handle_turn_line(session, emit, acc, line)

      {port, {:data, {:noeol, chunk}}} when port == session.port ->
        receive_turn(session, emit, acc, pending_line <> to_string(chunk))

      {port, {:exit_status, status}} when port == session.port ->
        {:error, {:port_exit, status}}
    after
      turn_timeout() ->
        {:error, :turn_timeout}
    end
  end

  defp handle_turn_line(session, emit, acc, line) do
    case decode_line(line) do
      {:ok, %{"method" => "turn/completed"} = payload} ->
        emit_app_event(emit, payload)
        {:ok, update_acc(acc, payload, line)}

      {:ok, %{"method" => "turn/failed", "params" => params} = payload} ->
        emit_app_event(emit, payload)
        {:error, {:turn_failed, params}}

      {:ok, %{"method" => "turn/cancelled", "params" => params} = payload} ->
        emit_app_event(emit, payload)
        {:error, {:turn_cancelled, params}}

      {:ok, %{"method" => _method} = payload} ->
        emit_app_event(emit, payload)
        receive_turn(session, emit, update_acc(acc, payload, line), "")

      {:ok, %{"id" => _id} = payload} ->
        emit_app_event(emit, payload)
        receive_turn(session, emit, update_acc(acc, payload, line), "")

      {:ok, payload} when is_map(payload) ->
        emit_app_event(emit, payload)
        receive_turn(session, emit, update_acc(acc, payload, line), "")

      {:error, _reason} ->
        if protocol_message_candidate?(line) do
          emit.(%{
            type: "app_server_malformed",
            provider: "codex_app_server",
            at: Basis.Run.Clock.now(),
            thread_id: session.thread_id,
            turn_id: nil,
            summary: String.slice(String.trim(line), 0, 500),
            raw: line
          })
        end

        receive_turn(session, emit, acc, "")
    end
  end

  defp await_response(session, request_id, emit) do
    receive_response(session, request_id, emit, "")
  end

  defp receive_response(session, request_id, emit, pending_line) do
    receive do
      {port, {:data, {:eol, chunk}}} when port == session.port ->
        line = pending_line <> to_string(chunk)
        handle_response_line(session, request_id, emit, line)

      {port, {:data, {:noeol, chunk}}} when port == session.port ->
        receive_response(session, request_id, emit, pending_line <> to_string(chunk))

      {port, {:exit_status, status}} when port == session.port ->
        {:error, {:port_exit, status}}
    after
      read_timeout() ->
        {:error, :response_timeout}
    end
  end

  defp handle_response_line(session, request_id, emit, line) do
    case decode_line(line) do
      {:ok, %{"id" => ^request_id, "error" => error}} ->
        {:error, {:response_error, error}}

      {:ok, %{"id" => ^request_id, "result" => result}} ->
        {:ok, result}

      {:ok, %{"method" => _method} = payload} ->
        emit_app_event(emit, payload)
        receive_response(session, request_id, emit, "")

      {:ok, _other} ->
        receive_response(session, request_id, emit, "")

      {:error, _reason} ->
        receive_response(session, request_id, emit, "")
    end
  end

  defp read_turn_text(%{thread_id: thread_id} = session, turn_id, emit) do
    send_message(session.port, %{
      "id" => @thread_read_id,
      "method" => "thread/read",
      "params" => %{"threadId" => thread_id, "includeTurns" => true}
    })

    case await_response(session, @thread_read_id, emit) do
      {:ok, result} -> extract_turn_text(result, turn_id)
      {:error, _reason} -> nil
    end
  end

  defp emit_app_event(emit, payload) do
    emit.(%{
      type: Map.get(payload, "method", "app_server_message"),
      provider: "codex_app_server",
      at: Basis.Run.Clock.now(),
      thread_id: thread_id(payload),
      turn_id: turn_id(payload),
      summary: event_summary(payload),
      raw: Basis.Json.encode!(payload)
    })
  end

  defp event_summary(%{"method" => "thread/started", "params" => %{"thread" => %{"id" => id}}}),
    do: "Created Codex app-server thread #{id}."

  defp event_summary(%{"method" => "turn/started", "params" => %{"turn" => %{"id" => id}}}),
    do: "Started Codex app-server turn #{id}."

  defp event_summary(%{"method" => "item/agentMessage/delta", "params" => %{"delta" => delta}})
       when is_binary(delta),
       do: delta

  defp event_summary(%{"method" => "turn/completed"}), do: "Turn completed."
  defp event_summary(%{"method" => "turn/failed"}), do: "Turn failed."
  defp event_summary(%{"method" => "turn/cancelled"}), do: "Turn cancelled."

  defp event_summary(%{"level" => level, "fields" => %{"message" => message}})
       when is_binary(level) and is_binary(message),
       do: "#{level}: #{message}"

  defp event_summary(%{"method" => method}) when is_binary(method), do: method
  defp event_summary(%{"id" => id}), do: "JSON-RPC response #{id}."
  defp event_summary(_payload), do: "Codex app-server message."

  defp update_acc(acc, payload, raw) do
    acc
    |> Map.update!(:raw_events, &Enum.take(&1 ++ [raw], -50))
    |> collect_delta(payload)
    |> collect_completed_turn(payload)
  end

  defp collect_delta(acc, %{
         "method" => "item/agentMessage/delta",
         "params" => %{"delta" => delta}
       })
       when is_binary(delta),
       do: Map.update!(acc, :deltas, &(&1 ++ [delta]))

  defp collect_delta(acc, _payload), do: acc

  defp collect_completed_turn(acc, %{"method" => "turn/completed", "params" => %{"turn" => turn}})
       when is_map(turn),
       do: Map.update!(acc, :completed_texts, &(&1 ++ extract_turn_item_texts(turn)))

  defp collect_completed_turn(acc, _payload), do: acc

  defp empty_acc, do: %{deltas: [], completed_texts: [], raw_events: []}

  defp accumulated_text(%{completed_texts: texts}) when texts != [], do: Enum.join(texts, "")
  defp accumulated_text(%{deltas: deltas}), do: Enum.join(deltas, "")

  defp raw_excerpt(%{raw_events: events}) do
    events
    |> Enum.join("\n")
    |> String.slice(0, 4_000)
  end

  defp extract_turn_text(%{"thread" => %{"turns" => turns}}, turn_id) when is_list(turns) do
    turns
    |> Enum.find(&(Map.get(&1, "id") == turn_id))
    |> case do
      nil -> nil
      turn -> turn |> extract_turn_item_texts() |> Enum.join("")
    end
    |> blank_to_nil()
  end

  defp extract_turn_text(_result, _turn_id), do: nil

  defp extract_turn_item_texts(%{"items" => items}) when is_list(items) do
    Enum.flat_map(items, &extract_item_text/1)
  end

  defp extract_turn_item_texts(_turn), do: []

  defp extract_item_text(%{"type" => "agentMessage", "text" => text}) when is_binary(text),
    do: [text]

  defp extract_item_text(%{"type" => "message", "role" => "assistant", "content" => content})
       when is_list(content) do
    content
    |> Enum.filter(&(Map.get(&1, "type") == "output_text"))
    |> Enum.map(&Map.get(&1, "text"))
    |> Enum.filter(&is_binary/1)
  end

  defp extract_item_text(_item), do: []

  defp thread_id(%{"params" => params}) when is_map(params) do
    Map.get(params, "threadId") || get_in(params, ["thread", "id"])
  end

  defp thread_id(_payload), do: nil

  defp turn_id(%{"params" => params}) when is_map(params) do
    Map.get(params, "turnId") || get_in(params, ["turn", "id"])
  end

  defp turn_id(_payload), do: nil

  defp decode_response(raw) do
    raw
    |> extract_json()
    |> case do
      nil -> %{}
      json -> Basis.Json.decode!(json)
    end
  rescue
    _ -> %{}
  end

  defp extract_json(raw) when is_binary(raw) do
    trimmed =
      raw
      |> String.trim()
      |> String.trim_leading("```json")
      |> String.trim_leading("```")
      |> String.trim_trailing("```")
      |> String.trim()

    with start when is_integer(start) <- find_index(trimmed, "{"),
         stop when is_integer(stop) <- find_last_index(trimmed, "}") do
      String.slice(trimmed, start, stop - start + 1)
    else
      _ -> nil
    end
  end

  defp extract_json(_raw), do: nil

  defp find_index(text, pattern) do
    case :binary.match(text, pattern) do
      {index, _length} -> index
      :nomatch -> nil
    end
  end

  defp find_last_index(text, pattern) do
    text
    |> :binary.matches(pattern)
    |> List.last()
    |> case do
      {index, _length} -> index
      nil -> nil
    end
  end

  defp list_field(map, key) do
    case Map.get(map, key) do
      items when is_list(items) -> items
      _ -> []
    end
  end

  defp map_field(map, key) do
    case Map.get(map, key) do
      item when is_map(item) -> item
      _ -> nil
    end
  end

  defp fallback_summary(raw), do: raw |> to_string() |> String.trim() |> String.slice(0, 600)

  defp decode_line(line) do
    {:ok, Basis.Json.decode!(line)}
  rescue
    exception -> {:error, exception}
  end

  defp send_message(port, payload) do
    Port.command(port, Basis.Json.encode!(payload) <> "\n")
  end

  defp stop_session(%{port: port}) when is_port(port) do
    case :erlang.port_info(port) do
      :undefined -> :ok
      _ -> Port.close(port)
    end
  rescue
    ArgumentError -> :ok
  end

  defp app_server_pid(port) do
    case :erlang.port_info(port, :os_pid) do
      {:os_pid, pid} -> to_string(pid)
      _ -> nil
    end
  end

  defp failure(started_at, reason) do
    {:error,
     %{
       provider: "codex_app_server",
       provider_status: "failed",
       started_at: started_at,
       completed_at: Basis.Run.Clock.now(),
       raw_text: "",
       console_excerpt: "",
       codex_thread_id: nil,
       codex_thread_url: nil,
       codex_turn_id: nil,
       error: reason
     }}
  end

  defp start_workspace(packet, project_root) do
    root =
      System.get_env("BASIS_CODEX_START_ROOT") ||
        Path.join(System.tmp_dir!(), "basis-codex-starts")

    workspace =
      root
      |> Path.expand()
      |> Path.join(safe_path_segment(Path.basename(project_root)))
      |> Path.join(safe_path_segment(packet.run_id || "run"))
      |> Path.join(safe_path_segment(packet.job_id || "job"))

    if Path.expand(workspace) == Path.expand(project_root) do
      raise ArgumentError, "Codex app-server start workspace must not be the project root"
    end

    File.mkdir_p!(workspace)
    workspace
  end

  defp safe_path_segment(value) do
    value
    |> to_string()
    |> String.replace(~r/[^A-Za-z0-9_.-]+/, "-")
    |> String.trim("-")
    |> case do
      "" -> "basis"
      segment -> String.slice(segment, 0, 96)
    end
  end

  defp adapter_scoped_prompt(packet, session) do
    """
    #{packet.prompt}

    Adapter execution boundary:
    - This speculative Codex app-server turn starts in #{session.workspace}.
    - The repository root for read-only inspection is #{session.project_root}.
    - Do not write implementation changes to the repository from this planning turn.
    - Treat any file edits, terminal output, or thread text as execution provenance,
      not accepted Basis state.

    Visible projection guidance:
    - The UI is an Understanding Studio. Prefer a concise `basis_show_thought`
      visible projection named "What This Wants To Become" when you can explain
      the build shape implied by the source. This prose should help the human
      decide what they actually want built, not merely summarize the section.
    - When a diagram would make the spec easier to read, emit a `basis_show_mermaid`
      visible projection before the final answer.
    - A visible diagram MUST be about semantic contents, not about the document,
      section, lens, job, provider, source-line container, or evidence container.
      Never use the document title, section title, lens name, job ID, or "source
      lines" as primary graph nodes.
    - Every node should be one of: source concept, candidate record, derived fact,
      missing dimension, coupled obligation, conflict, target projection,
      acceptance/review action, or blocker.
    - Every edge must carry a reducer relation verb such as proposes, derives,
      duplicates, splits into, requires, blocks, conflicts with, pressures,
      projects to, or awaits acceptance.
    - Good diagrams are small reading aids: 3-7 nodes, short noun labels, explicit
      edge verbs, and one source anchor with section ID plus line range.
    - Do not put paragraphs, long evidence strings, or JSON blobs inside diagram
      nodes. Use the final JSON for prose and the diagram for structure.
    - Prefer diagrams that show source sentence -> proposed record -> target
      projection impact or blocker -> human decision.
    - For each final JSON finding, include `suggested_actions`: one to three
      reviewer moves with a short `label`, an `action_type`, and a `rationale`.
      Valid action_type values are inspect_source, record_blocker, ask_synthesis,
      keep_pressure, defer_pressure, reject_pressure, and merge_pressure.
    - If the only available graph would be document metadata, do not emit a
      `basis_show_mermaid` projection.
    - The final answer contract still applies; visible diagrams are projections,
      not accepted Basis state.
    """
  end

  defp app_server_command do
    System.get_env("BASIS_CODEX_APP_SERVER_COMMAND") || "codex app-server"
  end

  defp approval_policy do
    case System.get_env("BASIS_CODEX_APPROVAL_POLICY") do
      nil -> "never"
      "" -> "never"
      value -> decode_env_value(value)
    end
  end

  defp thread_sandbox do
    System.get_env("BASIS_CODEX_THREAD_SANDBOX") || "workspace-write"
  end

  defp turn_sandbox_policy(workspace) do
    case System.get_env("BASIS_CODEX_TURN_SANDBOX_POLICY") do
      nil ->
        %{
          "type" => "workspaceWrite",
          "writableRoots" => [workspace],
          "readOnlyAccess" => %{"type" => "fullAccess"},
          "networkAccess" => false,
          "excludeTmpdirEnvVar" => false,
          "excludeSlashTmp" => false
        }

      "" ->
        turn_sandbox_policy(workspace)

      value ->
        decode_env_value(value)
    end
  end

  defp decode_env_value(value) do
    trimmed = String.trim(value)

    if String.starts_with?(trimmed, ["{", "["]) do
      Basis.Json.decode!(trimmed)
    else
      trimmed
    end
  rescue
    _ -> value
  end

  defp maybe_put_env(map, key, env_key) do
    case System.get_env(env_key) do
      value when is_binary(value) and value != "" -> Map.put(map, key, value)
      _ -> map
    end
  end

  defp maybe_put_budget(map, packet, key, budget_key) do
    value =
      Map.get(packet.budget || %{}, budget_key) ||
        Map.get(packet.budget || %{}, to_string(budget_key))

    if is_binary(value) and value != "" do
      Map.put(map, key, value)
    else
      map
    end
  end

  defp read_timeout do
    env_integer("BASIS_CODEX_READ_TIMEOUT_MS", @read_timeout)
  end

  defp turn_timeout do
    env_integer("BASIS_CODEX_TURN_TIMEOUT_MS", @turn_timeout)
  end

  defp env_integer(name, default) do
    case System.get_env(name) do
      nil -> default
      value -> String.to_integer(value)
    end
  rescue
    _ -> default
  end

  defp protocol_message_candidate?(line) do
    line
    |> to_string()
    |> String.trim_leading()
    |> String.starts_with?("{")
  end

  defp blank_to_nil(nil), do: nil

  defp blank_to_nil(value) when is_binary(value) do
    if String.trim(value) == "", do: nil, else: value
  end

  defp format_reason(reason) when is_binary(reason), do: reason
  defp format_reason(reason), do: inspect(reason)
end
