# Implementation Imaginer Component Specification

Status: Draft v0.3

Purpose: The Implementation Imaginer is the component that searches the
implementation-plan space for a Basis state, source spec, and repository
snapshot.

It imagines possible implementations before implementation begins by running
bounded, diverse, depth-first searches over counterfactual implementation
worlds. In each world, an Engineer lens proposes a path, slice, dependency, or
ownership choice, and a Reality lens attacks it using source obligations,
repository evidence, validation gates, adapter boundaries, cost, and missing
proof. The component synthesizes the details those worlds had to contend with
into a better implementation-plan proposal.

Imagining is not acceptance. Recursive agents, app-server threads, model output,
wiki pages, and simulated worlds are execution or projection surfaces. The
durable output is structured proposal state: candidate paths, trace nodes,
reality checks, research findings, stable constraints, risks, missing
dimensions, validation gates, decision candidates, and work slices that a human
or workflow may accept, reject, revise, or hand to an implementer.

The words `MUST`, `MUST NOT`, `SHOULD`, and `MAY` are used as normative terms.

## 1. Product Boundary

The imaginer owns:

- reading accepted Basis state, reducer packets, source specs, and repository
  artifacts as planning input
- declaring the implementation target under research
- mapping source obligations to repository surfaces
- generating candidate implementation paths
- declaring branch diversity policy, depth budget, stopping policy, and baseline
  policy
- running Engineer/Reality paired search over counterfactual implementation
  worlds
- generating and running an explicit research queue
- preserving evidence for local and external research findings
- comparing candidate paths against constraints, risks, and validation gates
- comparing recursive search against an ordinary single-pass planning baseline
- extracting stable constraints and recurring blockers across searched worlds
- projecting completed trace outputs into architecture-state diagrams that show
  the reachable implementation states, not only the decisions that led there
- mining prior execution threads for decision candidates, alternatives,
  rationales, and rejected paths that can inform the next search pass
- proposing ordered work slices
- naming missing spec dimensions that block implementation planning
- producing implementation-plan packets for review and acceptance

The imaginer does not own:

- accepted Basis state
- reducer semantics
- actual repository implementation
- automatic issue creation, pull request creation, or merge policy
- package, runtime, model-provider, browser, web-search, or issue-tracker policy
- acceptance of generated code, generated plans, or generated research findings
- treating raw recursive-agent transcripts, wiki pages, or app-server threads as
  durable plan state
- treating a thread statement as an accepted decision without an acceptance
  record
- claiming that recursive search improved a plan without baseline comparison or
  evidence-backed deltas

Imaginer output is a proposal. It MUST NOT become accepted Basis state,
accepted project policy, or implementation authority without an explicit
acceptance step.

## 2. Core Problem

Specs can be projection-complete for prose review while still leaving the
implementation-plan space underexplored.

An implementer may still have to invent:

- which module or process should own a behavior
- which existing abstractions are compatible
- which validation gate actually proves the behavior
- which dependency is allowed
- which migration step is safe
- which runtime boundary is authoritative
- which uncertainty should block implementation
- which rejected path should continue constraining the design

Ordinary planning often samples this space too shallowly. It can miss the
constraints that only appear after a plan tries to survive contact with
repository reality several steps later.

The imaginer exists to expose those choices before code is written. It searches
hypothetical implementation worlds, catalogs what the worlds repeatedly collide
with, preserves failed paths as negative pressure, and synthesizes a plan from
the constraints discovered across branches.

Its goal is not to predict the perfect implementation. Its goal is to make
implementation planning deeper, falsifiable, source-backed, measurable against a
baseline, and cheap to revise.

## 3. Inputs

An imaginer run MUST declare:

- run ID
- implementation target ID
- source Basis state ID or source material hashes
- source specs or reducer packets under planning
- repository root and repository snapshot
- target projections affected by the implementation
- actor or runner identity
- model-assisted steps, if any
- allowed research adapters
- research budget or stopping policy
- branch diversity policy
- maximum branch count and maximum search depth
- ordinary-planning baseline policy
- constraints on dependencies, languages, runtimes, and file ownership
- prior thread, turn, trace-packet, or run-event references available for
  decision-space mining

