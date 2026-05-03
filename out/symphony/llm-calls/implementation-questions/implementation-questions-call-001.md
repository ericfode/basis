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
    "id": "requirement-normative-language-the-key-words-must-must-not-required-should-should-not-recommended-may-and",
    "type": "requirement",
    "title": "The key words MUST, MUST NOT, REQUIRED, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and",
    "text": "The key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`, `RECOMMENDED`, `MAY`, and",
    "normative": [
      "MUST",
      "MUST NOT",
      "REQUIRED",
      "SHOULD",
      "SHOULD NOT",
      "RECOMMENDED",
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 8,
      "lineEnd": 8
    }
  },
  {
    "id": "requirement-normative-language-implementations-must-document-the-selected",
    "type": "requirement",
    "title": "Implementations MUST document the selected",
    "text": "Implementations MUST document the selected",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 12,
      "lineEnd": 12
    }
  },
  {
    "id": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "type": "requirement",
    "title": "WORKFLOW.md SHOULD be self-contained enough to describe and run different workflows (...",
    "text": "`WORKFLOW.md` SHOULD be self-contained enough to describe and run different workflows (prompt, runtime settings, hooks, and tracker selection/config) without requiring out-of-band service-specific configuration.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 308,
      "lineEnd": 308
    }
  },
  {
    "id": "requirement-5-2-file-format-yaml-front-matter-must-decode-to-a-map-object-non-map-yaml-is-an-error",
    "type": "requirement",
    "title": "YAML front matter MUST decode to a map/object; non-map YAML is an error.",
    "text": "YAML front matter MUST decode to a map/object; non-map YAML is an error.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 317,
      "lineEnd": 317
    }
  },
  {
    "id": "requirement-5-3-front-matter-schema-unknown-keys-should-be-ignored-for-forward-compatibility",
    "type": "requirement",
    "title": "Unknown keys SHOULD be ignored for forward compatibility.",
    "text": "Unknown keys SHOULD be ignored for forward compatibility.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 336,
      "lineEnd": 336
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
    "id": "requirement-5-3-2-polling-object-changes-should-be-re-applied-at-runtime-and-affect-future-tick-scheduling-withou",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect future tick scheduling without res...",
    "text": "Changes SHOULD be re-applied at runtime and affect future tick scheduling without restart.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 371,
      "lineEnd": 371
    }
  },
  {
    "id": "requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime for future hook executions.",
    "text": "Changes SHOULD be re-applied at runtime for future hook executions.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 405,
      "lineEnd": 405
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0007-heading-normative-language",
    "type": "heading",
    "lineStart": 7,
    "lineEnd": 7,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## Normative Language"
  },
  {
    "id": "block-0008-blank-blank",
    "type": "blank",
    "lineStart": 8,
    "lineEnd": 8,
    "generatedClaimIds": [
      "requirement-normative-language-the-key-words-must-must-not-required-should-should-not-recommended-may-and"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0011-paragraph-implementation-defined-means-the-behavior-is-part-of-the-implementation-contract",
    "type": "paragraph",
    "lineStart": 12,
    "lineEnd": 14,
    "generatedClaimIds": [
      "requirement-normative-language-implementations-must-document-the-selected"
    ],
    "rawMarkdown": "`Implementation-defined` means the behavior is part of the implementation contract, but this\nspecification does not prescribe one universal policy. Implementations MUST document the selected\nbehavior."
  },
  {
    "id": "block-0159-heading-5-2-file-format",
    "type": "heading",
    "lineStart": 303,
    "lineEnd": 303,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.2 File Format"
  },
  {
    "id": "block-0164-blank-blank",
    "type": "blank",
    "lineStart": 308,
    "lineEnd": 308,
    "generatedClaimIds": [
      "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0169-list-if-file-starts-with-parse-lines-until-the-next-as-yaml-front-matter-rem",
    "type": "list",
    "lineStart": 315,
    "lineEnd": 319,
    "generatedClaimIds": [
      "claim-5-2-file-format-remaining-lines-become-the-prompt-body",
      "claim-5-2-file-format-if-front-matter-is-absent-treat-the-entire-file-as-prompt-body-and-use-an-empty-",
      "requirement-5-2-file-format-yaml-front-matter-must-decode-to-a-map-object-non-map-yaml-is-an-error",
      "claim-5-2-file-format-prompt-body-is-trimmed-before-use"
    ],
    "rawMarkdown": "- If file starts with `---`, parse lines until the next `---` as YAML front matter.\n- Remaining lines become the prompt body.\n- If front matter is absent, treat the entire file as prompt body and use an empty config map.\n- YAML front matter MUST decode to a map/object; non-map YAML is an error.\n- Prompt body is trimmed before use."
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
    "id": "block-0180-blank-blank",
    "type": "blank",
    "lineStart": 336,
    "lineEnd": 336,
    "generatedClaimIds": [
      "requirement-5-3-front-matter-schema-unknown-keys-should-be-ignored-for-forward-compatibility"
    ],
    "rawMarkdown": ""
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
    "id": "block-0193-heading-5-3-2-polling-object",
    "type": "heading",
    "lineStart": 366,
    "lineEnd": 366,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.2 `polling` (object)"
  },
  {
    "id": "block-0197-list-intervalms-integer-default-30000-changes-should-be-re-applied-at-runtime-and",
    "type": "list",
    "lineStart": 370,
    "lineEnd": 372,
    "generatedClaimIds": [
      "claim-5-3-2-polling-object-default-30000",
      "requirement-5-3-2-polling-object-changes-should-be-re-applied-at-runtime-and-affect-future-tick-scheduling-withou"
    ],
    "rawMarkdown": "- `interval_ms` (integer)\n  - Default: `30000`\n  - Changes SHOULD be re-applied at runtime and affect future tick scheduling without restart."
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
