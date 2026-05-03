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
    "id": "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data",
    "type": "dependency",
    "title": "API calls and normalization for tracker data.",
    "text": "API calls and normalization for tracker data.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 132,
      "lineEnd": 132
    }
  },
  {
    "id": "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version",
    "type": "dependency",
    "title": "Issue tracker API (Linear for tracker.kind: linear in this specification version).",
    "text": "Issue tracker API (Linear for `tracker.kind: linear` in this specification version).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 139,
      "lineEnd": 139
    }
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastcodexevent-string-enum-or-null",
    "type": "claim",
    "title": "lastcodexevent (string/enum or null)",
    "text": "`last_codex_event` (string/enum or null)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 234,
      "lineEnd": 234
    }
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastcodexmessage-summarized-payload",
    "type": "claim",
    "title": "lastcodexmessage (summarized payload)",
    "text": "`last_codex_message` (summarized payload)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 236,
      "lineEnd": 236
    }
  },
  {
    "id": "requirement-5-3-front-matter-schema-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev",
    "type": "requirement",
    "title": "The workflow front matter is extensible. Extensions MAY define additional top-level k...",
    "text": "The workflow front matter is extensible. Extensions MAY define additional top-level keys without changing the core schema above.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 340,
      "lineEnd": 340
    }
  },
  {
    "id": "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet",
    "type": "requirement",
    "title": "Extensions SHOULD document their field schema, defaults, validation rules, and whethe...",
    "text": "Extensions SHOULD document their field schema, defaults, validation rules, and whether changes apply dynamically or require restart.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 342,
      "lineEnd": 342
    }
  },
  {
    "id": "dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "Default for tracker.kind == \"linear\": https://api.linear.app/graphql",
    "text": "Default for `tracker.kind == \"linear\"`: `https://api.linear.app/graphql`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 353,
      "lineEnd": 353
    }
  },
  {
    "id": "claim-5-3-1-tracker-object-apikey-string",
    "type": "claim",
    "title": "apikey (string)",
    "text": "`api_key` (string)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 354,
      "lineEnd": 354
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0057-heading-3-2-abstraction-levels",
    "type": "heading",
    "lineStart": 114,
    "lineEnd": 114,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Abstraction Levels"
  },
  {
    "id": "block-0069-list-5-integration-layer-linear-adapter-api-calls-and-normalization-for-tracker-data",
    "type": "list",
    "lineStart": 132,
    "lineEnd": 133,
    "generatedClaimIds": [
      "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data"
    ],
    "rawMarkdown": "5. `Integration Layer` (Linear adapter)\n   - API calls and normalization for tracker data."
  },
  {
    "id": "block-0073-heading-3-3-external-dependencies",
    "type": "heading",
    "lineStart": 138,
    "lineEnd": 138,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 External Dependencies"
  },
  {
    "id": "block-0074-blank-blank",
    "type": "blank",
    "lineStart": 139,
    "lineEnd": 139,
    "generatedClaimIds": [
      "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0119-heading-4-1-6-live-session-agent-session-metadata",
    "type": "heading",
    "lineStart": 225,
    "lineEnd": 225,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 4.1.6 Live Session (Agent Session Metadata)"
  },
  {
    "id": "block-0125-list-sessionid-string-threadid-turnid-threadid-string-turnid-string-cod",
    "type": "list",
    "lineStart": 231,
    "lineEnd": 245,
    "generatedClaimIds": [
      "claim-4-1-6-live-session-agent-session-metadata-threadid-string",
      "claim-4-1-6-live-session-agent-session-metadata-turnid-string",
      "claim-4-1-6-live-session-agent-session-metadata-codexappserverpid-string-or-null",
      "claim-4-1-6-live-session-agent-session-metadata-lastcodexevent-string-enum-or-null",
      "claim-4-1-6-live-session-agent-session-metadata-lastcodextimestamp-timestamp-or-null",
      "claim-4-1-6-live-session-agent-session-metadata-lastcodexmessage-summarized-payload",
      "claim-4-1-6-live-session-agent-session-metadata-codexinputtokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-codexoutputtokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-codextotaltokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-lastreportedinputtokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-lastreportedoutputtokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-lastreportedtotaltokens-integer",
      "claim-4-1-6-live-session-agent-session-metadata-turncount-integer",
      "claim-4-1-6-live-session-agent-session-metadata-number-of-coding-agent-turns-started-within-the-current-worker-lifetime"
    ],
    "rawMarkdown": "- `session_id` (string, `<thread_id>-<turn_id>`)\n- `thread_id` (string)\n- `turn_id` (string)\n- `codex_app_server_pid` (string or null)\n- `last_codex_event` (string/enum or null)\n- `last_codex_timestamp` (timestamp or null)\n- `last_codex_message` (summarized payload)\n- `codex_input_tokens` (integer)\n- `codex_output_tokens` (integer)\n- `codex_total_tokens` (integer)\n- `last_reported_input_tokens` (integer)\n- `last_reported_output_tokens` (integer)\n- `last_reported_total_tokens` (integer)\n- `turn_count` (integer)\n  - Number of coding-agent turns started within the current worker lifetime."
  },
  {
    "id": "block-0175-heading-5-3-front-matter-schema",
    "type": "heading",
    "lineStart": 326,
    "lineEnd": 326,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.3 Front Matter Schema"
  },
  {
    "id": "block-0184-blank-blank",
    "type": "blank",
    "lineStart": 340,
    "lineEnd": 340,
    "generatedClaimIds": [
      "requirement-5-3-front-matter-schema-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0185-list-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev",
    "type": "list",
    "lineStart": 341,
    "lineEnd": 344,
    "generatedClaimIds": [
      "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet"
    ],
    "rawMarkdown": "- The workflow front matter is extensible. Extensions MAY define additional top-level keys without\n  changing the core schema above.\n- Extensions SHOULD document their field schema, defaults, validation rules, and whether changes\n  apply dynamically or require restart."
  },
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
  }
]
```
