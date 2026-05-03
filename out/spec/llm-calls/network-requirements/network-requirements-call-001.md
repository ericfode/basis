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
    "id": "test-13-definition-of-done-for-current-increment-codex-app-server-participation-is-bounded-by-the-runner-contract",
    "type": "test",
    "title": "Codex app-server participation is bounded by the runner contract.",
    "text": "Codex `app-server` participation is bounded by the runner contract.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 772,
      "lineEnd": 772
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
    "id": "block-0353-heading-13-definition-of-done-for-current-increment",
    "type": "heading",
    "lineStart": 762,
    "lineEnd": 762,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "## 13. Definition of Done for Current Increment"
  },
  {
    "id": "block-0357-list-spec-md-is-the-top-level-authoritative-specification-the-primary-cli-is-specgym",
    "type": "list",
    "lineStart": 766,
    "lineEnd": 779,
    "generatedClaimIds": [
      "test-13-definition-of-done-for-current-increment-the-primary-cli-is-specgym",
      "test-13-definition-of-done-for-current-increment-spec-to-dataifiedspec-is-defined-as-the-first-transform",
      "test-13-definition-of-done-for-current-increment-dataifiedspec-to-specdraft-is-defined-as-the-first-reverse-transform",
      "test-13-definition-of-done-for-current-increment-claim-to-specdraft-is-documented-as-a-lossy-fallback",
      "test-13-definition-of-done-for-current-increment-projection-execution-emits-focused-llm-call-packets-instead-of-locally-synthesiz",
      "test-13-definition-of-done-for-current-increment-codex-app-server-participation-is-bounded-by-the-runner-contract",
      "test-13-definition-of-done-for-current-increment-default-generation-emits-only-core-artifacts",
      "test-13-definition-of-done-for-current-increment-named-projections-are-opt-in",
      "test-13-definition-of-done-for-current-increment-the-projection-boundary-is-documented",
      "test-13-definition-of-done-for-current-increment-the-symphony-service-specification-can-be-played-as-an-example-input",
      "test-13-definition-of-done-for-current-increment-the-lean-mock-model-type-checks",
      "test-13-definition-of-done-for-current-increment-the-local-tests-pass"
    ],
    "rawMarkdown": "- `spec.md` is the top-level authoritative specification.\n- The primary CLI is `specgym`.\n- `spec` to `dataified_spec` is defined as the first transform.\n- `dataified_spec` to `spec_draft` is defined as the first reverse transform.\n- `claim` to `spec_draft` is documented as a lossy fallback.\n- Projection execution emits focused LLM call packets instead of locally\n  synthesized projection content.\n- Codex `app-server` participation is bounded by the runner contract.\n- Default generation emits only core artifacts.\n- Named projections are opt-in.\n- The projection boundary is documented.\n- The Symphony service specification can be played as an example input.\n- The Lean mock model type-checks.\n- The local tests pass."
  }
]
```
