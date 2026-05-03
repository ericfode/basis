You are executing Spec Gym projection `protobuf-schema`: Protobuf Schema.

Projection instructions:
# Protobuf Schema

Derive a `.proto` schema from explicit data, protocol, request, response, and
event claims in the spec.

The projection should keep uncertain message or field names as comments or
questions rather than silently committing to an invented interface.

Output contract:
- Format: proto
- Final artifact path after merge: spec.proto
- Type contracts: protobuf-schema, data-type, protocol

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
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2",
    "type": "dependency",
    "title": "Suggested response shape:",
    "text": "Suggested response shape:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1438,
      "lineEnd": 1438
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-",
    "type": "dependency",
    "title": "If the issue is unknown to the current in-memory state, return 404 with an error resp...",
    "text": "If the issue is unknown to the current in-memory state, return `404` with an error response (for example `{\\\"error\\\":{\\\"code\\\":\\\"issue_not_found\\\",\\\"message\\\":\\\"...\\\"}}`).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1488,
      "lineEnd": 1488
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-post-api-v1-refresh",
    "type": "dependency",
    "title": "POST /api/v1/refresh",
    "text": "`POST /api/v1/refresh`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1491,
      "lineEnd": 1491
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-request-body-empty-body-or",
    "type": "dependency",
    "title": "Suggested request body: empty body or {}.",
    "text": "Suggested request body: empty body or `{}`.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1494,
      "lineEnd": 1494
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-202-accepted-shape",
    "type": "dependency",
    "title": "Suggested response (202 Accepted) shape:",
    "text": "Suggested response (`202 Accepted`) shape:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1495,
      "lineEnd": 1495
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
    "id": "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
    "type": "dependency",
    "title": "Do not log API tokens or secret env values.",
    "text": "Do not log API tokens or secret env values.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1633,
      "lineEnd": 1633
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
    "id": "block-0759-list-get-api-v1-issueidentifier-returns-issue-specific-runtime-debug-details-for-th",
    "type": "list",
    "lineStart": 1436,
    "lineEnd": 1490,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-returns-issue-specific-runtime-debug-details-for-the-identified-issue-including-",
      "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2",
      "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-"
    ],
    "rawMarkdown": "- `GET /api/v1/<issue_identifier>`\n  - Returns issue-specific runtime/debug details for the identified issue, including any information\n    the implementation tracks that is useful for debugging.\n  - Suggested response shape:\n\n    ```json\n    {\n      \"issue_identifier\": \"MT-649\",\n      \"issue_id\": \"abc123\",\n      \"status\": \"running\",\n      \"workspace\": {\n        \"path\": \"/tmp/symphony_workspaces/MT-649\"\n      },\n      \"attempts\": {\n        \"restart_count\": 1,\n        \"current_retry_attempt\": 2\n      },\n      \"running\": {\n        \"session_id\": \"thread-1-turn-1\",\n        \"turn_count\": 7,\n        \"state\": \"In Progress\",\n        \"started_at\": \"2026-02-24T20:10:12Z\",\n        \"last_event\": \"notification\",\n        \"last_message\": \"Working on tests\",\n        \"last_event_at\": \"2026-02-24T20:14:59Z\",\n        \"tokens\": {\n          \"input_tokens\": 1200,\n          \"output_tokens\": 800,\n          \"total_tokens\": 2000\n        }\n      },\n      \"retry\": null,\n      \"logs\": {\n        \"codex_session_logs\": [\n          {\n            \"label\": \"latest\",\n            \"path\": \"/var/log/symphony/codex/MT-649/latest.log\",\n            \"url\": null\n          }\n        ]\n      },\n      \"recent_events\": [\n        {\n          \"at\": \"2026-02-24T20:14:59Z\",\n          \"event\": \"notification\",\n          \"message\": \"Working on tests\"\n        }\n      ],\n      \"last_error\": null,\n      \"tracked\": {}\n    }\n    ```\n\n  - If the issue is unknown to the current in-memory state, return `404` with an error response (for\n    example `{\\\"error\\\":{\\\"code\\\":\\\"issue_not_found\\\",\\\"message\\\":\\\"...\\\"}}`)."
  },
  {
    "id": "block-0760-blank-blank",
    "type": "blank",
    "lineStart": 1491,
    "lineEnd": 1491,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-post-api-v1-refresh"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0761-list-post-api-v1-refresh-queues-an-immediate-tracker-poll-reconciliation-cycle-bes",
    "type": "list",
    "lineStart": 1492,
    "lineEnd": 1505,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-queues-an-immediate-tracker-poll-reconciliation-cycle-best-effort-trigger-implem",
      "dependency-13-7-2-json-rest-api-api-v1-suggested-request-body-empty-body-or",
      "dependency-13-7-2-json-rest-api-api-v1-suggested-response-202-accepted-shape"
    ],
    "rawMarkdown": "- `POST /api/v1/refresh`\n  - Queues an immediate tracker poll + reconciliation cycle (best-effort trigger; implementations\n    MAY coalesce repeated requests).\n  - Suggested request body: empty body or `{}`.\n  - Suggested response (`202 Accepted`) shape:\n\n    ```json\n    {\n      \"queued\": true,\n      \"coalesced\": false,\n      \"requested_at\": \"2026-02-24T20:15:30Z\",\n      \"operations\": [\"poll\", \"reconcile\"]\n    }\n    ```"
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
    "id": "block-0827-heading-15-3-secret-handling",
    "type": "heading",
    "lineStart": 1631,
    "lineEnd": 1631,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.3 Secret Handling"
  },
  {
    "id": "block-0829-list-support-var-indirection-in-workflow-config-do-not-log-api-tokens-or-secret-env",
    "type": "list",
    "lineStart": 1633,
    "lineEnd": 1635,
    "generatedClaimIds": [
      "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
      "test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them"
    ],
    "rawMarkdown": "- Support `$VAR` indirection in workflow config.\n- Do not log API tokens or secret env values.\n- Validate presence of secrets without printing them."
  }
]
```