The primary spec input MAY be Markdown when accepted structured Basis state does
not yet exist. In that case, Markdown remains source material only.

The repository snapshot SHOULD include:

- current branch
- working tree status
- relevant file paths
- relevant test and build commands
- dependency manifests
- runtime entrypoints
- known generated artifacts
- ignored or disposable projection fixtures

When a snapshot is unavailable, the run MUST record the missing snapshot as an
uncertainty instead of pretending repository state was inspected.

## 4. Target Projection

The imaginer introduces an `implementation_plan` projection target.

An `implementation_plan` projection is complete only when the plan packet names:

- what will be built
- why the selected path satisfies the source obligations
- what files, modules, processes, adapters, or schemas are likely affected
- what work slices can be executed independently
- what validation gates prove each slice
- what research evidence supports the selected path
- what rejected paths still constrain the work
- what missing dimensions remain unresolved
- what counterfactual worlds were searched
- what details stabilized across diverse branches
- what prior thread-mined decision candidates informed the search
- what the recursive search found beyond an ordinary single-pass plan

Projection-complete does not mean the plan must be accepted. It means the next
implementer should not need to silently invent behavior, policy, ownership, or
validation.

## 5. Proposed Record Classes

The imaginer MUST produce structured proposal records. Initial classes are:

- `implementation_intent`: the behavior or capability being planned
- `implementation_target`: the named code, runtime, projection, adapter, or
  workflow surface under change
- `candidate_path`: a possible implementation strategy
- `agent_bias_profile`: the explicit engineering stance used to diversify a
  branch
- `branch_policy`: branch count, branch selection, contamination, and search
  order policy
- `stopping_policy`: depth, budget, convergence, abandonment, and cost limits
- `ordinary_plan_baseline`: a single-pass plan used to measure recursive search
  value
- `decision_candidate`: a possible decision inferred from a thread, trace, run
  event, source record, or artifact
- `decision_alternative`: an option considered in the decision space
- `decision_rationale`: the source-backed reason a candidate or alternative
  appeared to win, lose, block, or remain open
- `decision_edge`: a typed relationship among decision candidates,
  alternatives, affected surfaces, constraints, and rejected paths
- `decision_space_graph`: a proposal graph built from mined decision candidates
  and explicit accepted decisions
- `decision_mining_pass`: a bounded extraction pass over thread or trace
  material
- `counterfactual_world`: one imagined implementation world in the search tree
- `plan_trace_node`: one DFS node with parentage, depth, role, evidence, and
  verdict
- `engineer_move`: a proposed next implementation step inside a world
- `reality_check`: a repo/spec-grounded attack on an engineer move
- `research_question`: a query or inspection task needed to evaluate a path
- `research_finding`: evidence returned by a research question
- `code_surface`: a repository file, module, process, test, command, schema, or
  artifact relevant to the plan
- `dependency`: a package, service, runtime, protocol, or local module the path
  would rely on
- `decision_point`: a behavior-affecting choice that must be accepted,
  rejected, or deferred
- `risk`: a failure mode, complexity cost, or coordination hazard
- `validation_gate`: a command, check, review step, or manual inspection needed
  to falsify the plan or implementation
- `work_slice`: an ordered, bounded implementation increment
- `experiment`: a reversible spike or probe used to reduce uncertainty
- `rejected_path`: an implementation strategy that should remain visible as
  negative pressure
- `stabilized_constraint`: a detail that recurs across branches with independent
  evidence
- `synthesis_constraint`: a constraint selected by synthesis from trace evidence
- `plan_metric`: a measured property of the search, baseline, or packet
- `wiki_projection`: a readable projection generated from structured world or
  packet state
- `architecture_state`: a projected implementation architecture state reachable
  from a completed trace, baseline, Reality check, or synthesis result
- `architecture_state_diagram`: a diagram projection for one architecture state,
  including components, authority boundaries, transitions, impacts, and caveats
- `architecture_state_transition`: a typed relationship between projected
  architecture states, distinct from a decision-tree edge
