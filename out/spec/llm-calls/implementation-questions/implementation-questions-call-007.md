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
    "id": "requirement-4-core-artifacts-default-generation-must-not-emit-named-adapter-files",
    "type": "requirement",
    "title": "Default generation MUST NOT emit named adapter files.",
    "text": "Default generation MUST NOT emit named adapter files.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 552,
      "lineEnd": 552
    }
  },
  {
    "id": "requirement-4-core-artifacts-named-projection-output-must-be-opt-in",
    "type": "requirement",
    "title": "Named projection output MUST be opt-in.",
    "text": "Named projection output MUST be opt-in.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 554,
      "lineEnd": 554
    }
  },
  {
    "id": "requirement-4-core-artifacts-reverse-generation-must-not-modify-spec-md-by-default",
    "type": "requirement",
    "title": "Reverse generation MUST NOT modify spec.md by default.",
    "text": "Reverse generation MUST NOT modify `spec.md` by default.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 556,
      "lineEnd": 556
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
    "id": "requirement-5-3-stability-node-ids-should-support-review-and-diffing-when-source-anchors-are-available",
    "type": "requirement",
    "title": "Node IDs SHOULD support review and diffing when source anchors are available.",
    "text": "Node IDs SHOULD support review and diffing when source anchors are available.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 585,
      "lineEnd": 585
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
    "id": "requirement-5-3-stability-the-schema-must-be-versioned",
    "type": "requirement",
    "title": "The schema MUST be versioned.",
    "text": "The schema MUST be versioned.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 588,
      "lineEnd": 588
    }
  },
  {
    "id": "requirement-5-3-stability-line-references-should-be-preserved-whenever-the-input-format-supports-them",
    "type": "requirement",
    "title": "Line references SHOULD be preserved whenever the input format supports them.",
    "text": "Line references SHOULD be preserved whenever the input format supports them.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 590,
      "lineEnd": 590
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0237-heading-4-core-artifacts",
    "type": "heading",
    "lineStart": 542,
    "lineEnd": 542,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 4. Core Artifacts"
  },
  {
    "id": "block-0242-blank-blank",
    "type": "blank",
    "lineStart": 552,
    "lineEnd": 552,
    "generatedClaimIds": [
      "requirement-4-core-artifacts-default-generation-must-not-emit-named-adapter-files"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0244-blank-blank",
    "type": "blank",
    "lineStart": 554,
    "lineEnd": 554,
    "generatedClaimIds": [
      "requirement-4-core-artifacts-named-projection-output-must-be-opt-in"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0246-blank-blank",
    "type": "blank",
    "lineStart": 556,
    "lineEnd": 556,
    "generatedClaimIds": [
      "requirement-4-core-artifacts-reverse-generation-must-not-modify-spec-md-by-default"
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
    "id": "block-0260-blank-blank",
    "type": "blank",
    "lineStart": 585,
    "lineEnd": 585,
    "generatedClaimIds": [
      "requirement-5-3-stability-node-ids-should-support-review-and-diffing-when-source-anchors-are-available"
    ],
    "rawMarkdown": ""
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
    "id": "block-0262-blank-blank",
    "type": "blank",
    "lineStart": 588,
    "lineEnd": 588,
    "generatedClaimIds": [
      "requirement-5-3-stability-the-schema-must-be-versioned"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0264-blank-blank",
    "type": "blank",
    "lineStart": 590,
    "lineEnd": 590,
    "generatedClaimIds": [
      "requirement-5-3-stability-line-references-should-be-preserved-whenever-the-input-format-supports-them"
    ],
    "rawMarkdown": ""
  }
]
```
