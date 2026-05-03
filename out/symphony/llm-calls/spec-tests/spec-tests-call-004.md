You are executing Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Output contract:
- Format: markdown
- Final artifact path after merge: tests/spec-derived-tests.md
- Type contracts: test-suite

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
    "id": "claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure",
    "type": "claim",
    "title": "turn timeout (turntimeoutms) -> failure",
    "text": "turn timeout (`turn_timeout_ms`) -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 978,
      "lineEnd": 978
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-subprocess-exit-failure",
    "type": "claim",
    "title": "subprocess exit -> failure",
    "text": "subprocess exit -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 979,
      "lineEnd": 979
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-treat-user-input-required-turns-as-hard-failure",
    "type": "requirement",
    "title": "Treat user-input-required turns as hard failure.",
    "text": "Treat user-input-required turns as hard failure.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1036,
      "lineEnd": 1036
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-unsupported-tool-names-should-still-return-a-failure-result-using-the-targeted-p",
    "type": "requirement",
    "title": "Unsupported tool names SHOULD still return a failure result using the targeted protoc...",
    "text": "Unsupported tool names SHOULD still return a failure result using the targeted protocol and continue the session.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1052,
      "lineEnd": 1052
    }
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-invalid-input-missing-auth-or-transport-failure-success-false-with-an-error-payl",
    "type": "claim",
    "title": "invalid input, missing auth, or transport failure -> success=false with an error payload",
    "text": "invalid input, missing auth, or transport failure -> `success=false` with an error payload",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1084,
      "lineEnd": 1084
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
    "id": "claim-11-4-error-handling-contract-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick",
    "type": "claim",
    "title": "Candidate fetch failure: log and skip dispatch for this tick.",
    "text": "Candidate fetch failure: log and skip dispatch for this tick.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1195,
      "lineEnd": 1195
    }
  },
  {
    "id": "claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running",
    "type": "claim",
    "title": "Running-state refresh failure: log and keep active workers running.",
    "text": "Running-state refresh failure: log and keep active workers running.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1196,
      "lineEnd": 1196
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0519-heading-10-3-streaming-turn-processing",
    "type": "heading",
    "lineStart": 969,
    "lineEnd": 969,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.3 Streaming Turn Processing"
  },
  {
    "id": "block-0525-list-targeted-protocol-turn-completion-signal-success-targeted-protocol-turn-failur",
    "type": "list",
    "lineStart": 976,
    "lineEnd": 980,
    "generatedClaimIds": [
      "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
      "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
      "claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure",
      "claim-10-3-streaming-turn-processing-subprocess-exit-failure"
    ],
    "rawMarkdown": "- Targeted-protocol turn completion signal -> success\n- Targeted-protocol turn failure signal -> failure\n- Targeted-protocol turn cancellation signal -> failure\n- turn timeout (`turn_timeout_ms`) -> failure\n- subprocess exit -> failure"
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
    "id": "block-0555-list-auto-approve-command-execution-approvals-for-the-session-auto-approve-file-chang",
    "type": "list",
    "lineStart": 1035,
    "lineEnd": 1037,
    "generatedClaimIds": [
      "claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-file-change-approvals-for-the-session",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-treat-user-input-required-turns-as-hard-failure"
    ],
    "rawMarkdown": "- Auto-approve command execution approvals for the session.\n- Auto-approve file-change approvals for the session.\n- Treat user-input-required turns as hard failure."
  },
  {
    "id": "block-0563-list-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve",
    "type": "list",
    "lineStart": 1049,
    "lineEnd": 1054,
    "generatedClaimIds": [
      "dependency-10-5-approval-tool-calls-and-user-input-policy-current-standardized-optional-tool-lineargraphql",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-if-implemented-supported-tools-should-be-advertised-to-the-app-server-session-du",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-unsupported-tool-names-should-still-return-a-failure-result-using-the-targeted-p"
    ],
    "rawMarkdown": "- An implementation MAY expose a limited set of client-side tools to the app-server session.\n- Current standardized optional tool: `linear_graphql`.\n- If implemented, supported tools SHOULD be advertised to the app-server session during startup\n  using the protocol mechanism supported by the targeted Codex app-server version.\n- Unsupported tool names SHOULD still return a failure result using the targeted protocol and\n  continue the session."
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
    "id": "block-0629-heading-11-4-error-handling-contract",
    "type": "heading",
    "lineStart": 1181,
    "lineEnd": 1181,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.4 Error Handling Contract"
  },
  {
    "id": "block-0636-blank-blank",
    "type": "blank",
    "lineStart": 1195,
    "lineEnd": 1195,
    "generatedClaimIds": [
      "claim-11-4-error-handling-contract-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0637-list-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick-running-state-refre",
    "type": "list",
    "lineStart": 1196,
    "lineEnd": 1198,
    "generatedClaimIds": [
      "claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running",
      "claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup"
    ],
    "rawMarkdown": "- Candidate fetch failure: log and skip dispatch for this tick.\n- Running-state refresh failure: log and keep active workers running.\n- Startup terminal cleanup failure: log warning and continue startup."
  }
]
```
