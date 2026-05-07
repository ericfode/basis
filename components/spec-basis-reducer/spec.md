# Spec Basis Reducer Component Specification

Status: Draft v0.2

Purpose: The Spec Basis Reducer is the component that takes an overcomplete
prose specification and proposes a smaller, more independent Basis state for
explicit projection targets.

It is not a general semantic processor. It is a skeptical reduction process. Its
job is to ask whether the current spec is using too many dimensions, hiding
several dimensions inside one record, or missing dimensions that downstream
projectors would otherwise invent.

The words `MUST`, `MUST NOT`, `SHOULD`, and `MAY` are used as normative terms.

## 1. Product Boundary

The reducer owns:

- reading source specs and related artifacts as input material
- dividing large source material into reviewable ranges
- extracting candidate basis dimensions
- marking derived, redundant, and coupled records
- naming missing dimensions that block target projections
- synthesizing a target-relative basis packet
- preserving provenance from each proposed record back to source material
- producing reviewable proposals for acceptance into Basis state

The reducer does not own:

- the accepted Basis state store
- projection generation into code, tests, diagrams, tickets, or proofs
- editor UI, graph UI, comments, permissions, or collaboration features
- issue tracker, agent runner, model provider, or hosted runtime policy
- automatic acceptance of model-generated structure

Reducer output is a proposal. It MUST NOT become accepted Basis state without an
explicit acceptance step.

## 2. Core Problem

Specs usually begin as overcomplete generating sets. They contain useful
conceptual material, but the coordinates are poor:

- one requirement is repeated in several forms
- one paragraph hides several independent obligations
- derived operational facts are written as primitive requirements
- rejected alternatives vanish
- important dimensions are implicit
- code-facing policy is left for the implementer or model to invent

The reducer tries to improve the coordinate system. It does not prove it has
found the true basis. It proposes a smaller candidate basis that should be easier
to compose, pressure, validate, and project.

## 3. Inputs

A reducer run MUST declare:

- source material paths
- source material hashes when available
- target projections under review
- actor or runner identity
- model-assisted steps, if any
- section ranges assigned to reviewers

The primary input MAY be Markdown, but Markdown structure is only source
material. Heading trees, line anchors, and blocks are useful for provenance, not
the native state the reducer is trying to produce.

## 4. Target Projections

Reduction is target-relative. A run MUST name at least one target projection.

Initial target projection classes:

- `code`: implementation surface
- `tests`: executable validation surface
- `schema`: structured data contract
- `proof`: formal or semi-formal obligation
- `diagram`: visual relationship view
- `ticket`: work breakdown or issue handoff
- `runbook`: operational procedure
- `spec_composition`: connection to another spec basis
- `software_map`: links between spec records and existing artifacts

A record is missing when a named projection would need to invent behavior,
choose policy silently, or hide an unresolved question.

## 5. Candidate Records

The reducer MUST propose records using these classes:

- `pivot`: an apparently independent dimension needed by a target projection
- `derived`: a record that can be computed from one or more pivots
- `redundant`: a record that restates another record without adding dimension
- `coupled`: a record that hides several dimensions and should be split
- `missing`: a dimension required by a target projection but not present enough
- `conflict`: records that cannot all hold as written
- `open_question`: a behavior-affecting uncertainty
- `rejected_alternative`: an idea that should continue constraining the space
- `software_link`: a relation between a record and a software artifact

Normative optionality is not itself an `open_question`. A `MAY`, an explicit
optional allowance, or a not-chosen affordance becomes blocking only when the
source leaves behavior undecided for a named projection through an explicit
issue marker such as `TBD:`, `TODO:`, `FIXME:`, `UNCLEAR:`, `UNKNOWN:`,
`UNRESOLVED:`, or `OPEN QUESTION:`. Descriptive prose that merely explains
unclear policy, questions, or unknown choices MUST NOT become an `open_question`
without such an issue marker. The reducer SHOULD preserve explicit optional
allowances as ordinary source-backed records or not-chosen/loss entries rather
than forcing a human decision where the spec has already made the choice
optional.