- `missing_spec_dimension`: a spec or Basis dimension without which the plan
  would require invention
- `acceptance_criterion`: a condition that must hold before a plan or work
  slice is considered ready

Every proposal record MUST include provenance.

Every semantic proposal record MUST include a falsifiable witness:

- target projection affected by the record
- source obligation or explicit absence of source support
- repository surface or explicit absence of a known surface
- research evidence or explicit absence of evidence
- producer identity and model fork ID when model-assisted
- confidence class
- rejection, demotion, merge, split, or replacement test
- known loss, uncertainty, or review caveat

A record without provenance is only scratch analysis, not imaginer output.

## 6. Research Evidence

Autoresearch is part of the component contract. It is not a license to blur
evidence.

A research finding MUST record:

- finding ID
- research question ID
- source kind, such as `local_file`, `local_command`, `dependency_manifest`,
  `thread_turn`, `run_event`, `external_doc`, `issue_tracker`, `model_prior`,
  or `human_note`
- source identifier
- retrieval time when applicable
- repository snapshot when applicable
- query or command when applicable
- result summary
- supported candidate paths
- contradicted candidate paths
- uncertainty introduced or removed
- staleness risk

Local repository evidence SHOULD be preferred before external evidence.

External research is an adapter. It MAY inform a candidate path, but it MUST NOT
define Basis semantics or silently override local contracts.

Model priors MAY seed research questions. They MUST NOT count as confirmed
research findings unless another source or human review accepts them as such.

Thread turns MAY seed decision candidates and research questions. They MUST NOT
count as accepted decisions unless an explicit acceptance record, durable state
change, or human review event identifies them as accepted.

An explicit absence of evidence is valid evidence only when the run records
where it looked, what it expected to find, and why the absence matters.

## 7. Candidate Path Semantics

A candidate path is a hypothesis about how to implement the target.

Each candidate path MUST name:

- path ID
- implementation intent
- source obligations covered
- repository surfaces affected
- new records, modules, processes, schemas, or adapters proposed
- dependencies introduced or reused
- work slices
- validation gates
- risks and known loss
- research findings supporting and contradicting the path
- rejected alternatives or predecessor paths
- missing dimensions that block readiness

The imaginer SHOULD compare candidate paths using explicit dimensions:

- contract coverage
- source support
- repository fit
- implementation complexity
- runtime ownership
- validation strength
- reversibility
- dependency cost
- blast radius
- ability to preserve provenance

A recommended path is still a proposal. It MUST carry the rejected alternatives
and the reasons they lost.

## 8. Plan-Space Search

The imaginer searches implementation plans as a tree of counterfactual worlds.

A counterfactual world is not a fiction blob. It is a structured branch state
containing:

- world ID
- parent world ID, if any
- candidate path ID
- depth
- agent bias profile
- source obligations under pressure
- repository surfaces under pressure
- engineer moves
- reality checks
- research questions and findings
- accepted branch-local assumptions
- rejected branch-local assumptions
- stabilized constraints
- missing spec dimensions
- verdict

The default search strategy SHOULD be depth-first because the purpose is to
force plans to collide with later implementation reality, not only enumerate
top-level options.

A valid search MUST include:

- at least two candidate branches when meaningful alternatives exist
- one ordinary single-pass planning baseline
- a branch diversity policy
- a stopping policy
- a trace of Engineer and Reality roles
- synthesis over stable constraints, rejected paths, and open blockers

The first implementation MAY use scripted or deterministic branch traces. Real
Codex app-server recursion, web research, and external agents are adapters that
come after the trace schema and validation gate exist.

## 9. Engineer And Reality Roles

Engineer and Reality are paired lenses.

The Engineer lens proposes the next implementation-world delta. It MAY propose:

- a candidate implementation path
- a work slice
- an ownership choice
- a dependency choice
- an adapter boundary
- an experiment
- a validation gate
- a revision to a prior path

The Reality lens attacks the Engineer move. It MUST ground objections in one of:

- accepted Basis state or source spec obligation
- local repository file, module, test, command, dependency manifest, or artifact
- explicit absence of expected local evidence
- declared external research finding
- declared human review note
- validation gate weakness
- adapter boundary violation
- cost, blast radius, reversibility, or provenance risk

