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
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally",
    "type": "dependency",
    "title": "CLI exits nonzero when startup fails or the host process exits abnormally",
    "text": "CLI exits nonzero when startup fails or the host process exits abnormally",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2044,
      "lineEnd": 2044
    }
  },
  {
    "id": "test-18-1-required-for-conformance-issue-tracker-client-with-candidate-fetch-state-refresh-terminal-fetch",
    "type": "test",
    "title": "Issue tracker client with candidate fetch + state refresh + terminal fetch",
    "text": "Issue tracker client with candidate fetch + state refresh + terminal fetch",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2074,
      "lineEnd": 2074
    }
  },
  {
    "id": "test-18-1-required-for-conformance-hook-timeout-config-hooks-timeoutms-default-60000",
    "type": "test",
    "title": "Hook timeout config (hooks.timeoutms, default 60000)",
    "text": "Hook timeout config (`hooks.timeout_ms`, default `60000`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2077,
      "lineEnd": 2077
    }
  },
  {
    "id": "test-18-1-required-for-conformance-coding-agent-app-server-subprocess-client-with-json-line-protocol",
    "type": "test",
    "title": "Coding-agent app-server subprocess client with JSON line protocol",
    "text": "Coding-agent app-server subprocess client with JSON line protocol",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2078,
      "lineEnd": 2078
    }
  },
  {
    "id": "test-18-1-required-for-conformance-codex-launch-command-config-codex-command-default-codex-app-server",
    "type": "test",
    "title": "Codex launch command config (codex.command, default codex app-server)",
    "text": "Codex launch command config (`codex.command`, default `codex app-server`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2079,
      "lineEnd": 2079
    }
  },
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
    "id": "test-18-1-required-for-conformance-configurable-retry-backoff-cap-agent-maxretrybackoffms-default-5m",
    "type": "test",
    "title": "Configurable retry backoff cap (agent.maxretrybackoffms, default 5m)",
    "text": "Configurable retry backoff cap (`agent.max_retry_backoff_ms`, default 5m)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2082,
      "lineEnd": 2082
    }
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind-",
    "type": "test",
    "title": "HTTP server extension honors CLI --port over server.port, uses a safe default bind ho...",
    "text": "HTTP server extension honors CLI `--port` over `server.port`, uses a safe default bind host, and exposes the baseline endpoints/error semantics in Section 13.7 if shipped.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2090,
      "lineEnd": 2090
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0913-heading-17-7-cli-and-host-lifecycle",
    "type": "heading",
    "lineStart": 2038,
    "lineEnd": 2038,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.7 CLI and Host Lifecycle"
  },
  {
    "id": "block-0915-list-cli-accepts-a-positional-workflow-path-argument-path-to-workflow-md-cli-uses",
    "type": "list",
    "lineStart": 2040,
    "lineEnd": 2045,
    "generatedClaimIds": [
      "dependency-17-7-cli-and-host-lifecycle-cli-uses-workflow-md-when-no-workflow-path-argument-is-provided",
      "dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md",
      "dependency-17-7-cli-and-host-lifecycle-cli-surfaces-startup-failure-cleanly",
      "dependency-17-7-cli-and-host-lifecycle-cli-exits-with-success-when-application-starts-and-shuts-down-normally",
      "dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally"
    ],
    "rawMarkdown": "- CLI accepts a positional workflow path argument (`path-to-WORKFLOW.md`)\n- CLI uses `./WORKFLOW.md` when no workflow path argument is provided\n- CLI errors on nonexistent explicit workflow path or missing default `./WORKFLOW.md`\n- CLI surfaces startup failure cleanly\n- CLI exits with success when application starts and shuts down normally\n- CLI exits nonzero when startup fails or the host process exits abnormally"
  },
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
    "id": "block-0934-blank-blank",
    "type": "blank",
    "lineStart": 2090,
    "lineEnd": 2090,
    "generatedClaimIds": [
      "test-18-2-recommended-extensions-not-required-for-conformance-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind-"
    ],
    "rawMarkdown": ""
  }
]
```