Likewise, several line-separated obligations in one section are not enough to
declare a blocking `coupled` record. A `coupled` label SHOULD be reserved for a
fused obligation whose witness cannot name clean child dimensions without
additional split work, such as one source sentence carrying multiple normative
operators or hiding several policies behind one surface.

When the reducer can deterministically project source-backed child dimensions
for a fused obligation, it SHOULD emit those children as replacement proposal
records and keep the parent coupling only as a traceable split witness. A
coupled parent with a complete replacement-record list MUST NOT block
projection-completeness by itself; a `coupled` verdict is reserved for fused
obligations whose child replacement records are absent or invalid.

Each proposed record MUST include provenance. A record without provenance is
only analysis scratch, not reducer output.

Each proposed semantic record MUST also include a falsifiable witness:

- target projection affected by the record
- source evidence or explicit absence of source evidence
- producer fork ID and supporting fork IDs when model-assisted
- independence or removal test for `pivot`
- derivation inputs for `derived`
- duplicate target and delta analysis for `redundant`
- split rationale and proposed child dimensions for `coupled`
- invention pressure for `missing`
- incompatible records for `conflict`
- behavior affected for `open_question`
- decision pressure preserved for `rejected_alternative`
- known loss, uncertainty, or review caveat

Forked execution makes reduction auditable. It does not make the semantic labels
true. A label such as `pivot`, `derived`, or `coupled` is reviewable only when
its witness says how the claim could be rejected, demoted, split, or merged.

## 6. Reduction Process

A reducer run SHOULD follow this sequence:

1. Declare target projections.
2. Read the complete source under optimization in one root session.
3. Fork from the root read before any section-specific interpretation.
4. Add explicit separators and metadata to a working copy of the source.
5. Build a section manifest over the working copy.
6. Split the manifest into section jobs and structured input records.
7. Fork specialized section sessions from the pre-split root context.
8. Extract candidate pivots, derived records, redundancies, couplings, missing
   dimensions, conflicts, rejected alternatives, and projection targets.
9. Merge duplicate pivots across ranges.
10. Promote repeated missing dimensions to candidate pivots.
11. Demote operational copies into derived records.
12. Split high-value coupled records.
13. Preserve conflicts and open questions instead of pretending to resolve them.
14. Infer the process-specific user interface needed to inspect the run.
15. Emit a basis packet, critique packet, and UI run model for human review.

The reducer SHOULD be allowed to use many reviewers or subagents. Parallelism is
an execution strategy, not a semantic guarantee. The synthesis step remains
responsible for deduplication, conflict preservation, and provenance.

## 7. Live Run Topology

The reducer is a live process, not only a batch transform.

A run MUST expose a run graph with these node kinds:

- `root_read`: reads the full source and records source identity
- `working_copy`: inserts separators and metadata without changing accepted
  source authority
- `section_manifest`: enumerates section ranges and stable section IDs
- `section_job`: structured work item for one section or section group
- `section_fork`: app-server thread fork specialized to one section job
- `section_result`: proposed records extracted from a section fork
- `synthesis`: merge, deduplicate, split couplings, and preserve conflicts
- `ui_inference`: infer what the human needs to see or interrupt
- `basis_packet`: target-relative reduction output
- `critique`: comparison against references, expectations, and pressure
- `acceptance_gate`: human or policy decision over proposed state changes

The graph MUST preserve parent-child relationships among app-server threads,
turns, section jobs, and output records.

The reducer MUST distinguish:

- execution topology: which app-server thread or turn produced a result
- source topology: which source section or artifact supports a result
- semantic topology: which basis records depend on, duplicate, conflict with, or
  derive from other records

Collapsing these topologies into one graph would hide exactly the structure the
component is meant to expose.

## 8. App-Server Forking Model

The app-server is the execution substrate for model-assisted reducer work.

A reducer implementation SHOULD use this thread pattern:

1. Start a root thread with the full source and target projections.
2. Run a root read turn that produces only global orientation and source
   identity.
3. Fork from the root thread before the splitting prompt.
4. In a working-copy turn, add separators, section IDs, source hashes, and line
   ranges.
