# Spec Gym Model

## Purpose

Spec Gym turns prose into a collaborative verifiability environment. The
canonical artifact is a claim lattice: an intermediate model between prose and
implementation that can be inspected, attacked, scored, formalized, refined, or
rejected.

## Pipeline

1. Read a Markdown specification.
2. Preserve its heading tree and source anchors.
3. Extract addressable claims from bullets and normative sentences.
4. Classify the claims into a small ontology.
5. Add viability findings as first-class graph nodes.
6. Emit:
   - `claim-lattice.json`
   - `viability-critique.md`
   - `refinement-packet.md`
   - `ClaimLattice.lean`
7. Optionally emit adapter projections for specific tools.

## Environment Contract

The environment block makes Spec Gym usable by humans now and by learned
policies later.

- `observation`: source spec, source anchors, claim lattice, obligation graph,
  viability critique, verification surfaces, and adapter outputs.
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
prose -> claim lattice -> typed policy/model -> proofs/checkers
```

The model remains useful even when the prover changes. Lean, Coq, Isabelle,
TLA+, Alloy, or a custom checker can target the same state.

## Adapter Rule

The claim lattice is the source artifact. External tools are adapters:

- multiplayer whiteboards are good for workshops
- graph databases are good for search and topology queries
- architecture DSLs are good for implementation handoff
- prover models are good for invariant pressure
- agent runners are good for executing a selected next increment

No adapter should become part of the core specification contract.
