You are executing Spec Gym projection `all-data-types`: All Data Types.

Projection instructions:
# All Data Types

Extract every data type, field, schema, enum, message, model, and structured
payload implied by the spec.

The projection should preserve source anchors and distinguish explicit source
text from inferred type candidates.

Output contract:
- Format: json
- Final artifact path after merge: projections/all-data-types.json
- Type contracts: data-type

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
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-othermessage",
    "type": "claim",
    "title": "othermessage",
    "text": "`other_message`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1017,
      "lineEnd": 1017
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-variables-is-optional-and-when-present-must-be-a-json-object",
    "type": "requirement",
    "title": "variables is OPTIONAL and, when present, MUST be a JSON object.",
    "text": "`variables` is OPTIONAL and, when present, MUST be a JSON object.",
    "normative": [
      "OPTIONAL",
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1073,
      "lineEnd": 1073
    }
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-return-the-graphql-response-or-error-payload-as-structured-tool-output-that-the-",
    "type": "dependency",
    "title": "Return the GraphQL response or error payload as structured tool output that the model...",
    "text": "Return the GraphQL response or error payload as structured tool output that the model can inspect in-session.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1085,
      "lineEnd": 1085
    }
  },
  {
    "id": "claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id",
    "type": "claim",
    "title": "Issue-state refresh query uses GraphQL issue IDs with variable type [ID!]",
    "text": "Issue-state refresh query uses GraphQL issue IDs with variable type `[ID!]`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1156,
      "lineEnd": 1156
    }
  },
  {
    "id": "requirement-11-2-query-semantics-linear-linear-graphql-schema-details-can-drift-keep-query-construction-isolated-and-tes",
    "type": "requirement",
    "title": "Linear GraphQL schema details can drift. Keep query construction isolated and test th...",
    "text": "Linear GraphQL schema details can drift. Keep query construction isolated and test the exact query fields/types REQUIRED by this specification.",
    "normative": [
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1163,
      "lineEnd": 1163
    }
  },
  {
    "id": "claim-11-3-normalization-rules-blockedby-derived-from-inverse-relations-where-relation-type-is-blocks",
    "type": "claim",
    "title": "blockedby -> derived from inverse relations where relation type is blocks",
    "text": "`blocked_by` -> derived from inverse relations where relation type is `blocks`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1176,
      "lineEnd": 1176
    }
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within",
    "type": "claim",
    "title": "Extract input/output/total token counts leniently from common field names within the...",
    "text": "Extract input/output/total token counts leniently from common field names within the selected payload.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1312,
      "lineEnd": 1312
    }
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin",
    "type": "claim",
    "title": "Do not treat generic usage maps as cumulative totals unless the event type defines th...",
    "text": "Do not treat generic `usage` maps as cumulative totals unless the event type defines them that way.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1315,
      "lineEnd": 1315
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0543-list-sessionstarted-startupfailed-turncompleted-turnfailed-turncancelled-turne",
    "type": "list",
    "lineStart": 1008,
    "lineEnd": 1019,
    "generatedClaimIds": [
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-startupfailed",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncompleted",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnfailed",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncancelled",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnendedwitherror",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turninputrequired",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-approvalautoapproved",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-unsupportedtoolcall",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-notification",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-othermessage",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-malformed"
    ],
    "rawMarkdown": "- `session_started`\n- `startup_failed`\n- `turn_completed`\n- `turn_failed`\n- `turn_cancelled`\n- `turn_ended_with_error`\n- `turn_input_required`\n- `approval_auto_approved`\n- `unsupported_tool_call`\n- `notification`\n- `other_message`\n- `malformed`"
  },
  {
    "id": "block-0545-heading-10-5-approval-tool-calls-and-user-input-policy",
    "type": "heading",
    "lineStart": 1021,
    "lineEnd": 1021,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.5 Approval, Tool Calls, and User Input Policy"
  },
  {
    "id": "block-0569-list-query-must-be-a-non-empty-string-query-must-contain-exactly-one-graphql-operatio",
    "type": "list",
    "lineStart": 1072,
    "lineEnd": 1087,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-contain-exactly-one-graphql-operation",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-variables-is-optional-and-when-present-must-be-a-json-object",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-may-additionally-accept-a-raw-graphql-query-string-as-shorthand-",
      "dependency-10-5-approval-tool-calls-and-user-input-policy-execute-one-graphql-operation-per-tool-call",
      "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-provided-document-contains-multiple-operations-reject-the-tool-call-as-in",
      "claim-10-5-approval-tool-calls-and-user-input-policy-operationname-selection-is-intentionally-out-of-scope-for-this-extension",
      "claim-10-5-approval-tool-calls-and-user-input-policy-reuse-the-configured-linear-endpoint-and-auth-from-the-active-symphony-workflow-",
      "dependency-10-5-approval-tool-calls-and-user-input-policy-tool-result-semantics",
      "claim-10-5-approval-tool-calls-and-user-input-policy-transport-success-no-top-level-graphql-errors-success-true",
      "claim-10-5-approval-tool-calls-and-user-input-policy-top-level-graphql-errors-present-success-false-but-preserve-the-graphql-response",
      "claim-10-5-approval-tool-calls-and-user-input-policy-invalid-input-missing-auth-or-transport-failure-success-false-with-an-error-payl",
      "dependency-10-5-approval-tool-calls-and-user-input-policy-return-the-graphql-response-or-error-payload-as-structured-tool-output-that-the-"
    ],
    "rawMarkdown": "- `query` MUST be a non-empty string.\n- `query` MUST contain exactly one GraphQL operation.\n- `variables` is OPTIONAL and, when present, MUST be a JSON object.\n- Implementations MAY additionally accept a raw GraphQL query string as shorthand input.\n- Execute one GraphQL operation per tool call.\n- If the provided document contains multiple operations, reject the tool call as invalid input.\n- `operationName` selection is intentionally out of scope for this extension.\n- Reuse the configured Linear endpoint and auth from the active Symphony workflow/runtime config; do\n  not require the coding agent to read raw tokens from disk.\n- Tool result semantics:\n  - transport success + no top-level GraphQL `errors` -> `success=true`\n  - top-level GraphQL `errors` present -> `success=false`, but preserve the GraphQL response body\n    for debugging\n  - invalid input, missing auth, or transport failure -> `success=false` with an error payload\n- Return the GraphQL response or error payload as structured tool output that the model can inspect\n  in-session."
  },
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
    "id": "block-0616-blank-blank",
    "type": "blank",
    "lineStart": 1163,
    "lineEnd": 1163,
    "generatedClaimIds": [
      "requirement-11-2-query-semantics-linear-linear-graphql-schema-details-can-drift-keep-query-construction-isolated-and-tes"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0621-heading-11-3-normalization-rules",
    "type": "heading",
    "lineStart": 1170,
    "lineEnd": 1170,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.3 Normalization Rules"
  },
  {
    "id": "block-0627-list-labels-lowercase-strings-blockedby-derived-from-inverse-relations-where-rel",
    "type": "list",
    "lineStart": 1176,
    "lineEnd": 1179,
    "generatedClaimIds": [
      "claim-11-3-normalization-rules-blockedby-derived-from-inverse-relations-where-relation-type-is-blocks",
      "claim-11-3-normalization-rules-priority-integer-only-non-integers-become-null",
      "claim-11-3-normalization-rules-createdat-and-updatedat-parse-iso-8601-timestamps"
    ],
    "rawMarkdown": "- `labels` -> lowercase strings\n- `blocked_by` -> derived from inverse relations where relation type is `blocks`\n- `priority` -> integer only (non-integers become null)\n- `created_at` and `updated_at` -> parse ISO-8601 timestamps"
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
  }
]
```
