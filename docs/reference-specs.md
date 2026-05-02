# Reference Specs

## Spec Gym

Path:

```text
/Users/ericfode/Documents/New project 4/spec.md
```

Why it matters:

- authoritative local product contract
- tool-neutral core
- adapter boundary
- bad-idea taxonomy
- definition of done for the current increment

## Symphony Service Specification

Path:

```text
/Users/ericfode/src/openai-symphony/spec.md
```

Why it matters:

- language-agnostic contract
- explicit goals and non-goals
- typed domain model
- state machine and reference algorithms
- validation matrix and definition of done

## Karpathy LLM Wiki

URL:

```text
https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
```

Why it matters:

- communicates a large idea without over-prescribing implementation
- keeps durable Markdown artifacts at the center
- treats graph view as a way to inspect accumulated structure
- makes maintenance, indexing, logging, and linting part of the core workflow

Design implication for this repo:

The first-class artifact should be a durable claim lattice with adapter boundaries.
Tools like Obsidian, Kumu, Neo4j/Bloom, Structurizr, Linear, and Symphony are
examples of targets, not part of the specification itself.
