# Basis Agent Contract

You are working in `/Users/ericfode/src/basis`.

This repository is about improving the coordinate system of specifications. Act
accordingly. Do not turn Basis into a pile of prose, screenshots, raw chat
history, or one enormous JavaScript file that happens to display something.

## Local Authority

Read these before making non-trivial changes:

- `spec.md`: the core Basis contract.
- `components/spec-basis-reducer/spec.md`: the reducer component contract.
- `docs/elixir-beam-practices.md`: the Elixir/BEAM runtime guidance for the
  rewrite.
- `components/spec-basis-reducer/examples/*.md`: reference pressure, not
  canonical truth.

The current UI prototype lives at
`components/spec-basis-reducer/ui/index.html`. Treat it as a disposable
projection fixture unless the task explicitly says otherwise. Its embedded data,
rendering code, event simulation, SVG helpers, and DOM handlers are not an
architecture to preserve.

## Operating Sequence

For each task:

1. Recover state with `git status --short --branch`.
2. Read the smallest relevant spec and implementation surface.
3. Name the project boundary being touched: core state, reducer state, live run
   model, projection, adapter, fixture, or documentation.
4. Make one narrow change.
5. Verify with the strongest available local gate.
6. Leave the repository easier to continue than you found it.

When the repo has no formal gate for the touched surface, use structural checks:
open the static HTML if relevant, run any available formatter or linter only if
the repo already owns one, and inspect diffs for accidental scope growth.

## Basis Aesthetic

Prefer explicit state over implicit behavior.

The durable shape should be:

- structured records before prose projections
- event logs before mutable UI state
- provenance before confidence
- proposal before acceptance
- adapters after core contracts
- narrow files with named ownership before large convenience scripts

Raw Markdown, generated prose, model output, chat transcripts, and UI caches are
not authoritative Basis state unless an explicit acceptance step records them as
such.

## Implementation Language

Use Elixir on the BEAM for the core implementation.

The hard part of Basis is not isolated theorem proving. It is custody of
context while many workers read, fork, reduce, block, synthesize, critique,
interrupt, and resume without collapsing execution history into semantic
authority. That is a supervision and message-passing problem before it is a
proof problem.

The rewrite should prefer:

- OTP supervision trees for reducer runs, section workers, synthesis workers,
  adapters, validators, and projection processes
- append-only event logs as the durable run authority
- typed structs and explicit transition functions for Basis state, reducer
  records, witnesses, topologies, verdicts, lifecycle states, and interventions
- GenServer or Broadway-style workers for long-running and model-assisted work
- PubSub or LiveView-style projections for the attention UI
- explicit context packets passed between workers instead of hidden global state
- adapters at the process boundary for app-server threads, model providers,
  files, issue trackers, and generated artifacts

Lean 4 remains valuable, but as a formal projection over accepted Basis state:
generated facts, handwritten theory, and proof obligations should be emitted
from the Elixir-owned run model when the project needs formal pressure. Lean
must not own live context orchestration.

Do not make TypeScript, JavaScript, Rust, Swift, Python, or Lean the runtime
core. They may appear only as adapters, render shells, formal projections, or
temporary migration tools. A browser UI should consume projected run models; it
must not own Basis semantics or worker coordination.

If a custom surface language is needed, build it as a small Basis DSL using
Elixir data, macros, and validated event records. The point is not public
ergonomics. The point is to make context boundaries explicit, worker handoffs
auditable, and semantic drift visible while the run is still live.

## JavaScript And UI Rules

Do not grow `components/spec-basis-reducer/ui/index.html` as a giant JavaScript
container. If UI work becomes more than a tiny text or style fix, split it first
or as part of the same patch.

Use native browser modules unless a task justifies introducing a build system.
Prefer this shape:

- `model/`: schemas, record types, constants, and lifecycle vocabulary
- `fixtures/`: sample run data and reference packets
- `state/`: event-log application, reducers, selectors, and derived counters
- `projections/`: view models generated from run state
- `renderers/`: DOM, SVG, diagram, and chart renderers
- `adapters/`: app-server, storage, file, or network boundaries
- `tests/`: deterministic checks over state transitions and projections

A single file must not own fixture data, lifecycle mutation, projection logic,
diagram rendering, DOM event wiring, and adapter behavior at the same time.
That is the exact failure mode this project exists to avoid.

Keep UI state subordinate to the run model. The UI may cache counters,
selection, and layout affordances, but the event log, proposed records,
intervention events, and packet versions remain the inspectable truth.

## Reducer Implementation Rules

Reducer output is a proposal. It does not become accepted Basis state without an
acceptance record.

Every semantic record should carry:

- target projection affected
- source evidence or explicit absence of evidence
- provenance back to source material and, when model-assisted, fork identity
- a falsifiable witness explaining how the label could be rejected, demoted,
  merged, split, or replaced
- known loss, uncertainty, or review caveat

Preserve the three topologies separately:

- execution topology: threads, turns, forks, runners, and owners
- source topology: files, sections, ranges, hashes, and artifacts
- semantic topology: pivots, derived records, redundancies, couplings,
  conflicts, dependencies, and interfaces

Collapsing those into one graph is a design regression.

## Adapter Boundaries

The app-server, issue trackers, model providers, local storage, generated
diagrams, and any future workflow runner are adapters. They can provide
execution provenance or projections. They must not silently define Basis
semantics.

Keep adapters thin and replaceable. Provider-specific behavior belongs at the
edge, not in core state transformation code.

## Pressure Questions

Use these questions while designing and reviewing changes:

- What authoritative state changes?
- What is only a projection?
- What source or event proves this record exists?
- What would a target projection have to invent if this were removed?
- Is this an independent dimension, a derived view, a duplicate, or a coupled
  record hiding several obligations?
- What acceptance step would make this durable?
- What file boundary prevents this from becoming another monolith?

If a patch cannot answer those questions, reduce its scope or add the missing
structure before expanding behavior.

## File Hygiene

Prefer small, named modules with plain contracts. Add an abstraction only when
it separates a real Basis boundary or removes meaningful duplication.

Avoid:

- broad rewrites without a named target projection
- hidden state in DOM nodes
- stringly typed record plumbing where a schema or structured object is viable
- generated output that overwrites `spec.md` or accepted state
- snapshots that become authority without provenance
- cosmetic UI work that obscures whether the run model is correct

When a file starts carrying multiple responsibilities, split by Basis boundary
first, framework preference second.
