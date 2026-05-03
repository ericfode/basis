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
    "id": "dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values",
    "type": "dependency",
    "title": "$VAR resolution works for tracker API key and path values",
    "text": "`$VAR` resolution works for tracker API key and path values",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1944,
      "lineEnd": 1944
    }
  },
  {
    "id": "dependency-17-3-issue-tracker-client-empty-fetchissuesbystates-returns-empty-without-api-call",
    "type": "dependency",
    "title": "Empty fetchissuesbystates([]) returns empty without API call",
    "text": "Empty `fetch_issues_by_states([])` returns empty without API call",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1970,
      "lineEnd": 1970
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
    "id": "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
    "type": "dependency",
    "title": "valid query / variables inputs execute against configured Linear auth",
    "text": "valid `query` / `variables` inputs execute against configured Linear auth",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2021,
      "lineEnd": 2021
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
    "id": "block-0889-heading-17-1-workflow-and-config-parsing",
    "type": "heading",
    "lineStart": 1931,
    "lineEnd": 1931,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.1 Workflow and Config Parsing"
  },
  {
    "id": "block-0891-list-workflow-file-path-precedence-explicit-runtime-path-is-used-when-provided-cwd",
    "type": "list",
    "lineStart": 1933,
    "lineEnd": 1950,
    "generatedClaimIds": [
      "claim-17-1-workflow-and-config-parsing-explicit-runtime-path-is-used-when-provided",
      "claim-17-1-workflow-and-config-parsing-cwd-default-is-workflow-md-when-no-explicit-runtime-path-is-provided",
      "claim-17-1-workflow-and-config-parsing-workflow-file-changes-are-detected-and-trigger-re-read-re-apply-without-restart",
      "claim-17-1-workflow-and-config-parsing-invalid-workflow-reload-keeps-last-known-good-effective-configuration-and-emits-",
      "claim-17-1-workflow-and-config-parsing-missing-workflow-md-returns-typed-error",
      "claim-17-1-workflow-and-config-parsing-invalid-yaml-front-matter-returns-typed-error",
      "claim-17-1-workflow-and-config-parsing-front-matter-non-map-returns-typed-error",
      "requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing",
      "claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear",
      "claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection",
      "dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values",
      "claim-17-1-workflow-and-config-parsing-path-expansion-works",
      "claim-17-1-workflow-and-config-parsing-codex-command-is-preserved-as-a-shell-command-string",
      "claim-17-1-workflow-and-config-parsing-per-state-concurrency-override-map-normalizes-state-names-and-ignores-invalid-va",
      "claim-17-1-workflow-and-config-parsing-prompt-template-renders-issue-and-attempt",
      "claim-17-1-workflow-and-config-parsing-prompt-rendering-fails-on-unknown-variables-strict-mode"
    ],
    "rawMarkdown": "- Workflow file path precedence:\n  - explicit runtime path is used when provided\n  - cwd default is `WORKFLOW.md` when no explicit runtime path is provided\n- Workflow file changes are detected and trigger re-read/re-apply without restart\n- Invalid workflow reload keeps last known good effective configuration and emits an\n  operator-visible error\n- Missing `WORKFLOW.md` returns typed error\n- Invalid YAML front matter returns typed error\n- Front matter non-map returns typed error\n- Config defaults apply when OPTIONAL values are missing\n- `tracker.kind` validation enforces currently supported kind (`linear`)\n- `tracker.api_key` works (including `$VAR` indirection)\n- `$VAR` resolution works for tracker API key and path values\n- `~` path expansion works\n- `codex.command` is preserved as a shell command string\n- Per-state concurrency override map normalizes state names and ignores invalid values\n- Prompt template renders `issue` and `attempt`\n- Prompt rendering fails on unknown variables (strict mode)"
  },
  {
    "id": "block-0897-heading-17-3-issue-tracker-client",
    "type": "heading",
    "lineStart": 1967,
    "lineEnd": 1967,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.3 Issue Tracker Client"
  },
  {
    "id": "block-0899-list-candidate-issue-fetch-uses-active-states-and-project-slug-linear-query-uses-the-",
    "type": "list",
    "lineStart": 1969,
    "lineEnd": 1977,
    "generatedClaimIds": [
      "dependency-17-3-issue-tracker-client-linear-query-uses-the-specified-project-filter-field-slugid",
      "dependency-17-3-issue-tracker-client-empty-fetchissuesbystates-returns-empty-without-api-call",
      "dependency-17-3-issue-tracker-client-pagination-preserves-order-across-multiple-pages",
      "dependency-17-3-issue-tracker-client-blockers-are-normalized-from-inverse-relations-of-type-blocks",
      "dependency-17-3-issue-tracker-client-labels-are-normalized-to-lowercase",
      "dependency-17-3-issue-tracker-client-issue-state-refresh-by-id-returns-minimal-normalized-issues",
      "dependency-17-3-issue-tracker-client-issue-state-refresh-query-uses-graphql-id-typing-id-as-specified-in-section-11-2",
      "dependency-17-3-issue-tracker-client-error-mapping-for-request-errors-non-200-graphql-errors-malformed-payloads"
    ],
    "rawMarkdown": "- Candidate issue fetch uses active states and project slug\n- Linear query uses the specified project filter field (`slugId`)\n- Empty `fetch_issues_by_states([])` returns empty without API call\n- Pagination preserves order across multiple pages\n- Blockers are normalized from inverse relations of type `blocks`\n- Labels are normalized to lowercase\n- Issue state refresh by ID returns minimal normalized issues\n- Issue state refresh query uses GraphQL ID typing (`[ID!]`) as specified in Section 11.2\n- Error mapping for request errors, non-200, GraphQL errors, malformed payloads"
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
  }
]
```