5. Split the working copy into section jobs.
6. For each section job, fork from the pre-split root thread and provide only
   the section job, target projections, reducer algorithm, and source metadata.
7. Run specialized section turns that extract candidate records.
8. Fork synthesis from the root thread with all section results as structured
   input.
9. Fork critique from synthesis with the basis packet and comparison references.

Forking is useful only if it reduces contamination and preserves provenance. A
section fork SHOULD inherit the shared problem framing but MUST NOT inherit
other section conclusions unless synthesis explicitly supplies them.

The app-server thread is not the authoritative store. It is an execution and
display container. Durable run state MUST be recorded separately with thread IDs
and turn IDs as provenance.

## 8A. LLM Lens Runtime

Semantic reduction MUST be driven by named LLM lens jobs. Deterministic source
processing MAY build source identity, section ranges, line hashes, and context
packet scaffolds, but it MUST NOT be the authority for semantic labels such as
`pivot`, `derived`, `redundant`, `coupled`, `missing`, `conflict`,
`open_question`, or `rejected_alternative`.

Each lens job MUST have an explicit context packet. The packet names:

- lens role and reducer purpose
- source path, source hash, section ID, and source range
- target projections under review
- source excerpt supplied to the model
- prior lens results supplied to the model
- excluded context that the lens must not rely on
- prompt or instruction contract
- context hash and budget

A semantic proposal is invalid unless it names the lens job and context packet
that produced it. Heuristics may queue attention hints or scaffold candidates,
but a synthesis lens MUST mark those as untrusted unless a model lens or human
review converts them into proposal evidence.

The reducer MUST stream live model-provider events for every running lens job.
The stream MUST include provider identity, Codex thread or session ID when
available, job ID, event type, event timestamp, and raw provider line or message
excerpt. Capturing only final model text or only thread identity is insufficient
for end-to-end observability.

The live UI MUST let a human inspect these streams while the run is active. When
the source document is visible, the UI SHOULD keep thread streams beside the
document section whose source range is currently in focus, and it SHOULD expose
links to the underlying Codex thread for escape-hatch inspection.

## 9. Human Intervention Interface

The reducer MUST have a live user interface designed for intervention.

The primary UI layout SHOULD be document-first: the source document remains the
central reading surface, and the live thread rail sits beside it. Scrolling or
selecting a source section SHOULD focus the rail on the Codex threads, lens
jobs, context packets, provider streams, and proposal evidence for that section.

The UI MUST show all active work at once:

- source coverage and section status
- app-server fork tree
- running, blocked, completed, and failed turns
- extracted pivots, redundancies, couplings, missing dimensions, conflicts, and
  rejected alternatives
- current synthesis decisions
- pressure findings
- projection-completeness verdicts by target
- critique against reference packets or expected outputs

The UI MUST allow a human to intervene without losing provenance:

- pause or resume a run
- stop a section fork
- request a rerun of a section with revised instructions
- split or merge section jobs
- mark a proposed pivot as derived, redundant, coupled, missing, conflict, open
  question, or rejected alternative
- attach a note to a record, section, fork, or synthesis decision
- accept, reject, or defer proposed records
- force a synthesis rerun from selected records
- compare current output with a reference packet

When a thread or section needs user input, the UI SHOULD expose an application
link to the relevant Codex thread, such as `codex://threads/<thread-id>`, while
keeping the durable run model as the authority.

Human attention is a scarce resource. The UI SHOULD rank intervention questions
by urgency, attention cost, and decision type:

- low-cost binary or constrained choices SHOULD be answerable in place
- accept, reject, and defer SHOULD be available for proposal decisions
- questions that need real feedback SHOULD state the smallest useful prompt
- thread links SHOULD appear only when opening the thread is likely to reduce
  total context switching
- the UI SHOULD identify the next best decision instead of making the human scan
  every active lane
- target verdicts SHOULD be askable, not only intervention cards
- an askable item SHOULD open a local question packet with relevant fragments,
  related records, current verdict or blocker, and a draft question before it
  asks the human to jump into a thread
- a thread link is a universal escape hatch, not a substitute for local context

