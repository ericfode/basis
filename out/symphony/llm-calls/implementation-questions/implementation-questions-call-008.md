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
    "id": "requirement-13-4-optional-human-readable-status-surface-if-present-it-should-draw-from-orchestrator-state-metrics-only-and-must-not-be-r",
    "type": "requirement",
    "title": "If present, it SHOULD draw from orchestrator state/metrics only and MUST NOT be REQUI...",
    "text": "If present, it SHOULD draw from orchestrator state/metrics only and MUST NOT be REQUIRED for",
    "normative": [
      "SHOULD",
      "MUST NOT",
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1300,
      "lineEnd": 1300
    }
  },
  {
    "id": "requirement-13-5-session-metrics-and-token-accounting-runtime-should-be-reported-as-a-live-aggregate-at-snapshot-render-time",
    "type": "requirement",
    "title": "Runtime SHOULD be reported as a live aggregate at snapshot/render time.",
    "text": "Runtime SHOULD be reported as a live aggregate at snapshot/render time.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1321,
      "lineEnd": 1321
    }
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-dashboard-api-must-be-observability-control-surfaces-only-and-must-not-becom",
    "type": "requirement",
    "title": "The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQ...",
    "text": "The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQUIRED for orchestrator correctness.",
    "normative": [
      "MUST",
      "MUST NOT",
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1351,
      "lineEnd": 1351
    }
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-implementations-should-bind-loopback-by-default-127-0-0-1-or-host-equivalent-unl",
    "type": "requirement",
    "title": "Implementations SHOULD bind loopback by default (127.0.0.1 or host equivalent) unless...",
    "text": "Implementations SHOULD bind loopback by default (`127.0.0.1` or host equivalent) unless explicitly configured otherwise.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1367,
      "lineEnd": 1367
    }
  },
  {
    "id": "requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-",
    "type": "requirement",
    "title": "The returned document SHOULD depict the current state of the system (for example acti...",
    "text": "The returned document SHOULD depict the current state of the system (for example active sessions, retry delays, token consumption, runtime totals, recent events, and health/error indicators).",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1375,
      "lineEnd": 1375
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
    "id": "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
    "type": "dependency",
    "title": "Implementations MAY add fields, but SHOULD avoid breaking existing fields within a ve...",
    "text": "Implementations MAY add fields, but SHOULD avoid breaking existing fields within a version.",
    "normative": [
      "MAY",
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1509,
      "lineEnd": 1509
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
    "type": "dependency",
    "title": "Endpoints SHOULD be read-only except for operational triggers like /refresh.",
    "text": "Endpoints SHOULD be read-only except for operational triggers like `/refresh`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1510,
      "lineEnd": 1510
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0703-heading-13-4-optional-human-readable-status-surface",
    "type": "heading",
    "lineStart": 1296,
    "lineEnd": 1296,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.4 OPTIONAL Human-Readable Status Surface"
  },
  {
    "id": "block-0706-blank-blank",
    "type": "blank",
    "lineStart": 1300,
    "lineEnd": 1300,
    "generatedClaimIds": [
      "requirement-13-4-optional-human-readable-status-surface-if-present-it-should-draw-from-orchestrator-state-metrics-only-and-must-not-be-r"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0709-heading-13-5-session-metrics-and-token-accounting",
    "type": "heading",
    "lineStart": 1304,
    "lineEnd": 1304,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.5 Session Metrics and Token Accounting"
  },
  {
    "id": "block-0716-blank-blank",
    "type": "blank",
    "lineStart": 1321,
    "lineEnd": 1321,
    "generatedClaimIds": [
      "requirement-13-5-session-metrics-and-token-accounting-runtime-should-be-reported-as-a-live-aggregate-at-snapshot-render-time"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0731-heading-13-7-optional-http-server-extension",
    "type": "heading",
    "lineStart": 1344,
    "lineEnd": 1344,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.7 OPTIONAL HTTP Server Extension"
  },
  {
    "id": "block-0737-list-the-http-server-is-an-extension-and-is-not-required-for-conformance-the-implemen",
    "type": "list",
    "lineStart": 1350,
    "lineEnd": 1353,
    "generatedClaimIds": [
      "requirement-13-7-optional-http-server-extension-the-implementation-may-serve-server-rendered-html-or-a-client-side-application-f",
      "requirement-13-7-optional-http-server-extension-the-dashboard-api-must-be-observability-control-surfaces-only-and-must-not-becom"
    ],
    "rawMarkdown": "- The HTTP server is an extension and is not REQUIRED for conformance.\n- The implementation MAY serve server-rendered HTML or a client-side application for the dashboard.\n- The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQUIRED for\n  orchestrator correctness."
  },
  {
    "id": "block-0745-list-start-the-http-server-when-a-cli-port-argument-is-provided-start-the-http-serv",
    "type": "list",
    "lineStart": 1364,
    "lineEnd": 1371,
    "generatedClaimIds": [
      "claim-13-7-optional-http-server-extension-start-the-http-server-when-server-port-is-present-in-workflow-md-front-matter",
      "claim-13-7-optional-http-server-extension-the-server-top-level-key-is-owned-by-this-extension",
      "claim-13-7-optional-http-server-extension-positive-server-port-values-bind-that-port",
      "requirement-13-7-optional-http-server-extension-implementations-should-bind-loopback-by-default-127-0-0-1-or-host-equivalent-unl",
      "requirement-13-7-optional-http-server-extension-changes-to-http-listener-settings-for-example-server-port-do-not-need-to-hot-reb"
    ],
    "rawMarkdown": "- Start the HTTP server when a CLI `--port` argument is provided.\n- Start the HTTP server when `server.port` is present in `WORKFLOW.md` front matter.\n- The `server` top-level key is owned by this extension.\n- Positive `server.port` values bind that port.\n- Implementations SHOULD bind loopback by default (`127.0.0.1` or host equivalent) unless explicitly\n  configured otherwise.\n- Changes to HTTP listener settings (for example `server.port`) do not need to hot-rebind;\n  restart-required behavior is conformant."
  },
  {
    "id": "block-0747-heading-13-7-1-human-readable-dashboard",
    "type": "heading",
    "lineStart": 1373,
    "lineEnd": 1373,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 13.7.1 Human-Readable Dashboard (`/`)"
  },
  {
    "id": "block-0749-list-host-a-human-readable-dashboard-at-the-returned-document-should-depict-the-cur",
    "type": "list",
    "lineStart": 1375,
    "lineEnd": 1379,
    "generatedClaimIds": [
      "requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-",
      "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client"
    ],
    "rawMarkdown": "- Host a human-readable dashboard at `/`.\n- The returned document SHOULD depict the current state of the system (for example active sessions,\n  retry delays, token consumption, runtime totals, recent events, and health/error indicators).\n- It is up to the implementation whether this is server-generated HTML or a client-side app that\n  consumes the JSON API below."
  },
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
  }
]
```
