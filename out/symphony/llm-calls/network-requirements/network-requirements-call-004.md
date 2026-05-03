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
    "id": "requirement-12-1-inputs-optional-attempt-integer-retry-continuation-metadata",
    "type": "requirement",
    "title": "OPTIONAL attempt integer (retry/continuation metadata)",
    "text": "OPTIONAL `attempt` integer (retry/continuation metadata)",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1219,
      "lineEnd": 1219
    }
  },
  {
    "id": "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh",
    "type": "risk",
    "title": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "text": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1242,
      "lineEnd": 1242
    }
  },
  {
    "id": "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional",
    "type": "requirement",
    "title": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "text": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1336,
      "lineEnd": 1336
    }
  },
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
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0647-heading-12-1-inputs",
    "type": "heading",
    "lineStart": 1214,
    "lineEnd": 1214,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 12.1 Inputs"
  },
  {
    "id": "block-0651-list-workflow-prompttemplate-normalized-issue-object-optional-attempt-integer-retry",
    "type": "list",
    "lineStart": 1218,
    "lineEnd": 1220,
    "generatedClaimIds": [
      "claim-12-1-inputs-normalized-issue-object",
      "requirement-12-1-inputs-optional-attempt-integer-retry-continuation-metadata"
    ],
    "rawMarkdown": "- `workflow.prompt_template`\n- normalized `issue` object\n- OPTIONAL `attempt` integer (retry/continuation metadata)"
  },
  {
    "id": "block-0663-heading-12-4-failure-semantics",
    "type": "heading",
    "lineStart": 1238,
    "lineEnd": 1238,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 12.4 Failure Semantics"
  },
  {
    "id": "block-0667-list-fail-the-run-attempt-immediately-let-the-orchestrator-treat-it-like-any-other-wo",
    "type": "list",
    "lineStart": 1242,
    "lineEnd": 1243,
    "generatedClaimIds": [
      "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh"
    ],
    "rawMarkdown": "- Fail the run attempt immediately.\n- Let the orchestrator treat it like any other worker failure and decide retry behavior."
  },
  {
    "id": "block-0723-heading-13-6-humanized-agent-event-summaries-optional",
    "type": "heading",
    "lineStart": 1335,
    "lineEnd": 1335,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.6 Humanized Agent Event Summaries (OPTIONAL)"
  },
  {
    "id": "block-0724-blank-blank",
    "type": "blank",
    "lineStart": 1336,
    "lineEnd": 1336,
    "generatedClaimIds": [
      "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional"
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
  }
]
```
