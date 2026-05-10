defmodule Basis.Run.ServerTest do
  use ExUnit.Case, async: false

  test "runs LLM lens jobs through provider streams and server-side actions" do
    snapshot =
      Basis.Run.Server.start_run(%{
        "source_path" => "components/spec-basis-reducer/spec.md",
        "targets" => ["code"],
        "section_limit" => 1,
        "max_concurrency" => 4
      })

    assert snapshot.status == "running"

    snapshot =
      wait_until(fn ->
        snapshot = Basis.Run.Server.snapshot()
        snapshot.counts.completed >= 5
      end)

    assert snapshot.counts.jobs >= 5
    assert map_size(snapshot.streams) >= 1
    assert Enum.all?(snapshot.results, &(&1.provider == "scripted_test_provider"))

    [job | _] = snapshot.jobs

    snapshot =
      Basis.Run.Server.action(%{
        "type" => "note",
        "subject_kind" => "lens_job",
        "subject_id" => job.id,
        "body" => "review note"
      })

    assert Enum.any?(snapshot.events, &(&1.type == "human_note"))
  end

  test "reducer run concurrency defaults to ten and clamps at ten" do
    snapshot =
      Basis.Run.Server.start_run(%{
        "source_path" => "components/spec-basis-reducer/spec.md",
        "section_limit" => 1
      })

    assert snapshot.max_concurrency == 10

    snapshot =
      Basis.Run.Server.start_run(%{
        "source_path" => "components/spec-basis-reducer/spec.md",
        "section_limit" => 1,
        "max_concurrency" => 99
      })

    assert snapshot.max_concurrency == 10
  end

  test "forced synthesis request on completed reducer run schedules new work" do
    Basis.Run.Server.start_run(%{
      "source_path" => "components/spec-basis-reducer/spec.md",
      "targets" => ["code"],
      "section_limit" => 1,
      "max_concurrency" => 4
    })

    snapshot =
      wait_until(fn ->
        snapshot = Basis.Run.Server.snapshot()
        snapshot.status == "complete"
      end)

    completed_before = snapshot.counts.completed

    snapshot =
      Basis.Run.Server.action(%{
        "type" => "request_synthesis",
        "subject_kind" => "decision",
        "subject_id" => "test-decision",
        "body" => "Reconcile this pressure after the reducer run has completed."
      })

    assert snapshot.status == "running"

    assert Enum.any?(
             snapshot.jobs,
             &(&1.kind == "synthesis_lens" and &1.status in ["queued", "running"])
           )

    snapshot =
      wait_until(fn ->
        snapshot = Basis.Run.Server.snapshot()
        snapshot.status == "complete" and snapshot.counts.completed > completed_before
      end)

    assert Enum.any?(snapshot.events, &(&1.type == "synthesis_requested"))
  end

  test "runs imaginer decision mining and engineer reality search with steering" do
    snapshot =
      Basis.Run.Server.start_run(%{
        "mode" => "imaginer",
        "source_path" => "components/implementation-imaginer/spec.md",
        "targets" => ["implementation_plan"],
        "implementation_target" => "Plan live app-server-backed implementation search",
        "branch_count" => 2,
        "max_depth" => 2,
        "max_concurrency" => 8
      })

    assert snapshot.mode == "imaginer"
    assert snapshot.status == "running"
    assert snapshot.implementation_target == "Plan live app-server-backed implementation search"

    snapshot =
      wait_until(fn ->
        snapshot = Basis.Run.Server.snapshot()

        snapshot.imaginer.metrics.max_depth >= 2 and snapshot.imaginer.synthesis != nil and
          snapshot.imaginer.metrics.architecture_state_count >= 2
      end)

    assert snapshot.imaginer.metrics.branch_count == 2
    assert snapshot.imaginer.metrics.baseline_delta >= 1
    assert Enum.any?(snapshot.imaginer.architecture_states)

    assert Enum.any?(
             snapshot.imaginer.architecture_states,
             &(&1.source_lens_role == "engineer_lens")
           )

    assert Enum.any?(snapshot.imaginer.decision_graph.candidates)

    assert Enum.any?(
             snapshot.imaginer.plan_trace,
             &(&1.role == "engineer_lens" and &1.depth == 2)
           )

    assert Enum.any?(
             snapshot.imaginer.plan_trace,
             &(&1.role == "reality_lens" and &1.depth == 2)
           )

    assert Enum.all?(
             snapshot.proposed_records,
             &(&1["acceptance_boundary"] == "proposal_not_basis_state")
           )

    snapshot =
      Basis.Run.Server.action(%{
        "type" => "steer_search",
        "body" => "Deepen the branch that preserves decision candidates without accepting them.",
        "branch_id" => "branch-conservative-otp"
      })

    assert Enum.any?(snapshot.steering_notes, &String.contains?(&1.body, "decision candidates"))

    snapshot =
      Basis.Run.Server.action(%{
        "type" => "queue_imaginer_branch",
        "title" => "Human Review Branch",
        "body" => "Search for the smallest UI affordance that lets the user steer Reality checks."
      })

    assert snapshot.focused_branch =~ "branch-human"
    assert Enum.any?(snapshot.jobs, &(Map.get(&1, :branch_id) == snapshot.focused_branch))
  end

  defp wait_until(fun, attempts \\ 60)
  defp wait_until(_fun, 0), do: flunk("condition did not become true")

  defp wait_until(fun, attempts) do
    if fun.() do
      Basis.Run.Server.snapshot()
    else
      Process.sleep(50)
      wait_until(fun, attempts - 1)
    end
  end
end
