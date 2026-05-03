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
    "id": "risk-14-1-failure-classes-hook-timeout-failure",
    "type": "risk",
    "title": "Hook timeout/failure",
    "text": "Hook timeout/failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1530,
      "lineEnd": 1530
    }
  },
  {
    "id": "risk-14-1-failure-classes-turn-timeout",
    "type": "risk",
    "title": "Turn timeout",
    "text": "Turn timeout",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1535,
      "lineEnd": 1535
    }
  },
  {
    "id": "risk-14-1-failure-classes-api-transport-errors",
    "type": "risk",
    "title": "API transport errors",
    "text": "API transport errors",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1541,
      "lineEnd": 1541
    }
  },
  {
    "id": "risk-14-1-failure-classes-snapshot-timeout",
    "type": "risk",
    "title": "Snapshot timeout",
    "text": "Snapshot timeout",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1547,
      "lineEnd": 1547
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-convert-to-retries-with-exponential-backoff",
    "type": "risk",
    "title": "Convert to retries with exponential backoff.",
    "text": "Convert to retries with exponential backoff.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1559,
      "lineEnd": 1559
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-retry-on-next-tick",
    "type": "risk",
    "title": "Retry on next tick.",
    "text": "Retry on next tick.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1567,
      "lineEnd": 1567
    }
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-no-retry-timers-are-restored-from-prior-process-memory",
    "type": "risk",
    "title": "No retry timers are restored from prior process memory.",
    "text": "No retry timers are restored from prior process memory.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1581,
      "lineEnd": 1581
    }
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
    "type": "risk",
    "title": "Adding external isolation layers such as OS/container/VM sandboxing, network restrict...",
    "text": "Adding external isolation layers such as OS/container/VM sandboxing, network restrictions, or separate credentials beyond the built-in Codex policy controls.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1663,
      "lineEnd": 1663
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0769-heading-14-1-failure-classes",
    "type": "heading",
    "lineStart": 1519,
    "lineEnd": 1519,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.1 Failure Classes"
  },
  {
    "id": "block-0773-list-2-workspace-failures-workspace-directory-creation-failure-workspace-population-s",
    "type": "list",
    "lineStart": 1527,
    "lineEnd": 1531,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-workspace-directory-creation-failure",
      "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
      "risk-14-1-failure-classes-invalid-workspace-path-configuration",
      "risk-14-1-failure-classes-hook-timeout-failure"
    ],
    "rawMarkdown": "2. `Workspace Failures`\n   - Workspace directory creation failure\n   - Workspace population/synchronization failure (implementation-defined; can come from hooks)\n   - Invalid workspace path configuration\n   - Hook timeout/failure"
  },
  {
    "id": "block-0775-list-3-agent-session-failures-startup-handshake-failure-turn-failed-cancelled-turn",
    "type": "list",
    "lineStart": 1533,
    "lineEnd": 1539,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-startup-handshake-failure",
      "risk-14-1-failure-classes-turn-failed-cancelled",
      "risk-14-1-failure-classes-turn-timeout",
      "risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p",
      "risk-14-1-failure-classes-subprocess-exit",
      "risk-14-1-failure-classes-stalled-session-no-activity"
    ],
    "rawMarkdown": "3. `Agent Session Failures`\n   - Startup handshake failure\n   - Turn failed/cancelled\n   - Turn timeout\n   - User input requested and handled as failure by the implementation's documented policy\n   - Subprocess exit\n   - Stalled session (no activity)"
  },
  {
    "id": "block-0777-list-4-tracker-failures-api-transport-errors-non-200-status-graphql-errors-malfor",
    "type": "list",
    "lineStart": 1541,
    "lineEnd": 1545,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-api-transport-errors",
      "risk-14-1-failure-classes-non-200-status",
      "risk-14-1-failure-classes-graphql-errors",
      "risk-14-1-failure-classes-malformed-payloads"
    ],
    "rawMarkdown": "4. `Tracker Failures`\n   - API transport errors\n   - Non-200 status\n   - GraphQL errors\n   - malformed payloads"
  },
  {
    "id": "block-0779-list-5-observability-failures-snapshot-timeout-dashboard-render-errors-log-sink-con",
    "type": "list",
    "lineStart": 1547,
    "lineEnd": 1550,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-snapshot-timeout",
      "risk-14-1-failure-classes-dashboard-render-errors",
      "risk-14-1-failure-classes-log-sink-configuration-failure"
    ],
    "rawMarkdown": "5. `Observability Failures`\n   - Snapshot timeout\n   - Dashboard render errors\n   - Log sink configuration failure"
  },
  {
    "id": "block-0781-heading-14-2-recovery-behavior",
    "type": "heading",
    "lineStart": 1552,
    "lineEnd": 1552,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.2 Recovery Behavior"
  },
  {
    "id": "block-0785-list-worker-failures-convert-to-retries-with-exponential-backoff",
    "type": "list",
    "lineStart": 1559,
    "lineEnd": 1560,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-convert-to-retries-with-exponential-backoff"
    ],
    "rawMarkdown": "- Worker failures:\n  - Convert to retries with exponential backoff."
  },
  {
    "id": "block-0789-list-reconciliation-state-refresh-failures-keep-current-workers-retry-on-next-tick",
    "type": "list",
    "lineStart": 1566,
    "lineEnd": 1568,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-keep-current-workers",
      "risk-14-2-recovery-behavior-retry-on-next-tick"
    ],
    "rawMarkdown": "- Reconciliation state-refresh failures:\n  - Keep current workers.\n  - Retry on next tick."
  },
  {
    "id": "block-0793-heading-14-3-partial-state-recovery-restart",
    "type": "heading",
    "lineStart": 1573,
    "lineEnd": 1573,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.3 Partial State Recovery (Restart)"
  },
  {
    "id": "block-0798-blank-blank",
    "type": "blank",
    "lineStart": 1581,
    "lineEnd": 1581,
    "generatedClaimIds": [
      "risk-14-3-partial-state-recovery-restart-no-retry-timers-are-restored-from-prior-process-memory"
    ],
    "rawMarkdown": ""
  },
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
  }
]
```
