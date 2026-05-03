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
    "id": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.",
    "text": "Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 413,
      "lineEnd": 413
    }
  },
  {
    "id": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "text": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 420,
      "lineEnd": 420
    }
  },
  {
    "id": "requirement-5-3-6-codex-object-implementors-should-treat-them-as-pass-through-codex-config-values-rather-than-r",
    "type": "requirement",
    "title": "Implementors SHOULD treat them as pass-through Codex config values rather than relyin...",
    "text": "Implementors SHOULD treat them as pass-through Codex config values rather than relying on a",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 432,
      "lineEnd": 432
    }
  },
  {
    "id": "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
    "type": "requirement",
    "title": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "text": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 441,
      "lineEnd": 441
    }
  },
  {
    "id": "requirement-5-4-prompt-template-contract-unknown-variables-must-fail-rendering",
    "type": "requirement",
    "title": "Unknown variables MUST fail rendering.",
    "text": "Unknown variables MUST fail rendering.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 463,
      "lineEnd": 463
    }
  },
  {
    "id": "requirement-5-4-prompt-template-contract-unknown-filters-must-fail-rendering",
    "type": "requirement",
    "title": "Unknown filters MUST fail rendering.",
    "text": "Unknown filters MUST fail rendering.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 464,
      "lineEnd": 464
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
    "id": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile",
    "type": "test",
    "title": "missingworkflowfile",
    "text": "`missing_workflow_file`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 485,
      "lineEnd": 485
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
    "id": "block-0217-heading-5-3-6-codex-object",
    "type": "heading",
    "lineStart": 427,
    "lineEnd": 427,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.6 `codex` (object)"
  },
  {
    "id": "block-0221-paragraph-for-codex-owned-config-values-such-as-approvalpolicy-threadsandbox-and-turnsandb",
    "type": "paragraph",
    "lineStart": 431,
    "lineEnd": 437,
    "generatedClaimIds": [
      "requirement-5-3-6-codex-object-implementors-should-treat-them-as-pass-through-codex-config-values-rather-than-r",
      "requirement-5-3-6-codex-object-implementations-may-validate-these"
    ],
    "rawMarkdown": "For Codex-owned config values such as `approval_policy`, `thread_sandbox`, and\n`turn_sandbox_policy`, supported values are defined by the targeted Codex app-server version.\nImplementors SHOULD treat them as pass-through Codex config values rather than relying on a\nhand-maintained enum in this spec. To inspect the installed Codex schema, run\n`codex app-server generate-json-schema --out <dir>` and inspect the relevant definitions referenced\nby `v2/ThreadStartParams.json` and `v2/TurnStartParams.json`. Implementations MAY validate these\nfields locally if they want stricter startup checks."
  },
  {
    "id": "block-0223-list-command-string-shell-command-default-codex-app-server-the-runtime-launches-t",
    "type": "list",
    "lineStart": 439,
    "lineEnd": 455,
    "generatedClaimIds": [
      "claim-5-3-6-codex-object-default-codex-app-server",
      "claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory",
      "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
      "claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value",
      "claim-5-3-6-codex-object-default-implementation-defined",
      "claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value",
      "claim-5-3-6-codex-object-default-implementation-defined-2",
      "claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value",
      "claim-5-3-6-codex-object-default-implementation-defined-3",
      "claim-5-3-6-codex-object-turntimeoutms-integer",
      "claim-5-3-6-codex-object-default-3600000-1-hour",
      "claim-5-3-6-codex-object-readtimeoutms-integer",
      "claim-5-3-6-codex-object-default-5000",
      "claim-5-3-6-codex-object-stalltimeoutms-integer",
      "claim-5-3-6-codex-object-default-300000-5-minutes",
      "claim-5-3-6-codex-object-if-0-stall-detection-is-disabled"
    ],
    "rawMarkdown": "- `command` (string shell command)\n  - Default: `codex app-server`\n  - The runtime launches this command via `bash -lc` in the workspace directory.\n  - The launched process MUST speak a compatible app-server protocol over stdio.\n- `approval_policy` (Codex `AskForApproval` value)\n  - Default: implementation-defined.\n- `thread_sandbox` (Codex `SandboxMode` value)\n  - Default: implementation-defined.\n- `turn_sandbox_policy` (Codex `SandboxPolicy` value)\n  - Default: implementation-defined.\n- `turn_timeout_ms` (integer)\n  - Default: `3600000` (1 hour)\n- `read_timeout_ms` (integer)\n  - Default: `5000`\n- `stall_timeout_ms` (integer)\n  - Default: `300000` (5 minutes)\n  - If `<= 0`, stall detection is disabled."
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
    "id": "block-0231-list-use-a-strict-template-engine-liquid-compatible-semantics-are-sufficient-unknow",
    "type": "list",
    "lineStart": 463,
    "lineEnd": 465,
    "generatedClaimIds": [
      "requirement-5-4-prompt-template-contract-unknown-variables-must-fail-rendering",
      "requirement-5-4-prompt-template-contract-unknown-filters-must-fail-rendering"
    ],
    "rawMarkdown": "- Use a strict template engine (Liquid-compatible semantics are sufficient).\n- Unknown variables MUST fail rendering.\n- Unknown filters MUST fail rendering."
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
    "id": "block-0241-heading-5-5-workflow-validation-and-error-surface",
    "type": "heading",
    "lineStart": 482,
    "lineEnd": 482,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.5 Workflow Validation and Error Surface"
  },
  {
    "id": "block-0244-blank-blank",
    "type": "blank",
    "lineStart": 485,
    "lineEnd": 485,
    "generatedClaimIds": [
      "test-5-5-workflow-validation-and-error-surface-missingworkflowfile"
    ],
    "rawMarkdown": ""
  }
]
```
