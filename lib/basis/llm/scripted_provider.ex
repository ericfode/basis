defmodule Basis.LLM.ScriptedProvider do
  @moduledoc """
  Test-only provider that returns a structured lens result without calling a
  model. UI and runtime projections label provider identity so this cannot be
  confused with actual LLM output.
  """

  def complete(packet), do: complete(packet, fn _event -> :ok end)

  def complete(%Basis.LLM.ContextPacket{} = packet, emit) when is_function(emit, 1) do
    emit.(%{
      type: "scripted_provider_event",
      provider: "scripted_test_provider",
      at: Basis.Run.Clock.now(),
      thread_id: nil,
      summary: "Scripted provider emitted a test event.",
      raw: "scripted #{packet.job_id}"
    })

    {:ok,
     %{
       provider: "scripted_test_provider",
       provider_status: "completed",
       started_at: Basis.Run.Clock.now(),
       completed_at: Basis.Run.Clock.now(),
       raw_text: "scripted result for #{packet.lens_role}",
       console_excerpt: "",
       summary:
         "Scripted #{packet.lens_role} result for #{packet.section_id || packet.branch_id || "root"}.",
       findings: scripted_findings(packet),
       proposed_records: scripted_records(packet),
       questions: scripted_questions(packet),
       confidence: 1.0
     }}
  end

  defp scripted_findings(%{lens_role: "decision_mining_lens"} = packet) do
    [
      finding(
        "decision_candidate",
        "Thread-mined planning boundary",
        packet,
        "Fixture thread indicates app-server threads are execution provenance, not accepted state."
      )
    ]
  end

  defp scripted_findings(%{lens_role: "ordinary_plan_baseline_lens"} = packet) do
    [
      finding(
        "ordinary_plan_baseline",
        "Baseline packet-first implementation",
        packet,
        "Baseline starts with packet validation before live recursion."
      )
    ]
  end

  defp scripted_findings(%{lens_role: "engineer_lens"} = packet) do
    [
      finding(
        "engineer_move",
        "Engineer proposes branch move",
        packet,
        "Engineer branch #{packet.branch_id} depth #{packet.depth} proposes the next bounded slice."
      )
    ]
  end

  defp scripted_findings(%{lens_role: "reality_lens"} = packet) do
    [
      finding(
        "reality_check",
        "Reality demands evidence",
        packet,
        "Reality checks branch #{packet.branch_id} depth #{packet.depth} against source, repo surface, and validation gate."
      )
    ]
  end

  defp scripted_findings(%{lens_role: "imaginer_synthesis_lens"} = packet) do
    [
      finding(
        "synthesis_constraint",
        "Synthesis preserves baseline delta",
        packet,
        "Synthesis keeps decision candidates and Reality blockers as proposal state."
      )
    ]
  end

  defp scripted_findings(%{lens_role: "architecture_state_lens"} = packet) do
    [
      finding(
        "architecture_state_diagram",
        "Projected architecture state",
        packet,
        "Low-effort projection follows completed #{packet.budget.source_lens_role} result #{packet.budget.architecture_subject_job_id}."
      )
    ]
  end

  defp scripted_findings(packet) do
    [
      finding("pressure", "Scripted lens finding", packet, "Test provider evidence.")
    ]
  end

  defp finding(kind, title, packet, evidence) do
    %{
      "kind" => kind,
      "title" => title,
      "evidence" => evidence,
      "target_projection" => packet.target_projections,
      "falsifiable_test" => "Replace the provider and rerun the lens.",
      "severity" => "low"
    }
  end

  defp scripted_records(%{lens_role: "decision_mining_lens"}) do
    [
      %{
        "kind" => "decision_candidate",
        "title" => "Use structured packets as authority",
        "body" =>
          "Prior thread-like fixture says recursive agents and wiki pages should inform the search without becoming accepted state.",
        "status" => "proposed",
        "affected_surface" => ["components/implementation-imaginer/spec.md"],
        "evidence" => "thread_turn fixture",
        "evidence_kind" => "thread_turn",
        "falsifiable_test" => "Reject if no acceptance record or source obligation supports it."
      },
      %{
        "kind" => "decision_alternative",
        "title" => "Use Markdown wiki as state",
        "body" => "Rejected alternative preserved as negative pressure.",
        "status" => "rejected",
        "evidence" => "thread_turn fixture",
        "evidence_kind" => "thread_turn",
        "falsifiable_test" => "Accept only with explicit Basis state acceptance."
      },
      %{
        "kind" => "missing_acceptance_record",
        "title" => "Decision still needs acceptance",
        "body" => "Thread phrasing alone cannot mark this decision accepted.",
        "status" => "proposed",
        "evidence" => "explicit_absence: no acceptance record in fixture",
        "evidence_kind" => "explicit_absence",
        "falsifiable_test" => "Provide an accepted Basis state change."
      }
    ]
  end

  defp scripted_records(%{lens_role: "ordinary_plan_baseline_lens"}) do
    [
      %{
        "kind" => "ordinary_plan_baseline",
        "title" => "Baseline plan",
        "body" =>
          "Implement packet structs, validation, and a smoke test before live app-server recursion.",
        "evidence" => "components/implementation-imaginer/spec.md",
        "evidence_kind" => "local_file",
        "falsifiable_test" =>
          "Recursive search must find useful evidence-backed deltas beyond this baseline."
      }
    ]
  end

  defp scripted_records(%{lens_role: "engineer_lens"} = packet) do
    [
      %{
        "kind" => "engineer_move",
        "title" => "Branch #{packet.branch_id} depth #{packet.depth}",
        "body" => "Add the next structured trace increment before expanding adapters.",
        "source_obligation" =>
          "Implementation Imaginer spec requires Engineer/Reality trace nodes.",
        "repository_surface" => "lib/basis/run/server.ex",
        "evidence" => "components/implementation-imaginer/spec.md",
        "evidence_kind" => "local_file",
        "falsifiable_test" => "Reality can reject this if no validation gate binds the slice."
      },
      %{
        "kind" => "work_slice",
        "title" => "Validate branch #{packet.branch_id} d#{packet.depth}",
        "body" =>
          "Ensure the trace node has source obligation, repo surface, and validation gate.",
        "source_obligation" => "Every work slice binds obligation, surface, and gate.",
        "repository_surface" => "test/basis/run/server_test.exs",
        "validation_gate" => "mix test",
        "evidence_kind" => "local_file",
        "falsifiable_test" => "Fail the test by removing the validation gate."
      }
    ]
  end

  defp scripted_records(%{lens_role: "reality_lens"} = packet) do
    [
      %{
        "kind" => "reality_check",
        "title" => "Evidence gate for #{packet.branch_id} d#{packet.depth}",
        "body" => "The branch must not count model-prior skepticism as Reality evidence.",
        "repository_surface" => "test/basis/run/server_test.exs",
        "evidence" => "local_file: test/basis/run/server_test.exs",
        "evidence_kind" => "local_file",
        "falsifiable_test" =>
          "Reject if Reality records lack evidence_kind or repository_surface."
      },
      %{
        "kind" => "stabilized_constraint",
        "title" => "Thread decisions remain candidates",
        "body" => "Decision mining informs the next pass but cannot accept decisions.",
        "evidence" => "components/implementation-imaginer/spec.md",
        "evidence_kind" => "local_file",
        "falsifiable_test" =>
          "Reject if a thread-mined candidate has accepted status without acceptance record."
      }
    ]
  end

  defp scripted_records(%{lens_role: "imaginer_synthesis_lens"}) do
    [
      %{
        "kind" => "implementation_plan",
        "title" => "Scripted live imaginer plan",
        "body" =>
          "Use decision mining, Engineer/Reality traces, and user steering as proposal state feeding the next pass.",
        "evidence" => "synthesis over scripted branch traces",
        "evidence_kind" => "run_event",
        "falsifiable_test" => "Reject if branch traces or baseline deltas are absent."
      },
      %{
        "kind" => "baseline_delta",
        "title" => "Decision graph feeds branch selection",
        "body" => "Recursive search adds decision-space mining beyond the ordinary baseline.",
        "evidence" => "decision_mining_lens result",
        "evidence_kind" => "run_event",
        "falsifiable_test" => "Reject if no decision candidates are present."
      }
    ]
  end

  defp scripted_records(%{lens_role: "architecture_state_lens"} = packet) do
    subject = packet.budget.source_lens_role || "imaginer_result"
    source_job = packet.budget.architecture_subject_job_id || packet.job_id
    state_id = "arch-#{source_job}"
    components = architecture_components(subject)

    [
      %{
        "kind" => "architecture_state",
        "state_id" => state_id,
        "title" => architecture_title(subject, packet),
        "body" =>
          "Projected state after #{subject}: #{Enum.join(components, " -> ")}. This is a navigable state projection, not a decision-tree edge.",
        "components" => components,
        "relations" => architecture_relations(components),
        "authority_boundary" =>
          "structured proposal records remain authority; diagram is projection",
        "impacts" => architecture_impacts(subject),
        "validation_gates" => ["mix test"],
        "evidence" => "completed result #{source_job}",
        "evidence_kind" => "run_event",
        "falsifiable_test" =>
          "Reject if the completed subject result does not support these components."
      },
      %{
        "kind" => "architecture_state_diagram",
        "state_id" => state_id,
        "title" => "#{architecture_title(subject, packet)} diagram",
        "diagram_kind" => "architecture_state",
        "diagram" => Enum.join(components, " -> "),
        "components" => components,
        "relations" => architecture_relations(components),
        "evidence" => "completed result #{source_job}",
        "evidence_kind" => "run_event",
        "falsifiable_test" => "Reject if the state diagram invents an unproposed owner."
      }
    ]
  end

  defp scripted_records(_packet), do: []

  defp scripted_questions(%{lens_role: "engineer_lens", branch_id: branch_id}) do
    [
      %{
        "question" =>
          "Should this branch keep pursuing #{branch_id} or fork a human-steered path?",
        "why_now" => "Human steering can redirect the next Engineer move.",
        "decision_effect" => "Adds a steering note or queues a new branch."
      }
    ]
  end

  defp scripted_questions(%{lens_role: "imaginer_synthesis_lens"}) do
    [
      %{
        "question" => "Which synthesized branch should the next pass deepen?",
        "why_now" => "The current pass has enough trace data to choose a direction.",
        "decision_effect" => "Focuses branch selection and future Reality checks."
      }
    ]
  end

  defp scripted_questions(_packet), do: []

  defp architecture_title("ordinary_plan_baseline_lens", _packet), do: "Baseline Proposal Runtime"
  defp architecture_title("decision_mining_lens", _packet), do: "Decision-Mined Planning Surface"

  defp architecture_title("imaginer_synthesis_lens", _packet),
    do: "Synthesized Implementation Core"

  defp architecture_title("engineer_lens", packet),
    do: architecture_branch_title(packet, "Candidate Implementation Surface")

  defp architecture_title("reality_lens", packet),
    do: architecture_branch_title(packet, "Reality-Validated Architecture Surface")

  defp architecture_title(_subject, _packet), do: "Projected Implementation Surface"

  defp architecture_branch_title(packet, fallback) do
    packet.budget[:branch_title] ||
      packet.budget["branch_title"] ||
      fallback
  end

  defp architecture_components("ordinary_plan_baseline_lens"),
    do: [
      "Source spec",
      "Basis.Run.Server",
      "ContextPacket",
      "Basis.Imaginer.PlanPacket",
      "Basis.Imaginer.ArchitectureState",
      "StateMapProjection",
      "mix test gate"
    ]

  defp architecture_components("decision_mining_lens"),
    do: [
      "Codex thread evidence",
      "DecisionMiner",
      "DecisionCandidate records",
      "Impact facet records",
      "Branch seed queue",
      "StateMapProjection"
    ]

  defp architecture_components("engineer_lens"),
    do: [
      "Prior ArchitectureState",
      "EngineerLens worker",
      "Implementation delta records",
      "Basis.Imaginer.PlanPacket",
      "Candidate ArchitectureState",
      "Validation gate list",
      "StateMapProjection"
    ]

  defp architecture_components("reality_lens"),
    do: [
      "Candidate ArchitectureState",
      "RealityLens worker",
      "How did you do that probe",
      "Repository evidence",
      "Risk and blocker records",
      "Revised ArchitectureState",
      "Validation gates"
    ]

  defp architecture_components("imaginer_synthesis_lens"),
    do: [
      "Explored ArchitectureStates",
      "Stable decision constraints",
      "Rejected path records",
      "ImplementationPlan packet",
      "Work-slice queue",
      "Acceptance gates"
    ]

  defp architecture_components(_subject), do: ["Completed result", "Projected state"]

  defp architecture_relations(components) do
    components
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [from, to] ->
      %{"from" => from, "to" => to, "label" => architecture_relation_label(from, to)}
    end)
  end

  defp architecture_relation_label("RealityLens worker", "How did you do that probe"), do: "asks"

  defp architecture_relation_label("How did you do that probe", "Repository evidence"),
    do: "requires"

  defp architecture_relation_label("Repository evidence", "Risk and blocker records"),
    do: "supports"

  defp architecture_relation_label("Risk and blocker records", "Revised ArchitectureState"),
    do: "revises"

  defp architecture_relation_label("EngineerLens worker", "Implementation delta records"),
    do: "proposes"

  defp architecture_relation_label("Implementation delta records", "Basis.Imaginer.PlanPacket"),
    do: "packs"

  defp architecture_relation_label("Basis.Imaginer.PlanPacket", "Candidate ArchitectureState"),
    do: "becomes"

  defp architecture_relation_label("DecisionMiner", "DecisionCandidate records"), do: "proposes"

  defp architecture_relation_label("DecisionCandidate records", "Impact facet records"),
    do: "explains"

  defp architecture_relation_label("DecisionCandidate records", "Branch seed queue"), do: "queues"

  defp architecture_relation_label("Basis.Imaginer.ArchitectureState", "StateMapProjection"),
    do: "renders"

  defp architecture_relation_label("ContextPacket", "Basis.Imaginer.PlanPacket"), do: "fills"
  defp architecture_relation_label(_, _), do: "feeds"

  defp architecture_impacts("reality_lens"), do: ["risk reduced", "validation pressure visible"]

  defp architecture_impacts("imaginer_synthesis_lens"),
    do: ["work slices visible", "baseline delta retained"]

  defp architecture_impacts(_subject), do: ["state made navigable"]
end
