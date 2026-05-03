You are executing Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Output contract:
- Format: markdown
- Final artifact path after merge: tests/spec-derived-tests.md
- Type contracts: test-suite

Rules:
- Use only the source slice below.
- Preserve source anchors for every emitted item.
- Mark inferred items explicitly.
- Do not fill missing facts with invented certainty.
- Return only the partial projection payload for this slice.

Source nodes:
```json
[
  {
    "id": "claim-5-3-5-agent-object-invalid-values-fail-configuration-validation",
    "type": "claim",
    "title": "Invalid values fail configuration validation.",
    "text": "Invalid values fail configuration validation.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 417,
      "lineEnd": 417
    }
  },
  {
    "id": "requirement-5-4-prompt-template-contract-workflow-file-read-parse-failures-are-configuration-validation-errors-and-should",
    "type": "requirement",
    "title": "Workflow file read/parse failures are configuration/validation errors and SHOULD NOT...",
    "text": "Workflow file read/parse failures are configuration/validation errors and SHOULD NOT silently fall back to a prompt.",
    "normative": [
      "SHOULD NOT"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 478,
      "lineEnd": 478
    }
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-if-startup-validation-fails-fail-startup-and-emit-an-operator-visible-error",
    "type": "test",
    "title": "If startup validation fails, fail startup and emit an operator-visible error.",
    "text": "If startup validation fails, fail startup and emit an operator-visible error.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 550,
      "lineEnd": 550
    }
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-if-validation-fails-skip-dispatch-for-that-tick-keep-reconciliation-active-and-e",
    "type": "test",
    "title": "If validation fails, skip dispatch for that tick, keep reconciliation active, and emi...",
    "text": "If validation fails, skip dispatch for that tick, keep reconciliation active, and emit an operator-visible error.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 555,
      "lineEnd": 555
    }
  },
  {
    "id": "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua",
    "type": "test",
    "title": "Once the worker exits normally, the orchestrator still schedules a short continuation...",
    "text": "Once the worker exits normally, the orchestrator still schedules a short continuation retry (about 1 second) so it can re-check whether the issue remains active and needs another worker session.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 634,
      "lineEnd": 634
    }
  },
  {
    "id": "claim-8-4-retry-and-backoff-failure-driven-retries-use-delay-min-10000-2-attempt-1-agent-maxretrybackoffms",
    "type": "claim",
    "title": "Failure-driven retries use delay = min(10000 2^(attempt - 1), agent.maxretrybackoffms).",
    "text": "Failure-driven retries use `delay = min(10000 * 2^(attempt - 1), agent.max_retry_backoff_ms)`.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 758,
      "lineEnd": 758
    }
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-if-failure-happens-while-creating-a-brand-new-workspace-implementations-may-remo",
    "type": "requirement",
    "title": "If failure happens while creating a brand-new workspace, implementations MAY remove t...",
    "text": "If failure happens while creating a brand-new workspace, implementations MAY remove the partially prepared directory.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 855,
      "lineEnd": 855
    }
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-reused-workspaces-should-not-be-destructively-reset-on-population-failure-unless",
    "type": "requirement",
    "title": "Reused workspaces SHOULD NOT be destructively reset on population failure unless that...",
    "text": "Reused workspaces SHOULD NOT be destructively reset on population failure unless that policy is explicitly chosen and documented.",
    "normative": [
      "SHOULD NOT"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 857,
      "lineEnd": 857
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0211-heading-5-3-5-agent-object",
    "type": "heading",
    "lineStart": 408,
    "lineEnd": 408,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.5 `agent` (object)"
  },
  {
    "id": "block-0215-list-maxconcurrentagents-integer-default-10-changes-should-be-re-applied-at-runti",
    "type": "list",
    "lineStart": 412,
    "lineEnd": 425,
    "generatedClaimIds": [
      "claim-5-3-5-agent-object-default-10",
      "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions",
      "claim-5-3-5-agent-object-maxturns-positive-integer",
      "claim-5-3-5-agent-object-default-20",
      "claim-5-3-5-agent-object-limits-the-number-of-coding-agent-turns-within-one-worker-session",
      "claim-5-3-5-agent-object-invalid-values-fail-configuration-validation",
      "claim-5-3-5-agent-object-maxretrybackoffms-integer",
      "claim-5-3-5-agent-object-default-300000-5-minutes",
      "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
      "claim-5-3-5-agent-object-maxconcurrentagentsbystate-map-statename-positive-integer",
      "claim-5-3-5-agent-object-default-empty-map",
      "claim-5-3-5-agent-object-state-keys-are-normalized-lowercase-for-lookup",
      "claim-5-3-5-agent-object-invalid-entries-non-positive-or-non-numeric-are-ignored"
    ],
    "rawMarkdown": "- `max_concurrent_agents` (integer)\n  - Default: `10`\n  - Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.\n- `max_turns` (positive integer)\n  - Default: `20`\n  - Limits the number of coding-agent turns within one worker session.\n  - Invalid values fail configuration validation.\n- `max_retry_backoff_ms` (integer)\n  - Default: `300000` (5 minutes)\n  - Changes SHOULD be re-applied at runtime and affect future retry scheduling.\n- `max_concurrent_agents_by_state` (map `state_name -> positive integer`)\n  - Default: empty map.\n  - State keys are normalized (`lowercase`) for lookup.\n  - Invalid entries (non-positive or non-numeric) are ignored."
  },
  {
    "id": "block-0225-heading-5-4-prompt-template-contract",
    "type": "heading",
    "lineStart": 457,
    "lineEnd": 457,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.4 Prompt Template Contract"
  },
  {
    "id": "block-0239-list-if-the-workflow-prompt-body-is-empty-the-runtime-may-use-a-minimal-default-promp",
    "type": "list",
    "lineStart": 477,
    "lineEnd": 480,
    "generatedClaimIds": [
      "requirement-5-4-prompt-template-contract-workflow-file-read-parse-failures-are-configuration-validation-errors-and-should"
    ],
    "rawMarkdown": "- If the workflow prompt body is empty, the runtime MAY use a minimal default prompt\n  (`You are working on an issue from Linear.`).\n- Workflow file read/parse failures are configuration/validation errors and SHOULD NOT silently fall\n  back to a prompt."
  },
  {
    "id": "block-0271-heading-6-3-dispatch-preflight-validation",
    "type": "heading",
    "lineStart": 542,
    "lineEnd": 542,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.3 Dispatch Preflight Validation"
  },
  {
    "id": "block-0277-list-validate-configuration-before-starting-the-scheduling-loop-if-startup-validation",
    "type": "list",
    "lineStart": 550,
    "lineEnd": 551,
    "generatedClaimIds": [
      "test-6-3-dispatch-preflight-validation-if-startup-validation-fails-fail-startup-and-emit-an-operator-visible-error"
    ],
    "rawMarkdown": "- Validate configuration before starting the scheduling loop.\n- If startup validation fails, fail startup and emit an operator-visible error."
  },
  {
    "id": "block-0281-list-re-validate-before-each-dispatch-cycle-if-validation-fails-skip-dispatch-for-th",
    "type": "list",
    "lineStart": 555,
    "lineEnd": 557,
    "generatedClaimIds": [
      "test-6-3-dispatch-preflight-validation-if-validation-fails-skip-dispatch-for-that-tick-keep-reconciliation-active-and-e"
    ],
    "rawMarkdown": "- Re-validate before each dispatch cycle.\n- If validation fails, skip dispatch for that tick, keep reconciliation active, and emit an\n  operator-visible error."
  },
  {
    "id": "block-0297-heading-7-1-issue-orchestration-states",
    "type": "heading",
    "lineStart": 603,
    "lineEnd": 603,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 7.1 Issue Orchestration States"
  },
  {
    "id": "block-0313-list-a-successful-worker-exit-does-not-mean-the-issue-is-done-forever-the-worker-may",
    "type": "list",
    "lineStart": 627,
    "lineEnd": 637,
    "generatedClaimIds": [
      "requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-",
      "claim-7-1-issue-orchestration-states-after-each-normal-turn-completion-the-worker-re-checks-the-tracker-issue-state",
      "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
      "requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt",
      "requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread",
      "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua"
    ],
    "rawMarkdown": "- A successful worker exit does not mean the issue is done forever.\n- The worker MAY continue through multiple back-to-back coding-agent turns before it exits.\n- After each normal turn completion, the worker re-checks the tracker issue state.\n- If the issue is still in an active state, the worker SHOULD start another turn on the same live\n  coding-agent thread in the same workspace, up to `agent.max_turns`.\n- The first turn SHOULD use the full rendered task prompt.\n- Continuation turns SHOULD send only continuation guidance to the existing thread, not resend the\n  original task prompt that is already present in thread history.\n- Once the worker exits normally, the orchestrator still schedules a short continuation retry\n  (about 1 second) so it can re-check whether the issue remains active and needs another worker\n  session."
  },
  {
    "id": "block-0379-heading-8-4-retry-and-backoff",
    "type": "heading",
    "lineStart": 749,
    "lineEnd": 749,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 8.4 Retry and Backoff"
  },
  {
    "id": "block-0387-list-normal-continuation-retries-after-a-clean-worker-exit-use-a-short-fixed-delay-of",
    "type": "list",
    "lineStart": 758,
    "lineEnd": 760,
    "generatedClaimIds": [
      "claim-8-4-retry-and-backoff-failure-driven-retries-use-delay-min-10000-2-attempt-1-agent-maxretrybackoffms",
      "claim-8-4-retry-and-backoff-power-is-capped-by-the-configured-max-retry-backoff-default-300000-5m"
    ],
    "rawMarkdown": "- Normal continuation retries after a clean worker exit use a short fixed delay of `1000` ms.\n- Failure-driven retries use `delay = min(10000 * 2^(attempt - 1), agent.max_retry_backoff_ms)`.\n- Power is capped by the configured max retry backoff (default `300000` / 5m)."
  },
  {
    "id": "block-0445-heading-9-3-optional-workspace-population-implementation-defined",
    "type": "heading",
    "lineStart": 846,
    "lineEnd": 846,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 9.3 OPTIONAL Workspace Population (Implementation-Defined)"
  },
  {
    "id": "block-0453-list-workspace-population-synchronization-failures-return-an-error-for-the-current-at",
    "type": "list",
    "lineStart": 855,
    "lineEnd": 859,
    "generatedClaimIds": [
      "requirement-9-3-optional-workspace-population-implementation-defined-if-failure-happens-while-creating-a-brand-new-workspace-implementations-may-remo",
      "requirement-9-3-optional-workspace-population-implementation-defined-reused-workspaces-should-not-be-destructively-reset-on-population-failure-unless"
    ],
    "rawMarkdown": "- Workspace population/synchronization failures return an error for the current attempt.\n- If failure happens while creating a brand-new workspace, implementations MAY remove the partially\n  prepared directory.\n- Reused workspaces SHOULD NOT be destructively reset on population failure unless that policy is\n  explicitly chosen and documented."
  }
]
```
