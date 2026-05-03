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
    "id": "component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model",
    "type": "component",
    "title": "Normalizes tracker payloads into a stable issue model.",
    "text": "Normalizes tracker payloads into a stable issue model.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 86,
      "lineEnd": 86
    }
  },
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
    "id": "block-0039-heading-3-1-main-components",
    "type": "heading",
    "lineStart": 71,
    "lineEnd": 71,
    "semanticRole": "component",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.1 Main Components"
  },
  {
    "id": "block-0045-list-3-issue-tracker-client-fetches-candidate-issues-in-active-states-fetches-curren",
    "type": "list",
    "lineStart": 83,
    "lineEnd": 87,
    "generatedClaimIds": [
      "component-3-1-main-components-fetches-candidate-issues-in-active-states",
      "component-3-1-main-components-fetches-current-states-for-specific-issue-ids-reconciliation",
      "component-3-1-main-components-fetches-terminal-state-issues-during-startup-cleanup",
      "component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model"
    ],
    "rawMarkdown": "3. `Issue Tracker Client`\n   - Fetches candidate issues in active states.\n   - Fetches current states for specific issue IDs (reconciliation).\n   - Fetches terminal-state issues during startup cleanup.\n   - Normalizes tracker payloads into a stable issue model."
  },
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
