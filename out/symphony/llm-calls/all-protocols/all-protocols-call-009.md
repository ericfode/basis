You are executing Spec Gym projection `all-protocols`: All Protocols.

Projection instructions:
# All Protocols

Extract every protocol, transport, API boundary, client-server contract, and
wire-format obligation implied by the spec.

The projection should preserve explicit protocol names, source anchors, and
open questions where the protocol is implied but not specified.

Output contract:
- Format: json
- Final artifact path after merge: projections/all-protocols.json
- Type contracts: protocol

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
    "id": "claim-13-7-optional-http-server-extension-start-the-http-server-when-server-port-is-present-in-workflow-md-front-matter",
    "type": "claim",
    "title": "Start the HTTP server when server.port is present in WORKFLOW.md front matter.",
    "text": "Start the HTTP server when `server.port` is present in `WORKFLOW.md` front matter.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1364,
      "lineEnd": 1364
    }
  },
  {
    "id": "claim-13-7-optional-http-server-extension-the-server-top-level-key-is-owned-by-this-extension",
    "type": "claim",
    "title": "The server top-level key is owned by this extension.",
    "text": "The `server` top-level key is owned by this extension.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1365,
      "lineEnd": 1365
    }
  },
  {
    "id": "claim-13-7-optional-http-server-extension-positive-server-port-values-bind-that-port",
    "type": "claim",
    "title": "Positive server.port values bind that port.",
    "text": "Positive `server.port` values bind that port.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1366,
      "lineEnd": 1366
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
    "id": "block-0731-heading-13-7-optional-http-server-extension",
    "type": "heading",
    "lineStart": 1344,
    "lineEnd": 1344,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.7 OPTIONAL HTTP Server Extension"
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