The UI SHOULD be arranged as an attention ladder, not as equal-weight telemetry.
The primary surface SHOULD be the current human decision and its local question
packet. Section status, fork topology, reference comparison, and activity logs
SHOULD remain available, but they MAY be collapsed, compacted, or moved to
diagnostic rails when the run is healthy. A human SHOULD NOT need to inspect the
fork tree or raw event log to answer an ordinary intervention.

An askable question packet SHOULD include:

- the selected intervention or target verdict
- the user-facing question
- why the question matters now
- the precise ask
- expected decision effect
- relevant source fragments
- related proposed records and witnesses
- application links to relevant threads
- a question-specific diagram or other local visual explanation
- a counterfactual branch rollup when choices are available

Question-specific diagrams MAY be generated by model-written custom renderers.
Those renderers MUST be treated as projections over an explicit packet, not as
run authority. A renderer MUST NOT mutate durable run state. The renderer
source, input packet ID, and output artifact ID SHOULD be recorded so a human can
review or replace the explanation.

When an intervention presents a choice, the reducer SHOULD treat the choice as
a branch point before spending human attention. By default, it SHOULD fork
counterfactual worlds for each available choice, run the same question-finding
process in each world, recursively fork newly exposed choices, and stop at a
configured search depth. The initial depth limit SHOULD be 5.

The UI SHOULD roll up this branch search into a human-facing decision packet
instead of showing every fork equally. The rollup SHOULD name:

- the root choices explored
- the number of worlds explored per root choice
- newly exposed choices by depth
- dimensions that stabilize across all worlds
- dimensions that only appear under one root choice
- downstream projection pressure
- expected human attention saved
- the cheapest question that would distinguish the remaining worlds

A human with a strong opinion MUST be able to short-circuit the branch search by
choosing a root option directly. A short-circuit MUST be recorded as a run event
with the skipped branch depth, skipped alternatives, and the human-selected
policy.

The UI SHOULD expose entanglement maps for choices that are not locally
obvious. An entanglement map names the dimensions, projections, adapters,
invariants, and runtime policies tangled with a question. Entanglement cards
SHOULD be expandable: the collapsed view states the relationship; the expanded
view says how the relationship changes under each important choice.

Interventions MUST become first-class run events. The UI MUST NOT mutate reducer
output silently.

The UI is a projection and action surface over the durable run model. It MUST
NOT become a second controller or a substitute state store for reducer semantics.

## 10. Live Run Data

A live run model MUST include:

- run ID and source identity
- target projections
- section manifest
- app-server thread IDs and turn IDs
- job state for each section
- reviewer or agent identity for each job
- event log with monotonic event IDs
- proposed records with provenance
- intervention events
- synthesis decisions
- packet versions
- critique verdicts
- validation results

The UI MAY cache derived counters and summaries, but the event log and proposed
records remain the inspectable run state.

For an attention-first UI, the live run model SHOULD also include these
projection-ready objects. They are not accepted Basis state; they are the data
needed to make the live process legible.

Section jobs SHOULD include:

- stable section ID
- source range and human-readable source range label
- reviewer or agent display name
- lifecycle state
- progress or completion summary
- record tags or proposed dimension names
- thread link when a section has an active or blocked fork

Intervention records SHOULD include:

- stable intervention ID
- title, body, and user-facing question
- `meaning`: what the blocker means in ordinary design terms
- `precise_ask`: the smallest useful thing the human can decide
- `decision_effect`: what changes in the reducer if the choice is made
- lifecycle state
- urgency or priority
- attention cost class
- estimated decision time
- decision kind, such as binary, classification, or written feedback
- available choices with action, label, effect, and recommended status
- related source fragments
- related proposed records
- related target verdicts
- application links
- diagram kind or renderer reference
- entanglement map reference when relevant
- branch rollup reference when choices have been explored

Question packets SHOULD include:

- packet ID
- selected askable item ID
- current context summary
- relevant fragments
- related records and witnesses
- draft question text
- editable human note or question text
- relevant application links
- diagram or renderer output artifact
- branch rollup, if one exists

Branch rollups SHOULD include:

