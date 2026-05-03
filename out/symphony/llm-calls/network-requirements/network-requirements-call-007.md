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
    "id": "risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d",
    "type": "risk",
    "title": "Reducing the set of client-side tools, credentials, filesystem paths, and network des...",
    "text": "Reducing the set of client-side tools, credentials, filesystem paths, and network destinations available to the agent to the minimum needed for the workflow.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1669,
      "lineEnd": 1669
    }
  },
  {
    "id": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-it-returns-running-rows-retry-rows-token-totals",
    "type": "dependency",
    "title": "If a snapshot API is implemented, it returns running rows, retry rows, token totals,...",
    "text": "If a snapshot API is implemented, it returns running rows, retry rows, token totals, and rate limits",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1993,
      "lineEnd": 1993
    }
  },
  {
    "id": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-timeout-unavailable-cases-are-surfaced",
    "type": "dependency",
    "title": "If a snapshot API is implemented, timeout/unavailable cases are surfaced",
    "text": "If a snapshot API is implemented, timeout/unavailable cases are surfaced",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1995,
      "lineEnd": 1995
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
    "type": "dependency",
    "title": "Session startup follows the targeted Codex app-server protocol.",
    "text": "Session startup follows the targeted Codex app-server protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2000,
      "lineEnd": 2000
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
    "type": "dependency",
    "title": "Client identity/capability payloads are valid when the targeted Codex app-server prot...",
    "text": "Client identity/capability payloads are valid when the targeted Codex app-server protocol requires them.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2001,
      "lineEnd": 2001
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
    "type": "dependency",
    "title": "Thread and turn identities exposed by the targeted protocol are extracted and used to...",
    "text": "Thread and turn identities exposed by the targeted protocol are extracted and used to emit `session_started`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2004,
      "lineEnd": 2004
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
    "type": "dependency",
    "title": "Request/response read timeout is enforced",
    "text": "Request/response read timeout is enforced",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2006,
      "lineEnd": 2006
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
    "type": "dependency",
    "title": "Turn timeout is enforced",
    "text": "Turn timeout is enforced",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2007,
      "lineEnd": 2007
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0839-heading-15-5-harness-hardening-guidance",
    "type": "heading",
    "lineStart": 1648,
    "lineEnd": 1648,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.5 Harness Hardening Guidance"
  },
  {
    "id": "block-0847-list-tightening-codex-approval-and-sandbox-settings-described-elsewhere-in-this-speci",
    "type": "list",
    "lineStart": 1662,
    "lineEnd": 1671,
    "generatedClaimIds": [
      "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
      "risk-15-5-harness-hardening-guidance-filtering-which-linear-issues-projects-teams-labels-or-other-tracker-sources-are",
      "risk-15-5-harness-hardening-guidance-narrowing-the-lineargraphql-tool-so-it-can-only-read-or-mutate-data-inside-the-i",
      "risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d"
    ],
    "rawMarkdown": "- Tightening Codex approval and sandbox settings described elsewhere in this specification instead\n  of running with a maximally permissive configuration.\n- Adding external isolation layers such as OS/container/VM sandboxing, network restrictions, or\n  separate credentials beyond the built-in Codex policy controls.\n- Filtering which Linear issues, projects, teams, labels, or other tracker sources are eligible for\n  dispatch so untrusted or out-of-scope tasks do not automatically reach the agent.\n- Narrowing the `linear_graphql` tool so it can only read or mutate data inside the\n  intended project scope, rather than exposing general workspace-wide tracker access.\n- Reducing the set of client-side tools, credentials, filesystem paths, and network destinations\n  available to the agent to the minimum needed for the workflow."
  },
  {
    "id": "block-0901-heading-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "type": "heading",
    "lineStart": 1979,
    "lineEnd": 1979,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.4 Orchestrator Dispatch, Reconciliation, and Retry"
  },
  {
    "id": "block-0903-list-dispatch-sort-order-is-priority-then-oldest-creation-time-todo-issue-with-non-te",
    "type": "list",
    "lineStart": 1981,
    "lineEnd": 1996,
    "generatedClaimIds": [
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-non-terminal-blockers-is-not-eligible",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-terminal-blockers-is-eligible",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-active-state-issue-refresh-updates-running-entry-state",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-non-active-state-stops-running-agent-without-workspace-cleanup",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-terminal-state-stops-running-agent-and-cleans-workspace",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-reconciliation-with-no-running-issues-is-a-no-op",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-normal-worker-exit-schedules-a-short-continuation-retry-attempt-1",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-abnormal-worker-exit-increments-retries-with-10s-based-exponential-backoff",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-backoff-cap-uses-configured-agent-maxretrybackoffms",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-queue-entries-include-attempt-due-time-identifier-and-error",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-stall-detection-kills-stalled-sessions-and-schedules-retry",
      "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-slot-exhaustion-requeues-retries-with-explicit-error-reason",
      "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-it-returns-running-rows-retry-rows-token-totals",
      "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-timeout-unavailable-cases-are-surfaced"
    ],
    "rawMarkdown": "- Dispatch sort order is priority then oldest creation time\n- `Todo` issue with non-terminal blockers is not eligible\n- `Todo` issue with terminal blockers is eligible\n- Active-state issue refresh updates running entry state\n- Non-active state stops running agent without workspace cleanup\n- Terminal state stops running agent and cleans workspace\n- Reconciliation with no running issues is a no-op\n- Normal worker exit schedules a short continuation retry (attempt 1)\n- Abnormal worker exit increments retries with 10s-based exponential backoff\n- Retry backoff cap uses configured `agent.max_retry_backoff_ms`\n- Retry queue entries include attempt, due time, identifier, and error\n- Stall detection kills stalled sessions and schedules retry\n- Slot exhaustion requeues retries with explicit error reason\n- If a snapshot API is implemented, it returns running rows, retry rows, token totals, and rate\n  limits\n- If a snapshot API is implemented, timeout/unavailable cases are surfaced"
  },
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
  }
]
```
