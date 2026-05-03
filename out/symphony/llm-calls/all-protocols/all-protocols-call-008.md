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
    "id": "requirement-13-7-optional-http-server-extension-this-section-defines-an-optional-http-interface-for-observability-and-operationa",
    "type": "requirement",
    "title": "This section defines an OPTIONAL HTTP interface for observability and operational con...",
    "text": "This section defines an OPTIONAL HTTP interface for observability and operational control.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1345,
      "lineEnd": 1345
    }
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance",
    "type": "requirement",
    "title": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "text": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "normative": [
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1349,
      "lineEnd": 1349
    }
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-implementation-may-serve-server-rendered-html-or-a-client-side-application-f",
    "type": "requirement",
    "title": "The implementation MAY serve server-rendered HTML or a client-side application for th...",
    "text": "The implementation MAY serve server-rendered HTML or a client-side application for the dashboard.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1350,
      "lineEnd": 1350
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
    "id": "requirement-13-7-optional-http-server-extension-server-port-integer-optional",
    "type": "requirement",
    "title": "server.port (integer, OPTIONAL)",
    "text": "`server.port` (integer, OPTIONAL)",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1356,
      "lineEnd": 1356
    }
  },
  {
    "id": "claim-13-7-optional-http-server-extension-enables-the-http-server-extension",
    "type": "claim",
    "title": "Enables the HTTP server extension.",
    "text": "Enables the HTTP server extension.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1357,
      "lineEnd": 1357
    }
  },
  {
    "id": "dependency-13-7-optional-http-server-extension-cli-port-overrides-server-port-when-both-are-present",
    "type": "dependency",
    "title": "CLI --port overrides server.port when both are present.",
    "text": "CLI `--port` overrides `server.port` when both are present.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1359,
      "lineEnd": 1359
    }
  },
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
    "id": "block-0732-blank-blank",
    "type": "blank",
    "lineStart": 1345,
    "lineEnd": 1345,
    "generatedClaimIds": [
      "requirement-13-7-optional-http-server-extension-this-section-defines-an-optional-http-interface-for-observability-and-operationa"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0736-blank-blank",
    "type": "blank",
    "lineStart": 1349,
    "lineEnd": 1349,
    "generatedClaimIds": [
      "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance"
    ],
    "rawMarkdown": ""
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
    "id": "block-0740-blank-blank",
    "type": "blank",
    "lineStart": 1356,
    "lineEnd": 1356,
    "generatedClaimIds": [
      "requirement-13-7-optional-http-server-extension-server-port-integer-optional"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0741-list-server-port-integer-optional-enables-the-http-server-extension-0-requests-a",
    "type": "list",
    "lineStart": 1357,
    "lineEnd": 1360,
    "generatedClaimIds": [
      "claim-13-7-optional-http-server-extension-enables-the-http-server-extension",
      "claim-13-7-optional-http-server-extension-0-requests-an-ephemeral-port-for-local-development-and-tests",
      "dependency-13-7-optional-http-server-extension-cli-port-overrides-server-port-when-both-are-present"
    ],
    "rawMarkdown": "- `server.port` (integer, OPTIONAL)\n  - Enables the HTTP server extension.\n  - `0` requests an ephemeral port for local development and tests.\n  - CLI `--port` overrides `server.port` when both are present."
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
  }
]
```
