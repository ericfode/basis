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
    "id": "component-3-1-main-components-tracks-session-metrics-and-retry-queue-state",
    "type": "component",
    "title": "Tracks session metrics and retry queue state.",
    "text": "Tracks session metrics and retry queue state.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 92,
      "lineEnd": 92
    }
  },
  {
    "id": "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data",
    "type": "dependency",
    "title": "API calls and normalization for tracker data.",
    "text": "API calls and normalization for tracker data.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 132,
      "lineEnd": 132
    }
  },
  {
    "id": "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version",
    "type": "dependency",
    "title": "Issue tracker API (Linear for tracker.kind: linear in this specification version).",
    "text": "Issue tracker API (Linear for `tracker.kind: linear` in this specification version).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 139,
      "lineEnd": 139
    }
  },
  {
    "id": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "type": "requirement",
    "title": "WORKFLOW.md SHOULD be self-contained enough to describe and run different workflows (...",
    "text": "`WORKFLOW.md` SHOULD be self-contained enough to describe and run different workflows (prompt, runtime settings, hooks, and tracker selection/config) without requiring out-of-band service-specific configuration.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 308,
      "lineEnd": 308
    }
  },
  {
    "id": "dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "Default for tracker.kind == \"linear\": https://api.linear.app/graphql",
    "text": "Default for `tracker.kind == \"linear\"`: `https://api.linear.app/graphql`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 353,
      "lineEnd": 353
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go",
    "type": "requirement",
    "title": "Invalid reloads MUST NOT crash the service; keep operating with the last known good e...",
    "text": "Invalid reloads MUST NOT crash the service; keep operating with the last known good effective configuration and emit an operator-visible error.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 538,
      "lineEnd": 538
    }
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-tracker-apikey-is-present-after-resolution",
    "type": "test",
    "title": "tracker.apikey is present after $ resolution.",
    "text": "`tracker.api_key` is present after `$` resolution.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 562,
      "lineEnd": 562
    }
  },
  {
    "id": "dependency-6-4-core-config-fields-summary-cheat-sheet-tracker-endpoint-string-default-https-api-linear-app-graphql-when-tracker-kind-l",
    "type": "dependency",
    "title": "tracker.endpoint: string, default https://api.linear.app/graphql when tracker.kind=li...",
    "text": "`tracker.endpoint`: string, default `https://api.linear.app/graphql` when `tracker.kind=linear`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 573,
      "lineEnd": 573
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0039-heading-3-1-main-components",
    "type": "heading",
    "lineStart": 71,
    "lineEnd": 71,
    "semanticRole": "component",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.1 Main Components"
  },
  {
    "id": "block-0047-list-4-orchestrator-owns-the-poll-tick-owns-the-in-memory-runtime-state-decides-w",
    "type": "list",
    "lineStart": 89,
    "lineEnd": 93,
    "generatedClaimIds": [
      "component-3-1-main-components-owns-the-poll-tick",
      "component-3-1-main-components-owns-the-in-memory-runtime-state",
      "component-3-1-main-components-decides-which-issues-to-dispatch-retry-stop-or-release",
      "component-3-1-main-components-tracks-session-metrics-and-retry-queue-state"
    ],
    "rawMarkdown": "4. `Orchestrator`\n   - Owns the poll tick.\n   - Owns the in-memory runtime state.\n   - Decides which issues to dispatch, retry, stop, or release.\n   - Tracks session metrics and retry queue state."
  },
  {
    "id": "block-0057-heading-3-2-abstraction-levels",
    "type": "heading",
    "lineStart": 114,
    "lineEnd": 114,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Abstraction Levels"
  },
  {
    "id": "block-0069-list-5-integration-layer-linear-adapter-api-calls-and-normalization-for-tracker-data",
    "type": "list",
    "lineStart": 132,
    "lineEnd": 133,
    "generatedClaimIds": [
      "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data"
    ],
    "rawMarkdown": "5. `Integration Layer` (Linear adapter)\n   - API calls and normalization for tracker data."
  },
  {
    "id": "block-0073-heading-3-3-external-dependencies",
    "type": "heading",
    "lineStart": 138,
    "lineEnd": 138,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 External Dependencies"
  },
  {
    "id": "block-0074-blank-blank",
    "type": "blank",
    "lineStart": 139,
    "lineEnd": 139,
    "generatedClaimIds": [
      "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0159-heading-5-2-file-format",
    "type": "heading",
    "lineStart": 303,
    "lineEnd": 303,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.2 File Format"
  },
  {
    "id": "block-0164-blank-blank",
    "type": "blank",
    "lineStart": 308,
    "lineEnd": 308,
    "generatedClaimIds": [
      "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0187-heading-5-3-1-tracker-object",
    "type": "heading",
    "lineStart": 346,
    "lineEnd": 346,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.1 `tracker` (object)"
  },
  {
    "id": "block-0191-list-kind-string-required-for-dispatch-current-supported-value-linear-endpoint",
    "type": "list",
    "lineStart": 350,
    "lineEnd": 364,
    "generatedClaimIds": [
      "requirement-5-3-1-tracker-object-required-for-dispatch",
      "claim-5-3-1-tracker-object-current-supported-value-linear",
      "claim-5-3-1-tracker-object-endpoint-string",
      "dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql",
      "claim-5-3-1-tracker-object-apikey-string",
      "requirement-5-3-1-tracker-object-may-be-a-literal-token-or-varname",
      "claim-5-3-1-tracker-object-canonical-environment-variable-for-tracker-kind-linear-linearapikey",
      "claim-5-3-1-tracker-object-if-varname-resolves-to-an-empty-string-treat-the-key-as-missing",
      "claim-5-3-1-tracker-object-projectslug-string",
      "requirement-5-3-1-tracker-object-required-for-dispatch-when-tracker-kind-linear",
      "claim-5-3-1-tracker-object-activestates-list-of-strings",
      "claim-5-3-1-tracker-object-default-todo-in-progress",
      "claim-5-3-1-tracker-object-terminalstates-list-of-strings",
      "claim-5-3-1-tracker-object-default-closed-cancelled-canceled-duplicate-done"
    ],
    "rawMarkdown": "- `kind` (string)\n  - REQUIRED for dispatch.\n  - Current supported value: `linear`\n- `endpoint` (string)\n  - Default for `tracker.kind == \"linear\"`: `https://api.linear.app/graphql`\n- `api_key` (string)\n  - MAY be a literal token or `$VAR_NAME`.\n  - Canonical environment variable for `tracker.kind == \"linear\"`: `LINEAR_API_KEY`.\n  - If `$VAR_NAME` resolves to an empty string, treat the key as missing.\n- `project_slug` (string)\n  - REQUIRED for dispatch when `tracker.kind == \"linear\"`.\n- `active_states` (list of strings)\n  - Default: `Todo`, `In Progress`\n- `terminal_states` (list of strings)\n  - Default: `Closed`, `Cancelled`, `Canceled`, `Duplicate`, `Done`"
  },
  {
    "id": "block-0265-heading-6-2-dynamic-reload-semantics",
    "type": "heading",
    "lineStart": 522,
    "lineEnd": 522,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.2 Dynamic Reload Semantics"
  },
  {
    "id": "block-0269-list-the-software-must-detect-workflow-md-changes-on-change-it-must-re-read-and-re-a",
    "type": "list",
    "lineStart": 526,
    "lineEnd": 540,
    "generatedClaimIds": [
      "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
      "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
      "claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis",
      "requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical",
      "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
      "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
      "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go"
    ],
    "rawMarkdown": "- The software MUST detect `WORKFLOW.md` changes.\n- On change, it MUST re-read and re-apply workflow config and prompt template without restart.\n- The software MUST attempt to adjust live behavior to the new config (for example polling\n  cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and\n  prompt content for future runs).\n- Reloaded config applies to future dispatch, retry scheduling, reconciliation decisions, hook\n  execution, and agent launches.\n- Implementations are not REQUIRED to restart in-flight agent sessions automatically when config\n  changes.\n- Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY\n  require restart unless the implementation explicitly supports live rebind.\n- Implementations SHOULD also re-validate/reload defensively during runtime operations (for example\n  before dispatch) in case filesystem watch events are missed.\n- Invalid reloads MUST NOT crash the service; keep operating with the last known good effective\n  configuration and emit an operator-visible error."
  },
  {
    "id": "block-0271-heading-6-3-dispatch-preflight-validation",
    "type": "heading",
    "lineStart": 542,
    "lineEnd": 542,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.3 Dispatch Preflight Validation"
  },
  {
    "id": "block-0285-list-workflow-file-can-be-loaded-and-parsed-tracker-kind-is-present-and-supported",
    "type": "list",
    "lineStart": 561,
    "lineEnd": 565,
    "generatedClaimIds": [
      "test-6-3-dispatch-preflight-validation-tracker-kind-is-present-and-supported",
      "test-6-3-dispatch-preflight-validation-tracker-apikey-is-present-after-resolution",
      "test-6-3-dispatch-preflight-validation-tracker-projectslug-is-present-when-required-by-the-selected-tracker-kind",
      "test-6-3-dispatch-preflight-validation-codex-command-is-present-and-non-empty"
    ],
    "rawMarkdown": "- Workflow file can be loaded and parsed.\n- `tracker.kind` is present and supported.\n- `tracker.api_key` is present after `$` resolution.\n- `tracker.project_slug` is present when REQUIRED by the selected tracker kind.\n- `codex.command` is present and non-empty."
  },
  {
    "id": "block-0287-heading-6-4-core-config-fields-summary-cheat-sheet",
    "type": "heading",
    "lineStart": 567,
    "lineEnd": 567,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.4 Core Config Fields Summary (Cheat Sheet)"
  },
  {
    "id": "block-0291-list-tracker-kind-string-required-currently-linear-tracker-endpoint-string-defaul",
    "type": "list",
    "lineStart": 573,
    "lineEnd": 596,
    "generatedClaimIds": [
      "dependency-6-4-core-config-fields-summary-cheat-sheet-tracker-endpoint-string-default-https-api-linear-app-graphql-when-tracker-kind-l",
      "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-apikey-string-or-var-canonical-env-linearapikey-when-tracker-kind-linear",
      "requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-projectslug-string-required-when-tracker-kind-linear",
      "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-activestates-list-of-strings-default-todo-in-progress",
      "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-terminalstates-list-of-strings-default-closed-cancelled-canceled",
      "claim-6-4-core-config-fields-summary-cheat-sheet-polling-intervalms-integer-default-30000",
      "claim-6-4-core-config-fields-summary-cheat-sheet-workspace-root-path-resolved-to-absolute-default-system-temp-symphonyworkspaces",
      "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-aftercreate-shell-script-or-null",
      "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforerun-shell-script-or-null",
      "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-afterrun-shell-script-or-null",
      "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforeremove-shell-script-or-null",
      "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-timeoutms-integer-default-60000",
      "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagents-integer-default-10",
      "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxturns-integer-default-20",
      "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxretrybackoffms-integer-default-300000-5m",
      "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagentsbystate-map-of-positive-integers-default",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-command-shell-command-string-default-codex-app-server",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-approvalpolicy-codex-askforapproval-value-default-implementation-defined",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-threadsandbox-codex-sandboxmode-value-default-implementation-defined",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turnsandboxpolicy-codex-sandboxpolicy-value-default-implementation-defined",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turntimeoutms-integer-default-3600000",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-readtimeoutms-integer-default-5000",
      "claim-6-4-core-config-fields-summary-cheat-sheet-codex-stalltimeoutms-integer-default-300000"
    ],
    "rawMarkdown": "- `tracker.kind`: string, REQUIRED, currently `linear`\n- `tracker.endpoint`: string, default `https://api.linear.app/graphql` when `tracker.kind=linear`\n- `tracker.api_key`: string or `$VAR`, canonical env `LINEAR_API_KEY` when `tracker.kind=linear`\n- `tracker.project_slug`: string, REQUIRED when `tracker.kind=linear`\n- `tracker.active_states`: list of strings, default `[\"Todo\", \"In Progress\"]`\n- `tracker.terminal_states`: list of strings, default `[\"Closed\", \"Cancelled\", \"Canceled\", \"Duplicate\", \"Done\"]`\n- `polling.interval_ms`: integer, default `30000`\n- `workspace.root`: path resolved to absolute, default `<system-temp>/symphony_workspaces`\n- `hooks.after_create`: shell script or null\n- `hooks.before_run`: shell script or null\n- `hooks.after_run`: shell script or null\n- `hooks.before_remove`: shell script or null\n- `hooks.timeout_ms`: integer, default `60000`\n- `agent.max_concurrent_agents`: integer, default `10`\n- `agent.max_turns`: integer, default `20`\n- `agent.max_retry_backoff_ms`: integer, default `300000` (5m)\n- `agent.max_concurrent_agents_by_state`: map of positive integers, default `{}`\n- `codex.command`: shell command string, default `codex app-server`\n- `codex.approval_policy`: Codex `AskForApproval` value, default implementation-defined\n- `codex.thread_sandbox`: Codex `SandboxMode` value, default implementation-defined\n- `codex.turn_sandbox_policy`: Codex `SandboxPolicy` value, default implementation-defined\n- `codex.turn_timeout_ms`: integer, default `3600000`\n- `codex.read_timeout_ms`: integer, default `5000`\n- `codex.stall_timeout_ms`: integer, default `300000`"
  }
]
```
