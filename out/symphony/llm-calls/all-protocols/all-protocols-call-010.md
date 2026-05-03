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
    "id": "dependency-13-7-2-json-rest-api-api-v1-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "dependency",
    "title": "The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging...",
    "text": "The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging ergonomics.",
    "normative": [
      "RECOMMENDED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1508,
      "lineEnd": 1508
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
    "type": "dependency",
    "title": "API errors SHOULD use a JSON envelope such as {\"error\":{\"code\":\"...\",\"message\":\"...\"}}.",
    "text": "API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1512,
      "lineEnd": 1512
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup",
    "type": "dependency",
    "title": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplica...",
    "text": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state logic.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1513,
      "lineEnd": 1513
    }
  },
  {
    "id": "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
    "type": "dependency",
    "title": "Do not log API tokens or secret env values.",
    "text": "Do not log API tokens or secret env values.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1633,
      "lineEnd": 1633
    }
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection",
    "type": "claim",
    "title": "tracker.apikey works (including $VAR indirection)",
    "text": "`tracker.api_key` works (including `$VAR` indirection)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1943,
      "lineEnd": 1943
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
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0751-heading-13-7-2-json-rest-api-api-v1",
    "type": "heading",
    "lineStart": 1381,
    "lineEnd": 1381,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 13.7.2 JSON REST API (`/api/v1/*`)"
  },
  {
    "id": "block-0764-blank-blank",
    "type": "blank",
    "lineStart": 1508,
    "lineEnd": 1508,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0765-list-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "list",
    "lineStart": 1509,
    "lineEnd": 1515,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
      "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
      "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
      "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
      "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup"
    ],
    "rawMarkdown": "- The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging ergonomics.\n- Implementations MAY add fields, but SHOULD avoid breaking existing fields within a version.\n- Endpoints SHOULD be read-only except for operational triggers like `/refresh`.\n- Unsupported methods on defined routes SHOULD return `405 Method Not Allowed`.\n- API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.\n- If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state\n  logic."
  },
  {
    "id": "block-0827-heading-15-3-secret-handling",
    "type": "heading",
    "lineStart": 1631,
    "lineEnd": 1631,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.3 Secret Handling"
  },
  {
    "id": "block-0829-list-support-var-indirection-in-workflow-config-do-not-log-api-tokens-or-secret-env",
    "type": "list",
    "lineStart": 1633,
    "lineEnd": 1635,
    "generatedClaimIds": [
      "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
      "test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them"
    ],
    "rawMarkdown": "- Support `$VAR` indirection in workflow config.\n- Do not log API tokens or secret env values.\n- Validate presence of secrets without printing them."
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
  }
]
```