- branch search depth limit
- root choices explored
- world count per root choice
- downstream choice summaries by depth
- dimensions that stabilize across all branches
- dimensions introduced by only one branch
- target projection pressure per branch
- recommended branch, if any
- cheapest remaining discriminating question
- skipped depth and skipped alternatives when a human short-circuits

Critique items SHOULD expose a display label, not only a compact code. Initial
critique states are `pass`, `warn`, and `fail`, with UI labels such as `Pass`,
`Warn`, and `Fail`.

Activity charts and other telemetry projections MAY be regenerated from the
event log. They SHOULD stay visually secondary unless they indicate a blocked or
failed run.

## 11. Lifecycle, Ownership, And Blocking

A live reducer run MUST model lifecycle state explicitly.

Run and fork states:

- `queued`
- `reading_source`
- `metadata_insertion`
- `splitting`
- `forked`
- `running`
- `waiting_for_human`
- `synthesizing`
- `critiquing`
- `paused`
- `failed`
- `superseded`
- `complete`

Each state transition MUST name its owner:

- `reducer`: deterministic local process
- `app_server`: thread, turn, fork, or transport operation
- `section_worker`: specialized model-assisted section session
- `synthesis_worker`: merge and packet generation session
- `human`: intervention, acceptance, rejection, or instruction change
- `validator`: schema, provenance, or reference comparison gate

Blocking conditions SHOULD include:

- source hash drift
- invalid section manifest
- fork creation failure
- app-server protocol mismatch
- section worker timeout
- proposed record without provenance
- conflict requiring human policy
- missing dimension blocking a named projection
- low-confidence coupling split
- duplicate pivot merge ambiguity
- reference comparison regression
- validation failure

A blocked run MUST expose the blocking event, affected records, owning actor,
and available interventions.

## 12. Fork And Merge Semantics

Every fork MUST record:

- parent thread ID
- parent turn ID
- fork reason
- source snapshot
- section job or synthesis job
- inherited context
- intentionally excluded context
- model and runner configuration when available

Fork results merge at record level, not by concatenating prose.

A merge decision MUST state whether each incoming record is:

- accepted into the working proposal
- rejected but retained as pressure or alternative
- deferred
- merged with an existing record
- split into multiple records
- demoted from pivot to derived or redundant
- promoted from missing dimension to pivot

The merge controller MUST preserve provenance unions and record known loss.

## 13. Event Log Contract

The reducer MUST maintain an append-only run event log.

Events MUST include:

- event ID
- timestamp
- actor
- event type
- affected run, fork, section, record, or packet version
- input references
- output references
- human intervention payload when applicable
- validation result when applicable

The event log is the UI's operational truth for a live run. Derived panes,
counters, timelines, and summaries MAY be regenerated from it.

When the UI displays compact activity telemetry, events SHOULD carry enough
structure to group them without reading prose. Useful grouping fields include
actor, event type, affected object kind, affected object ID, severity, and
whether the event requires human attention.

## 14. Gas-City Control-Plane Prior Art

The first implementation SHOULD reuse the control-plane pattern demonstrated in
`/Users/ericfode/src/gas-city-but-its-just-codex`, not invent a separate
orchestrator.

Relevant reference artifacts:

- `/Users/ericfode/src/gas-city-but-its-just-codex/docs/architecture/basis-live-reducer-prior-art.md`
- `/Users/ericfode/src/gas-city-but-its-just-codex/templates/workflows/spec-basis-reducer-live.json`

The useful pattern is:

- a durable ledger or run-event store owns live reducer state
- app-server threads, turns, and forks are execution provenance
- a shared workspace carries proposed records, artifacts, and intervention
  payloads
- the UI is a projection over durable run state, not over raw chat history

The missing object is a first-class fork-topology record or equivalent durable
overlay. A live reducer MUST be able to record:

- run ID
- fork ID
- parent thread ID
- parent turn ID
- child thread ID
- fork reason
- source snapshot ID or hash
- section or synthesis job ID
- inherited context references
- intentionally excluded context references
- model and runner configuration
- merge policy
- lifecycle state
- related event IDs

This is not a request for a graph database. It is the minimum fact needed to ask
why a child result exists, what it was allowed to know, what it was prevented
from inheriting, and how its records may re-enter synthesis.

