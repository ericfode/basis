You are executing Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Output contract:
- Format: markdown
- Final artifact path after merge: projections/implementation-questions.md
- Type contracts: implementation-question

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
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "dependency",
    "title": "Implementations MUST send messages that are valid for the targeted Codex app-server v...",
    "text": "Implementations MUST send messages that are valid for the targeted Codex app-server version.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 913,
      "lineEnd": 913
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
    "id": "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract",
    "type": "requirement",
    "title": "Startup MUST follow the targeted Codex app-server contract.",
    "text": "Startup MUST follow the targeted Codex app-server contract.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 944,
      "lineEnd": 944
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
    "id": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should",
    "type": "requirement",
    "title": "Each event SHOULD",
    "text": "Each event SHOULD",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 996,
      "lineEnd": 996
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi",
    "type": "requirement",
    "title": "Each implementation MUST document its chosen approval, sandbox, and operator-confirma...",
    "text": "Each implementation MUST document its chosen approval, sandbox, and operator-confirmation posture.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1026,
      "lineEnd": 1026
    }
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-approval-requests-and-user-input-required-events-must-not-leave-a-run-stalled-in",
    "type": "requirement",
    "title": "Approval requests and user-input-required events MUST NOT leave a run stalled indefin...",
    "text": "Approval requests and user-input-required events MUST NOT leave a run stalled indefinitely. An implementation MAY either satisfy them, surface them to an operator, auto-resolve them, or fail the run according to its documented policy.",
    "normative": [
      "MUST NOT",
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1028,
      "lineEnd": 1028
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0490-blank-blank",
    "type": "blank",
    "lineStart": 913,
    "lineEnd": 913,
    "generatedClaimIds": [
      "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser"
    ],
    "rawMarkdown": ""
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
    "id": "block-0507-heading-10-2-session-startup-responsibilities",
    "type": "heading",
    "lineStart": 941,
    "lineEnd": 941,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.2 Session Startup Responsibilities"
  },
  {
    "id": "block-0510-blank-blank",
    "type": "blank",
    "lineStart": 944,
    "lineEnd": 944,
    "generatedClaimIds": [
      "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract"
    ],
    "rawMarkdown": ""
  },
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
    "id": "block-0535-heading-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "type": "heading",
    "lineStart": 995,
    "lineEnd": 995,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.4 Emitted Runtime Events (Upstream to Orchestrator)"
  },
  {
    "id": "block-0536-blank-blank",
    "type": "blank",
    "lineStart": 996,
    "lineEnd": 996,
    "generatedClaimIds": [
      "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should"
    ],
    "rawMarkdown": ""
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
    "id": "block-0550-blank-blank",
    "type": "blank",
    "lineStart": 1026,
    "lineEnd": 1026,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0551-list-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi",
    "type": "list",
    "lineStart": 1027,
    "lineEnd": 1031,
    "generatedClaimIds": [
      "requirement-10-5-approval-tool-calls-and-user-input-policy-approval-requests-and-user-input-required-events-must-not-leave-a-run-stalled-in"
    ],
    "rawMarkdown": "- Each implementation MUST document its chosen approval, sandbox, and operator-confirmation\n  posture.\n- Approval requests and user-input-required events MUST NOT leave a run stalled indefinitely. An\n  implementation MAY either satisfy them, surface them to an operator, auto-resolve them, or\n  fail the run according to its documented policy."
  }
]
```
