defmodule Basis.LLM.LensSpec do
  @moduledoc """
  Named model lens contract.

  A lens is not a regex rule. It is an LLM role with an explicit context packet,
  output schema, and falsification burden.
  """

  @section_lenses [
    %{
      role: "basis_dimension_lens",
      title: "Basis Dimensions",
      purpose:
        "Find independent dimensions, derived facts, and redundancies needed by target projections."
    },
    %{
      role: "projection_gap_lens",
      title: "Projection Gaps",
      purpose: "Find places target projections would invent behavior or choose policy silently."
    },
    %{
      role: "coupling_conflict_lens",
      title: "Couplings And Conflicts",
      purpose: "Find fused obligations, incompatible requirements, and split pressure."
    },
    %{
      role: "fidelity_loss_lens",
      title: "Fidelity And Loss",
      purpose: "Name prior surfaces, replacements, named losses, and silent deletion risk."
    }
  ]

  @imaginer_bias_profiles [
    %{
      id: "branch-conservative-otp",
      title: "Conservative OTP Core",
      stance:
        "Prefer a small Elixir-owned packet and validation core before adapters, UI, or real Codex recursion."
    },
    %{
      id: "branch-app-server-first",
      title: "Codex App-Server First",
      stance:
        "Prefer live app-server threads and context packets, but keep app-server history as execution provenance."
    },
    %{
      id: "branch-artifact-wiki",
      title: "Artifact Wiki Projection",
      stance:
        "Prefer inspectable world artifacts and wiki-like projections while preserving structured packets as authority."
    },
    %{
      id: "branch-skeptical-validation",
      title: "Skeptical Validation",
      stance:
        "Try to falsify recursive planning value with baselines, metrics, and reality evidence gates."
    }
  ]

  def section_lenses, do: @section_lenses
  def imaginer_bias_profiles, do: @imaginer_bias_profiles

  def root_prompt(source, targets) do
    """
    You are the root read lens for a Basis reducer run.

    Read the full source identity and orient downstream lenses without extracting
    section-specific conclusions. Return JSON only:

    {
      "summary": "short orientation",
      "findings": [{"kind": "orientation", "title": "...", "evidence": "...", "falsifiable_test": "..."}],
      "build_shape": {
        "title": "short name for the system shape implied by the spec",
        "source": "root orientation thread over the loaded source",
        "boundary": "proposal state, not accepted Basis state",
        "nodes": [
          {"id": "source", "title": "source concept", "body": "short noun phrase", "kind": "source"},
          {"id": "claim", "title": "candidate claim", "body": "short noun phrase", "kind": "claim"},
          {"id": "state", "title": "proposal state", "body": "short noun phrase", "kind": "records"},
          {"id": "impact", "title": "projection impact", "body": "short noun phrase", "kind": "targets"}
        ],
        "edges": [
          {"from": "source", "to": "claim", "label": "supports"},
          {"from": "claim", "to": "state", "label": "proposes"},
          {"from": "state", "to": "impact", "label": "pressures"}
        ],
        "support": [
          {"title": "open pressure", "body": "short blocker or review pressure", "kind": "support"},
          {"title": "acceptance gate", "body": "what would make this durable", "kind": "gate"}
        ]
      },
      "proposed_records": [],
      "questions": [],
      "confidence": 0.0
    }

    The build_shape is a generated projection for the Understanding Studio
    diagram panel. It MUST be specific to the loaded spec. Do not use generic
    nodes such as "document", "section", "lens", "job", or "source lines" as
    the main content. Use 3-6 ordered nodes and short edge verbs that describe
    the semantic path from source concept to proposed Basis state to projection
    pressure.

    Source path: #{source.path}
    Source hash: #{source.hash}
    Target projections: #{Enum.join(targets, ", ")}

    Source:
    #{String.slice(source.text, 0, 24_000)}
    """
  end

  def section_prompt(lens, source, section, targets) do
    """
    You are an LLM lens in a Basis reducer run.

    Lens role: #{lens.role}
    Lens title: #{lens.title}
    Lens purpose: #{lens.purpose}

    Contract:
    - Use semantic judgment over the supplied context.
    - Do not infer from sibling sections.
    - Do not use keyword counting or regex-style surface matching as authority.
    - Every finding must name evidence or explicit absence of evidence.
    - Every proposed semantic record must include a falsifiable rejection,
      demotion, split, merge, or replacement test.
    - Every finding should suggest one to three next actions that a reviewer can
      take on that finding. Suggested actions are proposal guidance only.
    - Reducer output is proposal state, not accepted Basis state.

    Return JSON only:

    {
      "summary": "one paragraph",
      "findings": [
        {
          "kind": "pivot|derived|redundant|coupled|missing|conflict|open_question|rejected_alternative|fidelity_loss|pressure",
          "title": "short title",
          "evidence": "source-backed evidence or explicit absence",
          "target_projection": ["code"],
          "falsifiable_test": "how to reject, demote, split, merge, or replace it",
          "severity": "low|medium|high",
          "suggested_actions": [
            {
              "label": "short button label",
              "action_type": "inspect_source|record_blocker|ask_synthesis|keep_pressure|defer_pressure|reject_pressure|merge_pressure",
              "rationale": "why this action is the next useful reviewer move"
            }
          ]
        }
      ],
      "proposed_records": [
        {
          "kind": "pivot|derived|redundant|coupled|missing|conflict|open_question|rejected_alternative",
          "title": "short title",
          "body": "proposal body",
          "target_projection": ["code"],
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [
        {
          "question": "smallest useful human question",
          "why_now": "why it matters",
          "decision_effect": "what changes if answered"
        }
      ],
      "confidence": 0.0
    }

    Source path: #{source.path}
    Source hash: #{source.hash}
    Section: #{section.id} #{section.title}
    Lines: #{section.start_line}-#{section.end_line}
    Target projections: #{Enum.join(targets, ", ")}

    Section source:
    #{section.text}
    """
  end

  def synthesis_prompt(source, targets, completed_results) do
    rendered =
      completed_results
      |> Enum.map(fn result ->
        """
        Job: #{result.job_id}
        Lens: #{result.lens_role}
        Section: #{result.section_id || "root"}
        Summary: #{result.summary}
        Findings: #{Basis.Json.encode!(result.findings || [])}
        Proposed records: #{Basis.Json.encode!(result.proposed_records || [])}
        """
      end)
      |> Enum.join("\n")

    """
    You are the synthesis lens for a Basis reducer run.

    Merge lens outputs without pretending agreement where lenses disagree.
    Preserve conflicts, named losses, and review questions. Do not accept Basis
    state. Return JSON only:

    {
      "summary": "synthesis summary",
      "findings": [
        {
          "kind": "synthesis_decision|conflict|missing|fidelity_loss|pressure",
          "title": "short title",
          "evidence": "which lens results support it",
          "target_projection": ["code"],
          "falsifiable_test": "how this synthesis decision could be invalidated",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [],
      "questions": [
        {
          "question": "smallest useful human question",
          "why_now": "why it matters",
          "decision_effect": "what changes if answered"
        }
      ],
      "confidence": 0.0
    }

    Source path: #{source.path}
    Source hash: #{source.hash}
    Target projections: #{Enum.join(targets, ", ")}

    Completed lens results:
    #{rendered}
    """
  end

  def imaginer_decision_mining_prompt(source, implementation_target, targets) do
    """
    You are the decision-space mining lens for a Basis Implementation Imaginer run.

    Mine the supplied source and any visible prior context for decision
    candidates. Do not treat thread text, model output, or prose as authority.
    Return JSON only:

    {
      "summary": "one paragraph",
      "findings": [
        {
          "kind": "decision_candidate|decision_alternative|decision_conflict|missing_acceptance_record",
          "title": "short title",
          "evidence": "source-backed evidence or explicit absence",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how to reject, supersede, or require acceptance",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "decision_candidate|decision_alternative|decision_rationale|decision_edge|rejected_path",
          "title": "short title",
          "body": "proposal body",
          "status": "proposed|accepted|rejected|deferred|superseded|conflicted",
          "affected_surface": ["source spec", "repo surface", "adapter", "validation gate"],
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [
        {
          "question": "smallest useful human question",
          "why_now": "why it matters for the next search pass",
          "decision_effect": "how the decision graph or branch policy changes"
        }
      ],
      "confidence": 0.0
    }

    Implementation target: #{implementation_target}
    Target projections: #{Enum.join(targets, ", ")}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Source:
    #{String.slice(source.text, 0, 24_000)}
    """
  end

  def imaginer_baseline_prompt(source, implementation_target, targets) do
    """
    You are the ordinary single-pass baseline planning lens for a Basis
    Implementation Imaginer run.

    Produce a shallow implementation plan that later recursive search must beat.
    Do not accept Basis state. Return JSON only:

    {
      "summary": "baseline plan summary",
      "findings": [
        {
          "kind": "ordinary_plan_baseline|risk|validation_gate|missing_spec_dimension",
          "title": "short title",
          "evidence": "source or repository evidence, or explicit absence",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how this baseline detail could be rejected",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "ordinary_plan_baseline|candidate_path|work_slice|validation_gate|risk",
          "title": "short title",
          "body": "proposal body",
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [],
      "confidence": 0.0
    }

    Implementation target: #{implementation_target}
    Target projections: #{Enum.join(targets, ", ")}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Source:
    #{String.slice(source.text, 0, 20_000)}
    """
  end

  def imaginer_engineer_prompt(source, attrs) do
    """
    You are the Engineer lens in a Basis Implementation Imaginer depth-first
    search.

    Propose the next implementation-world delta. Be opinionated according to the
    branch bias, but keep output proposal-only. Return JSON only:

    {
      "summary": "engineer move summary",
      "findings": [
        {
          "kind": "engineer_move|candidate_path|work_slice|dependency|validation_gate|risk",
          "title": "short title",
          "evidence": "source obligation, repo surface, or explicit absence",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how Reality could reject or revise this move",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "engineer_move|candidate_path|work_slice|validation_gate|experiment",
          "title": "short title",
          "body": "proposal body",
          "source_obligation": "source-backed obligation or explicit absence",
          "repository_surface": "repo surface or explicit absence",
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [
        {
          "question": "smallest useful user steering question",
          "why_now": "why this branch needs it",
          "decision_effect": "what changes if answered"
        }
      ],
      "confidence": 0.0
    }

    Implementation target: #{attrs.implementation_target}
    Branch: #{attrs.branch_id}
    Depth: #{attrs.depth}
    Bias: #{attrs.bias_title}
    Bias stance: #{attrs.bias_stance}
    Prior result refs: #{Enum.join(attrs.prior_result_refs, ", ")}
    Steering notes: #{attrs.steering_notes}
    Target projections: #{Enum.join(attrs.targets, ", ")}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Source excerpt:
    #{String.slice(source.text, 0, 16_000)}
    """
  end

  def imaginer_reality_prompt(source, attrs) do
    """
    You are the Reality lens in a Basis Implementation Imaginer depth-first
    search.

    Attack the Engineer move using source obligations, repository evidence,
    validation gates, adapter boundaries, costs, and missing proof. Generic
    skepticism is invalid; cite evidence or explicit absence. Return JSON only:

    {
      "summary": "reality check summary",
      "findings": [
        {
          "kind": "reality_check|risk|missing_spec_dimension|validation_gap|rejected_path|stabilized_constraint",
          "title": "short title",
          "evidence": "local file/command/source evidence or explicit absence",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how Engineer can answer or reject this check",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "reality_check|risk|missing_spec_dimension|stabilized_constraint|rejected_path",
          "title": "short title",
          "body": "proposal body",
          "evidence_kind": "local_file|local_command|thread_turn|run_event|explicit_absence|model_prior|human_note",
          "repository_surface": "repo surface or explicit absence",
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [
        {
          "question": "smallest useful steering question",
          "why_now": "why this branch is blocked or risky",
          "decision_effect": "what changes if answered"
        }
      ],
      "confidence": 0.0
    }

    Implementation target: #{attrs.implementation_target}
    Branch: #{attrs.branch_id}
    Depth: #{attrs.depth}
    Bias: #{attrs.bias_title}
    Engineer result refs: #{Enum.join(attrs.prior_result_refs, ", ")}
    Steering notes: #{attrs.steering_notes}
    Target projections: #{Enum.join(attrs.targets, ", ")}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Source excerpt:
    #{String.slice(source.text, 0, 16_000)}
    """
  end

  def imaginer_synthesis_prompt(source, implementation_target, targets, results, steering_notes) do
    rendered =
      results
      |> Enum.map(fn result ->
        """
        Job: #{result.job_id}
        Lens: #{result.lens_role}
        Summary: #{result.summary}
        Findings: #{Basis.Json.encode!(result.findings || [])}
        Proposed records: #{Basis.Json.encode!(result.proposed_records || [])}
        """
      end)
      |> Enum.join("\n")

    """
    You are the synthesis lens for a Basis Implementation Imaginer run.

    Merge structured deltas. Preserve rejected paths, minority blockers,
    decision candidates, baseline deltas, stable constraints, and missing
    acceptance records. Do not accept Basis state. Return JSON only:

    {
      "summary": "implementation-plan synthesis",
      "findings": [
        {
          "kind": "synthesis_constraint|baseline_delta|decision_conflict|missing_acceptance_record|work_slice|validation_gate",
          "title": "short title",
          "evidence": "which results support it",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how this synthesis could be invalidated",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "implementation_plan|synthesis_constraint|baseline_delta|work_slice|rejected_path|decision_candidate",
          "title": "short title",
          "body": "proposal body",
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        }
      ],
      "questions": [
        {
          "question": "smallest useful next user steering question",
          "why_now": "why it matters",
          "decision_effect": "how the next pass changes"
        }
      ],
      "confidence": 0.0
    }

    Implementation target: #{implementation_target}
    Target projections: #{Enum.join(targets, ", ")}
    Steering notes: #{steering_notes}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Completed results:
    #{rendered}
    """
  end

  def imaginer_architecture_state_prompt(source, attrs) do
    rendered = Basis.Json.encode!(attrs.subject_result)

    """
    You are the low-effort architecture-state projection lens for a Basis
    Implementation Imaginer run.

    Project the completed result into the architecture state it would lead to.
    Do not draw a decision tree. Show the state the tree reaches: components,
    state authority, adapters, validation gates, risks, and unresolved caveats.
    You own the user-facing name for this state. The architecture_state title
    MUST be a human-readable architecture state name, not a branch label, job
    title, depth marker, or trace role. Do not return names like "State After
    ...", "Engineer State ...", "Reality-Checked State ...", or "... d2
    State". Prefer names that reveal the implementation shape, such as
    "Validated Plan Packet Core" or "App-Server Search Context".
    If the subject is an Engineer or Reality turn, behave like the Reality
    player kept asking "how did you do that?" until the proposed implementation
    has concrete build surfaces. Components must be modules, records, workers,
    adapters, gates, projections, or artifacts that could actually be built;
    do not use generic trace labels such as "Engineer move" or "candidate
    architecture" as diagram nodes.
    Do not accept Basis state and do not deepen the search. Return JSON only:

    {
      "summary": "one paragraph architecture-state summary",
      "findings": [
        {
          "kind": "architecture_state|architecture_state_diagram|architecture_gap|state_impact",
          "title": "short title",
          "evidence": "which completed result fields support the state",
          "target_projection": ["implementation_plan"],
          "falsifiable_test": "how to reject or revise this state projection",
          "severity": "low|medium|high"
        }
      ],
      "proposed_records": [
        {
          "kind": "architecture_state",
          "state_id": "stable state id",
          "title": "state name",
          "body": "what this architecture state contains",
          "components": ["component or module"],
          "relations": [{"from": "component", "to": "component", "label": "relationship"}],
          "authority_boundary": "what owns semantic authority in this state",
          "impacts": ["impact or risk"],
          "validation_gates": ["gate"],
          "known_loss": "loss/caveat or empty string",
          "falsifiable_test": "test"
        },
        {
          "kind": "architecture_state_diagram",
          "state_id": "same state id",
          "title": "diagram title",
          "diagram_kind": "architecture_state",
          "diagram": "compact text diagram or mermaid-like state sketch",
          "components": ["component or module"],
          "relations": [{"from": "component", "to": "component", "label": "relationship"}],
          "falsifiable_test": "test"
        }
      ],
      "questions": [],
      "confidence": 0.0
    }

    Implementation target: #{attrs.implementation_target}
    Subject job: #{attrs.subject_job.id}
    Subject lens: #{attrs.subject_job.lens_role}
    Branch: #{Map.get(attrs.subject_job, :branch_id) || "run"}
    Depth: #{Map.get(attrs.subject_job, :depth) || "n/a"}
    Target projections: #{Enum.join(attrs.targets, ", ")}
    Source path: #{source.path}
    Source hash: #{source.hash}

    Completed subject result:
    #{rendered}
    """
  end
end
