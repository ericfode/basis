# Spec Gym

Spec Gym turns prose specifications into a collaborative spec verifiability
environment. A spec becomes a playable state: humans, agents, provers, tests,
adapters, and future learned policies can refine claims, add evidence, expose
obligations, score verifiability, and reject weak ideas before prototype work
gets expensive.

The authoritative specification for this repository is [spec.md](/Users/ericfode/Documents/New%20project%204/spec.md).

## Current Increment

The first tool is intentionally small and deterministic. It does not prescribe a
graph UI, project manager, prover, or execution system.

```sh
npm run play:symphony
npm run play:self
npm test
```

The Symphony example command reads:

```text
/Users/ericfode/src/openai-symphony/spec.md
```

and writes:

```text
out/symphony/claim-lattice.json
out/symphony/viability-critique.md
out/symphony/ClaimLattice.lean
out/symphony/refinement-packet.md
```

The self-spec command reads top-level `spec.md` and writes:

```text
out/spec/claim-lattice.json
out/spec/viability-critique.md
out/spec/ClaimLattice.lean
out/spec/refinement-packet.md
```

## CLI

```sh
node src/specgym.mjs play spec.md --out out/spec
node src/specgym.mjs score spec.md --out out/spec
node src/specgym.mjs step spec.md --action split_claim --claim claim-12
node src/specgym.mjs rollout spec.md --policy human
node src/specgym.mjs export spec.md --projection symphony
```

`image` remains a compatibility alias for `play`, but the primary command is
`specgym`.

## Model

The canonical model is a claim lattice.

- `section` nodes preserve the source document structure.
- `goal`, `non_goal`, `requirement`, `component`, `dependency`, `test`, `risk`,
  and `claim` nodes make prose assertions addressable.
- `finding` nodes represent bad-idea pressure.
- Edges record containment, elaboration, evidence, and detected tension.
- The environment block records actors, actions, reward signals, done states,
  and the safety invariant for human and automated play.

This is deliberately not a semantic parser and not a diagram editor. It is a
legibility layer that creates stable handles for later human editing and
formalization.

## Optional Projections

Named tools are adapters, not part of the specification model.

```sh
npm run play:symphony:projections
node src/specgym.mjs export spec.md --projection kumu --projection neo4j
```

Known projections in this increment:

- `kumu`
- `neo4j`
- `structurizr`
- `symphony`

The canonical artifact remains `claim-lattice.json`. Projection files are
disposable views over the model.

## Bad-Idea Pressure

The first classifier looks for six failure modes:

- `impossible`: direct normative contradictions or unbounded requirements.
- `useless`: missing problem, goal, actor, or validation surface.
- `more_complex_than_nothing`: structure that grows faster than justified
  goals/tests.
- `misses_problem`: goals and validation do not overlap with the stated problem.
- `underspecified`: normative claims use vague language or
  implementation-defined behavior without a visible obligation.
- `unfalsifiable`: no clear validation could prove the idea wrong.

The output is not a verdict from authority. It is a queue of things that should
be resolved or explicitly accepted before prototype work becomes expensive.

## Prover Direction

`ClaimLattice.lean` is a mock target, not the final formalization. Its job is to
name the algebra:

- bad-idea classes
- severity
- graph counts
- presence of core surfaces
- rejection conditions

The next useful step is to make user moves in the environment become changes to
the Lean-facing model instead of regenerating a static sketch.