Reality MUST NOT be generic skepticism. A Reality response that contains only a
model prior or stylistic preference is not evidence; it may only generate a
research question or pressure item.

Every plan trace node MUST include:

- node ID
- world ID
- parent node ID, if any
- depth
- role, either `engineer_lens`, `reality_lens`, or `synthesis_lens`
- agent bias profile
- input references
- output proposal records
- evidence references or explicit absence of evidence
- validation gate or explicit validation gap
- verdict
- context packet or prompt contract
- simulated fork or app-server fork provenance
- contamination exclusions

Simulated forks and real app-server forks MUST be distinct provenance classes.
A simulated fork may support deterministic smoke tests. It MUST NOT be rendered
as app-server execution provenance.

## 10. Diversity, Stopping, And Baselines

Recursive search is useful only when diversity, cost, and comparison are
explicit.

An agent bias profile MUST name the operational stance being tested, such as:

- conservative Elixir/OTP core first
- artifact-first wiki projection
- Codex app-server orchestration first
- skeptical validation first
- adapter-minimal path
- UI-inspection-first path

Diversity is not aesthetic tone. Two branches are meaningfully diverse only
when they differ in at least one implementation-relevant dimension:

- runtime owner
- state authority
- adapter boundary
- artifact authority
- dependency policy
- validation strategy
- migration path
- cost or reversibility assumption

A stopping policy MUST name:

- maximum depth
- maximum branch count
- maximum research questions
- cost or time budget
- convergence condition
- abandonment criteria
- conditions that force `blocked_on_spec`, `blocked_on_research`,
  `blocked_on_repository_state`, `overbroad`, or `rejected`

The imaginer MUST produce or import an ordinary single-pass planning baseline
for the same target, source identity, and repository snapshot unless the run
records why no baseline is available.

Recursive search is better than ordinary planning only when synthesis can name
evidence-backed deltas over the baseline, such as:

- source-backed risks not present in the baseline
- repository surfaces not present in the baseline
- validation gates not present in the baseline
- missing spec dimensions not present in the baseline
- rejected paths whose failure constrains the final plan
- reduced implementer invention in later execution

## 11. Synthesis, Metrics, And Wiki Projection

Synthesis MUST merge structured deltas, not compress prose.

A synthesis result SHOULD identify:

- constraints that stabilize across branches with independent evidence
- details that recur across branches only as model priors
- minority blockers that should not be averaged away
- rejected paths and rejection evidence
- remaining missing spec dimensions
- recommended path, if any
- work slices and validation gates
- baseline deltas

Initial search metrics are:

- `branch_count`
- `max_depth`
- `evidence_density`: evidence-backed claims divided by total claims
- `reality_rejection_rate`
- `cross_branch_stability`: recurring details with independent evidence
- `common_mode_risk`: recurring details supported only by model priors
- `surface_coverage`: repository surfaces named and validated
- `gate_strength`: executable or local gates outrank structural, manual, and
  model-prior gates
- `baseline_delta`: confirmed useful details found beyond ordinary planning
- `implementation_surprise_rate`: decisions discovered during coding but absent
  from the plan

Wiki pages, Markdown worlds, diagrams, architecture-state maps, and
LLM-wiki-style notebooks MAY be generated as projections over structured trace
packets. They MUST NOT be edited or treated as authority unless a separate
ingestion step converts bounded changes back into validated structured records.

An imaginer UI SHOULD make architecture states navigable before showing a
decision tree. The decision topology explains why a state is reachable; the
state projection shows what the implementation would look like if that path
became the current plan.

After a trace result completes, the run SHOULD queue a low-effort
`architecture_state_lens` behind it. That lens produces only proposal records
and diagrams over the completed result. It MUST NOT deepen the search, accept a
decision, or rewrite the result it projects.

## 12. Decision-Space Mining

The imaginer SHOULD mine prior execution threads, app-server turns, trace
packets, run events, and review artifacts for decision candidates before the
next search pass.

The mining pass is not a transcript summarizer. It extracts a proposal graph of
the decision space the work appears to have traversed.

