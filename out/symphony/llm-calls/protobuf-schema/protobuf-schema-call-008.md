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
    "id": "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
    "type": "dependency",
    "title": "Request/response read timeout is enforced",
    "text": "Request/response read timeout is enforced",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2006,
      "lineEnd": 2006
    }
  },
  {
    "id": "claim-17-6-observability-if-humanized-event-summaries-are-implemented-they-cover-key-wrapper-agent-event-",
    "type": "claim",
    "title": "If humanized event summaries are implemented, they cover key wrapper/agent event clas...",
    "text": "If humanized event summaries are implemented, they cover key wrapper/agent event classes without changing orchestrator behavior",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2034,
      "lineEnd": 2034
    }
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap",
    "type": "dependency",
    "title": "A real tracker smoke test can be run with valid credentials supplied by LINEARAPIKEY...",
    "text": "A real tracker smoke test can be run with valid credentials supplied by `LINEAR_API_KEY` or a documented local bootstrap mechanism (for example `~/.linear_api_key`).",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2051,
      "lineEnd": 2051
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0905-heading-17-5-coding-agent-app-server-client",
    "type": "heading",
    "lineStart": 1998,
    "lineEnd": 1998,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.5 Coding-Agent App-Server Client"
  },
  {
    "id": "block-0907-list-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command-session-st",
    "type": "list",
    "lineStart": 2000,
    "lineEnd": 2025,
    "generatedClaimIds": [
      "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
      "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
      "dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san",
      "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
      "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
      "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
      "dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu",
      "dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session",
      "dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol",
      "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
      "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
      "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
      "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
      "dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session",
      "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
      "dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body",
      "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
      "dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session"
    ],
    "rawMarkdown": "- Launch command uses workspace cwd and invokes `bash -lc <codex.command>`\n- Session startup follows the targeted Codex app-server protocol.\n- Client identity/capability payloads are valid when the targeted Codex app-server protocol requires\n  them.\n- Policy-related startup payloads use the implementation's documented approval/sandbox settings\n- Thread and turn identities exposed by the targeted protocol are extracted and used to emit\n  `session_started`\n- Request/response read timeout is enforced\n- Turn timeout is enforced\n- Transport framing required by the targeted protocol is handled correctly\n- For stdio-based transports, diagnostic stderr handling is kept separate from the protocol stream\n- Command/file-change approvals are handled according to the implementation's documented policy\n- Unsupported dynamic tool calls are rejected without stalling the session\n- User input requests are handled according to the implementation's documented policy and do not\n  stall indefinitely\n- Usage and rate-limit telemetry exposed by the targeted protocol is extracted\n- Approval, user-input-required, usage, and rate-limit signals are interpreted according to the\n  targeted protocol\n- If client-side tools are implemented, session startup advertises the supported tool specs\n  using the targeted app-server protocol\n- If the `linear_graphql` client-side tool extension is implemented:\n  - the tool is advertised to the session\n  - valid `query` / `variables` inputs execute against configured Linear auth\n  - top-level GraphQL `errors` produce `success=false` while preserving the GraphQL body\n  - invalid arguments, missing auth, and transport failures return structured failure payloads\n  - unsupported tool names still fail without stalling the session"
  },
  {
    "id": "block-0909-heading-17-6-observability",
    "type": "heading",
    "lineStart": 2027,
    "lineEnd": 2027,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.6 Observability"
  },
  {
    "id": "block-0911-list-validation-failures-are-operator-visible-structured-logging-includes-issue-sessi",
    "type": "list",
    "lineStart": 2029,
    "lineEnd": 2036,
    "generatedClaimIds": [
      "claim-17-6-observability-structured-logging-includes-issue-session-context-fields",
      "claim-17-6-observability-logging-sink-failures-do-not-crash-orchestration",
      "claim-17-6-observability-token-rate-limit-aggregation-remains-correct-across-repeated-agent-updates",
      "claim-17-6-observability-if-a-human-readable-status-surface-is-implemented-it-is-driven-from-orchestrator",
      "claim-17-6-observability-if-humanized-event-summaries-are-implemented-they-cover-key-wrapper-agent-event-"
    ],
    "rawMarkdown": "- Validation failures are operator-visible\n- Structured logging includes issue/session context fields\n- Logging sink failures do not crash orchestration\n- Token/rate-limit aggregation remains correct across repeated agent updates\n- If a human-readable status surface is implemented, it is driven from orchestrator state and does\n  not affect correctness\n- If humanized event summaries are implemented, they cover key wrapper/agent event classes without\n  changing orchestrator behavior"
  },
  {
    "id": "block-0917-heading-17-8-real-integration-profile-recommended",
    "type": "heading",
    "lineStart": 2047,
    "lineEnd": 2047,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.8 Real Integration Profile (RECOMMENDED)"
  },
  {
    "id": "block-0920-blank-blank",
    "type": "blank",
    "lineStart": 2051,
    "lineEnd": 2051,
    "generatedClaimIds": [
      "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap"
    ],
    "rawMarkdown": ""
  }
]
```
