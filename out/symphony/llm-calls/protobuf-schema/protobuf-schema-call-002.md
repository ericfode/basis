You are executing Spec Gym projection `protobuf-schema`: Protobuf Schema.

Projection instructions:
# Protobuf Schema

Derive a `.proto` schema from explicit data, protocol, request, response, and
event claims in the spec.

The projection should keep uncertain message or field names as comments or
questions rather than silently committing to an invented interface.

Output contract:
- Format: proto
- Final artifact path after merge: spec.proto
- Type contracts: protobuf-schema, data-type, protocol

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
    "id": "claim-7-3-transition-triggers-codex-update-event",
    "type": "claim",
    "title": "Codex Update Event",
    "text": "`Codex Update Event`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 675,
      "lineEnd": 675
    }
  },
  {
    "id": "claim-8-5-active-run-reconciliation-lastcodextimestamp-if-any-event-has-been-seen-else",
    "type": "claim",
    "title": "lastcodextimestamp if any event has been seen, else",
    "text": "`last_codex_timestamp` if any event has been seen, else",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 785,
      "lineEnd": 785
    }
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
    "type": "dependency",
    "title": "Implementations MUST consult the targeted Codex app-server documentation or generated...",
    "text": "Implementations MUST consult the targeted Codex app-server documentation or generated schema instead of treating this specification as a protocol schema.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 914,
      "lineEnd": 914
    }
  },
  {
    "id": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should",
    "type": "requirement",
    "title": "Each event SHOULD",
    "text": "Each event SHOULD",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 996,
      "lineEnd": 996
    }
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-event-enum-string",
    "type": "claim",
    "title": "event (enum/string)",
    "text": "`event` (enum/string)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 999,
      "lineEnd": 999
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
  },
  {
    "id": "block-0323-heading-7-3-transition-triggers",
    "type": "heading",
    "lineStart": 657,
    "lineEnd": 657,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 7.3 Transition Triggers"
  },
  {
    "id": "block-0330-blank-blank",
    "type": "blank",
    "lineStart": 675,
    "lineEnd": 675,
    "generatedClaimIds": [
      "claim-7-3-transition-triggers-codex-update-event"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0397-heading-8-5-active-run-reconciliation",
    "type": "heading",
    "lineStart": 779,
    "lineEnd": 779,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 8.5 Active Run Reconciliation"
  },
  {
    "id": "block-0403-list-for-each-running-issue-compute-elapsedms-since-lastcodextimestamp-if-any-event",
    "type": "list",
    "lineStart": 785,
    "lineEnd": 789,
    "generatedClaimIds": [
      "claim-8-5-active-run-reconciliation-lastcodextimestamp-if-any-event-has-been-seen-else",
      "claim-8-5-active-run-reconciliation-startedat",
      "claim-8-5-active-run-reconciliation-if-elapsedms-codex-stalltimeoutms-terminate-the-worker-and-queue-a-retry",
      "claim-8-5-active-run-reconciliation-if-stalltimeoutms-0-skip-stall-detection-entirely"
    ],
    "rawMarkdown": "- For each running issue, compute `elapsed_ms` since:\n  - `last_codex_timestamp` if any event has been seen, else\n  - `started_at`\n- If `elapsed_ms > codex.stall_timeout_ms`, terminate the worker and queue a retry.\n- If `stall_timeout_ms <= 0`, skip stall detection entirely."
  },
  {
    "id": "block-0485-heading-10-agent-runner-protocol-coding-agent-integration",
    "type": "heading",
    "lineStart": 906,
    "lineEnd": 906,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "## 10. Agent Runner Protocol (Coding Agent Integration)"
  },
  {
    "id": "block-0491-list-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "list",
    "lineStart": 914,
    "lineEnd": 920,
    "generatedClaimIds": [
      "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
      "dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro",
      "dependency-10-agent-runner-protocol-coding-agent-integration-symphony-specific-requirements-in-this-section-still-control-orchestration-behav"
    ],
    "rawMarkdown": "- Implementations MUST send messages that are valid for the targeted Codex app-server version.\n- Implementations MUST consult the targeted Codex app-server documentation or generated schema\n  instead of treating this specification as a protocol schema.\n- If this specification appears to conflict with the targeted Codex app-server protocol, the Codex\n  protocol controls protocol shape and transport behavior.\n- Symphony-specific requirements in this section still control orchestration behavior, workspace\n  selection, prompt construction, continuation handling, and observability extraction."
  },
  {
    "id": "block-0535-heading-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "type": "heading",
    "lineStart": 995,
    "lineEnd": 995,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.4 Emitted Runtime Events (Upstream to Orchestrator)"
  },
  {
    "id": "block-0536-blank-blank",
    "type": "blank",
    "lineStart": 996,
    "lineEnd": 996,
    "generatedClaimIds": [
      "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0538-blank-blank",
    "type": "blank",
    "lineStart": 999,
    "lineEnd": 999,
    "generatedClaimIds": [
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-event-enum-string"
    ],
    "rawMarkdown": ""
  }
]
```
