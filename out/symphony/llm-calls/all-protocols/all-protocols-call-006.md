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
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-agent-requests-a-dynamic-tool-call-that-is-not-supported-return-a-tool-fa",
    "type": "dependency",
    "title": "If the agent requests a dynamic tool call that is not supported, return a tool failur...",
    "text": "If the agent requests a dynamic tool call that is not supported, return a tool failure response using the targeted protocol and continue the session.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1042,
      "lineEnd": 1042
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve",
    "type": "requirement",
    "title": "An implementation MAY expose a limited set of client-side tools to the app-server ses...",
    "text": "An implementation MAY expose a limited set of client-side tools to the app-server session.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1048,
      "lineEnd": 1048
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-if-implemented-supported-tools-should-be-advertised-to-the-app-server-session-du",
    "type": "requirement",
    "title": "If implemented, supported tools SHOULD be advertised to the app-server session during...",
    "text": "If implemented, supported tools SHOULD be advertised to the app-server session during startup using the protocol mechanism supported by the targeted Codex app-server version.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1050,
      "lineEnd": 1050
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
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-transport-success-no-top-level-graphql-errors-success-true",
    "type": "claim",
    "title": "transport success + no top-level GraphQL errors -> success=true",
    "text": "transport success + no top-level GraphQL `errors` -> `success=true`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1081,
      "lineEnd": 1081
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
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-",
    "type": "requirement",
    "title": "Implementations MUST document how targeted-protocol user-input-required signals are h...",
    "text": "Implementations MUST document how targeted-protocol user-input-required signals are handled.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1090,
      "lineEnd": 1090
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0559-list-supported-dynamic-tool-calls-that-are-explicitly-implemented-and-advertised-by-t",
    "type": "list",
    "lineStart": 1041,
    "lineEnd": 1045,
    "generatedClaimIds": [
      "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-agent-requests-a-dynamic-tool-call-that-is-not-supported-return-a-tool-fa",
      "dependency-10-5-approval-tool-calls-and-user-input-policy-this-prevents-the-session-from-stalling-on-unsupported-tool-execution-paths"
    ],
    "rawMarkdown": "- Supported dynamic tool calls that are explicitly implemented and advertised by the runtime SHOULD\n  be handled according to their extension contract.\n- If the agent requests a dynamic tool call that is not supported, return a tool failure response\n  using the targeted protocol and continue the session.\n- This prevents the session from stalling on unsupported tool execution paths."
  },
  {
    "id": "block-0562-blank-blank",
    "type": "blank",
    "lineStart": 1048,
    "lineEnd": 1048,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve"
    ],
    "rawMarkdown": ""
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
    "id": "block-0572-blank-blank",
    "type": "blank",
    "lineStart": 1090,
    "lineEnd": 1090,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-"
    ],
    "rawMarkdown": ""
  }
]
```
