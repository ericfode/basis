# Refinement Packet: Redis Historical Mined Spec

## Objective

Resolve the highest-value viability finding before prototype work proceeds.

## Input Artifacts

- Source spec: `/Users/ericfode/Documents/New project 4/out/redis-history/mined-spec.md`
- Dataified spec: `dataified-spec.json`
- Canonical graph: `claim-lattice.json`
- Critique: `viability-critique.md`
- Lean mock model: `ClaimLattice.lean`
- Optional projections: generated only when requested.
- Environment score: `1`

## Current Findings

No current findings.

## Player Procedure

1. Load `viability-critique.md`, `dataified-spec.json`, and `claim-lattice.json`.
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
- Regenerated artifacts include source anchors and enough provenance to review differences.
- The Lean mock model still type-checks.
- No new high-severity finding is introduced.
