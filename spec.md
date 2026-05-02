# Spec Gym Specification

Status: Draft v0.2

Purpose: Define a tool-neutral, collaborative spec verifiability environment for
turning prose specifications into playable, inspectable, criticizable, and
formalizable state before prototype work begins.

## Normative Language

The key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`,
`RECOMMENDED`, `MAY`, and `OPTIONAL` in this document are to be interpreted as
described in RFC 2119.

`Spec Gym` means the environment and CLI surface.

`Claim lattice` means the canonical model: claims, refinements, obligations,
evidence, verification surfaces, critiques, actors, reward signals, and terminal
states.

`Adapter` means a projection from the claim lattice into a particular tool, file
format, API, or workflow. Adapters are implementation surfaces, not the core
model.

## 1. Problem Statement

Teams often write specifications as unstructured text, then discover only during
prototype or implementation that the idea is impossible, useless, more complex
than the baseline, or aimed at the wrong problem.

Spec Gym exists to move that failure earlier. It turns a prose specification
into a collaborative environment where humans, agents, provers, test runners,
adapters, and future learned policies can play durable refinement moves against
the same state.

The point is not to prove the whole idea automatically. The point is to make the
verifiable parts explicit: claims, source anchors, evidence, tests, proof
obligations, contradictions, missing validation, and rejection pressure.

Spec Gym is not a diagram product, project-management system, prover,
whiteboard, graph database, or agent runner. It can emit adapters for those
systems, but it MUST preserve a tool-neutral core.

## 2. Goals and Non-Goals

### 2.1 Goals

- Parse Markdown specifications into a canonical claim lattice.
- Preserve source structure and line-level evidence.
- Extract addressable claims from headings, bullets, and normative sentences.
- Classify claims into a small, stable ontology.
- Detect early bad-idea pressure with explainable evidence.
- Emit a viability critique for human and agent review.
- Emit a refinement packet for the next narrow correction.
- Emit a prover-facing model that can become sharper over time.
- Expose an environment boundary suitable for future RL: observation, action,
  actor, reward, done state, and safety invariant.
- Support optional adapters for collaboration, graph query, architecture
  projection, knowledge vaults, formal models, and execution queues.

### 2.2 Non-Goals

- Owning multiplayer canvas infrastructure.
- Owning identity, comments, permissions, or live cursors.
- Owning a graph database.
- Requiring a specific issue tracker, diagram tool, prover, or agent runner.
- Treating adapter output as canonical specification state.
- Replacing human judgment or domain expertise.
- Making reward metrics authoritative over recorded rationale.

## 3. Core Artifacts

Default generation MUST emit only core artifacts:

- `claim-lattice.json`
- `viability-critique.md`
- `ClaimLattice.lean`
- `refinement-packet.md`

Default generation MUST NOT emit named adapter files.

Adapter output MUST be opt-in.

## 4. Claim Lattice

### 4.1 Node Types

- `spec`: root input document.
- `section`: source heading and line range.
- `goal`: desired outcome.
- `non_goal`: explicit boundary.
- `requirement`: normative claim.
- `component`: named subsystem, actor, layer, or responsibility.
- `dependency`: external system, file, tool, API, or host assumption.
- `test`: validation surface or conformance check.
- `risk`: safety, recovery, trust, failure, or ambiguity pressure.
- `claim`: extracted assertion not yet sharpened.
- `finding`: generated bad-idea pressure.

### 4.2 Edge Types

- `contains`: structural containment.
- `elaborates`: source claim elaborates a section.
- `evidences`: source node supports a finding.
- `pressures`: finding pressures a source node.
- `tensions`: source nodes appear to conflict.

### 4.3 Stability

Node IDs SHOULD be deterministic for the same source text and heading structure.

The schema MUST be versioned.

Line references SHOULD be preserved whenever the input format supports them.

## 5. Environment Boundary

Spec Gym MUST treat the human as a first-class player, not an external approver.

The environment state SHOULD expose:

- `observation`: source spec, source anchors, claim lattice, obligation graph,
  viability critique, verification surfaces, and adapter outputs.
- `action`: split, merge, strengthen, weaken, restate, classify, add evidence,
  add negative test, add proof obligation, mark non-goal, reject idea, or ask for
  a narrower experiment.
- `actor`: human, agent, prover, test runner, adapter, or policy.
- `reward`: verifiability score delta, traceability score delta,
  falsifiability score delta, contradiction reduction, ambiguity reduction,
  obligations discharged, negative tests rejected, or invalid idea rejected.
- `done`: implementation-ready threshold reached, idea rejected, or unresolved
  state preserved with named missing evidence.
- `safetyInvariant`: a player cannot improve score by deleting source evidence
  or weakening the stated problem without recording that tradeoff.

## 6. Bad-Idea Pressure

The toolkit SHOULD detect at least these failure modes:

- `impossible`: constraints cannot all hold at once.
- `useless`: success does not improve the stated problem.
- `more_complex_than_nothing`: coordination cost exceeds justified value.
- `misses_problem`: machinery optimizes adjacent work instead of the problem.
- `underspecified`: behavior-affecting choices are unnamed.
- `unfalsifiable`: no clear validation could prove the idea wrong.

Findings MUST include:

- class
- severity
- title
- explanation
- evidence node IDs when available

Findings are not final authority. They are prompts for correction, rejection, or
formal elaboration.

## 7. Refinement Packet

The refinement packet is a tool-neutral work instruction derived from the
current claim lattice and viability critique.

It SHOULD:

- rank current findings by severity
- identify evidence nodes
- require exactly one narrow correction or rejection move
- name the actor when known
- require regeneration of core artifacts
- require verification gates
- avoid naming a specific runner unless emitted by an adapter

## 8. Formalization Boundary

The prover-facing artifact SHOULD model the algebra of the claim lattice rather
than raw prose.

Initial formal surfaces include:

- bad-idea classes
- severity
- graph counts
- core-surface presence
- prototype-readiness predicates

The toolkit SHOULD separate generated facts from handwritten theory once the
formal model grows beyond the mock stage.

## 9. Adapter Boundary

Adapters MAY target specific tools, but the core model MUST remain tool-neutral.

Adapter capabilities include:

- `collaborative_map`
- `graph_query`
- `architecture_projection`
- `knowledge_vault`
- `formal_model`
- `execution_queue`

Each adapter MUST state:

- capability served
- input schema version
- emitted files or API calls
- import or execution instructions
- lossy transformations
- verification command or manual check

An adapter MUST NOT introduce required core node types or change claim-lattice
semantics.

## 10. Reference Inputs

The toolkit SHOULD be validated against specifications that are already useful
as documents.

Current reference inputs:

- `/Users/ericfode/src/openai-symphony/spec.md`
- `https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f`

Reference inputs are examples. Their local tool choices MUST NOT become toolkit
requirements.

## 11. Definition of Done for Current Increment

The repository is acceptable when:

- `spec.md` is the top-level authoritative specification.
- The primary CLI is `specgym`.
- Default generation emits only core artifacts.
- Named projections are opt-in.
- The adapter boundary is documented.
- The Symphony service specification can be played as an example input.
- The Lean mock model type-checks.
- The local tests pass.
