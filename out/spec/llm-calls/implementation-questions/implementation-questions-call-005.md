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
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-transform-should-preserve-the-original-heading-order-when-the-claim-lattice",
    "type": "requirement",
    "title": "The transform SHOULD preserve the original heading order when the claim lattice",
    "text": "The transform SHOULD preserve the original heading order when the claim lattice",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 411,
      "lineEnd": 411
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-structure-the-runner-should-emit-a-conventional-order-problem-goals",
    "type": "requirement",
    "title": "structure, the runner SHOULD emit a conventional order: problem, goals,",
    "text": "structure, the runner SHOULD emit a conventional order: problem, goals,",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 413,
      "lineEnd": 413
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-a-claim-to-specdraft-transform-must-fail-with-missingsourceanchor-when",
    "type": "requirement",
    "title": "A claim to specdraft transform MUST fail with missingsourceanchor when",
    "text": "A `claim` to `spec_draft` transform MUST fail with `missing_source_anchor` when",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 426,
      "lineEnd": 426
    }
  },
  {
    "id": "requirement-3-9-llm-projection-process-projection-content-must-be-generated-through-llm-calls",
    "type": "requirement",
    "title": "Projection content MUST be generated through LLM calls.",
    "text": "Projection content MUST be generated through LLM calls.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 432,
      "lineEnd": 432
    }
  },
  {
    "id": "requirement-3-9-llm-projection-process-local-code-must-not-synthesize-final",
    "type": "requirement",
    "title": "Local code MUST NOT synthesize final",
    "text": "Local code MUST NOT synthesize final",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 434,
      "lineEnd": 434
    }
  },
  {
    "id": "requirement-3-9-llm-projection-process-for-each-selected-projection-the-tool-should",
    "type": "requirement",
    "title": "For each selected projection, the tool SHOULD:",
    "text": "For each selected projection, the tool SHOULD:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 438,
      "lineEnd": 438
    }
  },
  {
    "id": "requirement-3-10-projection-composition-and-determinism-training-the-cli-must-support-applying-one-projection-repeated-projections-or",
    "type": "requirement",
    "title": "The CLI MUST support applying one projection, repeated projections, or",
    "text": "The CLI MUST support applying one projection, repeated projections, or",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 457,
      "lineEnd": 457
    }
  },
  {
    "id": "requirement-3-10-projection-composition-and-determinism-training-projection-combinations-should-be-recorded-in-the-transform-record",
    "type": "requirement",
    "title": "Projection combinations SHOULD be recorded in the transform record.",
    "text": "Projection combinations SHOULD be recorded in the transform record.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 460,
      "lineEnd": 460
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0176-blank-blank",
    "type": "blank",
    "lineStart": 411,
    "lineEnd": 411,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-transform-should-preserve-the-original-heading-order-when-the-claim-lattice"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0177-paragraph-the-transform-should-preserve-the-original-heading-order-when-the-claim-lattice-",
    "type": "paragraph",
    "lineStart": 412,
    "lineEnd": 416,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-structure-the-runner-should-emit-a-conventional-order-problem-goals"
    ],
    "rawMarkdown": "The transform SHOULD preserve the original heading order when the claim lattice\ncontains source section nodes. If the claim lattice has no reliable section\nstructure, the runner SHOULD emit a conventional order: problem, goals,\nnon-goals, requirements, components, dependencies, risks, validation, and open\nquestions."
  },
  {
    "id": "block-0182-blank-blank",
    "type": "blank",
    "lineStart": 426,
    "lineEnd": 426,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-a-claim-to-specdraft-transform-must-fail-with-missingsourceanchor-when"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0185-heading-3-9-llm-projection-process",
    "type": "heading",
    "lineStart": 431,
    "lineEnd": 431,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.9 LLM Projection Process"
  },
  {
    "id": "block-0186-blank-blank",
    "type": "blank",
    "lineStart": 432,
    "lineEnd": 432,
    "generatedClaimIds": [
      "requirement-3-9-llm-projection-process-projection-content-must-be-generated-through-llm-calls"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0187-paragraph-projection-content-must-be-generated-through-llm-calls-local-code-may-parse-sour",
    "type": "paragraph",
    "lineStart": 433,
    "lineEnd": 437,
    "generatedClaimIds": [
      "requirement-3-9-llm-projection-process-local-code-must-not-synthesize-final"
    ],
    "rawMarkdown": "Projection content MUST be generated through LLM calls. Local code may parse\nsource documents, build intermediate forms, select focused slices, write prompts,\nvalidate schemas, and compare drift. Local code MUST NOT synthesize final\nprojection content for requirements, protocols, architecture, protobufs, or\nimplementation questions."
  },
  {
    "id": "block-0188-blank-blank",
    "type": "blank",
    "lineStart": 438,
    "lineEnd": 438,
    "generatedClaimIds": [
      "requirement-3-9-llm-projection-process-for-each-selected-projection-the-tool-should"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0195-heading-3-10-projection-composition-and-determinism-training",
    "type": "heading",
    "lineStart": 456,
    "lineEnd": 456,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.10 Projection Composition And Determinism Training"
  },
  {
    "id": "block-0196-blank-blank",
    "type": "blank",
    "lineStart": 457,
    "lineEnd": 457,
    "generatedClaimIds": [
      "requirement-3-10-projection-composition-and-determinism-training-the-cli-must-support-applying-one-projection-repeated-projections-or"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0198-blank-blank",
    "type": "blank",
    "lineStart": 460,
    "lineEnd": 460,
    "generatedClaimIds": [
      "requirement-3-10-projection-composition-and-determinism-training-projection-combinations-should-be-recorded-in-the-transform-record"
    ],
    "rawMarkdown": ""
  }
]
```
