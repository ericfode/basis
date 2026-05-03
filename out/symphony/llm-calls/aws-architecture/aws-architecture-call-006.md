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
    "id": "test-18-1-required-for-conformance-exponential-retry-queue-with-continuation-retries-after-normal-exit",
    "type": "test",
    "title": "Exponential retry queue with continuation retries after normal exit",
    "text": "Exponential retry queue with continuation retries after normal exit",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2081,
      "lineEnd": 2081
    }
  },
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
    "id": "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
    "type": "dependency",
    "title": "Each worker run is assigned to one host at a time, and that host becomes part of the...",
    "text": "Each worker run is assigned to one host at a time, and that host becomes part of the run's effective execution identity along with the issue workspace.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2125,
      "lineEnd": 2125
    }
  },
  {
    "id": "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
    "type": "requirement",
    "title": "Continuation turns inside one worker lifetime SHOULD stay on the same host and worksp...",
    "text": "Continuation turns inside one worker lifetime SHOULD stay on the same host and workspace.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2130,
      "lineEnd": 2130
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0929-heading-18-1-required-for-conformance",
    "type": "heading",
    "lineStart": 2068,
    "lineEnd": 2068,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 18.1 REQUIRED for Conformance"
  },
  {
    "id": "block-0931-list-workflow-path-selection-supports-explicit-runtime-path-and-cwd-default-workflow-",
    "type": "list",
    "lineStart": 2070,
    "lineEnd": 2087,
    "generatedClaimIds": [
      "test-18-1-required-for-conformance-workflow-md-loader-with-yaml-front-matter-prompt-body-split",
      "test-18-1-required-for-conformance-typed-config-layer-with-defaults-and-resolution",
      "test-18-1-required-for-conformance-dynamic-workflow-md-watch-reload-re-apply-for-config-and-prompt",
      "test-18-1-required-for-conformance-polling-orchestrator-with-single-authority-mutable-state",
      "test-18-1-required-for-conformance-issue-tracker-client-with-candidate-fetch-state-refresh-terminal-fetch",
      "test-18-1-required-for-conformance-workspace-manager-with-sanitized-per-issue-workspaces",
      "test-18-1-required-for-conformance-workspace-lifecycle-hooks-aftercreate-beforerun-afterrun-beforeremove",
      "test-18-1-required-for-conformance-hook-timeout-config-hooks-timeoutms-default-60000",
      "test-18-1-required-for-conformance-coding-agent-app-server-subprocess-client-with-json-line-protocol",
      "test-18-1-required-for-conformance-codex-launch-command-config-codex-command-default-codex-app-server",
      "test-18-1-required-for-conformance-strict-prompt-rendering-with-issue-and-attempt-variables",
      "test-18-1-required-for-conformance-exponential-retry-queue-with-continuation-retries-after-normal-exit",
      "test-18-1-required-for-conformance-configurable-retry-backoff-cap-agent-maxretrybackoffms-default-5m",
      "test-18-1-required-for-conformance-reconciliation-that-stops-runs-on-terminal-non-active-tracker-states",
      "test-18-1-required-for-conformance-workspace-cleanup-for-terminal-issues-startup-sweep-active-transition",
      "test-18-1-required-for-conformance-structured-logs-with-issueid-issueidentifier-and-sessionid",
      "test-18-1-required-for-conformance-operator-visible-observability-structured-logs-optional-snapshot-status-surface"
    ],
    "rawMarkdown": "- Workflow path selection supports explicit runtime path and cwd default\n- `WORKFLOW.md` loader with YAML front matter + prompt body split\n- Typed config layer with defaults and `$` resolution\n- Dynamic `WORKFLOW.md` watch/reload/re-apply for config and prompt\n- Polling orchestrator with single-authority mutable state\n- Issue tracker client with candidate fetch + state refresh + terminal fetch\n- Workspace manager with sanitized per-issue workspaces\n- Workspace lifecycle hooks (`after_create`, `before_run`, `after_run`, `before_remove`)\n- Hook timeout config (`hooks.timeout_ms`, default `60000`)\n- Coding-agent app-server subprocess client with JSON line protocol\n- Codex launch command config (`codex.command`, default `codex app-server`)\n- Strict prompt rendering with `issue` and `attempt` variables\n- Exponential retry queue with continuation retries after normal exit\n- Configurable retry backoff cap (`agent.max_retry_backoff_ms`, default 5m)\n- Reconciliation that stops runs on terminal/non-active tracker states\n- Workspace cleanup for terminal issues (startup sweep + active transition)\n- Structured logs with `issue_id`, `issue_identifier`, and `session_id`\n- Operator-visible observability (structured logs; OPTIONAL snapshot/status surface)"
  },
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
