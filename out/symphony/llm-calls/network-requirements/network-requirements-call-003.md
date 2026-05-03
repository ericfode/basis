You are executing Spec Gym projection `network-requirements`: Network Requirements.

Projection instructions:
# Network Requirements

Extract all requirements, dependencies, risks, and validation surfaces related
to networking.

The projection should include source-backed requirements first, then inferred
network obligations and missing validation questions.

Output contract:
- Format: json
- Final artifact path after merge: projections/network-requirements.json
- Type contracts: requirement

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
    "id": "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an",
    "type": "requirement",
    "title": "The app-server subprocess SHOULD remain alive across those continuation turns and be...",
    "text": "The app-server subprocess SHOULD remain alive across those continuation turns and be stopped only when the worker run is ending.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 985,
      "lineEnd": 985
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
    "id": "block-0529-list-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "list",
    "lineStart": 984,
    "lineEnd": 987,
    "generatedClaimIds": [
      "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an"
    ],
    "rawMarkdown": "- If the worker decides to continue after a successful turn, it SHOULD start another turn on the same\n  live thread using the targeted protocol.\n- The app-server subprocess SHOULD remain alive across those continuation turns and be stopped only\n  when the worker run is ending."
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
    "id": "block-0572-blank-blank",
    "type": "blank",
    "lineStart": 1090,
    "lineEnd": 1090,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-"
    ],
    "rawMarkdown": ""
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
  }
]
```
