You are executing Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Output contract:
- Format: markdown
- Final artifact path after merge: tests/spec-derived-tests.md
- Type contracts: test-suite

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
    "id": "claim-3-5-transform-record-failure-state-when-the-transform-is-rejected",
    "type": "claim",
    "title": "failure state when the transform is rejected",
    "text": "failure state when the transform is rejected",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 311,
      "lineEnd": 311
    }
  },
  {
    "id": "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-acceptance-must-not-require-byte-for-byte-equality-with-the-previous-markdown",
    "type": "requirement",
    "title": "Acceptance MUST NOT require byte-for-byte equality with the previous Markdown.",
    "text": "Acceptance MUST NOT require byte-for-byte equality with the previous Markdown.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 385,
      "lineEnd": 385
    }
  },
  {
    "id": "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-acceptance-should-require-an-explicit-loss-report-bounded-for-human-review",
    "type": "requirement",
    "title": "Acceptance SHOULD require an explicit loss report bounded for human review.",
    "text": "Acceptance SHOULD require an explicit loss report bounded for human review.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 386,
      "lineEnd": 386
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-carry-unresolved-findings-tensions-and-missing-validation",
    "type": "requirement",
    "title": "The output MUST carry unresolved findings, tensions, and missing validation",
    "text": "The output MUST carry unresolved findings, tensions, and missing validation",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 408,
      "lineEnd": 408
    }
  },
  {
    "id": "test-5-1-node-types-test-validation-surface-or-conformance-check",
    "type": "test",
    "title": "test: validation surface or conformance check.",
    "text": "`test`: validation surface or conformance check.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 570,
      "lineEnd": 570
    }
  },
  {
    "id": "claim-5-1-node-types-risk-safety-recovery-trust-failure-or-ambiguity-pressure",
    "type": "claim",
    "title": "risk: safety, recovery, trust, failure, or ambiguity pressure.",
    "text": "`risk`: safety, recovery, trust, failure, or ambiguity pressure.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 571,
      "lineEnd": 571
    }
  },
  {
    "id": "requirement-5-3-stability-they-must-not-be-treated-as-proof-that-the-transform-is-deterministic",
    "type": "requirement",
    "title": "They MUST NOT be treated as proof that the transform is deterministic.",
    "text": "They MUST NOT be treated as proof that the transform is deterministic.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 586,
      "lineEnd": 586
    }
  },
  {
    "id": "claim-6-codex-app-server-runner-validation-gates",
    "type": "claim",
    "title": "validation gates",
    "text": "validation gates",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 617,
      "lineEnd": 617
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0117-heading-3-5-transform-record",
    "type": "heading",
    "lineStart": 296,
    "lineEnd": 296,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.5 Transform Record"
  },
  {
    "id": "block-0121-list-source-path-source-hash-source-form-target-form-target-schema-version-run",
    "type": "list",
    "lineStart": 301,
    "lineEnd": 312,
    "generatedClaimIds": [
      "claim-3-5-transform-record-source-hash",
      "claim-3-5-transform-record-source-form",
      "claim-3-5-transform-record-target-form",
      "claim-3-5-transform-record-target-schema-version",
      "claim-3-5-transform-record-runner",
      "claim-3-5-transform-record-runner-command",
      "claim-3-5-transform-record-codex-app-server-protocol-evidence-or-generated-schema-path-when-available",
      "claim-3-5-transform-record-prompt-or-instruction-digest",
      "claim-3-5-transform-record-output-artifact-paths",
      "claim-3-5-transform-record-validation-gates",
      "claim-3-5-transform-record-failure-state-when-the-transform-is-rejected"
    ],
    "rawMarkdown": "- source path\n- source hash\n- source form\n- target form\n- target schema version\n- runner\n- runner command\n- Codex `app-server` protocol evidence or generated schema path when available\n- prompt or instruction digest\n- output artifact paths\n- validation gates\n- failure state when the transform is rejected"
  },
  {
    "id": "block-0143-heading-3-7-reverse-transform-dataified-spec-to-spec-draft",
    "type": "heading",
    "lineStart": 357,
    "lineEnd": 357,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.7 Reverse Transform: Dataified Spec to Spec Draft"
  },
  {
    "id": "block-0158-blank-blank",
    "type": "blank",
    "lineStart": 385,
    "lineEnd": 385,
    "generatedClaimIds": [
      "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-acceptance-must-not-require-byte-for-byte-equality-with-the-previous-markdown"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0159-paragraph-acceptance-must-not-require-byte-for-byte-equality-with-the-previous-markdown-ac",
    "type": "paragraph",
    "lineStart": 386,
    "lineEnd": 387,
    "generatedClaimIds": [
      "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-acceptance-should-require-an-explicit-loss-report-bounded-for-human-review"
    ],
    "rawMarkdown": "Acceptance MUST NOT require byte-for-byte equality with the previous Markdown.\nAcceptance SHOULD require an explicit loss report bounded for human review."
  },
  {
    "id": "block-0161-heading-3-8-lossy-reverse-transform-claim-to-spec-draft",
    "type": "heading",
    "lineStart": 389,
    "lineEnd": 389,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.8 Lossy Reverse Transform: Claim to Spec Draft"
  },
  {
    "id": "block-0174-blank-blank",
    "type": "blank",
    "lineStart": 408,
    "lineEnd": 408,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-carry-unresolved-findings-tensions-and-missing-validation"
    ],
    "rawMarkdown": ""
  },
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
    "id": "block-0259-heading-5-3-stability",
    "type": "heading",
    "lineStart": 584,
    "lineEnd": 584,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.3 Stability"
  },
  {
    "id": "block-0261-paragraph-node-ids-should-support-review-and-diffing-when-source-anchors-are-available-the",
    "type": "paragraph",
    "lineStart": 586,
    "lineEnd": 587,
    "generatedClaimIds": [
      "requirement-5-3-stability-they-must-not-be-treated-as-proof-that-the-transform-is-deterministic"
    ],
    "rawMarkdown": "Node IDs SHOULD support review and diffing when source anchors are available.\nThey MUST NOT be treated as proof that the transform is deterministic."
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
    "id": "block-0279-list-source-artifact-path-or-content-source-form-target-form-target-schema-or-arti",
    "type": "list",
    "lineStart": 612,
    "lineEnd": 619,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-source-form",
      "claim-6-codex-app-server-runner-target-form",
      "claim-6-codex-app-server-runner-target-schema-or-artifact-contract",
      "claim-6-codex-app-server-runner-allowed-mutations",
      "requirement-6-codex-app-server-runner-required-source-anchor-preservation",
      "claim-6-codex-app-server-runner-validation-gates",
      "claim-6-codex-app-server-runner-honesty-boundary-for-uncertainty-and-rejected-transforms"
    ],
    "rawMarkdown": "- source artifact path or content\n- source form\n- target form\n- target schema or artifact contract\n- allowed mutations\n- required source-anchor preservation\n- validation gates\n- honesty boundary for uncertainty and rejected transforms"
  }
]
```
