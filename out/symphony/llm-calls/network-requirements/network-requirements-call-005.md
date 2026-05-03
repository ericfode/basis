You are executing Spec Gym projection `network-requirements`: Network Requirements.

Projection instructions:
# Network Requirements

Extract all requirements, dependencies, risks, and validation surfaces related
to networking.

The projection should include source-backed requirements first, then inferred
network obligations and missing validation questions.

Output contract:
- Format: json
- Final artifact path after merge: projections/network-requirements.json
- Type contracts: requirement

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
    "id": "dependency-13-7-optional-http-server-extension-start-the-http-server-when-a-cli-port-argument-is-provided",
    "type": "dependency",
    "title": "Start the HTTP server when a CLI --port argument is provided.",
    "text": "Start the HTTP server when a CLI `--port` argument is provided.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1363,
      "lineEnd": 1363
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
    "id": "requirement-13-7-optional-http-server-extension-changes-to-http-listener-settings-for-example-server-port-do-not-need-to-hot-reb",
    "type": "requirement",
    "title": "Changes to HTTP listener settings (for example server.port) do not need to hot-rebind...",
    "text": "Changes to HTTP listener settings (for example `server.port`) do not need to hot-rebind; restart-required behavior is conformant.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1369,
      "lineEnd": 1369
    }
  },
  {
    "id": "dependency-13-7-1-human-readable-dashboard-host-a-human-readable-dashboard-at",
    "type": "dependency",
    "title": "Host a human-readable dashboard at /.",
    "text": "Host a human-readable dashboard at `/`.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1374,
      "lineEnd": 1374
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
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0744-blank-blank",
    "type": "blank",
    "lineStart": 1363,
    "lineEnd": 1363,
    "generatedClaimIds": [
      "dependency-13-7-optional-http-server-extension-start-the-http-server-when-a-cli-port-argument-is-provided"
    ],
    "rawMarkdown": ""
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
    "id": "block-0748-blank-blank",
    "type": "blank",
    "lineStart": 1374,
    "lineEnd": 1374,
    "generatedClaimIds": [
      "dependency-13-7-1-human-readable-dashboard-host-a-human-readable-dashboard-at"
    ],
    "rawMarkdown": ""
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
