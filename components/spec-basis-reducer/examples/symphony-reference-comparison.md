# Symphony Live Reducer Reference Comparison

Source under optimization: `/Users/ericfode/src/openai-symphony/spec.md`

Reference packet:
`/Users/ericfode/.codex/skills/spec-basis-reducer/references/symphony-spec-basis-packet.md`

UI fixture:
`/Users/ericfode/src/basis/components/spec-basis-reducer/ui/index.html`

Status: critique of the live reducer process against the prior reference packet.

## Fit

The live reducer process fits the reference packet's semantic result. It keeps
the same target projections:

- orchestrator runtime implementation
- configuration parser, schema, and validator
- issue tracker adapter contract
- agent runner adapter contract
- workspace manager and safety checks
- observability snapshot, logs, and status surfaces
- failure and recovery runbook
- validation and definition-of-done matrix
- formal invariant model
- optional extension registry

It also keeps the same high-value reduction shape:

- promote issue identity, effective config, tracker interface, eligibility,
  capacity, ownership, run attempt, agent session, workspace identity, retry,
  reconciliation, observability, failure, security, and extension policy as
  candidate pivots
- demote status surfaces, counters, workspace paths, available slots,
  `Claimed`, `Released`, HTTP status APIs, and DoD checklist copies into
  derived records
- split coupled records like runtime state, running entries, retry attempts,
  dynamic reload, workspace manager safety, app-server client, reconciliation,
  observability snapshot, SSH worker extension, and real integration validation
- keep missing dimensions visible instead of allowing the implementation to
  invent policy

## Improvement Over The Reference Packet

The reference packet is semantically strong but too batch-shaped. It says the
right things, but it does not make the process inspectable while it is running.

The live reducer process improves this by adding:

- app-server thread and turn provenance
- root-read, working-copy, section-fork, synthesis, critique, and acceptance
  nodes
- explicit lifecycle states for runs and forks
- intervention events as first-class run records
- blocking conditions that require human decision before merge
- record-level merge semantics
- an event log that can regenerate UI panes and summaries

This matters because the human is not merely reviewing a final artifact. The
human may pause, rerun, split, merge, demote, reject, or force synthesis while
the run is still unfolding.

## Remaining Regression Risk

The UI fixture is a prototype over embedded Symphony run data. It does not yet
prove real app-server integration.

The real implementation still needs:

- live thread and turn streaming from the app-server
- durable run-event storage outside the app-server thread
- source hashes and per-record line anchors
- schema validation for section jobs, proposed records, intervention events,
  and basis packets
- replay from event log into the UI
- real comparison against a machine-readable reference packet

The most important gap is provenance density. The prior reference packet gives a
source file and method, but most records do not carry source hashes and exact
line anchors. The live UI should make that omission hard to miss and impossible
to accept silently.

## Verdict

The proposed live reducer process fits the Symphony reference result at least as
well as the prior batch packet, provided the implementation treats the app-server
thread as execution provenance rather than durable authority.

For the `orchestrator runtime implementation` target, the correct verdict
remains:

- `blocked`: missing dimensions still force invention
- `overcomplete`: repeated derived coordinates still need reduction
- `coupled`: several records still hide multiple independent obligations

That is a good result for the reducer. It means the process is surfacing the
actual problem instead of pretending the prose is ready to project into code.
