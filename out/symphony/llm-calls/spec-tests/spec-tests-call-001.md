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
    "id": "claim-3-2-abstraction-levels-team-specific-rules-for-ticket-handling-validation-and-handoff",
    "type": "claim",
    "title": "Team-specific rules for ticket handling, validation, and handoff.",
    "text": "Team-specific rules for ticket handling, validation, and handoff.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 119,
      "lineEnd": 119
    }
  },
  {
    "id": "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet",
    "type": "requirement",
    "title": "Extensions SHOULD document their field schema, defaults, validation rules, and whethe...",
    "text": "Extensions SHOULD document their field schema, defaults, validation rules, and whether changes apply dynamically or require restart.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 342,
      "lineEnd": 342
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-aborts-workspace-creation",
    "type": "claim",
    "title": "Failure aborts workspace creation.",
    "text": "Failure aborts workspace creation.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 389,
      "lineEnd": 389
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-aborts-the-current-attempt",
    "type": "claim",
    "title": "Failure aborts the current attempt.",
    "text": "Failure aborts the current attempt.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 393,
      "lineEnd": 393
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w",
    "type": "claim",
    "title": "Runs after each agent attempt (success, failure, timeout, or cancellation) once the w...",
    "text": "Runs after each agent attempt (success, failure, timeout, or cancellation) once the workspace exists.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 395,
      "lineEnd": 395
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored",
    "type": "claim",
    "title": "Failure is logged but ignored.",
    "text": "Failure is logged but ignored.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 397,
      "lineEnd": 397
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds",
    "type": "claim",
    "title": "Failure is logged but ignored; cleanup still proceeds.",
    "text": "Failure is logged but ignored; cleanup still proceeds.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 400,
      "lineEnd": 400
    }
  },
  {
    "id": "claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation",
    "type": "claim",
    "title": "Invalid values fail configuration validation.",
    "text": "Invalid values fail configuration validation.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 404,
      "lineEnd": 404
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0057-heading-3-2-abstraction-levels",
    "type": "heading",
    "lineStart": 114,
    "lineEnd": 114,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Abstraction Levels"
  },
  {
    "id": "block-0061-list-1-policy-layer-repo-defined-workflow-md-prompt-body-team-specific-rules-for-t",
    "type": "list",
    "lineStart": 118,
    "lineEnd": 120,
    "generatedClaimIds": [
      "claim-3-2-abstraction-levels-workflow-md-prompt-body",
      "claim-3-2-abstraction-levels-team-specific-rules-for-ticket-handling-validation-and-handoff"
    ],
    "rawMarkdown": "1. `Policy Layer` (repo-defined)\n   - `WORKFLOW.md` prompt body.\n   - Team-specific rules for ticket handling, validation, and handoff."
  },
  {
    "id": "block-0175-heading-5-3-front-matter-schema",
    "type": "heading",
    "lineStart": 326,
    "lineEnd": 326,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.3 Front Matter Schema"
  },
  {
    "id": "block-0185-list-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev",
    "type": "list",
    "lineStart": 341,
    "lineEnd": 344,
    "generatedClaimIds": [
      "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet"
    ],
    "rawMarkdown": "- The workflow front matter is extensible. Extensions MAY define additional top-level keys without\n  changing the core schema above.\n- Extensions SHOULD document their field schema, defaults, validation rules, and whether changes\n  apply dynamically or require restart."
  },
  {
    "id": "block-0205-heading-5-3-4-hooks-object",
    "type": "heading",
    "lineStart": 384,
    "lineEnd": 384,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.4 `hooks` (object)"
  },
  {
    "id": "block-0209-list-aftercreate-multiline-shell-script-string-optional-runs-only-when-a-workspace",
    "type": "list",
    "lineStart": 388,
    "lineEnd": 406,
    "generatedClaimIds": [
      "claim-5-3-4-hooks-object-runs-only-when-a-workspace-directory-is-newly-created",
      "claim-5-3-4-hooks-object-failure-aborts-workspace-creation",
      "requirement-5-3-4-hooks-object-beforerun-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-before-each-agent-attempt-after-workspace-preparation-and-before-launching-",
      "claim-5-3-4-hooks-object-failure-aborts-the-current-attempt",
      "requirement-5-3-4-hooks-object-afterrun-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w",
      "claim-5-3-4-hooks-object-failure-is-logged-but-ignored",
      "requirement-5-3-4-hooks-object-beforeremove-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-before-workspace-deletion-if-the-directory-exists",
      "claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds",
      "requirement-5-3-4-hooks-object-timeoutms-integer-optional",
      "claim-5-3-4-hooks-object-default-60000",
      "claim-5-3-4-hooks-object-applies-to-all-workspace-hooks",
      "claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation",
      "requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions"
    ],
    "rawMarkdown": "- `after_create` (multiline shell script string, OPTIONAL)\n  - Runs only when a workspace directory is newly created.\n  - Failure aborts workspace creation.\n- `before_run` (multiline shell script string, OPTIONAL)\n  - Runs before each agent attempt after workspace preparation and before launching the coding\n    agent.\n  - Failure aborts the current attempt.\n- `after_run` (multiline shell script string, OPTIONAL)\n  - Runs after each agent attempt (success, failure, timeout, or cancellation) once the workspace\n    exists.\n  - Failure is logged but ignored.\n- `before_remove` (multiline shell script string, OPTIONAL)\n  - Runs before workspace deletion if the directory exists.\n  - Failure is logged but ignored; cleanup still proceeds.\n- `timeout_ms` (integer, OPTIONAL)\n  - Default: `60000`\n  - Applies to all workspace hooks.\n  - Invalid values fail configuration validation.\n  - Changes SHOULD be re-applied at runtime for future hook executions."
  }
]
```
