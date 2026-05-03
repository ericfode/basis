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
    "id": "test-3-2-projection-registry-validation-command-or-manual-check",
    "type": "test",
    "title": "validation command or manual check",
    "text": "validation command or manual check",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 200,
      "lineEnd": 200
    }
  },
  {
    "id": "requirement-3-2-projection-registry-whether-it-is-included-by-projection-all-reverse-direction-projections-such-as-c",
    "type": "requirement",
    "title": "whether it is included by --projection all; reverse-direction projections such as cod...",
    "text": "whether it is included by `--projection all`; reverse-direction projections such as code-to-spec SHOULD be explicit-only",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 203,
      "lineEnd": 203
    }
  },
  {
    "id": "requirement-3-3-type-registry-projection-output-types-must-be-described-under-types",
    "type": "requirement",
    "title": "Projection output types MUST be described under types/.",
    "text": "Projection output types MUST be described under `types/`.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 237,
      "lineEnd": 237
    }
  },
  {
    "id": "requirement-3-3-type-registry-projection-files-should-reference-these-types-so-repeated-transformations-have",
    "type": "requirement",
    "title": "Projection files SHOULD reference these types so repeated transformations have",
    "text": "Projection files SHOULD reference these types so repeated transformations have",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 251,
      "lineEnd": 251
    }
  },
  {
    "id": "requirement-3-4-transform-request-a-transform-request-should-be-representable-as-data",
    "type": "requirement",
    "title": "A transform request SHOULD be representable as data:",
    "text": "A transform request SHOULD be representable as data:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 256,
      "lineEnd": 256
    }
  },
  {
    "id": "requirement-3-4-transform-request-the-opposite-transform-should-use-the-same-envelope",
    "type": "requirement",
    "title": "The opposite transform SHOULD use the same envelope:",
    "text": "The opposite transform SHOULD use the same envelope:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 274,
      "lineEnd": 274
    }
  },
  {
    "id": "requirement-3-4-transform-request-the-request-must-not-rely-on-conversation-context-that-is-absent-from-the-source",
    "type": "requirement",
    "title": "The request MUST NOT rely on conversation context that is absent from the source",
    "text": "The request MUST NOT rely on conversation context that is absent from the source",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 292,
      "lineEnd": 292
    }
  },
  {
    "id": "requirement-3-5-transform-record-model-assisted-transforms-should-emit-a-transform-record-alongside-the-target",
    "type": "requirement",
    "title": "Model-assisted transforms SHOULD emit a transform record alongside the target",
    "text": "Model-assisted transforms SHOULD emit a transform record alongside the target",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 297,
      "lineEnd": 297
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0077-heading-3-2-projection-registry",
    "type": "heading",
    "lineStart": 188,
    "lineEnd": 188,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Projection Registry"
  },
  {
    "id": "block-0083-list-projection-id-purpose-accepted-input-forms-emitted-files-or-api-calls-targe",
    "type": "list",
    "lineStart": 195,
    "lineEnd": 205,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-purpose",
      "claim-3-2-projection-registry-accepted-input-forms",
      "dependency-3-2-projection-registry-emitted-files-or-api-calls",
      "claim-3-2-projection-registry-target-artifact-contract",
      "claim-3-2-projection-registry-lossy-transformations",
      "test-3-2-projection-registry-validation-command-or-manual-check",
      "claim-3-2-projection-registry-focus-strategy-for-small-source-slices",
      "claim-3-2-projection-registry-merge-strategy-for-partial-llm-outputs",
      "requirement-3-2-projection-registry-whether-it-is-included-by-projection-all-reverse-direction-projections-such-as-c"
    ],
    "rawMarkdown": "- projection ID\n- purpose\n- accepted input forms\n- emitted files or API calls\n- target artifact contract\n- lossy transformations\n- validation command or manual check\n- focus strategy for small source slices\n- merge strategy for partial LLM outputs\n- whether it is included by `--projection all`; reverse-direction projections\n  such as code-to-spec SHOULD be explicit-only"
  },
  {
    "id": "block-0095-heading-3-3-type-registry",
    "type": "heading",
    "lineStart": 236,
    "lineEnd": 236,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 Type Registry"
  },
  {
    "id": "block-0096-blank-blank",
    "type": "blank",
    "lineStart": 237,
    "lineEnd": 237,
    "generatedClaimIds": [
      "requirement-3-3-type-registry-projection-output-types-must-be-described-under-types"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0102-blank-blank",
    "type": "blank",
    "lineStart": 251,
    "lineEnd": 251,
    "generatedClaimIds": [
      "requirement-3-3-type-registry-projection-files-should-reference-these-types-so-repeated-transformations-have"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0105-heading-3-4-transform-request",
    "type": "heading",
    "lineStart": 255,
    "lineEnd": 255,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.4 Transform Request"
  },
  {
    "id": "block-0106-blank-blank",
    "type": "blank",
    "lineStart": 256,
    "lineEnd": 256,
    "generatedClaimIds": [
      "requirement-3-4-transform-request-a-transform-request-should-be-representable-as-data"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0110-blank-blank",
    "type": "blank",
    "lineStart": 274,
    "lineEnd": 274,
    "generatedClaimIds": [
      "requirement-3-4-transform-request-the-opposite-transform-should-use-the-same-envelope"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0114-blank-blank",
    "type": "blank",
    "lineStart": 292,
    "lineEnd": 292,
    "generatedClaimIds": [
      "requirement-3-4-transform-request-the-request-must-not-rely-on-conversation-context-that-is-absent-from-the-source"
    ],
    "rawMarkdown": ""
  },
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
    "id": "block-0118-blank-blank",
    "type": "blank",
    "lineStart": 297,
    "lineEnd": 297,
    "generatedClaimIds": [
      "requirement-3-5-transform-record-model-assisted-transforms-should-emit-a-transform-record-alongside-the-target"
    ],
    "rawMarkdown": ""
  }
]
```
