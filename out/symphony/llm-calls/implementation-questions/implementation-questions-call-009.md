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
    "id": "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
    "type": "dependency",
    "title": "Unsupported methods on defined routes SHOULD return 405 Method Not Allowed.",
    "text": "Unsupported methods on defined routes SHOULD return `405 Method Not Allowed`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1511,
      "lineEnd": 1511
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
    "type": "dependency",
    "title": "API errors SHOULD use a JSON envelope such as {\"error\":{\"code\":\"...\",\"message\":\"...\"}}.",
    "text": "API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1512,
      "lineEnd": 1512
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup",
    "type": "dependency",
    "title": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplica...",
    "text": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state logic.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1513,
      "lineEnd": 1513
    }
  },
  {
    "id": "risk-14-1-failure-classes-missing-workflow-md",
    "type": "risk",
    "title": "Missing WORKFLOW.md",
    "text": "Missing `WORKFLOW.md`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1521,
      "lineEnd": 1521
    }
  },
  {
    "id": "risk-14-1-failure-classes-unsupported-tracker-kind-or-missing-tracker-credentials-project-slug",
    "type": "risk",
    "title": "Unsupported tracker kind or missing tracker credentials/project slug",
    "text": "Unsupported tracker kind or missing tracker credentials/project slug",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1523,
      "lineEnd": 1523
    }
  },
  {
    "id": "risk-14-1-failure-classes-missing-coding-agent-executable",
    "type": "risk",
    "title": "Missing coding-agent executable",
    "text": "Missing coding-agent executable",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1524,
      "lineEnd": 1524
    }
  },
  {
    "id": "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
    "type": "risk",
    "title": "Workspace population/synchronization failure (implementation-defined; can come from h...",
    "text": "Workspace population/synchronization failure (implementation-defined; can come from hooks)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1528,
      "lineEnd": 1528
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-dispatch-validation-failures",
    "type": "risk",
    "title": "Dispatch validation failures:",
    "text": "Dispatch validation failures:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1553,
      "lineEnd": 1553
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0751-heading-13-7-2-json-rest-api-api-v1",
    "type": "heading",
    "lineStart": 1381,
    "lineEnd": 1381,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 13.7.2 JSON REST API (`/api/v1/*`)"
  },
  {
    "id": "block-0765-list-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "list",
    "lineStart": 1509,
    "lineEnd": 1515,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
      "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
      "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
      "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
      "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup"
    ],
    "rawMarkdown": "- The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging ergonomics.\n- Implementations MAY add fields, but SHOULD avoid breaking existing fields within a version.\n- Endpoints SHOULD be read-only except for operational triggers like `/refresh`.\n- Unsupported methods on defined routes SHOULD return `405 Method Not Allowed`.\n- API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.\n- If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state\n  logic."
  },
  {
    "id": "block-0769-heading-14-1-failure-classes",
    "type": "heading",
    "lineStart": 1519,
    "lineEnd": 1519,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.1 Failure Classes"
  },
  {
    "id": "block-0771-list-1-workflow-config-failures-missing-workflow-md-invalid-yaml-front-matter-unsup",
    "type": "list",
    "lineStart": 1521,
    "lineEnd": 1525,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-missing-workflow-md",
      "risk-14-1-failure-classes-invalid-yaml-front-matter",
      "risk-14-1-failure-classes-unsupported-tracker-kind-or-missing-tracker-credentials-project-slug",
      "risk-14-1-failure-classes-missing-coding-agent-executable"
    ],
    "rawMarkdown": "1. `Workflow/Config Failures`\n   - Missing `WORKFLOW.md`\n   - Invalid YAML front matter\n   - Unsupported tracker kind or missing tracker credentials/project slug\n   - Missing coding-agent executable"
  },
  {
    "id": "block-0773-list-2-workspace-failures-workspace-directory-creation-failure-workspace-population-s",
    "type": "list",
    "lineStart": 1527,
    "lineEnd": 1531,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-workspace-directory-creation-failure",
      "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
      "risk-14-1-failure-classes-invalid-workspace-path-configuration",
      "risk-14-1-failure-classes-hook-timeout-failure"
    ],
    "rawMarkdown": "2. `Workspace Failures`\n   - Workspace directory creation failure\n   - Workspace population/synchronization failure (implementation-defined; can come from hooks)\n   - Invalid workspace path configuration\n   - Hook timeout/failure"
  },
  {
    "id": "block-0781-heading-14-2-recovery-behavior",
    "type": "heading",
    "lineStart": 1552,
    "lineEnd": 1552,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.2 Recovery Behavior"
  },
  {
    "id": "block-0782-blank-blank",
    "type": "blank",
    "lineStart": 1553,
    "lineEnd": 1553,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-dispatch-validation-failures"
    ],
    "rawMarkdown": ""
  }
]
```
