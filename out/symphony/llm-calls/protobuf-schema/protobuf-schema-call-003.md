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
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-top-level-graphql-errors-present-success-false-but-preserve-the-graphql-response",
    "type": "claim",
    "title": "top-level GraphQL errors present -> success=false, but preserve the GraphQL response...",
    "text": "top-level GraphQL `errors` present -> `success=false`, but preserve the GraphQL response body for debugging",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1082,
      "lineEnd": 1082
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
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-a-conforming-implementation-may-fail-the-run-surface-the-request-to-an-operator-",
    "type": "requirement",
    "title": "A conforming implementation MAY fail the run, surface the request to an operator, sat...",
    "text": "A conforming implementation MAY fail the run, surface the request to an operator, satisfy it through an approved operator channel, or auto-resolve it according to its documented policy.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1092,
      "lineEnd": 1092
    }
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests",
    "type": "claim",
    "title": "codex.readtimeoutms: request/response timeout during startup and sync requests",
    "text": "`codex.read_timeout_ms`: request/response timeout during startup and sync requests",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1100,
      "lineEnd": 1100
    }
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codex-stalltimeoutms-enforced-by-orchestrator-based-on-event-inactivity",
    "type": "claim",
    "title": "codex.stalltimeoutms: enforced by orchestrator based on event inactivity",
    "text": "`codex.stall_timeout_ms`: enforced by orchestrator based on event inactivity",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1102,
      "lineEnd": 1102
    }
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-responsetimeout",
    "type": "claim",
    "title": "responsetimeout",
    "text": "`response_timeout`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1108,
      "lineEnd": 1108
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
    "id": "block-0573-list-implementations-must-document-how-targeted-protocol-user-input-required-signals-",
    "type": "list",
    "lineStart": 1091,
    "lineEnd": 1095,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-a-run-must-not-stall-indefinitely-waiting-for-user-input",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-a-conforming-implementation-may-fail-the-run-surface-the-request-to-an-operator-",
      "requirement-10-5-approval-tool-calls-and-user-input-policy-the-example-high-trust-behavior-above-fails-user-input-required-turns-immediatel"
    ],
    "rawMarkdown": "- Implementations MUST document how targeted-protocol user-input-required signals are handled.\n- A run MUST NOT stall indefinitely waiting for user input.\n- A conforming implementation MAY fail the run, surface the request to an operator, satisfy it\n  through an approved operator channel, or auto-resolve it according to its documented policy.\n- The example high-trust behavior above fails user-input-required turns immediately."
  },
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
    "id": "block-0578-blank-blank",
    "type": "blank",
    "lineStart": 1100,
    "lineEnd": 1100,
    "generatedClaimIds": [
      "claim-10-6-timeouts-and-error-mapping-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0579-list-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests-co",
    "type": "list",
    "lineStart": 1101,
    "lineEnd": 1103,
    "generatedClaimIds": [
      "claim-10-6-timeouts-and-error-mapping-codex-turntimeoutms-total-turn-stream-timeout",
      "claim-10-6-timeouts-and-error-mapping-codex-stalltimeoutms-enforced-by-orchestrator-based-on-event-inactivity"
    ],
    "rawMarkdown": "- `codex.read_timeout_ms`: request/response timeout during startup and sync requests\n- `codex.turn_timeout_ms`: total turn stream timeout\n- `codex.stall_timeout_ms`: enforced by orchestrator based on event inactivity"
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
  }
]
```
