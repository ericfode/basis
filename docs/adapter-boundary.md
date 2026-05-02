# Adapter Boundary

## Decision

The specification model is tool-neutral.

The core artifact set is:

```text
claim-lattice.json
viability-critique.md
ClaimLattice.lean
refinement-packet.md
```

Everything else is an adapter.

## Core Capabilities

The toolkit should describe capabilities, not vendors or local setup choices.

- `collaborative_map`: many people inspect and annotate a graph.
- `graph_query`: users ask structural questions over typed nodes and edges.
- `architecture_projection`: stable components become architecture diagrams.
- `knowledge_vault`: claims become linked durable notes.
- `formal_model`: claims become prover-facing terms and obligations.
- `execution_queue`: selected findings become work packets for agents or humans.

## Adapter Contract

An adapter may target any tool that satisfies a capability.

Each adapter must state:

- capability served
- input claim-lattice schema version
- emitted files or API calls
- import or execution instructions
- what information is lossy
- verification command or manual check

An adapter must not:

- change the canonical claim-lattice semantics
- introduce new required node types
- make the core spec depend on a hosted service
- make the bad-idea taxonomy depend on a project-management tool

## Current Example Adapters

These are examples, not commitments:

- Kumu can satisfy `collaborative_map`.
- Neo4j/Bloom can satisfy `graph_query`.
- Structurizr can satisfy `architecture_projection`.
- Obsidian can satisfy `knowledge_vault`.
- Lean can satisfy `formal_model`.
- Linear/Symphony can satisfy `execution_queue`.

## CLI Rule

Default generation emits only core artifacts.

Named adapters are opt-in:

```sh
node src/specgym.mjs export spec.md --projection neo4j
node src/specgym.mjs export spec.md --projection kumu,structurizr
node src/specgym.mjs export spec.md --projection all
```

This keeps examples useful without allowing them to define the product.