Thread rollout alone MUST NOT be treated as reducer authority. It is evidence
for execution topology. The ledger, event log, proposed records, and acceptance
events remain the reducer state.

## 15. Basis Packet

The reducer output is a basis packet.

A basis packet MUST include:

- source material identifiers
- target projections
- candidate pivots
- derived and redundant records
- coupled records, including split witnesses and unresolved records to split
- missing dimensions
- conflicts and open questions
- rejected alternatives when found
- composition interfaces
- software links when available
- projection-completeness verdict
- provenance for every proposed record
- semantic witness for every proposed record

The verdict MUST be one of:

- `complete`: no hidden invention is required for the named targets
- `blocked`: missing dimensions force invention
- `overcomplete`: targets are covered but redundant dimensions should be reduced
- `coupled`: targets are blocked because records hide multiple obligations and
  lack valid child replacement records

The verdict MUST name the target projection it applies to.

## 16. Acceptance Boundary

The reducer proposes structure. It does not accept structure.

Acceptance is a separate state change that MUST record:

- source Basis state or source material hash
- proposed basis packet
- accepted records
- rejected records
- known loss or unresolved pressure
- actor or reviewer
- validation gates

Rejected reducer records SHOULD remain visible when they constrain future work.

## 17. Pressure Questions

Every reducer run SHOULD apply these skeptical questions:

- Is this record actually independent?
- Is this a primitive dimension or a derived view?
- Is this one idea or several fused ideas?
- What projection would fail if this record were removed?
- What projection would need to invent policy if this record stayed vague?
- Is this complexity better than doing nothing?
- Does this machinery solve the core problem or an adjacent one?

The question "is this really a good idea?" is not a vibe check. It must attach
to a projection, a cost, a conflict, a missing dimension, or rejected evidence.

## 18. Symphony Reference Application

The first worked application target is the Symphony service spec:

- source: `/Users/ericfode/src/openai-symphony/spec.md`
- reference packet:
  `/Users/ericfode/.codex/skills/spec-basis-reducer/references/symphony-spec-basis-packet.md`

A reducer implementation SHOULD apply the live process to that spec and compare
the result against the reference packet.

The comparison MUST ask:

- Does the run identify scheduler, config, tracker, agent runner, workspace,
  observability, failure, validation, and formal invariant projection targets?
- Does it preserve the distinction between execution topology, source topology,
  and semantic topology?
- Does it identify at least the same missing dimensions as the reference packet?
- Does it expose the high-value coupled records the reference packet names?
- Does the UI make it obvious where a human should intervene?
- Does the critique explain whether the new result fits the source at least as
  well as the reference packet?
- Does the run beat a do-nothing baseline that only preserves original prose and
  names obvious headings?

The reference packet is not canonical truth. It is a regression target for the
process until accepted Basis state exists. A reference comparison MUST NOT count
as success unless the result is also better than the do-nothing baseline for at
least one named target projection.

A first implementation MAY represent reference comparison as a critique item
and a `compare_reference` intervention request before the live reference adapter
exists. That representation is sufficient to avoid silently dropping the
surface only when the fidelity table names the missing adapter behavior as loss
and the UI exposes the comparison request as an event-ingested intervention.

## 19. Validation

A reducer implementation is acceptable when it can:

- produce a deterministic section manifest for a source spec
- preserve source provenance for proposed records
- produce a live run graph with app-server thread and turn provenance
- encode fork topology as durable run records, not only app-server history
- attach falsifiable semantic witnesses to proposed records
- distinguish pivots from derived and redundant records
- identify coupled records and name their hidden dimensions
- identify missing dimensions for explicit target projections
- emit a basis packet with a target-relative verdict
- emit a UI run model that allows intervention events to be reviewed
- emit attention-first question packets, branch rollups, entanglement maps, and
  compact telemetry projections when the UI needs them
- enforce lifecycle, fork, merge, blocking, and event-log contracts
- compare a run against a reference packet without making the reference
  authoritative
- keep generated proposals separate from accepted Basis state
- validate any gas-city workflow template used as live-run prior art

