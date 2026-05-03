You are executing Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Output contract:
- Format: markdown
- Final artifact path after merge: projections/implementation-questions.md
- Type contracts: implementation-question

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
    "id": "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
    "type": "requirement",
    "title": "If the issue is still in an active state, the worker SHOULD start another turn on the...",
    "text": "If the issue is still in an active state, the worker SHOULD start another turn on the same live coding-agent thread in the same workspace, up to `agent.max_turns`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 629,
      "lineEnd": 629
    }
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt",
    "type": "requirement",
    "title": "The first turn SHOULD use the full rendered task prompt.",
    "text": "The first turn SHOULD use the full rendered task prompt.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 631,
      "lineEnd": 631
    }
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread",
    "type": "requirement",
    "title": "Continuation turns SHOULD send only continuation guidance to the existing thread, not...",
    "text": "Continuation turns SHOULD send only continuation guidance to the existing thread, not resend the original task prompt that is already present in thread history.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 632,
      "lineEnd": 632
    }
  },
  {
    "id": "requirement-8-1-poll-loop-the-effective-poll-interval-should-be-updated-when-workflow-config-changes-are-r",
    "type": "requirement",
    "title": "The effective poll interval SHOULD be updated when workflow config changes are re-app...",
    "text": "The effective poll interval SHOULD be updated when workflow config changes are re-applied.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 702,
      "lineEnd": 702
    }
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-implementations-may-populate-or-synchronize-the-workspace-using-implementation-d",
    "type": "requirement",
    "title": "Implementations MAY populate or synchronize the workspace using implementation-define...",
    "text": "Implementations MAY populate or synchronize the workspace using implementation-defined logic and/or",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 849,
      "lineEnd": 849
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
  },
  {
    "id": "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root",
    "type": "risk",
    "title": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "text": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 894,
      "lineEnd": 894
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0345-heading-8-1-poll-loop",
    "type": "heading",
    "lineStart": 698,
    "lineEnd": 698,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 8.1 Poll Loop"
  },
  {
    "id": "block-0348-blank-blank",
    "type": "blank",
    "lineStart": 702,
    "lineEnd": 702,
    "generatedClaimIds": [
      "requirement-8-1-poll-loop-the-effective-poll-interval-should-be-updated-when-workflow-config-changes-are-r"
    ],
    "rawMarkdown": ""
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
    "id": "block-0448-blank-blank",
    "type": "blank",
    "lineStart": 849,
    "lineEnd": 849,
    "generatedClaimIds": [
      "requirement-9-3-optional-workspace-population-implementation-defined-implementations-may-populate-or-synchronize-the-workspace-using-implementation-d"
    ],
    "rawMarkdown": ""
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
  },
  {
    "id": "block-0469-heading-9-5-safety-invariants",
    "type": "heading",
    "lineStart": 886,
    "lineEnd": 886,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 9.5 Safety Invariants"
  },
  {
    "id": "block-0476-blank-blank",
    "type": "blank",
    "lineStart": 894,
    "lineEnd": 894,
    "generatedClaimIds": [
      "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root"
    ],
    "rawMarkdown": ""
  }
]
```
