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
    "id": "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-must-preserve-traceability-by-including-one-of",
    "type": "requirement",
    "title": "The output MUST preserve traceability by including one of:",
    "text": "The output MUST preserve traceability by including one of:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 369,
      "lineEnd": 369
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
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-implementations-should-prefer",
    "type": "requirement",
    "title": "Implementations SHOULD prefer",
    "text": "Implementations SHOULD prefer",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 393,
      "lineEnd": 393
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-be-reviewable-markdown-not-a-silent-patch-to-the-original",
    "type": "requirement",
    "title": "The output MUST be reviewable Markdown, not a silent patch to the original",
    "text": "The output MUST be reviewable Markdown, not a silent patch to the original",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 396,
      "lineEnd": 396
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-preserve-traceability-by-including-one-of",
    "type": "requirement",
    "title": "The output MUST preserve traceability by including one of:",
    "text": "The output MUST preserve traceability by including one of:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 399,
      "lineEnd": 399
    }
  },
  {
    "id": "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-distinguish-source-backed-content-from-synthesized-connective",
    "type": "requirement",
    "title": "The output MUST distinguish source-backed content from synthesized connective",
    "text": "The output MUST distinguish source-backed content from synthesized connective",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 405,
      "lineEnd": 405
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
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0150-blank-blank",
    "type": "blank",
    "lineStart": 369,
    "lineEnd": 369,
    "generatedClaimIds": [
      "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-must-preserve-traceability-by-including-one-of"
    ],
    "rawMarkdown": ""
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
    "id": "block-0164-blank-blank",
    "type": "blank",
    "lineStart": 393,
    "lineEnd": 393,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-implementations-should-prefer"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0166-blank-blank",
    "type": "blank",
    "lineStart": 396,
    "lineEnd": 396,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-be-reviewable-markdown-not-a-silent-patch-to-the-original"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0168-blank-blank",
    "type": "blank",
    "lineStart": 399,
    "lineEnd": 399,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-preserve-traceability-by-including-one-of"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0172-blank-blank",
    "type": "blank",
    "lineStart": 405,
    "lineEnd": 405,
    "generatedClaimIds": [
      "requirement-3-8-lossy-reverse-transform-claim-to-spec-draft-the-output-must-distinguish-source-backed-content-from-synthesized-connective"
    ],
    "rawMarkdown": ""
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
  }
]
```
