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
    "id": "test-5-5-workflow-validation-and-error-surface-templaterendererror-unknown-variable-filter-invalid-interpolation",
    "type": "test",
    "title": "templaterendererror (unknown variable/filter, invalid interpolation)",
    "text": "`template_render_error` (unknown variable/filter, invalid interpolation)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 489,
      "lineEnd": 489
    }
  },
  {
    "id": "requirement-6-1-configuration-resolution-pipeline-apply-built-in-defaults-for-missing-optional-fields",
    "type": "requirement",
    "title": "Apply built-in defaults for missing OPTIONAL fields.",
    "text": "Apply built-in defaults for missing OPTIONAL fields.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 504,
      "lineEnd": 504
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-the-software-must-detect-workflow-md-changes",
    "type": "requirement",
    "title": "The software MUST detect WORKFLOW.md changes.",
    "text": "The software MUST detect `WORKFLOW.md` changes.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 525,
      "lineEnd": 525
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
    "type": "requirement",
    "title": "On change, it MUST re-read and re-apply workflow config and prompt template without r...",
    "text": "On change, it MUST re-read and re-apply workflow config and prompt template without restart.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 526,
      "lineEnd": 526
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
    "type": "requirement",
    "title": "The software MUST attempt to adjust live behavior to the new config (for example poll...",
    "text": "The software MUST attempt to adjust live behavior to the new config (for example polling cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and prompt content for future runs).",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 527,
      "lineEnd": 527
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
    "type": "requirement",
    "title": "Implementations SHOULD also re-validate/reload defensively during runtime operations...",
    "text": "Implementations SHOULD also re-validate/reload defensively during runtime operations (for example before dispatch) in case filesystem watch events are missed.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 536,
      "lineEnd": 536
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go",
    "type": "requirement",
    "title": "Invalid reloads MUST NOT crash the service; keep operating with the last known good e...",
    "text": "Invalid reloads MUST NOT crash the service; keep operating with the last known good effective configuration and emit an operator-visible error.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 538,
      "lineEnd": 538
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
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0245-list-missingworkflowfile-workflowparseerror-workflowfrontmatternotamap-templatepar",
    "type": "list",
    "lineStart": 486,
    "lineEnd": 490,
    "generatedClaimIds": [
      "test-5-5-workflow-validation-and-error-surface-workflowparseerror",
      "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap",
      "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering",
      "test-5-5-workflow-validation-and-error-surface-templaterendererror-unknown-variable-filter-invalid-interpolation"
    ],
    "rawMarkdown": "- `missing_workflow_file`\n- `workflow_parse_error`\n- `workflow_front_matter_not_a_map`\n- `template_parse_error` (during prompt rendering)\n- `template_render_error` (unknown variable/filter, invalid interpolation)"
  },
  {
    "id": "block-0253-heading-6-1-configuration-resolution-pipeline",
    "type": "heading",
    "lineStart": 499,
    "lineEnd": 499,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.1 Configuration Resolution Pipeline"
  },
  {
    "id": "block-0257-list-1-select-the-workflow-file-path-explicit-runtime-setting-otherwise-cwd-default-2",
    "type": "list",
    "lineStart": 503,
    "lineEnd": 507,
    "generatedClaimIds": [
      "requirement-6-1-configuration-resolution-pipeline-apply-built-in-defaults-for-missing-optional-fields"
    ],
    "rawMarkdown": "1. Select the workflow file path (explicit runtime setting, otherwise cwd default).\n2. Parse YAML front matter into a raw config map.\n3. Apply built-in defaults for missing OPTIONAL fields.\n4. Resolve `$VAR_NAME` indirection only for config values that explicitly contain `$VAR_NAME`.\n5. Coerce and validate typed values."
  },
  {
    "id": "block-0265-heading-6-2-dynamic-reload-semantics",
    "type": "heading",
    "lineStart": 522,
    "lineEnd": 522,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.2 Dynamic Reload Semantics"
  },
  {
    "id": "block-0268-blank-blank",
    "type": "blank",
    "lineStart": 525,
    "lineEnd": 525,
    "generatedClaimIds": [
      "requirement-6-2-dynamic-reload-semantics-the-software-must-detect-workflow-md-changes"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0269-list-the-software-must-detect-workflow-md-changes-on-change-it-must-re-read-and-re-a",
    "type": "list",
    "lineStart": 526,
    "lineEnd": 540,
    "generatedClaimIds": [
      "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
      "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
      "claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis",
      "requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical",
      "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
      "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
      "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go"
    ],
    "rawMarkdown": "- The software MUST detect `WORKFLOW.md` changes.\n- On change, it MUST re-read and re-apply workflow config and prompt template without restart.\n- The software MUST attempt to adjust live behavior to the new config (for example polling\n  cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and\n  prompt content for future runs).\n- Reloaded config applies to future dispatch, retry scheduling, reconciliation decisions, hook\n  execution, and agent launches.\n- Implementations are not REQUIRED to restart in-flight agent sessions automatically when config\n  changes.\n- Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY\n  require restart unless the implementation explicitly supports live rebind.\n- Implementations SHOULD also re-validate/reload defensively during runtime operations (for example\n  before dispatch) in case filesystem watch events are missed.\n- Invalid reloads MUST NOT crash the service; keep operating with the last known good effective\n  configuration and emit an operator-visible error."
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
  }
]
```
