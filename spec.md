# Basis Specification

Status: Draft v0.3

Purpose: Define a small, artifact-first spec projection tool for turning
`spec.md` into reviewable data formats: low-loss structured specs, typed claim
lattices, JSON requirement files, architecture documents, protobuf schemas, and
other explicitly requested projections.

## Normative Language

The key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`,
`RECOMMENDED`, `MAY`, and `OPTIONAL` in this document are to be interpreted as
described in RFC 2119.

`Basis` means the environment and CLI surface.

`Spec projector` is the product role: a tool that reads `spec.md`, builds
intermediate forms, and emits named projections.

`Form` means a named representation of a specification, such as `spec`,
`dataified_spec`, `claim`, `critique`, `refinement`, or `prover_mock`.

`Projection` means a named output artifact produced from a spec form, such as
`requirements.json`, `architecture.md`, a `.proto` file, a graph import file, or
an execution handoff packet.

`Transform` means a bounded operation that reads one form, emits another form,
and records enough evidence to validate or replay the result.

`Historical spec mining` means a transform over a Git repository that samples
snapshots, infers source-backed claims, writes candidate as-built specs, and
judges those candidates by temporal validity and essence coverage.

`Spec form` means the normalized source Markdown document with title, heading
tree, source path, source hash, line anchors, and raw excerpts.

`Dataified spec form` means a structured, machine-editable representation of
the Markdown spec that preserves source order, raw Markdown blocks, source
anchors, semantic roles, and derived claim IDs so it can regenerate `spec.md`
with as little loss as possible.

`Spec draft form` means generated Markdown derived from another form. It can
become source `spec` form only after an explicit accept step.

`Claim form` means the canonical claim lattice generated from a spec or
dataified spec.

`Claim lattice` means the canonical model: claims, refinements, obligations,
evidence, verification surfaces, critiques, actors, reward signals, and terminal
states.

`Runner` means the execution surface used for a transform. A runner can be a
local parser, a scripted renderer, or a model-assisted Codex `app-server`
session.

`Codex app-server runner` means the adapter that launches and communicates with
the targeted Codex `app-server` protocol for model-assisted transforms.

`Adapter` means the implementation surface used to write a projection into a
particular tool, file format, API, or workflow. Adapters are implementation
surfaces, not the core model.

## 1. Problem Statement

Teams often write specifications as unstructured text, then translate them into
claims, protobufs, architecture notes, JSON requirement files, diagrams,
tickets, critique, tests, proof sketches, or agent prompts by hand. Those
translations are usually chat residue or local convention, so they are hard to
compare, replay, validate, or reject.

Basis exists to make those translations explicit. It turns a prose
specification into typed forms where humans, agents, provers, test runners,
adapters, and future learned policies can play durable refinement moves against
the same state.

The point is not to prove the whole idea automatically. The point is to make the
verifiable parts explicit: claims, source anchors, evidence, tests, proof
obligations, contradictions, missing validation, and rejection pressure.

Basis is not a diagram product, project-management system, prover,
whiteboard, graph database, interface-definition language, or agent runner. It
can emit projections for those systems, but it MUST preserve a tool-neutral
core.

## 2. Goals and Non-Goals

### 2.1 Goals

- Parse Markdown specifications into a canonical claim lattice.
- Treat `spec` to `dataified_spec` as the mandatory first transform.
- Treat `dataified_spec` to `claim` as the first semantic transform.
- Support the opposite direction by turning `dataified_spec` form into
  reviewable `spec_draft` form with minimal loss.
- Support `claim` to `spec_draft` only as a lossy reconstruction when the richer
  dataified spec is unavailable.
- Support trainable projection cycles such as `spec.md <-> architecture.md`,
  `spec.md <-> tests`, and `code <-> spec.md` by emitting explicit forward,
  reverse, and judge call packets.
- Validate round trips by comparing the original claim form with the claim form
  regenerated from a spec draft and, when available, comparing the original
  dataified spec with the dataified spec regenerated from the draft.
- Mine as-built spec drafts from Git history by optimizing writer/judge
  prompt-policy loops against sampled repository snapshots.
- Define a small form registry with explicit input, output, lossiness, and
  validation rules.
- Accept transform requests that name source form, target form, runner, output
  directory, and verification gates.
- Preserve source structure and line-level evidence.
- Extract addressable claims from headings, bullets, and normative sentences.
- Classify claims into a small, stable ontology.
- Detect early bad-idea pressure with explainable evidence.
- Emit named projections for concrete target formats, beginning with
  `requirements.json`, `architecture.md`, and protobuf schemas.
- Emit a viability critique for human and agent review.
- Emit a refinement packet for the next narrow correction.
- Emit a prover-facing model that can become sharper over time.
- Expose an environment boundary suitable for future RL: observation, action,
  actor, reward, done state, and safety invariant.
- Use Codex `app-server` for model-assisted transforms while keeping durable
  artifacts, not thread transcripts, authoritative.
- Support optional projections for collaboration, graph query, architecture
  documentation, knowledge vaults, formal models, and execution queues.

### 2.2 Non-Goals

- Owning multiplayer canvas infrastructure.
- Owning identity, comments, permissions, or live cursors.
- Owning a graph database.
- Owning protobuf runtime libraries or generated application code.
- Requiring a specific issue tracker, diagram tool, prover, or agent runner.
- Owning the Codex `app-server` wire protocol.
- Treating a Codex thread transcript as canonical specification state.
- Treating projection output as canonical specification state.
- Treating mined as-built specs as authoritative project intent without human
  review.
- Generating final projection content with local heuristics instead of LLM calls.
- Allowing model output to overwrite the source specification unless the
  requested transform explicitly targets a source edit.
- Pretending `claim` to `spec_draft` can recover prose that was not preserved in
  the claim form.
- Adding new forms to the registry without an explicit product decision.
- Replacing human judgment or domain expertise.
- Making reward metrics authoritative over recorded rationale.

## 3. Transform Model

A transform is the smallest meaningful unit of work. It reads one or more input
forms, writes one target form, validates the target form, and records enough
metadata for a later operator to know what happened.

Transforms MUST be treated as non-deterministic at the product boundary. Even
when one implementation path uses local code, users MUST NOT rely on byte-for-
byte identical output from repeated runs. The durable contract is provenance,
traceability, reviewability, and measured loss, not deterministic replay.

### 3.1 Form Registry

A form declaration MUST include:

- form ID
- purpose
- accepted input forms
- emitted artifact or API shape
- schema version when machine-readable
- lossy transformations
- validation command or manual check

The initial form registry contains:

- `spec`: normalized Markdown input with source anchors.
- `dataified_spec`: low-loss structured spec with raw Markdown preservation.
- `spec_draft`: generated Markdown awaiting review or acceptance as source.
- `claim`: typed claim lattice and source-backed graph.
- `critique`: bad-idea pressure over the claim form.
- `refinement`: the next narrow correction packet.
- `prover_mock`: prover-facing model derived from the claim form.
- `architecture_document`: architecture Markdown or structured architecture
  extracted from the spec or used as reverse input.
- `test_suite`: test plan, executable-test outline, or focused test slices used
  as projection output or reverse input.

`dataified_spec` is the first canonical target form. `claim` is the first
semantic target form. `spec_draft` is the first reverse target form. Other forms
are downstream of `claim` unless their form declaration explicitly states
otherwise.

### 3.2 Projection Registry

A projection declaration MUST be a Markdown file under `projections/` with
front matter and explanatory instructions.

A projection declaration MUST include:

- projection ID
- purpose
- accepted input forms
- emitted files or API calls
- target artifact contract
- lossy transformations
- validation command or manual check
- focus strategy for small source slices
- merge strategy for partial LLM outputs
- whether it is included by `--projection all`; reverse-direction projections
  such as code-to-spec SHOULD be explicit-only

The initial projection registry contains:

- `requirements_json`: emits `requirements.json` from requirement, goal,
  non-goal, risk, and validation claims.
- `architecture_markdown`: emits `architecture.md` from component, dependency,
  risk, and validation claims.
- `protobuf_schema`: emits a `.proto` schema for the selected spec interface or
  interchange model.
- `graph_dataset`: emits graph import files for graph-query or collaborative
  map tools.
- `prover_model`: emits prover-facing facts and mock models.
- `execution_packet`: emits work packets for humans, agents, or orchestration
  systems.

Example projection files include:

- `projections/all-data-types.md`
- `projections/all-protocols.md`
- `projections/network-requirements.md`
- `projections/aws-architecture.md`
- `projections/architecture-to-spec.md`
- `projections/implementation-questions.md`
- `projections/spec-tests.md`
- `projections/tests-to-spec.md`
- `projections/code-to-spec.md`

New projection files MAY be added when they describe an output view over the
same spec state. New internal forms still require an explicit product decision.

### 3.3 Type Registry

Projection output types MUST be described under `types/`.

The initial type registry includes:

- `types/data-type.schema.json`
- `types/protocol.schema.json`
- `types/requirement.schema.json`
- `types/architecture-document.schema.json`
- `types/implementation-question.schema.json`
- `types/protobuf-schema.schema.json`
- `types/spec-draft.schema.json`
- `types/test-suite.schema.json`
- `types/projection-cycle.schema.json`

Projection files SHOULD reference these types so repeated transformations have
a stable target contract to train against.

### 3.4 Transform Request

A transform request SHOULD be representable as data:

```json
{
  "source": {
    "form": "spec",
    "path": "spec.md"
  },
  "targetForm": "dataified_spec",
  "runner": "codex_app_server",
  "out": "out/spec",
  "gates": [
    "node --check src/basis.mjs",
    "npm test"
  ]
}
```

The opposite transform SHOULD use the same envelope:

```json
{
  "source": {
    "form": "dataified_spec",
    "path": "out/spec/dataified-spec.json"
  },
  "targetForm": "spec_draft",
  "runner": "codex_app_server",
  "out": "out/spec-draft",
  "gates": [
    "node src/basis.mjs play out/spec-draft/spec.md --out out/spec-draft/roundtrip",
    "npm test"
  ]
}
```

The request MUST NOT rely on conversation context that is absent from the source
artifact or transform request.

### 3.5 Transform Record

Model-assisted transforms SHOULD emit a transform record alongside the target
artifact. The record SHOULD include:

- source path
- source hash
- source form
- target form
- target schema version
- runner
- runner command
- Codex `app-server` protocol evidence or generated schema path when available
- prompt or instruction digest
- output artifact paths
- validation gates
- failure state when the transform is rejected

The transform record is evidence. The emitted form remains the artifact under
review.

The transform record MUST NOT claim that a later run will reproduce identical
output. It SHOULD make later differences explainable by recording source
hashes, schema versions, runner configuration, prompt or instruction digests,
validation gates, and emitted artifact paths.

### 3.6 Dataified Spec Contract

The `dataified_spec` form is the loss-minimizing interchange form for rebuilding
`spec.md`.

It MUST preserve:

- document order
- heading hierarchy
- raw Markdown for every source block
- normalized block type
- source path and source hash
- line anchors when available
- source-anchored block IDs for review and diffing
- semantic role when known
- generated claim IDs when available
- unresolved findings or review notes attached to affected blocks

It SHOULD preserve Markdown constructs as first-class blocks when present:

- paragraphs
- headings
- bullets and ordered lists
- fenced code blocks
- tables
- block quotes
- links and reference definitions
- front matter

Unknown or unsupported Markdown constructs MUST be retained as opaque raw
Markdown blocks rather than dropped or rewritten.

The `dataified_spec` form reduces loss. It does not make the reverse transform
deterministic.

### 3.7 Reverse Transform: Dataified Spec to Spec Draft

The `dataified_spec` to `spec_draft` transform reconstructs a readable Markdown
specification from the structured representation.

The output MUST be reviewable Markdown, not a silent patch to the original
source file.

The output SHOULD preserve source wording, ordering, headings, code fences,
tables, examples, and unknown raw blocks unless the request explicitly asks for
a rewrite. This is a loss-minimization goal, not a promise of byte-identical
regeneration.

The output MUST preserve traceability by including one of:

- source-anchored block or claim IDs in generated Markdown anchors
- a sidecar map from generated Markdown line ranges to block or claim IDs
- both anchors and a sidecar map

The transform is accepted only when regenerating `dataified_spec` from the draft
produces a round-trip report with:

- previous block IDs covered, renamed, or explicitly retired
- source-backed blocks lost from the draft
- new blocks introduced by generated prose
- raw Markdown blocks rewritten without permission
- findings that disappeared without a recorded correction
- findings that remain unresolved

Acceptance MUST NOT require byte-for-byte equality with the previous Markdown.
Acceptance SHOULD require an explicit loss report bounded for human review.

### 3.8 Lossy Reverse Transform: Claim to Spec Draft

The `claim` to `spec_draft` transform reconstructs a readable Markdown
specification from a claim lattice.

This is a lossy fallback. Implementations SHOULD prefer
`dataified_spec` to `spec_draft` whenever dataified spec form is available.

The output MUST be reviewable Markdown, not a silent patch to the original
source file.

The output MUST preserve traceability by including one of:

- source-anchored claim IDs in generated Markdown anchors
- a sidecar map from generated Markdown line ranges to claim IDs
- both anchors and a sidecar map

The output MUST distinguish source-backed content from synthesized connective
prose when that distinction affects review.

The output MUST carry unresolved findings, tensions, and missing validation
forward instead of dropping them because they are awkward prose.

The transform SHOULD preserve the original heading order when the claim lattice
contains source section nodes. If the claim lattice has no reliable section
structure, the runner SHOULD emit a conventional order: problem, goals,
non-goals, requirements, components, dependencies, risks, validation, and open
questions.

The reverse transform is accepted only when regenerating `claim` form from the
draft produces a round-trip report with:

- previous claim IDs covered, renamed, or explicitly retired
- new claims introduced by generated prose
- source-backed claims lost from the draft
- findings that disappeared without a recorded correction
- findings that remain unresolved

A `claim` to `spec_draft` transform MUST fail with `missing_source_anchor` when
required source anchors are absent and the request does not permit synthesized
structure.

### 3.9 LLM Projection Process

Projection content MUST be generated through LLM calls. Local code may parse
source documents, build intermediate forms, select focused slices, write prompts,
validate schemas, and compare drift. Local code MUST NOT synthesize final
projection content for requirements, protocols, architecture, protobufs, or
implementation questions.

For each selected projection, the tool SHOULD:

1. Load the projection Markdown file and referenced type contracts.
2. Slice the spec into small source-focused packets using source anchors,
   headings, matched claims, and raw Markdown blocks.
3. Emit one Codex `app-server` call packet per projection/slice.
4. Require each call packet to preserve source anchors and mark inferred
   content explicitly.
5. Emit a merge call packet that combines partial LLM outputs into the target
   artifact.
6. Validate the merged artifact against its type contract or manual check.
7. Record drift when the same projection is run repeatedly.

The same process applies to code-to-spec projection: the source is code slices
instead of Markdown blocks, the target is `spec_draft`, and the merge call
assembles a reviewable `spec.md` candidate.

### 3.10 Projection Composition And Determinism Training

The CLI MUST support applying one projection, repeated projections, or
comma-separated projection combinations to the same spec document.

Projection combinations SHOULD be recorded in the transform record.

The system should train toward consistency by running many projection and
reverse-projection cycles, comparing outputs against type contracts, claim
coverage, source anchors, and reviewable loss reports. The goal is not to
assume deterministic output. The goal is to measure and reduce projection drift
over repeated transformations.

Trainable cycles are first-class artifacts. A cycle MUST name:

- forward projection
- reverse projection
- seed source artifact
- intermediate artifact path
- returned spec draft path
- number of attempts or iterations
- judge prompt and drift report contract
- gates used to re-parse the returned spec draft

Examples:

- `spec.md -> aws-architecture -> architecture.md -> architecture-to-spec ->
  spec-draft.md`
- `spec.md -> spec-tests -> tests/spec-derived-tests.md -> tests-to-spec ->
  spec-draft.md`
- `src/ -> code-to-spec -> spec-draft.md -> spec-tests ->
  tests/spec-derived-tests.md`

The forward and reverse transforms MAY both be lossy. A training cycle is useful
when the judge can say what moved: source anchors preserved, claims lost,
claims invented, tests no longer grounded, architectural assumptions added, or
open questions collapsed into unsupported certainty.

The CLI SHOULD emit one directory per cycle round with:

- forward LLM call packets
- reverse LLM call packet template
- merge prompts
- judge prompt
- expected drift report path

The cycle runner MUST NOT silently accept the returned draft as `spec.md`.
Returned drafts remain review artifacts until explicitly accepted.

### 3.11 Historical Spec Mining

Historical spec mining samples a Git repository through time and emits a
reviewable `spec_draft` plus judge evidence. It MAY use local heuristics to
infer feature claims and score candidate drafts because the output is a mined
draft under review, not final projection content.

The mining record SHOULD include:

- source repository path
- root commit or explicit `--since` commit
- target branch or commit
- sampled commits
- writer prompt policies
- judge prompt policy
- selected claim IDs or feature IDs
- temporal validity score
- coverage score
- first invalid snapshot, when present
- later-only features excluded from the root-stable draft

The reward SHOULD prioritize:

1. temporal validity from the first judged snapshot
2. coverage of high-weight stable project essence
3. compactness

A mined spec MUST distinguish root-stable claims from later-only drift. It MUST
NOT backdate future behavior into the beginning-of-history spec.

### 3.12 Registry Changes

The form and type registries are intentionally small. New internal forms or
output types beyond the registries in this document MUST be proposed and
accepted before implementation. New projection Markdown files MAY be added when
they reuse existing forms and types.

## 4. Core Artifacts

Default `spec` to `dataified_spec` to `claim` generation MUST emit only core
artifacts:

- `dataified-spec.json`
- `claim-lattice.json`
- `viability-critique.md`
- `ClaimLattice.lean`
- `refinement-packet.md`

Default generation MUST NOT emit named adapter files.

Named projection output MUST be opt-in.

Reverse generation MUST NOT modify `spec.md` by default. It emits draft
artifacts under the requested output directory.

## 5. Claim Lattice

### 5.1 Node Types

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

### 5.2 Edge Types

- `contains`: structural containment.
- `elaborates`: source claim elaborates a section.
- `evidences`: source node supports a finding.
- `pressures`: finding pressures a source node.
- `tensions`: source nodes appear to conflict.

### 5.3 Stability

Node IDs SHOULD support review and diffing when source anchors are available.
They MUST NOT be treated as proof that the transform is deterministic.

The schema MUST be versioned.

Line references SHOULD be preserved whenever the input format supports them.

## 6. Codex App-Server Runner

Codex `app-server` is the first model-assisted runner. It is a runner adapter,
not the claim-lattice schema and not the source of truth.

The default launch command SHOULD be `codex app-server`, but implementations
MUST allow the command, model, sandbox policy, approval policy, timeout, and
transport to be configured.

Implementations MUST follow the targeted Codex `app-server` protocol. This
specification MUST NOT be treated as the protocol schema. If the targeted Codex
protocol conflicts with this document, the Codex protocol controls transport
and message shape.

Implementations SHOULD use `codex app-server generate-json-schema` or the
targeted protocol documentation to validate client assumptions.

The transform prompt sent through the runner MUST include:

- source artifact path or content
- source form
- target form
- target schema or artifact contract
- allowed mutations
- required source-anchor preservation
- validation gates
- honesty boundary for uncertainty and rejected transforms

The runner MUST reject output that cannot be parsed as the target form or that
drops required source anchors.

The runner SHOULD capture, when exposed by the targeted protocol:

- thread ID
- turn ID
- model and configuration summary
- workspace directory
- app-server process identity
- token or rate-limit telemetry
- terminal error state

Failure states SHOULD be normalized as:

- `app_server_unavailable`
- `protocol_mismatch`
- `invalid_output_schema`
- `missing_source_anchor`
- `unsafe_source_mutation`
- `timeout`
- `runner_rejected`
- `roundtrip_mismatch`
- `projection_drift_exceeds_budget`
- `llm_call_plan_invalid`

## 7. Environment Boundary

Basis MUST treat the human as a first-class player, not an external approver.

The environment state SHOULD expose:

- `observation`: source spec, source anchors, claim lattice, obligation graph,
  viability critique, verification surfaces, and projection outputs.
- `action`: split, merge, strengthen, weaken, restate, classify, add evidence,
  add negative test, add proof obligation, mark non-goal, reject idea, or ask for
  a narrower experiment.
- `actor`: human, agent, prover, test runner, projection adapter, or policy.
- `reward`: verifiability score delta, traceability score delta,
  falsifiability score delta, contradiction reduction, ambiguity reduction,
  obligations discharged, negative tests rejected, or invalid idea rejected.
- `done`: implementation-ready threshold reached, idea rejected, or unresolved
  state preserved with named missing evidence.
- `safetyInvariant`: a player cannot improve score by deleting source evidence
  or weakening the stated problem without recording that tradeoff.

## 8. Bad-Idea Pressure

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

## 9. Refinement Packet

The refinement packet is a tool-neutral work instruction derived from the
current claim lattice and viability critique.

It SHOULD:

- rank current findings by severity
- identify evidence nodes
- require exactly one narrow correction or rejection move
- name the actor when known
- require regeneration of core artifacts
- require verification gates
- avoid naming a specific runner unless emitted by a projection adapter

## 10. Formalization Boundary

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

## 11. Projection Boundary

Projections MAY target specific tools, files, protocols, or APIs, but the core
model MUST remain tool-neutral.

Projection categories include:

- `collaborative_map`
- `graph_query`
- `requirements_data`
- `architecture_document`
- `interface_schema`
- `knowledge_vault`
- `formal_model`
- `execution_queue`
- `transform_runner`

Each projection MUST state:

- capability served
- input schema version
- emitted files or API calls
- import or execution instructions
- lossy transformations
- verification command or manual check

A projection MUST NOT introduce required core node types or change
claim-lattice semantics.

## 12. Reference Inputs

The toolkit SHOULD be validated against specifications that are already useful
as documents.

Current reference inputs:

- `/Users/ericfode/src/openai-symphony/spec.md`
- `https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f`

Reference inputs are examples. Their local tool choices MUST NOT become toolkit
requirements.

## 13. Definition of Done for Current Increment

The repository is acceptable when:

- `spec.md` is the top-level authoritative specification.
- The primary CLI is `basis`.
- `spec` to `dataified_spec` is defined as the first transform.
- `dataified_spec` to `spec_draft` is defined as the first reverse transform.
- `claim` to `spec_draft` is documented as a lossy fallback.
- Projection execution emits focused LLM call packets instead of locally
  synthesized projection content.
- Codex `app-server` participation is bounded by the runner contract.
- Default generation emits only core artifacts.
- Named projections are opt-in.
- The projection boundary is documented.
- The Symphony service specification can be played as an example input.
- The Lean mock model type-checks.
- The local tests pass.
