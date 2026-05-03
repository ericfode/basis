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
    "id": "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
    "type": "dependency",
    "title": "Transport framing required by the targeted protocol is handled correctly",
    "text": "Transport framing required by the targeted protocol is handled correctly",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2008,
      "lineEnd": 2008
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
    "type": "dependency",
    "title": "For stdio-based transports, diagnostic stderr handling is kept separate from the prot...",
    "text": "For stdio-based transports, diagnostic stderr handling is kept separate from the protocol stream",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2009,
      "lineEnd": 2009
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
    "type": "dependency",
    "title": "Usage and rate-limit telemetry exposed by the targeted protocol is extracted",
    "text": "Usage and rate-limit telemetry exposed by the targeted protocol is extracted",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2014,
      "lineEnd": 2014
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
    "type": "dependency",
    "title": "Approval, user-input-required, usage, and rate-limit signals are interpreted accordin...",
    "text": "Approval, user-input-required, usage, and rate-limit signals are interpreted according to the targeted protocol",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2015,
      "lineEnd": 2015
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
    "type": "dependency",
    "title": "If client-side tools are implemented, session startup advertises the supported tool s...",
    "text": "If client-side tools are implemented, session startup advertises the supported tool specs using the targeted app-server protocol",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2017,
      "lineEnd": 2017
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
    "type": "dependency",
    "title": "If the lineargraphql client-side tool extension is implemented:",
    "text": "If the `linear_graphql` client-side tool extension is implemented:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2019,
      "lineEnd": 2019
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
    "type": "dependency",
    "title": "valid query / variables inputs execute against configured Linear auth",
    "text": "valid `query` / `variables` inputs execute against configured Linear auth",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2021,
      "lineEnd": 2021
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
    "type": "dependency",
    "title": "invalid arguments, missing auth, and transport failures return structured failure pay...",
    "text": "invalid arguments, missing auth, and transport failures return structured failure payloads",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2023,
      "lineEnd": 2023
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
  }
]
```
