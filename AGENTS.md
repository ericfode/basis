# Spec Gym

You are working in the Spec Gym repository.

## Operating Rule

Recover concrete state before changing direction. This project should remain an
interchange kernel, not a custom graph application.

## Product Boundary

The top-level [spec.md](/Users/ericfode/Documents/New%20project%204/spec.md) is
the authoritative specification for this repository.

The repo owns:

- Markdown spec ingestion
- typed claim-lattice generation
- bad-idea pressure classification
- optional projections through adapters
- prover-facing mock models
- generic refinement packets

The repo does not own:

- multiplayer canvas infrastructure
- identity, comments, permissions, or live cursors
- a bespoke graph database
- a specific issue tracker, diagram tool, or agent runner

## Validation

Use the strongest cheap gate available:

```sh
npm test
npm run play:self
npm run play:symphony
lean out/symphony/ClaimLattice.lean
node --check src/specgym.mjs
git diff --check
```

When working through an agent runner, keep the change to one narrow increment
and report the exact artifact paths regenerated.
