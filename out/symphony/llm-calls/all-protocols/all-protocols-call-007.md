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
    "id": "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "GraphQL endpoint (default https://api.linear.app/graphql)",
    "text": "GraphQL endpoint (default `https://api.linear.app/graphql`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1152,
      "lineEnd": 1152
    }
  },
  {
    "id": "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp",
    "type": "requirement",
    "title": "A non-Linear implementation MAY change transport details, but the normalized outputs...",
    "text": "A non-Linear implementation MAY change transport details, but the normalized outputs MUST match the",
    "normative": [
      "MAY",
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1166,
      "lineEnd": 1166
    }
  },
  {
    "id": "claim-11-4-error-handling-contract-missingtrackerapikey",
    "type": "claim",
    "title": "missingtrackerapikey",
    "text": "`missing_tracker_api_key`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1185,
      "lineEnd": 1185
    }
  },
  {
    "id": "claim-11-4-error-handling-contract-linearapirequest-transport-failures",
    "type": "claim",
    "title": "linearapirequest (transport failures)",
    "text": "`linear_api_request` (transport failures)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1187,
      "lineEnd": 1187
    }
  },
  {
    "id": "claim-11-4-error-handling-contract-linearapistatus-non-200-http",
    "type": "claim",
    "title": "linearapistatus (non-200 HTTP)",
    "text": "`linear_api_status` (non-200 HTTP)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1188,
      "lineEnd": 1188
    }
  },
  {
    "id": "dependency-11-5-tracker-writes-important-boundary-if-the-lineargraphql-client-side-tool-extension-is-implemented-it-is-still-part-",
    "type": "dependency",
    "title": "If the lineargraphql client-side tool extension is implemented, it is still part of t...",
    "text": "If the `linear_graphql` client-side tool extension is implemented, it is still part of the agent toolchain rather than orchestrator business logic.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1208,
      "lineEnd": 1208
    }
  },
  {
    "id": "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
    "type": "dependency",
    "title": "Ignore delta-style payloads such as lasttokenusage for dashboard/API totals.",
    "text": "Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1311,
      "lineEnd": 1311
    }
  },
  {
    "id": "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional",
    "type": "requirement",
    "title": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "text": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1336,
      "lineEnd": 1336
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0609-heading-11-2-query-semantics-linear",
    "type": "heading",
    "lineStart": 1148,
    "lineEnd": 1148,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.2 Query Semantics (Linear)"
  },
  {
    "id": "block-0613-list-tracker-kind-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "list",
    "lineStart": 1152,
    "lineEnd": 1160,
    "generatedClaimIds": [
      "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
      "claim-11-2-query-semantics-linear-auth-token-sent-in-authorization-header",
      "claim-11-2-query-semantics-linear-tracker-projectslug-maps-to-linear-project-slugid",
      "claim-11-2-query-semantics-linear-candidate-issue-query-filters-project-using-project-slugid-eq-projectslug",
      "claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id",
      "requirement-11-2-query-semantics-linear-pagination-required-for-candidate-issues",
      "claim-11-2-query-semantics-linear-page-size-default-50",
      "claim-11-2-query-semantics-linear-network-timeout-30000-ms"
    ],
    "rawMarkdown": "- `tracker.kind == \"linear\"`\n- GraphQL endpoint (default `https://api.linear.app/graphql`)\n- Auth token sent in `Authorization` header\n- `tracker.project_slug` maps to Linear project `slugId`\n- Candidate issue query filters project using `project: { slugId: { eq: $projectSlug } }`\n- Issue-state refresh query uses GraphQL issue IDs with variable type `[ID!]`\n- Pagination REQUIRED for candidate issues\n- Page size default: `50`\n- Network timeout: `30000 ms`"
  },
  {
    "id": "block-0618-blank-blank",
    "type": "blank",
    "lineStart": 1166,
    "lineEnd": 1166,
    "generatedClaimIds": [
      "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0629-heading-11-4-error-handling-contract",
    "type": "heading",
    "lineStart": 1181,
    "lineEnd": 1181,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.4 Error Handling Contract"
  },
  {
    "id": "block-0633-list-unsupportedtrackerkind-missingtrackerapikey-missingtrackerprojectslug-lineara",
    "type": "list",
    "lineStart": 1185,
    "lineEnd": 1192,
    "generatedClaimIds": [
      "claim-11-4-error-handling-contract-missingtrackerapikey",
      "claim-11-4-error-handling-contract-missingtrackerprojectslug",
      "claim-11-4-error-handling-contract-linearapirequest-transport-failures",
      "claim-11-4-error-handling-contract-linearapistatus-non-200-http",
      "claim-11-4-error-handling-contract-lineargraphqlerrors",
      "claim-11-4-error-handling-contract-linearunknownpayload",
      "claim-11-4-error-handling-contract-linearmissingendcursor-pagination-integrity-error"
    ],
    "rawMarkdown": "- `unsupported_tracker_kind`\n- `missing_tracker_api_key`\n- `missing_tracker_project_slug`\n- `linear_api_request` (transport failures)\n- `linear_api_status` (non-200 HTTP)\n- `linear_graphql_errors`\n- `linear_unknown_payload`\n- `linear_missing_end_cursor` (pagination integrity error)"
  },
  {
    "id": "block-0639-heading-11-5-tracker-writes-important-boundary",
    "type": "heading",
    "lineStart": 1200,
    "lineEnd": 1200,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.5 Tracker Writes (Important Boundary)"
  },
  {
    "id": "block-0643-list-ticket-mutations-state-transitions-comments-pr-metadata-are-typically-handled-b",
    "type": "list",
    "lineStart": 1204,
    "lineEnd": 1210,
    "generatedClaimIds": [
      "claim-11-5-tracker-writes-important-boundary-the-service-remains-a-scheduler-runner-and-tracker-reader",
      "claim-11-5-tracker-writes-important-boundary-workflow-specific-success-often-means-reached-the-next-handoff-state-for-example",
      "dependency-11-5-tracker-writes-important-boundary-if-the-lineargraphql-client-side-tool-extension-is-implemented-it-is-still-part-"
    ],
    "rawMarkdown": "- Ticket mutations (state transitions, comments, PR metadata) are typically handled by the coding\n  agent using tools defined by the workflow prompt.\n- The service remains a scheduler/runner and tracker reader.\n- Workflow-specific success often means \"reached the next handoff state\" (for example\n  `Human Review`) rather than tracker terminal state `Done`.\n- If the `linear_graphql` client-side tool extension is implemented, it is still part of the agent\n  toolchain rather than orchestrator business logic."
  },
  {
    "id": "block-0709-heading-13-5-session-metrics-and-token-accounting",
    "type": "heading",
    "lineStart": 1304,
    "lineEnd": 1304,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.5 Session Metrics and Token Accounting"
  },
  {
    "id": "block-0713-list-agent-events-can-include-token-counts-in-multiple-payload-shapes-prefer-absolute",
    "type": "list",
    "lineStart": 1308,
    "lineEnd": 1318,
    "generatedClaimIds": [
      "claim-13-5-session-metrics-and-token-accounting-prefer-absolute-thread-totals-when-available-such-as",
      "claim-13-5-session-metrics-and-token-accounting-thread-tokenusage-updated-payloads",
      "claim-13-5-session-metrics-and-token-accounting-totaltokenusage-within-token-count-wrapper-events",
      "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
      "claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within",
      "claim-13-5-session-metrics-and-token-accounting-for-absolute-totals-track-deltas-relative-to-last-reported-totals-to-avoid-doubl",
      "claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin",
      "claim-13-5-session-metrics-and-token-accounting-accumulate-aggregate-totals-in-orchestrator-state"
    ],
    "rawMarkdown": "- Agent events can include token counts in multiple payload shapes.\n- Prefer absolute thread totals when available, such as:\n  - `thread/tokenUsage/updated` payloads\n  - `total_token_usage` within token-count wrapper events\n- Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.\n- Extract input/output/total token counts leniently from common field names within the selected\n  payload.\n- For absolute totals, track deltas relative to last reported totals to avoid double-counting.\n- Do not treat generic `usage` maps as cumulative totals unless the event type defines them that\n  way.\n- Accumulate aggregate totals in orchestrator state."
  },
  {
    "id": "block-0723-heading-13-6-humanized-agent-event-summaries-optional",
    "type": "heading",
    "lineStart": 1335,
    "lineEnd": 1335,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.6 Humanized Agent Event Summaries (OPTIONAL)"
  },
  {
    "id": "block-0724-blank-blank",
    "type": "blank",
    "lineStart": 1336,
    "lineEnd": 1336,
    "generatedClaimIds": [
      "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional"
    ],
    "rawMarkdown": ""
  }
]
```
