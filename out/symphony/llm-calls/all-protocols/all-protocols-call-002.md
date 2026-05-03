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
    "id": "claim-5-3-1-tracker-object-canonical-environment-variable-for-tracker-kind-linear-linearapikey",
    "type": "claim",
    "title": "Canonical environment variable for tracker.kind == \"linear\": LINEARAPIKEY.",
    "text": "Canonical environment variable for `tracker.kind == \"linear\"`: `LINEAR_API_KEY`.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 356,
      "lineEnd": 356
    }
  },
  {
    "id": "claim-5-3-6-codex-object-default-codex-app-server",
    "type": "claim",
    "title": "Default: codex app-server",
    "text": "Default: `codex app-server`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 439,
      "lineEnd": 439
    }
  },
  {
    "id": "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
    "type": "requirement",
    "title": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "text": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 441,
      "lineEnd": 441
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
    "type": "requirement",
    "title": "Extensions that manage their own listeners/resources (for example an HTTP server port...",
    "text": "Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY require restart unless the implementation explicitly supports live rebind.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 534,
      "lineEnd": 534
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
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-apikey-string-or-var-canonical-env-linearapikey-when-tracker-kind-linear",
    "type": "claim",
    "title": "tracker.apikey: string or $VAR, canonical env LINEARAPIKEY when tracker.kind=linear",
    "text": "`tracker.api_key`: string or `$VAR`, canonical env `LINEAR_API_KEY` when `tracker.kind=linear`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 574,
      "lineEnd": 574
    }
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-command-shell-command-string-default-codex-app-server",
    "type": "claim",
    "title": "codex.command: shell command string, default codex app-server",
    "text": "`codex.command`: shell command string, default `codex app-server`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 589,
      "lineEnd": 589
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0217-heading-5-3-6-codex-object",
    "type": "heading",
    "lineStart": 427,
    "lineEnd": 427,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.6 `codex` (object)"
  },
  {
    "id": "block-0223-list-command-string-shell-command-default-codex-app-server-the-runtime-launches-t",
    "type": "list",
    "lineStart": 439,
    "lineEnd": 455,
    "generatedClaimIds": [
      "claim-5-3-6-codex-object-default-codex-app-server",
      "claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory",
      "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
      "claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value",
      "claim-5-3-6-codex-object-default-implementation-defined",
      "claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value",
      "claim-5-3-6-codex-object-default-implementation-defined-2",
      "claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value",
      "claim-5-3-6-codex-object-default-implementation-defined-3",
      "claim-5-3-6-codex-object-turntimeoutms-integer",
      "claim-5-3-6-codex-object-default-3600000-1-hour",
      "claim-5-3-6-codex-object-readtimeoutms-integer",
      "claim-5-3-6-codex-object-default-5000",
      "claim-5-3-6-codex-object-stalltimeoutms-integer",
      "claim-5-3-6-codex-object-default-300000-5-minutes",
      "claim-5-3-6-codex-object-if-0-stall-detection-is-disabled"
    ],
    "rawMarkdown": "- `command` (string shell command)\n  - Default: `codex app-server`\n  - The runtime launches this command via `bash -lc` in the workspace directory.\n  - The launched process MUST speak a compatible app-server protocol over stdio.\n- `approval_policy` (Codex `AskForApproval` value)\n  - Default: implementation-defined.\n- `thread_sandbox` (Codex `SandboxMode` value)\n  - Default: implementation-defined.\n- `turn_sandbox_policy` (Codex `SandboxPolicy` value)\n  - Default: implementation-defined.\n- `turn_timeout_ms` (integer)\n  - Default: `3600000` (1 hour)\n- `read_timeout_ms` (integer)\n  - Default: `5000`\n- `stall_timeout_ms` (integer)\n  - Default: `300000` (5 minutes)\n  - If `<= 0`, stall detection is disabled."
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
