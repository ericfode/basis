# Basis Specification

Status: Draft v0.5

Purpose: Basis is a way to explore and manipulate the latent space of
specifications. It helps a spec converge toward a useful basis: a smaller set of
independent conceptual dimensions that still spans the projections the project
needs. Markdown may bootstrap the system and MUST remain available as a human
review view, but Markdown is not the native form.

The words `MUST`, `MUST NOT`, `SHOULD`, and `MAY` are used as normative terms.

## 1. Product Boundary

Basis owns the representation and operations needed to work with spec essence:

- accepted structured state for a spec
- relationships among specs, claims, evidence, decisions, and software artifacts
- provenance between structured state and readable views
- projection-completeness checks for explicit targets
- rules for accepting, rejecting, composing, and replacing state
- required readable views for human review

External tools, runtimes, protocols, collaboration surfaces, and generated
artifacts are adapters unless a future spec change admits them into the core
contract.

Raw model output, projection output, and chat transcripts MUST NOT become
authoritative state without an explicit acceptance step.

## 2. Core Problem

Specifications are usually written in a bad coordinate system.

The prose contains the project intent, but not as a clean basis. It is typically
overcomplete and entangled:

- the same idea appears several times under different wording
- independent concerns are fused into one paragraph
- implementation accidents become apparent requirements
- hidden assumptions carry real weight
- missing dimensions are patched later by code, tests, or agent guesses
- rejected ideas disappear instead of constraining future choices
- interfaces to existing software are underspecified or implicit

In linear algebra, a basis does not have to be orthogonal. It has to span the
space without redundant vectors. Orthogonality is extra structure. For specs,
the analogous goal is not perfectly independent prose; it is a structured state
with fewer accidental dimensions, visible dependencies, and enough independent
concepts to span the projections the project needs.

The core problem is convergence: how to take messy prose and surrounding
artifacts and move toward a spec basis that can be shared, composed, pressured,
projected into code, and connected back to the software it governs.

## 3. Spec Basis

A Basis state is a candidate basis for a specification space.

It is useful when it exposes:

- the independent claims the spec relies on
- constraints that cannot be violated
- assumptions that other claims depend on
- interfaces between this spec and other specs or software artifacts
- evidence for accepted claims
- open dimensions that are not yet decided
- rejected alternatives that still constrain the space
- redundancies where several records describe the same dimension
- couplings where one record is pretending to be several dimensions

A spec is projection-complete for a target when its Basis state spans what that
target needs. The target may be code, tests, schemas, diagrams, tickets, proof
obligations, or another spec. Projection-complete does not mean perfect. It means
the projector should not need to invent requirements, silently choose policy, or
hide unresolved questions.

Two specs are composable when their Basis states can be combined while
preserving assumptions, interfaces, conflicts, redundancies, and unresolved
questions. Composition is not appending prose. It is connecting bases.

## 4. Durable State

The durable Basis state is a structured representation of spec essence, not a
prose document.

It MUST represent:

- basis dimensions
- claims
- constraints
- assumptions
- interfaces
- evidence
- obligations
- open questions
- accepted decisions
- rejected ideas
- redundancy and coupling markers
- projection targets
- links to software artifacts when available
- provenance for every source-backed item

It SHOULD represent relationships among those records, including similarity,
composition, containment, derivation, support, validation, dependency, interface
compatibility, implementation, conflict, redundancy, coupling, resolution, and
rejection.

Before any structured state is accepted, Markdown is only the bootstrap input.
Accepting structured state means recording a state version as the current
project contract. After that point, the accepted state is authoritative and
Markdown is a readable projection of it.

## 5. Provenance

Basis MUST make accepted state auditable.

For each accepted record, Basis SHOULD preserve enough provenance to answer:

- what source, prior state, or human decision produced it
- what evidence supports it
- what uncertainty or rejection pressure remains attached to it
- what would be lost if it were changed or removed

Raw Markdown structure is useful only insofar as it supports that audit. Heading
trees, block IDs, and line anchors are implementation choices, not the point of
the system.

Derived records MUST NOT erase the distinction between source text, accepted
structure, and generated analysis.

## 6. State Changes

A state change reads existing state, proposes a target state, validates the
target, and records enough evidence for later review.

A state-change record SHOULD include:

- source state ID or hash
- target state ID or hash
- changed records
- actor or runner
- validation gates
- known loss or drift
- acceptance or rejection decision

Local parser and renderer changes SHOULD be deterministic where feasible.
Model-assisted changes MUST be treated as nondeterministic at the product
boundary. The durable contract is provenance, traceability, reviewability, and
bounded loss, not byte-identical replay.

Generated drafts MUST NOT silently overwrite `spec.md` or accepted structured
Basis state.

## 7. Projections

A projection is an optional view over accepted Basis state. It may target files,
tools, APIs, diagrams, schemas, proof systems, issue trackers, agent runners, or
software maps.

Each projection MUST state:

- projection ID
- input state version
- output contract
- whether generation is deterministic, model-assisted, or hybrid
- lossy transformations
- validation command or manual review check

Projection output MUST NOT introduce required core record types, change state
semantics, or become canonical specification state.

Composing specs MUST preserve visible assumptions, interfaces, conflicts, and
unresolved questions.

## 8. Pressure

Basis SHOULD support derived pressure over the structured state. Pressure is not
authority. It is a review aid.

Initial pressure classes:

- `impossible`: constraints cannot all hold at once
- `useless`: success does not improve the stated problem
- `more_complex_than_nothing`: coordination cost exceeds justified value
- `misses_problem`: machinery optimizes adjacent work instead of the problem
- `underspecified`: behavior-affecting choices are unnamed
- `unfalsifiable`: no clear validation could prove the idea wrong

Pressure findings MUST include class, severity, explanation, and source-backed
evidence when available.

## 9. Formalization

Formal artifacts are projections over accepted Basis state.

They SHOULD model structured records and relationships rather than raw prose.

Generated facts and handwritten theory SHOULD remain separate once handwritten
theory exists.

## 10. Acceptance

This specification is acceptable when:

- accepted structured Basis state is the authoritative project contract
- Markdown is a bootstrap input and required readable projection, not the native
  form
- Basis state converges the spec toward a smaller set of useful conceptual
  dimensions
- projection-completeness is target-relative and explicitly checked
- provenance is mandatory
- composition preserves assumptions, interfaces, conflicts, and unresolved
  questions
- state changes require recorded provenance
- generated output cannot silently replace accepted state
- projections are optional and non-canonical
- runner-specific behavior is adapter behavior, not core behavior

Everything else belongs outside the core contract until a future spec change
admits it.

## 11. Contract Fidelity

Basis reductions MUST preserve contract obligations explicitly.

A reduction candidate carries a contract-coverage table against the prior
contract. The table names every prior surface, its replacement surface, and any
dropped behavior. A reducer grade is invalid when a prior surface lacks either a
replacement or a loss entry. Shrinking prose is allowed only when each removed
obligation is represented by a remaining surface, a not-chosen entry, or a named
loss. Completion for named projections depends on this fidelity table in
addition to local pressure counts.

The fidelity table is proposal evidence, not acceptance. Accepting a reduction
still requires a separate state-change record that names chosen records,
not-chosen records, unresolved pressure, known loss, and validation gates.
