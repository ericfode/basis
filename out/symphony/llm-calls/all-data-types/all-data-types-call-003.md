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
    "id": "claim-13-5-session-metrics-and-token-accounting-any-human-readable-presentation-of-rate-limit-data-is-implementation-defined",
    "type": "claim",
    "title": "Any human-readable presentation of rate-limit data is implementation-defined.",
    "text": "Any human-readable presentation of rate-limit data is implementation-defined.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1332,
      "lineEnd": 1332
    }
  },
  {
    "id": "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client",
    "type": "dependency",
    "title": "It is up to the implementation whether this is server-generated HTML or a client-side...",
    "text": "It is up to the implementation whether this is server-generated HTML or a client-side app that consumes the JSON API below.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1377,
      "lineEnd": 1377
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-",
    "type": "dependency",
    "title": "If the issue is unknown to the current in-memory state, return 404 with an error resp...",
    "text": "If the issue is unknown to the current in-memory state, return `404` with an error response (for example `{\\\"error\\\":{\\\"code\\\":\\\"issue_not_found\\\",\\\"message\\\":\\\"...\\\"}}`).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1488,
      "lineEnd": 1488
    }
  },
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
    "id": "dependency-17-3-issue-tracker-client-linear-query-uses-the-specified-project-filter-field-slugid",
    "type": "dependency",
    "title": "Linear query uses the specified project filter field (slugId)",
    "text": "Linear query uses the specified project filter field (`slugId`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1969,
      "lineEnd": 1969
    }
  },
  {
    "id": "dependency-17-3-issue-tracker-client-blockers-are-normalized-from-inverse-relations-of-type-blocks",
    "type": "dependency",
    "title": "Blockers are normalized from inverse relations of type blocks",
    "text": "Blockers are normalized from inverse relations of type `blocks`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1972,
      "lineEnd": 1972
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0721-list-track-the-latest-rate-limit-payload-seen-in-any-agent-update-any-human-readable",
    "type": "list",
    "lineStart": 1332,
    "lineEnd": 1333,
    "generatedClaimIds": [
      "claim-13-5-session-metrics-and-token-accounting-any-human-readable-presentation-of-rate-limit-data-is-implementation-defined"
    ],
    "rawMarkdown": "- Track the latest rate-limit payload seen in any agent update.\n- Any human-readable presentation of rate-limit data is implementation-defined."
  },
  {
    "id": "block-0747-heading-13-7-1-human-readable-dashboard",
    "type": "heading",
    "lineStart": 1373,
    "lineEnd": 1373,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 13.7.1 Human-Readable Dashboard (`/`)"
  },
  {
    "id": "block-0749-list-host-a-human-readable-dashboard-at-the-returned-document-should-depict-the-cur",
    "type": "list",
    "lineStart": 1375,
    "lineEnd": 1379,
    "generatedClaimIds": [
      "requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-",
      "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client"
    ],
    "rawMarkdown": "- Host a human-readable dashboard at `/`.\n- The returned document SHOULD depict the current state of the system (for example active sessions,\n  retry delays, token consumption, runtime totals, recent events, and health/error indicators).\n- It is up to the implementation whether this is server-generated HTML or a client-side app that\n  consumes the JSON API below."
  },
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
    "id": "block-0759-list-get-api-v1-issueidentifier-returns-issue-specific-runtime-debug-details-for-th",
    "type": "list",
    "lineStart": 1436,
    "lineEnd": 1490,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-returns-issue-specific-runtime-debug-details-for-the-identified-issue-including-",
      "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2",
      "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-"
    ],
    "rawMarkdown": "- `GET /api/v1/<issue_identifier>`\n  - Returns issue-specific runtime/debug details for the identified issue, including any information\n    the implementation tracks that is useful for debugging.\n  - Suggested response shape:\n\n    ```json\n    {\n      \"issue_identifier\": \"MT-649\",\n      \"issue_id\": \"abc123\",\n      \"status\": \"running\",\n      \"workspace\": {\n        \"path\": \"/tmp/symphony_workspaces/MT-649\"\n      },\n      \"attempts\": {\n        \"restart_count\": 1,\n        \"current_retry_attempt\": 2\n      },\n      \"running\": {\n        \"session_id\": \"thread-1-turn-1\",\n        \"turn_count\": 7,\n        \"state\": \"In Progress\",\n        \"started_at\": \"2026-02-24T20:10:12Z\",\n        \"last_event\": \"notification\",\n        \"last_message\": \"Working on tests\",\n        \"last_event_at\": \"2026-02-24T20:14:59Z\",\n        \"tokens\": {\n          \"input_tokens\": 1200,\n          \"output_tokens\": 800,\n          \"total_tokens\": 2000\n        }\n      },\n      \"retry\": null,\n      \"logs\": {\n        \"codex_session_logs\": [\n          {\n            \"label\": \"latest\",\n            \"path\": \"/var/log/symphony/codex/MT-649/latest.log\",\n            \"url\": null\n          }\n        ]\n      },\n      \"recent_events\": [\n        {\n          \"at\": \"2026-02-24T20:14:59Z\",\n          \"event\": \"notification\",\n          \"message\": \"Working on tests\"\n        }\n      ],\n      \"last_error\": null,\n      \"tracked\": {}\n    }\n    ```\n\n  - If the issue is unknown to the current in-memory state, return `404` with an error response (for\n    example `{\\\"error\\\":{\\\"code\\\":\\\"issue_not_found\\\",\\\"message\\\":\\\"...\\\"}}`)."
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
  }
]
```