For the first implementation, a worked run over the Symphony service spec is a
valid smoke test if it produces a packet that names scheduler, config, tracker,
agent runner, workspace, observability, failure, validation, and formal
invariant projections.

## 20. Elixir Rewrite Boundary

The reducer runtime core MUST be implemented in Elixir/BEAM.

The current first-class implementation surfaces are:

- `Basis.Reducer.Source`: source identity, source hash, and line fingerprints
- `Basis.Reducer.SectionManifest`: deterministic source ranges
- `Basis.Reducer.ProposedRecord`: proposal-only candidate records with
  provenance and falsifiable witnesses
- `Basis.Reducer.Fidelity`: prior-contract coverage table
- `Basis.Reducer.Validation`: structural checks over targets, provenance,
  witnesses, and fidelity coverage
- `Basis.Reducer.Projection`: basis-packet and run-model projections
- `Basis.Reducer.Artifacts`: JSON artifact writer for UI and review surfaces
- `Basis.Run.Server`: live run owner, lens scheduler, provider-stream ingestor,
  and server-side action boundary
- `Basis.Reducer.ActionIngest`: validation and event append for browser-authored
  human review actions when importing offline action artifacts
- `Basis.Reducer.Projection.branch_rollups/2` and
  `Basis.Reducer.Projection.entanglement_maps/2`: projection-ready summaries
  for askable target verdicts
- `Basis.Reducer.Projection.fork_topology/1`: deterministic topology overlay
  for root, section, synthesis, and validation work
- `mix basis.reduce`: local runner for explicit target projections
- `mix basis.ingest_actions`: local runner for review action ingestion
- `Basis.Run.*`: supervised live-run spine, append-only events, explicit
  context packets, and replay transitions

The browser UI is a projection and command surface. It MUST NOT own
reducer semantics, section lifecycle, event ingestion, acceptance decisions, or
Basis state.

The web interface under `components/spec-basis-reducer/ui/` MUST be split into
native browser modules when it grows beyond a small fixture. Its default data
source is the live Elixir run model exposed by the local server. File loading is
allowed as a projection affordance; reducer mutation still belongs behind
Elixir event ingestion.

The interface MUST be interactive enough to support review work. At minimum it
SHOULD allow target selection, record filtering, record inspection, question
packet inspection, live provider streams, reviewer notes, accept/reject/defer
commands, action import, and export of bounded human action payloads.

The current UI MUST also expose the broader intervention surface named earlier
in this spec as server-side actions:

- pause and resume run requests
- section fork stop requests
- section rerun, split, and merge requests
- record reclassification requests
- notes on records, sections, forks, synthesis decisions, and reference items
- synthesis rerun requests
- reference comparison requests

These controls MUST call a live Elixir action endpoint when the run server is
available. Export-only controls are allowed only as an offline fallback and MUST
be labeled as such. Displaying a disabled or prose-only affordance is not
sufficient when the run model contains the relevant subject.

The review UI MUST format reducer evidence for a human before exposing raw
machine records. Witnesses and provenance SHOULD be rendered as named decision
rows, source fragments, short hashes, and explicit reject tests. Raw JSON MAY be
available only behind collapsed diagnostics.

Record inspection and draft actions SHOULD stay spatially local to the selected
record, especially in narrow or long-scrolling layouts. A side detail pane MAY
exist, but it MUST NOT be the only place where a clicked record explains what
changed or exposes its draft action controls.

The event log is an operational replay surface, not the default human work
queue. The UI SHOULD foreground replay events only when validation, severity, or
`requires_human_attention` marks them as issues. Healthy replay logs SHOULD be
collapsed into diagnostics.

The fidelity table SHOULD project as a coverage map. Each row SHOULD show the
prior surface, replacement or named-loss surface, status, and an edge strength
derived from coverage status. Long source references SHOULD be formatted as
short labeled references with full values available as diagnostic titles rather
than as opaque wrapped strings.

