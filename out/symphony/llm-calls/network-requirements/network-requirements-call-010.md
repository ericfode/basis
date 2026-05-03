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
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-todo-persist-retry-queue-and-session-metadata-across-process-restarts",
    "type": "test",
    "title": "TODO: Persist retry queue and session metadata across process restarts.",
    "text": "TODO: Persist retry queue and session metadata across process restarts.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2094,
      "lineEnd": 2094
    }
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne",
    "type": "test",
    "title": "Run the Real Integration Profile from Section 17.8 with valid credentials and network...",
    "text": "Run the `Real Integration Profile` from Section 17.8 with valid credentials and network access.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2103,
      "lineEnd": 2103
    }
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
    "type": "test",
    "title": "Verify hook execution and workflow path resolution on the target host OS/shell enviro...",
    "text": "Verify hook execution and workflow path resolution on the target host OS/shell environment.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2104,
      "lineEnd": 2104
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
    "id": "requirement-appendix-a-ssh-worker-extension-optional-worker-sshhosts-list-of-ssh-host-strings-optional",
    "type": "requirement",
    "title": "worker.sshhosts (list of SSH host strings, OPTIONAL)",
    "text": "`worker.ssh_hosts` (list of SSH host strings, OPTIONAL)",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2115,
      "lineEnd": 2115
    }
  },
  {
    "id": "requirement-appendix-a-ssh-worker-extension-optional-worker-maxconcurrentagentsperhost-positive-integer-optional",
    "type": "requirement",
    "title": "worker.maxconcurrentagentsperhost (positive integer, OPTIONAL)",
    "text": "`worker.max_concurrent_agents_per_host` (positive integer, OPTIONAL)",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2117,
      "lineEnd": 2117
    }
  },
  {
    "id": "dependency-appendix-a-ssh-worker-extension-optional-shared-per-host-cap-applied-across-configured-ssh-hosts",
    "type": "dependency",
    "title": "Shared per-host cap applied across configured SSH hosts.",
    "text": "Shared per-host cap applied across configured SSH hosts.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2118,
      "lineEnd": 2118
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
    "id": "block-0938-blank-blank",
    "type": "blank",
    "lineStart": 2103,
    "lineEnd": 2103,
    "generatedClaimIds": [
      "test-18-3-operational-validation-before-production-recommended-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne"
    ],
    "rawMarkdown": ""
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
    "id": "block-0941-heading-appendix-a-ssh-worker-extension-optional",
    "type": "heading",
    "lineStart": 2109,
    "lineEnd": 2109,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## Appendix A. SSH Worker Extension (OPTIONAL)"
  },
  {
    "id": "block-0946-blank-blank",
    "type": "blank",
    "lineStart": 2115,
    "lineEnd": 2115,
    "generatedClaimIds": [
      "requirement-appendix-a-ssh-worker-extension-optional-worker-sshhosts-list-of-ssh-host-strings-optional"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0947-list-worker-sshhosts-list-of-ssh-host-strings-optional-when-omitted-work-runs-loca",
    "type": "list",
    "lineStart": 2116,
    "lineEnd": 2119,
    "generatedClaimIds": [
      "claim-appendix-a-ssh-worker-extension-optional-when-omitted-work-runs-locally",
      "requirement-appendix-a-ssh-worker-extension-optional-worker-maxconcurrentagentsperhost-positive-integer-optional",
      "dependency-appendix-a-ssh-worker-extension-optional-shared-per-host-cap-applied-across-configured-ssh-hosts"
    ],
    "rawMarkdown": "- `worker.ssh_hosts` (list of SSH host strings, OPTIONAL)\n  - When omitted, work runs locally.\n- `worker.max_concurrent_agents_per_host` (positive integer, OPTIONAL)\n  - Shared per-host cap applied across configured SSH hosts."
  }
]
```
