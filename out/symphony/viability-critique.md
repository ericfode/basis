# Viability Critique: Symphony Service Specification

Source: `/Users/ericfode/src/openai-symphony/spec.md`
Generated: 2026-05-04T16:39:04.221Z

## Claim Lattice Summary

- Nodes: 981
- Edges: 1032
- Findings: 4
- Problem surface: yes
- Goal surface: yes
- Validation surface: yes

## Findings

### Unbounded normative claims need explicit assumptions

- Class: `impossible`
- Severity: `medium`
- Detail: Claims using always, never, all, every, or complete often hide impossible total guarantees over real environments.
- Evidence nodes: `risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker`, `requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible`, `test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations`, `requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme`, `requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal`

### Optional surface is large relative to goals

- Class: `more_complex_than_nothing`
- Severity: `low`
- Detail: Detected 46 optional references. Large optional surfaces can make conformance harder than the baseline problem.
- Evidence nodes: `section-002-normative-language`, `section-010-3-3-external-dependencies`, `section-024-5-2-file-format`, `section-029-5-3-4-hooks-object`, `section-035-6-1-configuration-resolution-pipeline`, `section-054-9-3-optional-workspace-population-implementation-defined`, `section-061-10-4-emitted-runtime-events-upstream-to-orchestrator`, `section-072-12-1-inputs`, `section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended`, `section-080-13-4-optional-human-readable-status-surface`, `section-082-13-6-humanized-agent-event-summaries-optional`, `section-083-13-7-optional-http-server-extension`

### Problem, goals, and tests have weak lexical overlap

- Class: `misses_problem`
- Severity: `medium`
- Detail: Problem-goal overlap 0.11, problem-test overlap 0.08. Low overlap is not proof of failure, but it is a good prompt to link goals and tests explicitly.
- Evidence nodes: `section-003-1-problem-statement`, `goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr`, `goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco`, `goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs`, `goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible`, `test-5-5-workflow-validation-and-error-surface-missingworkflowfile`, `test-5-5-workflow-validation-and-error-surface-workflowparseerror`, `test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap`, `test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering`

### Normative claims contain vague qualifiers

- Class: `underspecified`
- Severity: `medium`
- Detail: Normative language with vague qualifiers needs defaults, measurable thresholds, or a named implementation-defined policy.
- Evidence nodes: `requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl`, `requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and`

## Next Formalization Moves

- CoreSurfacePresent
- NoHighSeverityImpossibleFinding
- EveryGoalHasValidationLink
- EveryImplementationDefinedChoiceHasDocumentedPolicy
- ComponentPressureIsJustifiedByGoals