Browser interactions are not reducer authority by themselves. They become
durable reducer review state only when the live run server or
`mix basis.ingest_actions` validates the run ID, source hash, action count,
supported action, affected subject kind, affected subject ID, and subject-local
invariants such as target record ID, current record kind, section ID, synthesis
decision ID, lens job ID, context packet ID, provider stream ID, or reference
critique ID. Valid record accept/reject/defer actions append
`human_record_decision` events. Other valid intervention requests append
`human_intervention_requested` events. The reviewed projection MAY mark records
as accepted for the working packet, rejected as pressure, or deferred, but its
acceptance boundary remains `human_review_state_not_basis_state` until a
separate Basis acceptance record is created.

The browser MAY load reviewed artifacts, but it MUST re-check the reviewed
artifact against the currently loaded run model before displaying reviewed
badges. A forged or stale artifact with a matching run ID but unsupported
actions, mismatched current record kinds, unknown section IDs, unknown
synthesis decisions, or inconsistent review indexes MUST be displayed as
rejected import state rather than reviewed state.

The archived pre-Elixir UI fixture under
`components/spec-basis-reducer/archive/ui-prototype-2026-05-05/` is historical
pressure only. It is not runtime authority.

## 21. Fidelity Surface

A reduction candidate carries a contract-coverage table against the prior
contract. The table names every prior surface, its replacement surface, and any
dropped behavior. A reducer grade is invalid when a prior surface lacks either a
replacement or a loss entry. Shrinking prose is allowed only when each removed
obligation is represented by a remaining surface, a not-chosen entry, or a named
loss. Completion for named projections depends on this fidelity table in
addition to local pressure counts.

The table MUST cover at least:

- product boundary
- inputs
- target projections
- candidate records
- reduction process
- live run topology
- app-server forking model
- human intervention interface
- live run data
- lifecycle, ownership, and blocking
- fork and merge semantics
- event log contract
- basis packet
- acceptance boundary
- validation
- fidelity surface

Loss entries are allowed. Silent deletion is not.

## 22. Runner And Reader Procedures

The write-reducer-skills worktree exposed two reusable workflow requirements:
running a reducer and reading reducer output are separate procedures.

A reducer runner procedure MUST:

- recover repository state first
- require explicit target projections
- report source path, source hash, target projections, run ID, validation
  status, and output or projection location
- keep generated proposals out of `spec.md` unless a separate acceptance step
  records them
- fail loudly when validation fails

The local runner command is:

```sh
mix basis.reduce --source components/spec-basis-reducer/spec.md --out components/spec-basis-reducer/out/elixir-self --target code --target schema --target proof --target runbook
```

The local action ingestion command is:

```sh
mix basis.ingest_actions --run-model components/spec-basis-reducer/out/elixir-self/run-model.json --actions <exported-actions.json> --out components/spec-basis-reducer/out/elixir-self-review
```

A reducer reader procedure MUST read validation before interpretation. It SHOULD
then inspect telemetry or event counts, run model, basis packet, critique or
pressure, question packets, and only then propose the next action.

Reducer summaries MUST remain target-relative. They MUST NOT describe proposal
records as accepted Basis state.

## 23. Artifact Contract

The Elixir reducer does not need to reproduce the archived JavaScript artifact
set byte-for-byte, but it MUST preserve the useful surfaces:

- source identity
- section manifest
- section jobs
- proposed records
- synthesis decisions
- critique items
- basis packet
- question packets
- branch rollups
- entanglement maps
- fork topology overlay
- run model projection
- event log and replay source
- repository state snapshot
- fidelity table
- validation result

The current JSON artifact files are:

- `run-summary.json`
- `run-model.json`
- `basis-packet.json`
- `question-packets.json`
- `branch-rollups.json`
- `entanglement-maps.json`
- `fork-topology.json`
- `section-manifest.json`
- `proposed-records.json`
- `fidelity-table.json`
- `repo-state.json`
- `run-events.jsonl`
- `validation.json`

Action ingestion adds review artifacts rather than rewriting accepted Basis
state:

- `action-ingest-validation.json`
- `review-state.json`
- `run-model.review.json`
- `run-events.review.jsonl`

Future UI, app-server, model-provider, reference-comparison, and action-ingest
adapters MAY add richer packet files. Those adapters remain subordinate to the
Elixir-owned run model and event stream.
