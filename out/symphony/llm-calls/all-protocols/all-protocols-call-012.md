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
    "id": "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
    "type": "dependency",
    "title": "If client-side tools are implemented, session startup advertises the supported tool s...",
    "text": "If client-side tools are implemented, session startup advertises the supported tool specs using the targeted app-server protocol",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2017,
      "lineEnd": 2017
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
    "type": "dependency",
    "title": "If the lineargraphql client-side tool extension is implemented:",
    "text": "If the `linear_graphql` client-side tool extension is implemented:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2019,
      "lineEnd": 2019
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
    "type": "dependency",
    "title": "invalid arguments, missing auth, and transport failures return structured failure pay...",
    "text": "invalid arguments, missing auth, and transport failures return structured failure payloads",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2023,
      "lineEnd": 2023
    }
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap",
    "type": "dependency",
    "title": "A real tracker smoke test can be run with valid credentials supplied by LINEARAPIKEY...",
    "text": "A real tracker smoke test can be run with valid credentials supplied by `LINEAR_API_KEY` or a documented local bootstrap mechanism (for example `~/.linear_api_key`).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2051,
      "lineEnd": 2051
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
    "id": "block-0905-heading-17-5-coding-agent-app-server-client",
    "type": "heading",
    "lineStart": 1998,
    "lineEnd": 1998,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.5 Coding-Agent App-Server Client"
  },
  {
    "id": "block-0907-list-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command-session-st",
    "type": "list",
    "lineStart": 2000,
    "lineEnd": 2025,
    "generatedClaimIds": [
      "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
      "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
      "dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san",
      "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
      "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
      "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
      "dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu",
      "dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session",
      "dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol",
      "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
      "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
      "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
      "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
      "dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session",
      "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
      "dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body",
      "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
      "dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session"
    ],
    "rawMarkdown": "- Launch command uses workspace cwd and invokes `bash -lc <codex.command>`\n- Session startup follows the targeted Codex app-server protocol.\n- Client identity/capability payloads are valid when the targeted Codex app-server protocol requires\n  them.\n- Policy-related startup payloads use the implementation's documented approval/sandbox settings\n- Thread and turn identities exposed by the targeted protocol are extracted and used to emit\n  `session_started`\n- Request/response read timeout is enforced\n- Turn timeout is enforced\n- Transport framing required by the targeted protocol is handled correctly\n- For stdio-based transports, diagnostic stderr handling is kept separate from the protocol stream\n- Command/file-change approvals are handled according to the implementation's documented policy\n- Unsupported dynamic tool calls are rejected without stalling the session\n- User input requests are handled according to the implementation's documented policy and do not\n  stall indefinitely\n- Usage and rate-limit telemetry exposed by the targeted protocol is extracted\n- Approval, user-input-required, usage, and rate-limit signals are interpreted according to the\n  targeted protocol\n- If client-side tools are implemented, session startup advertises the supported tool specs\n  using the targeted app-server protocol\n- If the `linear_graphql` client-side tool extension is implemented:\n  - the tool is advertised to the session\n  - valid `query` / `variables` inputs execute against configured Linear auth\n  - top-level GraphQL `errors` produce `success=false` while preserving the GraphQL body\n  - invalid arguments, missing auth, and transport failures return structured failure payloads\n  - unsupported tool names still fail without stalling the session"
  },
  {
    "id": "block-0917-heading-17-8-real-integration-profile-recommended",
    "type": "heading",
    "lineStart": 2047,
    "lineEnd": 2047,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.8 Real Integration Profile (RECOMMENDED)"
  },
  {
    "id": "block-0920-blank-blank",
    "type": "blank",
    "lineStart": 2051,
    "lineEnd": 2051,
    "generatedClaimIds": [
      "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap"
    ],
    "rawMarkdown": ""
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
