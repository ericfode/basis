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
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-lineargraphql-client-side-tool-extension-exposes-raw-linear-graphql-access-throu",
    "type": "test",
    "title": "lineargraphql client-side tool extension exposes raw Linear GraphQL access through th...",
    "text": "`linear_graphql` client-side tool extension exposes raw Linear GraphQL access through the app-server session using configured Symphony auth.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2092,
      "lineEnd": 2092
    }
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l",
    "type": "test",
    "title": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopb...",
    "text": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default bind expectations on the target environment.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2105,
      "lineEnd": 2105
    }
  },
  {
    "id": "claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub",
    "type": "claim",
    "title": "The coding-agent app-server is launched over SSH stdio instead of as a local subproce...",
    "text": "The coding-agent app-server is launched over SSH stdio instead of as a local subprocess, so the orchestrator still owns the session lifecycle even though commands execute remotely.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2128,
      "lineEnd": 2128
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0933-heading-18-2-recommended-extensions-not-required-for-conformance",
    "type": "heading",
    "lineStart": 2089,
    "lineEnd": 2089,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 18.2 RECOMMENDED Extensions (Not REQUIRED for Conformance)"
  },
  {
    "id": "block-0935-list-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind",
    "type": "list",
    "lineStart": 2091,
    "lineEnd": 2100,
    "generatedClaimIds": [
      "test-18-2-recommended-extensions-not-required-for-conformance-lineargraphql-client-side-tool-extension-exposes-raw-linear-graphql-access-throu",
      "test-18-2-recommended-extensions-not-required-for-conformance-todo-persist-retry-queue-and-session-metadata-across-process-restarts",
      "test-18-2-recommended-extensions-not-required-for-conformance-todo-make-observability-settings-configurable-in-workflow-front-matter-without-p",
      "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-first-class-tracker-write-apis-comments-state-transitions-in-the-orches",
      "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-pluggable-issue-tracker-adapters-beyond-linear"
    ],
    "rawMarkdown": "- HTTP server extension honors CLI `--port` over `server.port`, uses a safe default bind host, and\n  exposes the baseline endpoints/error semantics in Section 13.7 if shipped.\n- `linear_graphql` client-side tool extension exposes raw Linear GraphQL access through the\n  app-server session using configured Symphony auth.\n- TODO: Persist retry queue and session metadata across process restarts.\n- TODO: Make observability settings configurable in workflow front matter without prescribing UI\n  implementation details.\n- TODO: Add first-class tracker write APIs (comments/state transitions) in the orchestrator instead\n  of only via agent tools.\n- TODO: Add pluggable issue tracker adapters beyond Linear."
  },
  {
    "id": "block-0937-heading-18-3-operational-validation-before-production-recommended",
    "type": "heading",
    "lineStart": 2102,
    "lineEnd": 2102,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 18.3 Operational Validation Before Production (RECOMMENDED)"
  },
  {
    "id": "block-0939-list-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne",
    "type": "list",
    "lineStart": 2104,
    "lineEnd": 2107,
    "generatedClaimIds": [
      "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
      "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l"
    ],
    "rawMarkdown": "- Run the `Real Integration Profile` from Section 17.8 with valid credentials and network access.\n- Verify hook execution and workflow path resolution on the target host OS/shell environment.\n- If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default\n  bind expectations on the target environment."
  },
  {
    "id": "block-0949-heading-a-1-execution-model",
    "type": "heading",
    "lineStart": 2121,
    "lineEnd": 2121,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### A.1 Execution Model"
  },
  {
    "id": "block-0951-list-the-orchestrator-remains-the-single-source-of-truth-for-polling-claims-retries-a",
    "type": "list",
    "lineStart": 2123,
    "lineEnd": 2134,
    "generatedClaimIds": [
      "claim-a-1-execution-model-worker-sshhosts-provides-the-candidate-ssh-destinations-for-remote-execution",
      "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
      "dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host",
      "claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub",
      "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
      "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme"
    ],
    "rawMarkdown": "- The orchestrator remains the single source of truth for polling, claims, retries, and\n  reconciliation.\n- `worker.ssh_hosts` provides the candidate SSH destinations for remote execution.\n- Each worker run is assigned to one host at a time, and that host becomes part of the run's\n  effective execution identity along with the issue workspace.\n- `workspace.root` is interpreted on the remote host, not on the orchestrator host.\n- The coding-agent app-server is launched over SSH stdio instead of as a local subprocess, so the\n  orchestrator still owns the session lifecycle even though commands execute remotely.\n- Continuation turns inside one worker lifetime SHOULD stay on the same host and workspace.\n- A remote host SHOULD satisfy the same basic contract as a local worker environment: reachable\n  shell, writable workspace root, coding-agent executable, and any required auth or repository\n  prerequisites."
  }
]
```