A decision candidate MUST include:

- decision candidate ID
- statement of the apparent decision
- status: `proposed`, `accepted`, `rejected`, `deferred`, `superseded`, or
  `conflicted`
- thread, turn, event, source, or artifact provenance
- affected source obligations
- affected repository surfaces
- alternatives considered
- rationale or explicit absence of rationale
- evidence references
- conflicts with other candidates or accepted records
- acceptance record, if one exists
- rejection, supersession, or revision test

A decision-space graph SHOULD include:

- decision candidates
- alternatives
- rejected paths
- rationale records
- evidence references
- affected source, repository, adapter, and validation surfaces
- conflict edges
- supersession edges
- dependency edges
- acceptance edges

The graph informs the next pass by:

- seeding candidate paths and branch diversity profiles
- preserving rejected paths as negative pressure
- giving Reality prior decisions to verify against repository evidence
- exposing conflicts among threads before they become implementation policy
- identifying missing acceptance records
- lowering repeated invention across recursive searches

Decision mining MUST preserve the boundary between decision candidates and
accepted decisions. A thread sentence such as "we decided" is still only a
candidate unless it links to an acceptance record or accepted Basis state.

Decision-space graphs are proposal state. They MAY be projected as diagrams,
wiki pages, or review packets, but those projections do not define the graph.

## 13. Autoresearch Process

An imaginer run SHOULD follow this sequence:

1. Recover repository state.
2. Load accepted Basis state, reducer packet, or source spec under planning.
3. Declare the implementation target and affected projections.
4. Mine available prior threads, trace packets, and run events into a
   decision-space graph.
5. Build a repository map for relevant code, tests, adapters, and artifacts.
6. Extract source obligations that the implementation plan must cover.
7. Generate an ordinary single-pass baseline plan.
8. Generate initial candidate paths and agent bias profiles from the source
   obligations, repository map, and decision-space graph.
9. Search candidate paths depth-first through Engineer/Reality paired lenses.
10. Generate a research queue from candidate-path and reality-check
   uncertainties.
11. Execute local research questions first.
12. Execute external research only through declared adapters when needed.
13. Convert research results into structured findings.
14. Revise, split, merge, or reject candidate paths.
15. Update the decision-space graph with newly exposed candidates, rejected
    paths, conflicts, and acceptance gaps.
16. Project completed trace results into architecture states and diagrams.
17. Synthesize stable constraints and baseline deltas.
18. Select a recommended path only when the evidence supports doing so.
19. Emit ordered work slices with validation gates.
20. Emit missing spec dimensions and decision points as blockers.
21. Emit an implementation-plan packet and critique packet for review.

The process MAY run candidate-path researchers in parallel. Parallelism is an
execution strategy, not a semantic guarantee.

The synthesis step remains responsible for evidence quality, path comparison,
and preserving uncertainty.

## 14. Research Queue Lifecycle

Research questions MUST have explicit lifecycle state.

Initial states are:

- `queued`
- `researching`
- `evidence_found`
- `contradicted`
- `blocked`
- `stale`
- `resolved`
- `abandoned`

Each state transition MUST name:

- actor
- event time
- input references
- output references
- affected candidate paths
- reason for the transition

A blocked research question MUST state the missing adapter, missing source,
permission boundary, or unresolved human decision.

## 15. Topology Separation

The imaginer MUST keep these topologies separate:

- source topology: specs, Basis records, reducer packets, source ranges,
  hashes, and artifacts
- repository topology: files, modules, tests, commands, runtime processes,
  dependencies, and adapters
- semantic topology: obligations, assumptions, decisions, constraints, risks,
  missing dimensions, and rejected alternatives
- decision topology: decision candidates, alternatives, rationale, conflicts,
  supersessions, acceptance edges, and affected surfaces
- execution topology: research jobs, model forks, commands, adapter calls, and
  human interventions
- plan topology: candidate paths, work slices, ordering constraints, and
  validation gates

Collapsing these topologies into one graph would hide the difference between
what the spec requires, what the repo already contains, what the runner did,
and what the plan proposes.

