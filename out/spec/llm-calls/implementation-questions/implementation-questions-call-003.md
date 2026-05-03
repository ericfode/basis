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
    "id": "requirement-3-5-transform-record-the-record-should-include",
    "type": "requirement",
    "title": "The record SHOULD include:",
    "text": "The record SHOULD include:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 298,
      "lineEnd": 298
    }
  },
  {
    "id": "requirement-3-5-transform-record-the-transform-record-must-not-claim-that-a-later-run-will-reproduce-identical",
    "type": "requirement",
    "title": "The transform record MUST NOT claim that a later run will reproduce identical",
    "text": "The transform record MUST NOT claim that a later run will reproduce identical",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 316,
      "lineEnd": 316
    }
  },
  {
    "id": "requirement-3-5-transform-record-it-should-make-later-differences-explainable-by-recording-source",
    "type": "requirement",
    "title": "It SHOULD make later differences explainable by recording source",
    "text": "It SHOULD make later differences explainable by recording source",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 317,
      "lineEnd": 317
    }
  },
  {
    "id": "requirement-3-6-dataified-spec-contract-it-must-preserve",
    "type": "requirement",
    "title": "It MUST preserve:",
    "text": "It MUST preserve:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 326,
      "lineEnd": 326
    }
  },
  {
    "id": "requirement-3-6-dataified-spec-contract-it-should-preserve-markdown-constructs-as-first-class-blocks-when-present",
    "type": "requirement",
    "title": "It SHOULD preserve Markdown constructs as first-class blocks when present:",
    "text": "It SHOULD preserve Markdown constructs as first-class blocks when present:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 339,
      "lineEnd": 339
    }
  },
  {
    "id": "requirement-3-6-dataified-spec-contract-unknown-or-unsupported-markdown-constructs-must-be-retained-as-opaque-raw",
    "type": "requirement",
    "title": "Unknown or unsupported Markdown constructs MUST be retained as opaque raw",
    "text": "Unknown or unsupported Markdown constructs MUST be retained as opaque raw",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 350,
      "lineEnd": 350
    }
  },
  {
    "id": "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-must-be-reviewable-markdown-not-a-silent-patch-to-the-original",
    "type": "requirement",
    "title": "The output MUST be reviewable Markdown, not a silent patch to the original",
    "text": "The output MUST be reviewable Markdown, not a silent patch to the original",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 361,
      "lineEnd": 361
    }
  },
  {
    "id": "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-should-preserve-source-wording-ordering-headings-code-fences",
    "type": "requirement",
    "title": "The output SHOULD preserve source wording, ordering, headings, code fences,",
    "text": "The output SHOULD preserve source wording, ordering, headings, code fences,",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 364,
      "lineEnd": 364
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
    "id": "block-0119-paragraph-model-assisted-transforms-should-emit-a-transform-record-alongside-the-target-ar",
    "type": "paragraph",
    "lineStart": 298,
    "lineEnd": 299,
    "generatedClaimIds": [
      "requirement-3-5-transform-record-the-record-should-include"
    ],
    "rawMarkdown": "Model-assisted transforms SHOULD emit a transform record alongside the target\nartifact. The record SHOULD include:"
  },
  {
    "id": "block-0124-blank-blank",
    "type": "blank",
    "lineStart": 316,
    "lineEnd": 316,
    "generatedClaimIds": [
      "requirement-3-5-transform-record-the-transform-record-must-not-claim-that-a-later-run-will-reproduce-identical"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0125-paragraph-the-transform-record-must-not-claim-that-a-later-run-will-reproduce-identical-ou",
    "type": "paragraph",
    "lineStart": 317,
    "lineEnd": 320,
    "generatedClaimIds": [
      "requirement-3-5-transform-record-it-should-make-later-differences-explainable-by-recording-source"
    ],
    "rawMarkdown": "The transform record MUST NOT claim that a later run will reproduce identical\noutput. It SHOULD make later differences explainable by recording source\nhashes, schema versions, runner configuration, prompt or instruction digests,\nvalidation gates, and emitted artifact paths."
  },
  {
    "id": "block-0127-heading-3-6-dataified-spec-contract",
    "type": "heading",
    "lineStart": 322,
    "lineEnd": 322,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.6 Dataified Spec Contract"
  },
  {
    "id": "block-0130-blank-blank",
    "type": "blank",
    "lineStart": 326,
    "lineEnd": 326,
    "generatedClaimIds": [
      "requirement-3-6-dataified-spec-contract-it-must-preserve"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0134-blank-blank",
    "type": "blank",
    "lineStart": 339,
    "lineEnd": 339,
    "generatedClaimIds": [
      "requirement-3-6-dataified-spec-contract-it-should-preserve-markdown-constructs-as-first-class-blocks-when-present"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0138-blank-blank",
    "type": "blank",
    "lineStart": 350,
    "lineEnd": 350,
    "generatedClaimIds": [
      "requirement-3-6-dataified-spec-contract-unknown-or-unsupported-markdown-constructs-must-be-retained-as-opaque-raw"
    ],
    "rawMarkdown": ""
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
    "id": "block-0146-blank-blank",
    "type": "blank",
    "lineStart": 361,
    "lineEnd": 361,
    "generatedClaimIds": [
      "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-must-be-reviewable-markdown-not-a-silent-patch-to-the-original"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0148-blank-blank",
    "type": "blank",
    "lineStart": 364,
    "lineEnd": 364,
    "generatedClaimIds": [
      "requirement-3-7-reverse-transform-dataified-spec-to-spec-draft-the-output-should-preserve-source-wording-ordering-headings-code-fences"
    ],
    "rawMarkdown": ""
  }
]
```
