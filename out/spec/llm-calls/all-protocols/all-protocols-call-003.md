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
    "id": "dependency-5-1-node-types-dependency-external-system-file-tool-api-or-host-assumption",
    "type": "dependency",
    "title": "dependency: external system, file, tool, API, or host assumption.",
    "text": "`dependency`: external system, file, tool, API, or host assumption.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 569,
      "lineEnd": 569
    }
  },
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
  },
  {
    "id": "claim-6-codex-app-server-runner-app-server-process-identity",
    "type": "claim",
    "title": "app-server process identity",
    "text": "app-server process identity",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 629,
      "lineEnd": 629
    }
  },
  {
    "id": "claim-6-codex-app-server-runner-appserverunavailable",
    "type": "claim",
    "title": "appserverunavailable",
    "text": "`app_server_unavailable`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 635,
      "lineEnd": 635
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0251-heading-5-1-node-types",
    "type": "heading",
    "lineStart": 562,
    "lineEnd": 562,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.1 Node Types"
  },
  {
    "id": "block-0253-list-spec-root-input-document-section-source-heading-and-line-range-goal-desire",
    "type": "list",
    "lineStart": 564,
    "lineEnd": 574,
    "generatedClaimIds": [
      "claim-5-1-node-types-section-source-heading-and-line-range",
      "claim-5-1-node-types-goal-desired-outcome",
      "claim-5-1-node-types-nongoal-explicit-boundary",
      "claim-5-1-node-types-requirement-normative-claim",
      "claim-5-1-node-types-component-named-subsystem-actor-layer-or-responsibility",
      "dependency-5-1-node-types-dependency-external-system-file-tool-api-or-host-assumption",
      "test-5-1-node-types-test-validation-surface-or-conformance-check",
      "claim-5-1-node-types-risk-safety-recovery-trust-failure-or-ambiguity-pressure",
      "claim-5-1-node-types-claim-extracted-assertion-not-yet-sharpened",
      "claim-5-1-node-types-finding-generated-bad-idea-pressure"
    ],
    "rawMarkdown": "- `spec`: root input document.\n- `section`: source heading and line range.\n- `goal`: desired outcome.\n- `non_goal`: explicit boundary.\n- `requirement`: normative claim.\n- `component`: named subsystem, actor, layer, or responsibility.\n- `dependency`: external system, file, tool, API, or host assumption.\n- `test`: validation surface or conformance check.\n- `risk`: safety, recovery, trust, failure, or ambiguity pressure.\n- `claim`: extracted assertion not yet sharpened.\n- `finding`: generated bad-idea pressure."
  },
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
    "id": "block-0282-blank-blank",
    "type": "blank",
    "lineStart": 623,
    "lineEnd": 623,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-runner-should-capture-when-exposed-by-the-targeted-protocol"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0285-list-thread-id-turn-id-model-and-configuration-summary-workspace-directory-app-s",
    "type": "list",
    "lineStart": 626,
    "lineEnd": 632,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-turn-id",
      "claim-6-codex-app-server-runner-model-and-configuration-summary",
      "claim-6-codex-app-server-runner-workspace-directory",
      "claim-6-codex-app-server-runner-app-server-process-identity",
      "claim-6-codex-app-server-runner-token-or-rate-limit-telemetry",
      "claim-6-codex-app-server-runner-terminal-error-state"
    ],
    "rawMarkdown": "- thread ID\n- turn ID\n- model and configuration summary\n- workspace directory\n- app-server process identity\n- token or rate-limit telemetry\n- terminal error state"
  },
  {
    "id": "block-0288-blank-blank",
    "type": "blank",
    "lineStart": 635,
    "lineEnd": 635,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-appserverunavailable"
    ],
    "rawMarkdown": ""
  }
]
```