## 16. Implementation-Plan Packet

The primary output is an implementation-plan packet.

A packet MUST include:

- packet ID
- run ID
- implementation target ID
- source identity
- repository snapshot
- affected target projections
- implementation intent records
- candidate paths
- agent bias profiles
- branch and stopping policies
- ordinary single-pass baseline
- decision mining passes
- decision-space graph
- counterfactual worlds
- plan trace nodes
- engineer moves and reality checks
- recommended path, if any
- rejected paths
- research questions and findings
- code surfaces
- dependencies
- decision points
- decision candidates, alternatives, rationales, and decision edges
- risks
- missing spec dimensions
- stabilized constraints and synthesis constraints
- metrics and baseline deltas
- wiki projection references, if generated
- ordered work slices
- validation gates
- acceptance criteria
- critique items
- provenance for every proposed record
- packet validation result

The packet verdict MUST be one of:

- `ready_for_review`: enough evidence exists for a human to accept or reject
  the plan
- `blocked_on_spec`: missing spec dimensions force implementation invention
- `blocked_on_research`: required evidence is unavailable or stale
- `blocked_on_repository_state`: repository state is unknown, dirty in relevant
  files, or inconsistent with the plan
- `overbroad`: the plan cannot be executed as bounded work slices
- `rejected`: all candidate paths failed current pressure

The verdict MUST name the target implementation and affected projections.

## 17. Work Slices

A work slice is the smallest implementation increment that can be assigned,
executed, and validated without losing plan provenance.

Each work slice MUST include:

- slice ID
- candidate path ID
- source obligations covered
- affected repository surfaces
- expected state changes
- dependencies on prior slices
- validation gates
- rollback or rejection condition
- known risks
- handoff notes for the implementer

A slice MUST NOT be only a prose instruction such as "implement the feature."
It must bind source obligation, repository surface, and validation gate.

## 18. Critique And Pressure

Every imaginer run SHOULD apply these pressure questions:

- What would the implementer have to invent if this plan were removed?
- What source obligation proves this work slice is needed?
- What repository surface proves this path fits the current code?
- What validation gate could falsify this path?
- Which dependency or adapter becomes authoritative if this path is accepted?
- Which uncertainty should block implementation instead of becoming code?
- Which rejected path should continue constraining future work?
- Which thread-mined decision candidate lacks an acceptance record?
- Which prior decision candidate should Reality try to falsify in the next
  pass?
- Is this plan narrower than doing the entire project at once?

Pressure findings MUST attach to a candidate path, work slice, decision point,
research finding, validation gate, or missing spec dimension.

## 19. Acceptance Boundary

The imaginer proposes plans. It does not accept plans.

Accepting an implementation-plan packet is a separate state change that MUST
record:

- source Basis state or source material hash
- implementation-plan packet ID
- accepted candidate path or accepted subset of work slices
- rejected candidate paths
- deferred work slices
- known loss or unresolved pressure
- actor or reviewer
- validation gates required before implementation begins

Accepted plans are not implemented code. They are accepted planning state.

Accepted decision-space records are not automatically accepted implementation
policy unless the acceptance state change says so.

Actual code changes MUST still be recorded by the implementation workflow that
performs them.

## 20. Adapter Boundaries

Research adapters MAY include:

- local repository inspection
- local command execution
- package manifest inspection
- documentation lookup
- issue tracker lookup
- model-provider calls
- app-server thread and turn reads
- browser or web search
- human review

Adapters provide evidence, execution provenance, or projections. They MUST NOT
define imaginer semantics.

Provider-specific behavior belongs at the edge. Core state transformation MUST
operate over structured research questions, findings, candidate paths, and plan
packets.

## 21. Elixir Runtime Boundary

The imaginer runtime core MUST be implemented in Elixir/BEAM.

Initial implementation surfaces SHOULD be:

