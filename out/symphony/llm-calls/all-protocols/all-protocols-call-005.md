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
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-completion-signal-success",
    "type": "claim",
    "title": "Targeted-protocol turn completion signal -> success",
    "text": "Targeted-protocol turn completion signal -> success",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 975,
      "lineEnd": 975
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn failure signal -> failure",
    "text": "Targeted-protocol turn failure signal -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 976,
      "lineEnd": 976
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn cancellation signal -> failure",
    "text": "Targeted-protocol turn cancellation signal -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 977,
      "lineEnd": 977
    }
  },
  {
    "id": "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "requirement",
    "title": "If the worker decides to continue after a successful turn, it SHOULD start another tu...",
    "text": "If the worker decides to continue after a successful turn, it SHOULD start another turn on the same live thread using the targeted protocol.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 983,
      "lineEnd": 983
    }
  },
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
    "id": "claim-10-3-streaming-turn-processing-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version",
    "type": "claim",
    "title": "Follow the transport and framing rules of the targeted Codex app-server version.",
    "text": "Follow the transport and framing rules of the targeted Codex app-server version.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 990,
      "lineEnd": 990
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-for-stdio-based-transports-keep-protocol-stream-handling-separate-from-diagnosti",
    "type": "claim",
    "title": "For stdio-based transports, keep protocol stream handling separate from diagnostic st...",
    "text": "For stdio-based transports, keep protocol stream handling separate from diagnostic stderr handling unless the targeted protocol specifies otherwise.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 991,
      "lineEnd": 991
    }
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-codexappserverpid-if-available",
    "type": "claim",
    "title": "codexappserverpid (if available)",
    "text": "`codex_app_server_pid` (if available)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1001,
      "lineEnd": 1001
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
    "id": "block-0524-blank-blank",
    "type": "blank",
    "lineStart": 975,
    "lineEnd": 975,
    "generatedClaimIds": [
      "claim-10-3-streaming-turn-processing-targeted-protocol-turn-completion-signal-success"
    ],
    "rawMarkdown": ""
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
    "id": "block-0528-blank-blank",
    "type": "blank",
    "lineStart": 983,
    "lineEnd": 983,
    "generatedClaimIds": [
      "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe"
    ],
    "rawMarkdown": ""
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
    "id": "block-0532-blank-blank",
    "type": "blank",
    "lineStart": 990,
    "lineEnd": 990,
    "generatedClaimIds": [
      "claim-10-3-streaming-turn-processing-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0533-list-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version",
    "type": "list",
    "lineStart": 991,
    "lineEnd": 993,
    "generatedClaimIds": [
      "claim-10-3-streaming-turn-processing-for-stdio-based-transports-keep-protocol-stream-handling-separate-from-diagnosti"
    ],
    "rawMarkdown": "- Follow the transport and framing rules of the targeted Codex app-server version.\n- For stdio-based transports, keep protocol stream handling separate from diagnostic stderr\n  handling unless the targeted protocol specifies otherwise."
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
    "id": "block-0539-list-event-enum-string-timestamp-utc-timestamp-codexappserverpid-if-available",
    "type": "list",
    "lineStart": 1000,
    "lineEnd": 1004,
    "generatedClaimIds": [
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-timestamp-utc-timestamp",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-codexappserverpid-if-available",
      "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-optional-usage-map-token-counts",
      "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-payload-fields-as-needed"
    ],
    "rawMarkdown": "- `event` (enum/string)\n- `timestamp` (UTC timestamp)\n- `codex_app_server_pid` (if available)\n- OPTIONAL `usage` map (token counts)\n- payload fields as needed"
  }
]
```
