# Projection Boundary

## Decision

The specification model is tool-neutral.

The core artifact set is:

```text
dataified-spec.json
claim-lattice.json
viability-critique.md
ClaimLattice.lean
refinement-packet.md
```

Everything else is a projection or adapter output.

## Core Capabilities

The toolkit should describe capabilities, not vendors or local setup choices.

- `collaborative_map`: many people inspect and annotate a graph.
- `graph_query`: users ask structural questions over typed nodes and edges.
- `spec_regeneration`: structured source blocks become reviewable Markdown.
- `requirements_data`: requirements become typed JSON.
- `protocol_inventory`: protocol claims become typed inventories.
- `architecture_document`: stable components become architecture documents.
- `knowledge_vault`: claims become linked durable notes.
- `formal_model`: claims become prover-facing terms and obligations.
- `execution_queue`: selected findings become work packets for agents or humans.

## Projection Contract

A projection may target any tool, file, or API that satisfies a capability.

Each projection must state:

- capability served
- input form and schema version
- emitted files or API calls
- import or execution instructions
- what information is lossy
- verification command or manual check

A projection must not:

- change the canonical claim-lattice semantics
- introduce new required node types
- make the core spec depend on a hosted service
- make the bad-idea taxonomy depend on a project-management tool

## Current Example Projections

These are examples, not commitments:

- `all-data-types` can satisfy `requirements_data`.
- `all-protocols` can satisfy `protocol_inventory`.
- `network-requirements` can satisfy `requirements_data`.
- `aws-architecture` can satisfy `architecture_document`.
- `implementation-questions` can satisfy implementation handoff pressure.
- `protobuf-schema` can satisfy `interface_schema`.
- Kumu can satisfy `collaborative_map`.
- Neo4j/Bloom can satisfy `graph_query`.
- Structurizr can satisfy `architecture_document`.
- Obsidian can satisfy `knowledge_vault`.
- Lean can satisfy `formal_model`.
- Linear/Symphony can satisfy `execution_queue`.

## CLI Rule

Default generation emits only core artifacts.

Named projections are opt-in:

```sh
node src/basis.mjs export spec.md --projection network-requirements
node src/basis.mjs export spec.md --projection aws-architecture,implementation-questions
node src/basis.mjs export spec.md --projection all
node src/basis.mjs export src --out out/code-to-spec --projection code-to-spec
node src/basis.mjs train spec.md --out out/architecture-cycle --forward aws-architecture --reverse architecture-to-spec --iterations 3
```

The CLI emits LLM call packets under `llm-calls/<projection-id>/`. Final
projection content is produced by running those packets through the configured
LLM runner and merge prompt.

Training cycles emit per-round forward, reverse, and judge packets under
`projection-cycles/<forward>__<reverse>/`. They are drift-measurement artifacts,
not automatic source edits.

This keeps examples useful without allowing them to define the product.
