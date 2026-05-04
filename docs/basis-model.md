# Basis Model

## Purpose

Basis turns prose into a collaborative verifiability environment. The
low-loss interchange artifact is a dataified spec: structured source blocks,
anchors, and semantic overlays that can be rendered back toward Markdown with
minimal loss. The canonical semantic artifact is a claim lattice: an
intermediate model between prose and implementation that can be inspected,
attacked, scored, formalized, refined, or rejected.

Transforms are not deterministic at the product boundary. Repeated runs may
produce different Markdown or model output. The model is useful because changes
are source-anchored, reviewable, and measurable, not because replay is byte-for-
byte identical.

## Pipeline

1. Read a Markdown specification.
2. Preserve its raw Markdown blocks, heading tree, and source anchors in
   `dataified-spec.json`.
3. Extract addressable claims from bullets and normative sentences.
4. Classify the claims into a small ontology.
5. Add viability findings as first-class graph nodes.
6. Emit:
   - `dataified-spec.json`
   - `claim-lattice.json`
   - `viability-critique.md`
   - `refinement-packet.md`
   - `ClaimLattice.lean`
7. Optionally emit focused LLM call packets for projections described by
   Markdown files in `projections/`.

## Environment Contract

The environment block makes Basis usable by humans now and by learned
policies later.

- `observation`: source spec, source anchors, claim lattice, obligation graph,
  viability critique, verification surfaces, and projection outputs.
- `action`: split, merge, strengthen, weaken, restate, classify, add evidence,
  add negative test, add proof obligation, mark non-goal, reject idea, or ask for
  a narrower experiment.
- `actor`: human, agent, prover, test runner, adapter, or policy.
- `rewardSignals`: measurable improvements such as verifiability,
  traceability, falsifiability, contradiction reduction, ambiguity reduction,
  obligation discharge, and invalid-idea rejection.
- `doneStates`: implementation-ready, rejected, or unresolved with named missing
  evidence.
- `safetyInvariant`: no actor may improve score by deleting evidence or
  weakening the problem statement without recording that tradeoff.

## Node Types

- `spec`: one root per input document.
- `section`: source heading with line range.
- `goal`: desired property or outcome.
- `non_goal`: explicit boundary.
- `requirement`: normative `MUST`, `SHOULD`, `MAY`, or `REQUIRED` claim.
- `component`: named subsystem, actor, layer, or service part.
- `dependency`: external system, file, tool, or host assumption.
- `test`: validation surface or conformance check.
- `risk`: safety, recovery, trust, failure, or ambiguity pressure.
- `claim`: extracted assertion that does not yet fit a sharper type.
- `finding`: bad-idea pressure produced by an evaluator.

## Edge Types

- `contains`: tree or section containment.
- `elaborates`: prose claim elaborates a section.
- `evidences`: a source node supports a finding.
- `pressures`: a finding pressures a source node.
- `tensions`: two source nodes appear to conflict.

## Editing Rule

User interaction should converge toward sharper structure:

- split vague claims into smaller requirements
- connect goals to tests
- mark implementation-defined areas with selected policies
- add negative tests or counterexamples
- demote speculative ideas into questions
- promote stable claims into prover terms
- reject ideas that fail before prototype

## Formal Boundary

The prover should not ingest raw prose as truth. It should ingest a normalized
claim lattice:

```text
prose -> dataified spec -> claim lattice -> typed policy/model -> proofs/checkers
```

The model remains useful even when the prover changes. Lean, Coq, Isabelle,
TLA+, Alloy, or a custom checker can target the same state.

## Projection Rule

The claim lattice and dataified spec are source artifacts. External formats are
projections:

- `all-data-types` extracts type candidates
- `all-protocols` extracts protocol candidates
- `network-requirements` extracts network-scoped requirements
- `aws-architecture` emits an AWS-flavored architecture document
- `architecture-to-spec` emits a reviewable `spec.md` draft from an
  architecture document and is explicit-only
- `implementation-questions` emits implementation-blocking questions
- `spec-tests` emits a test-suite draft from spec claims
- `tests-to-spec` emits a reviewable `spec.md` draft from tests and is
  explicit-only
- `code-to-spec` emits a reviewable `spec.md` draft from focused code slices
  and is explicit-only, not part of `--projection all`

Projection Markdown files define what to extract. JSON schemas under `types/`
define the target contracts. Projection outputs should be compared across many
runs to measure and reduce drift.

Local code does not synthesize final projection content. It focuses the source
into small call packets, records the target contract, and leaves projection
generation and merge to LLM calls.

Projection training composes two projections into a repeated cycle. For
example, `aws-architecture` can be paired with `architecture-to-spec`, or
`spec-tests` with `tests-to-spec`. The judge compares the returned spec draft
against the original dataified spec and claim lattice to measure drift, lost
anchors, invented claims, and collapsed uncertainty.

## Historical Mining

Historical mining treats a Git repository as evidence for an as-built spec. The
current `mine` command samples first-parent history from the earliest reachable
root or an explicit `--since` commit, infers feature claims from source,
documentation, configuration, tests, and command surfaces, and runs a
writer/judge prompt-policy loop.

The loop is intentionally artifact-first:

- writer policies propose candidate specs from observed features
- the judge scores each candidate against sampled snapshots
- reward prioritizes temporal validity from the root snapshot
- coverage measures how much stable high-weight project essence is explained
- later-only features are reported as drift, not silently backdated

The output is still a draft. A mined spec is evidence about project behavior
across history, not proof of maintainer intent.
