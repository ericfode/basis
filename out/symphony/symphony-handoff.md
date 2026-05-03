# Refinement Packet: Symphony Service Specification

## Objective

Resolve the highest-value viability finding before prototype work proceeds.

## Input Artifacts

- Source spec: `/Users/ericfode/src/openai-symphony/spec.md`
- Dataified spec: `dataified-spec.json`
- Canonical graph: `claim-lattice.json`
- Critique: `viability-critique.md`
- Lean mock model: `ClaimLattice.lean`
- Optional projections: generated only when requested.
- Environment score: `0.7`

## Current Findings

- MEDIUM `impossible`: Unbounded normative claims need explicit assumptions (`risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker`, `requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible`, `test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations`, `requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme`, `requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal`)
- MEDIUM `misses_problem`: Problem, goals, and tests have weak lexical overlap (`section-003-1-problem-statement`, `goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr`, `goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco`, `goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs`, `goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible`, `test-5-5-workflow-validation-and-error-surface-missingworkflowfile`)
- MEDIUM `underspecified`: Normative claims contain vague qualifiers (`requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl`, `requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and`)
- LOW `more_complex_than_nothing`: Optional surface is large relative to goals (`section-002-normative-language`, `section-010-3-3-external-dependencies`, `section-024-5-2-file-format`, `section-029-5-3-4-hooks-object`, `section-035-6-1-configuration-resolution-pipeline`, `section-054-9-3-optional-workspace-population-implementation-defined`)

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
