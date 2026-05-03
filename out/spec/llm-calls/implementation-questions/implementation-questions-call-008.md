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
    "id": "requirement-6-codex-app-server-runner-the-default-launch-command-should-be-codex-app-server-but-implementations",
    "type": "requirement",
    "title": "The default launch command SHOULD be codex app-server, but implementations",
    "text": "The default launch command SHOULD be `codex app-server`, but implementations",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 597,
      "lineEnd": 597
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-must-allow-the-command-model-sandbox-policy-approval-policy-timeout-and",
    "type": "requirement",
    "title": "MUST allow the command, model, sandbox policy, approval policy, timeout, and",
    "text": "MUST allow the command, model, sandbox policy, approval policy, timeout, and",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 598,
      "lineEnd": 598
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-implementations-must-follow-the-targeted-codex-app-server-protocol",
    "type": "requirement",
    "title": "Implementations MUST follow the targeted Codex app-server protocol.",
    "text": "Implementations MUST follow the targeted Codex `app-server` protocol.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 601,
      "lineEnd": 601
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-specification-must-not-be-treated-as-the-protocol-schema",
    "type": "requirement",
    "title": "specification MUST NOT be treated as the protocol schema.",
    "text": "specification MUST NOT be treated as the protocol schema.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 602,
      "lineEnd": 602
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-implementations-should-use-codex-app-server-generate-json-schema-or-the",
    "type": "requirement",
    "title": "Implementations SHOULD use codex app-server generate-json-schema or the",
    "text": "Implementations SHOULD use `codex app-server generate-json-schema` or the",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 606,
      "lineEnd": 606
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-the-transform-prompt-sent-through-the-runner-must-include",
    "type": "requirement",
    "title": "The transform prompt sent through the runner MUST include:",
    "text": "The transform prompt sent through the runner MUST include:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 609,
      "lineEnd": 609
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-the-runner-must-reject-output-that-cannot-be-parsed-as-the-target-form-or-that",
    "type": "requirement",
    "title": "The runner MUST reject output that cannot be parsed as the target form or that",
    "text": "The runner MUST reject output that cannot be parsed as the target form or that",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 620,
      "lineEnd": 620
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-the-runner-should-capture-when-exposed-by-the-targeted-protocol",
    "type": "requirement",
    "title": "The runner SHOULD capture, when exposed by the targeted protocol:",
    "text": "The runner SHOULD capture, when exposed by the targeted protocol:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 623,
      "lineEnd": 623
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0267-heading-6-codex-app-server-runner",
    "type": "heading",
    "lineStart": 593,
    "lineEnd": 593,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 6. Codex App-Server Runner"
  },
  {
    "id": "block-0270-blank-blank",
    "type": "blank",
    "lineStart": 597,
    "lineEnd": 597,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-default-launch-command-should-be-codex-app-server-but-implementations"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0271-paragraph-the-default-launch-command-should-be-codex-app-server-but-implementations-must-a",
    "type": "paragraph",
    "lineStart": 598,
    "lineEnd": 600,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-must-allow-the-command-model-sandbox-policy-approval-policy-timeout-and"
    ],
    "rawMarkdown": "The default launch command SHOULD be `codex app-server`, but implementations\nMUST allow the command, model, sandbox policy, approval policy, timeout, and\ntransport to be configured."
  },
  {
    "id": "block-0272-blank-blank",
    "type": "blank",
    "lineStart": 601,
    "lineEnd": 601,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-implementations-must-follow-the-targeted-codex-app-server-protocol"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0273-paragraph-implementations-must-follow-the-targeted-codex-app-server-protocol-this-specific",
    "type": "paragraph",
    "lineStart": 602,
    "lineEnd": 605,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-specification-must-not-be-treated-as-the-protocol-schema"
    ],
    "rawMarkdown": "Implementations MUST follow the targeted Codex `app-server` protocol. This\nspecification MUST NOT be treated as the protocol schema. If the targeted Codex\nprotocol conflicts with this document, the Codex protocol controls transport\nand message shape."
  },
  {
    "id": "block-0274-blank-blank",
    "type": "blank",
    "lineStart": 606,
    "lineEnd": 606,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-implementations-should-use-codex-app-server-generate-json-schema-or-the"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0276-blank-blank",
    "type": "blank",
    "lineStart": 609,
    "lineEnd": 609,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-transform-prompt-sent-through-the-runner-must-include"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0280-blank-blank",
    "type": "blank",
    "lineStart": 620,
    "lineEnd": 620,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-runner-must-reject-output-that-cannot-be-parsed-as-the-target-form-or-that"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0282-blank-blank",
    "type": "blank",
    "lineStart": 623,
    "lineEnd": 623,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-runner-should-capture-when-exposed-by-the-targeted-protocol"
    ],
    "rawMarkdown": ""
  }
]
```
