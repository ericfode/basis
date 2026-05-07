# Plan-Space Search Experiment

Date: 2026-05-05

Status: read-only orchestration experiment, synthesized into component spec

## Goal

Test whether an Implementation Imaginer should search implementation-plan space
by running many diverse, depth-first hypothetical implementation searches. The
tested shape was paired agents playing Engineer versus Reality: Engineer
proposes implementation moves; Reality attacks them with source obligations,
repository evidence, validation gates, adapter boundaries, costs, and missing
proof. Synthesis then extracts the details that all viable plans had to contend
with.

## Method

Four no-write experiments were run with different priors:

- conservative Elixir/OTP core first
- artifact-first LLM-wiki projection
- Codex app-server orchestration first
- skeptical validation and baseline first

Each experiment simulated at least one depth-first branch to depth four and at
least two branches. The experiments inspected the Basis core spec, the new
Implementation Imaginer spec, the reducer spec, and the existing Elixir run and
LLM surfaces.

## Result

The idea works if the durable unit is not "an agent writes a plan." The durable
unit should be a structured counterfactual implementation world with paired
Engineer and Reality trace nodes.

Recursive agents, Codex app-server threads, model output, wiki pages, and
Markdown worlds are execution or projection surfaces. They are not planning
authority. The Elixir-owned run state must preserve the search tree, evidence,
reality checks, rejected paths, stable constraints, and final plan packet.

Prior threads are still valuable. They should be mined for decision candidates,
alternatives, rationales, rejected paths, conflicts, and missing acceptance
records before the next search pass. Those mined records inform branch
selection and Reality checks, but they remain proposal state until accepted.

## Recurring Constraints

Every viable plan had to contend with these constraints:

- Proposal state is not accepted Basis state.
- Local repository evidence outranks external search and model priors.
- Thread-mined decisions are decision candidates, not accepted decisions.
- Reality must cite source, repository, command, explicit absence, external
  finding, human note, or validation weakness.
- A generic skeptical model voice is not Reality evidence.
- The current `Basis.Run.Server` is reducer-shaped; it should not be reused as
  imaginer semantics without a separate imaginer contract.
- Codex app-server threads are execution provenance, not durable plan state.
- Wiki pages are useful projections, not state authority.
- Branch diversity must be operational, not tonal.
- Depth alone does not prove value; the run needs a baseline and metrics.
- Synthesis must preserve minority blockers and rejected paths.
- Work slices must bind source obligation, repository surface, validation gate,
  and rollback or rejection condition.
- The next pass should start from both the current plan trace and a
  decision-space graph mined from prior threads.

## Record Types Exposed By The Experiment

The experiment found that the spec needs first-class records for:

- `agent_bias_profile`
- `branch_policy`
- `stopping_policy`
- `ordinary_plan_baseline`
- `decision_mining_pass`
- `decision_candidate`
- `decision_alternative`
- `decision_rationale`
- `decision_edge`
- `decision_space_graph`
- `counterfactual_world`
- `plan_trace_node`
- `engineer_move`
- `reality_check`
- `stabilized_constraint`
- `synthesis_constraint`
- `plan_metric`
- `wiki_projection`

## Validation Shape

The method is better than ordinary planning only if it can show evidence-backed
deltas over a single-pass baseline for the same target and repository snapshot.

Initial gates:

- at least two branches when meaningful alternatives exist
- one branch reaches configured depth or records a valid early-stop reason
- every trace node has role, parentage, depth, context packet or prompt
  contract, and fork provenance
- Engineer and Reality roles alternate on searched branches
- Reality checks cite evidence or explicit absence
- source, repository, semantic, execution, and plan topologies stay separate
- decision topology stays separate from execution-thread topology
- thread-mined decision candidates are not marked accepted without acceptance
  records
- recursive synthesis names baseline deltas
- every work slice binds source obligation, repository surface, validation
  gate, and rollback or rejection condition
- invalid or overbroad branches remain visible as rejected paths

Initial metrics:

- `branch_count`
- `max_depth`
- `evidence_density`
- `reality_rejection_rate`
- `cross_branch_stability`
- `common_mode_risk`
- `surface_coverage`
- `gate_strength`
- `baseline_delta`
- `implementation_surprise_rate`

## Recommended First Implementation Slice

Build a deterministic, no-network packet and validation slice before connecting
real recursive Codex threads:

- `Basis.Imaginer.PlanPacket`
- `Basis.Imaginer.CandidatePath`
- `Basis.Imaginer.AgentBiasProfile`
- `Basis.Imaginer.DecisionCandidate`
- `Basis.Imaginer.DecisionGraph`
- `Basis.Imaginer.DecisionMining`
- `Basis.Imaginer.CounterfactualWorld`
- `Basis.Imaginer.PlanTraceNode`
- `Basis.Imaginer.WorkSlice`
- `Basis.Imaginer.Validation`

The first test should construct an in-memory plan packet for a narrow Basis
implementation target with a tiny thread-like fixture, a decision-space graph,
two branches, and one depth-four trace. It should compare that trace against an
ordinary baseline and fail if any work slice lacks source obligation,
repository surface, provenance, validation gate, or rollback condition. It
should also fail if a thread-mined decision candidate is treated as accepted
without an acceptance record.

## Next-Pass Process

The next imaginer pass should run this loop:

1. Recover repository state and source identity.
2. Mine prior threads, trace packets, and run events into a decision-space
   graph.
3. Classify mined records as proposed, accepted, rejected, deferred,
   superseded, or conflicted.
4. Seed candidate paths, branch diversity profiles, rejected paths, and Reality
   checks from that graph.
5. Run the depth-first Engineer/Reality search.
6. Update the decision-space graph with newly exposed decisions, conflicts,
   rejected alternatives, and missing acceptance records.
7. Synthesize stable constraints, baseline deltas, and the next implementation
   plan packet.

## Rejected First Paths

- Markdown or wiki pages as canonical state.
- Direct recursive Codex threads before packet validation exists.
- Reusing reducer lens roles as implementation-search semantics.
- A single prompt that asks for the best implementation plan.
- External research before local repository inspection.
- UI-first implementation.
- A search that reports depth without proving evidence-backed baseline deltas.
