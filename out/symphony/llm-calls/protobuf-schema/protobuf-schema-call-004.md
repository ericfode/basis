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
    "id": "claim-10-6-timeouts-and-error-mapping-responseerror",
    "type": "claim",
    "title": "responseerror",
    "text": "`response_error`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1111,
      "lineEnd": 1111
    }
  },
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
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0575-heading-10-6-timeouts-and-error-mapping",
    "type": "heading",
    "lineStart": 1097,
    "lineEnd": 1097,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.6 Timeouts and Error Mapping"
  },
  {
    "id": "block-0583-list-codexnotfound-invalidworkspacecwd-responsetimeout-turntimeout-portexit-re",
    "type": "list",
    "lineStart": 1107,
    "lineEnd": 1115,
    "generatedClaimIds": [
      "claim-10-6-timeouts-and-error-mapping-invalidworkspacecwd",
      "claim-10-6-timeouts-and-error-mapping-responsetimeout",
      "claim-10-6-timeouts-and-error-mapping-turntimeout",
      "claim-10-6-timeouts-and-error-mapping-portexit",
      "claim-10-6-timeouts-and-error-mapping-responseerror",
      "claim-10-6-timeouts-and-error-mapping-turnfailed",
      "claim-10-6-timeouts-and-error-mapping-turncancelled",
      "claim-10-6-timeouts-and-error-mapping-turninputrequired"
    ],
    "rawMarkdown": "- `codex_not_found`\n- `invalid_workspace_cwd`\n- `response_timeout`\n- `turn_timeout`\n- `port_exit`\n- `response_error`\n- `turn_failed`\n- `turn_cancelled`\n- `turn_input_required`"
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
  }
]
```
