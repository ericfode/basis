# Refinement Packet: Spec Gym Specification

## Objective

Resolve the highest-value viability finding before prototype work proceeds.

## Input Artifacts

- Source spec: `/Users/ericfode/Documents/New project 4/spec.md`
- Canonical graph: `claim-lattice.json`
- Critique: `viability-critique.md`
- Lean mock model: `ClaimLattice.lean`
- Optional projections: generated only when requested.
- Environment score: `0.9`

## Current Findings

- MEDIUM `misses_problem`: Problem, goals, and tests have weak lexical overlap (`section-003-1-problem-statement`, `goal-2-1-goals-parse-markdown-specifications-into-a-canonical-claim-lattice`, `goal-2-1-goals-preserve-source-structure-and-line-level-evidence`, `goal-2-1-goals-extract-addressable-claims-from-headings-bullets-and-normative-sentences`, `goal-2-1-goals-classify-claims-into-a-small-stable-ontology`, `test-4-1-node-types-test-validation-surface-or-conformance-check`)
- LOW `underspecified`: Risk vocabulary appears without extracted risk nodes

## Player Procedure

1. Load `viability-critique.md` and `claim-lattice.json`.
2. Pick exactly one finding, preferring high severity over broad cleanup.
3. Trace its evidence nodes back to source lines.
4. Patch the source specification, add a recorded design decision, or reject the idea with evidence.
5. Regenerate the Spec Gym state.
6. Run the verification gates.
7. Report the changed source lines, regenerated artifacts, and remaining highest finding.

## Verification Gates

```sh
npm test
npm run play:symphony
lean out/symphony/ClaimLattice.lean
```

## Acceptance

- The selected finding is resolved or explicitly reclassified with evidence.
- The claim lattice artifacts regenerate deterministically.
- The Lean mock model still type-checks.
- No new high-severity finding is introduced.