- `Basis.Imaginer.Run`: supervised run owner and lifecycle transitions
- `Basis.Imaginer.RepositoryMap`: repository snapshot and code-surface records
- `Basis.Imaginer.SourceObligation`: source-backed implementation obligations
- `Basis.Imaginer.CandidatePath`: candidate implementation strategies
- `Basis.Imaginer.AgentBiasProfile`: branch diversity records
- `Basis.Imaginer.CounterfactualWorld`: searched implementation worlds
- `Basis.Imaginer.PlanTraceNode`: Engineer, Reality, and synthesis trace nodes
- `Basis.Imaginer.SearchPolicy`: branch, depth, contamination, budget, and
  stopping policy
- `Basis.Imaginer.DecisionCandidate`: thread-mined decision proposal records
- `Basis.Imaginer.DecisionGraph`: decision-space graph assembly and validation
- `Basis.Imaginer.DecisionMining`: bounded extraction from threads, trace
  packets, run events, and review artifacts
- `Basis.Imaginer.ResearchQueue`: research questions and lifecycle state
- `Basis.Imaginer.ResearchFinding`: evidence records
- `Basis.Imaginer.WorkSlice`: bounded implementation increments
- `Basis.Imaginer.PlanPacket`: packet assembly and verdicts
- `Basis.Imaginer.Validation`: structural checks over evidence, provenance,
  work slices, and acceptance criteria
- `Basis.Imaginer.Projection`: JSON and UI-ready projections

Model providers, web search, issue trackers, filesystem crawlers, package
managers, and app-server threads are adapters around this core.

## 22. Relationship To The Reducer

The reducer improves the coordinate system of the spec. The imaginer researches
how an implementation could satisfy that coordinate system.

The imaginer MAY consume:

- accepted Basis state
- reducer basis packets
- reducer missing dimensions
- reducer projection-completeness verdicts
- reducer software links
- source specs before reduction exists

The imaginer MAY return pressure to the reducer:

- missing spec dimensions
- ambiguous implementation ownership
- hidden dependency decisions
- validation gaps
- rejected implementation paths that imply rejected spec interpretations

The imaginer MUST NOT mutate reducer output or accepted Basis state. It may
propose follow-up reducer work.

## 23. Validation

An imaginer implementation is acceptable when it can:

- recover and record repository state
- load source spec or Basis-state input with hashes
- declare an implementation target
- map source obligations to repository surfaces or explicit absences
- generate more than one candidate path when meaningful alternatives exist
- generate research questions from candidate-path uncertainties
- preserve evidence for research findings
- revise or reject candidate paths from evidence
- preserve an ordinary single-pass baseline
- mine prior threads or record that no thread corpus was available
- distinguish decision candidates from accepted decisions
- preserve decision alternatives, rejected paths, rationale, conflicts, and
  missing acceptance records
- explore at least two branches when meaningful alternatives exist
- reach configured depth in at least one branch or record why it stopped early
- alternate Engineer and Reality trace nodes
- distinguish simulated fork provenance from real app-server fork provenance
- compute baseline deltas and search metrics
- emit work slices tied to source obligations and validation gates
- preserve missing spec dimensions as blockers
- emit an implementation-plan packet with a target-relative verdict
- validate that no proposal record lacks provenance
- validate that no Reality response is counted as evidence without a source,
  repository surface, command, explicit absence, external finding, or human note
- validate that no thread-mined decision is treated as accepted without an
  acceptance record
- keep generated plans separate from accepted Basis state and implemented code

The first smoke test SHOULD produce an implementation-plan packet for a narrow
change in this repository. It SHOULD compare recursive search against an
ordinary single-pass baseline and prove that every proposed work slice maps to a
source obligation, a repository surface, and a validation gate. It SHOULD also
include a tiny thread-like fixture that mines at least one proposed decision,
one rejected alternative, and one missing acceptance record into the next search
pass.

## 24. Anti-Goals

The imaginer MUST NOT become:

- a general chat transcript summarizer
- a tool that treats thread phrasing as accepted project policy
- a code generator that bypasses planning acceptance
- a project-management system
- an issue tracker replacement
- an external search cache without provenance
- a one-prompt architecture generator
- recursive theater that creates deeper traces without better evidence
- a UI fixture that owns planning semantics
- a way to treat model confidence as evidence

Its job is narrower: make implementation planning explicit, researched,
falsifiable, and reviewable before code changes begin.
