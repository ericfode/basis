You are executing Spec Gym projection `aws-architecture`: AWS Architecture Document.

Projection instructions:
# AWS Architecture Document

Transform the spec into an `architecture.md` document using AWS vocabulary.

The projection should map spec components and dependencies to plausible AWS
service roles only when the source supports the mapping. Unsupported mappings
should remain questions instead of invented architecture.

Output contract:
- Format: markdown
- Final artifact path after merge: architecture.md
- Type contracts: architecture-document

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
    "id": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "type": "requirement",
    "title": "If a configured log sink fails, the service SHOULD continue running when possible and...",
    "text": "If a configured log sink fails, the service SHOULD continue running when possible and emit an operator-visible warning through any remaining sink.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1272,
      "lineEnd": 1272
    }
  },
  {
    "id": "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
    "type": "dependency",
    "title": "Ignore delta-style payloads such as lasttokenusage for dashboard/API totals.",
    "text": "Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1311,
      "lineEnd": 1311
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
    "id": "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client",
    "type": "dependency",
    "title": "It is up to the implementation whether this is server-generated HTML or a client-side...",
    "text": "It is up to the implementation whether this is server-generated HTML or a client-side app that consumes the JSON API below.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1377,
      "lineEnd": 1377
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-state",
    "type": "dependency",
    "title": "GET /api/v1/state",
    "text": "`GET /api/v1/state`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1386,
      "lineEnd": 1386
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-returns-a-summary-view-of-the-current-system-state-running-sessions-retry-queue-",
    "type": "dependency",
    "title": "Returns a summary view of the current system state (running sessions, retry queue/del...",
    "text": "Returns a summary view of the current system state (running sessions, retry queue/delays, aggregate token/runtime totals, latest rate limits, and any additional tracked summary fields).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1387,
      "lineEnd": 1387
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-issueidentifier",
    "type": "dependency",
    "title": "GET /api/v1/<issueidentifier>",
    "text": "`GET /api/v1/<issue_identifier>`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1435,
      "lineEnd": 1435
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
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0685-heading-13-2-logging-outputs-and-sinks",
    "type": "heading",
    "lineStart": 1265,
    "lineEnd": 1265,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.2 Logging Outputs and Sinks"
  },
  {
    "id": "block-0691-list-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "list",
    "lineStart": 1271,
    "lineEnd": 1274,
    "generatedClaimIds": [
      "requirement-13-2-logging-outputs-and-sinks-implementations-may-write-to-one-or-more-sinks",
      "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible"
    ],
    "rawMarkdown": "- Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.\n- Implementations MAY write to one or more sinks.\n- If a configured log sink fails, the service SHOULD continue running when possible and emit an\n  operator-visible warning through any remaining sink."
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
    "id": "block-0713-list-agent-events-can-include-token-counts-in-multiple-payload-shapes-prefer-absolute",
    "type": "list",
    "lineStart": 1308,
    "lineEnd": 1318,
    "generatedClaimIds": [
      "claim-13-5-session-metrics-and-token-accounting-prefer-absolute-thread-totals-when-available-such-as",
      "claim-13-5-session-metrics-and-token-accounting-thread-tokenusage-updated-payloads",
      "claim-13-5-session-metrics-and-token-accounting-totaltokenusage-within-token-count-wrapper-events",
      "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
      "claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within",
      "claim-13-5-session-metrics-and-token-accounting-for-absolute-totals-track-deltas-relative-to-last-reported-totals-to-avoid-doubl",
      "claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin",
      "claim-13-5-session-metrics-and-token-accounting-accumulate-aggregate-totals-in-orchestrator-state"
    ],
    "rawMarkdown": "- Agent events can include token counts in multiple payload shapes.\n- Prefer absolute thread totals when available, such as:\n  - `thread/tokenUsage/updated` payloads\n  - `total_token_usage` within token-count wrapper events\n- Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.\n- Extract input/output/total token counts leniently from common field names within the selected\n  payload.\n- For absolute totals, track deltas relative to last reported totals to avoid double-counting.\n- Do not treat generic `usage` maps as cumulative totals unless the event type defines them that\n  way.\n- Accumulate aggregate totals in orchestrator state."
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
    "id": "block-0756-blank-blank",
    "type": "blank",
    "lineStart": 1386,
    "lineEnd": 1386,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-state"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0757-list-get-api-v1-state-returns-a-summary-view-of-the-current-system-state-running-ses",
    "type": "list",
    "lineStart": 1387,
    "lineEnd": 1434,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-returns-a-summary-view-of-the-current-system-state-running-sessions-retry-queue-",
      "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape"
    ],
    "rawMarkdown": "- `GET /api/v1/state`\n  - Returns a summary view of the current system state (running sessions, retry queue/delays,\n    aggregate token/runtime totals, latest rate limits, and any additional tracked summary fields).\n  - Suggested response shape:\n\n    ```json\n    {\n      \"generated_at\": \"2026-02-24T20:15:30Z\",\n      \"counts\": {\n        \"running\": 2,\n        \"retrying\": 1\n      },\n      \"running\": [\n        {\n          \"issue_id\": \"abc123\",\n          \"issue_identifier\": \"MT-649\",\n          \"state\": \"In Progress\",\n          \"session_id\": \"thread-1-turn-1\",\n          \"turn_count\": 7,\n          \"last_event\": \"turn_completed\",\n          \"last_message\": \"\",\n          \"started_at\": \"2026-02-24T20:10:12Z\",\n          \"last_event_at\": \"2026-02-24T20:14:59Z\",\n          \"tokens\": {\n            \"input_tokens\": 1200,\n            \"output_tokens\": 800,\n            \"total_tokens\": 2000\n          }\n        }\n      ],\n      \"retrying\": [\n        {\n          \"issue_id\": \"def456\",\n          \"issue_identifier\": \"MT-650\",\n          \"attempt\": 3,\n          \"due_at\": \"2026-02-24T20:16:00Z\",\n          \"error\": \"no available orchestrator slots\"\n        }\n      ],\n      \"codex_totals\": {\n        \"input_tokens\": 5000,\n        \"output_tokens\": 2400,\n        \"total_tokens\": 7400,\n        \"seconds_running\": 1834.2\n      },\n      \"rate_limits\": null\n    }\n    ```"
  },
  {
    "id": "block-0758-blank-blank",
    "type": "blank",
    "lineStart": 1435,
    "lineEnd": 1435,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-issueidentifier"
    ],
    "rawMarkdown": ""
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
  }
]
```
