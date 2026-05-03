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
    "id": "requirement-normative-language-the-key-words-must-must-not-required-should-should-not",
    "type": "requirement",
    "title": "The key words MUST, MUST NOT, REQUIRED, SHOULD, SHOULD NOT,",
    "text": "The key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`,",
    "normative": [
      "MUST",
      "MUST NOT",
      "REQUIRED",
      "SHOULD",
      "SHOULD NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 11,
      "lineEnd": 11
    }
  },
  {
    "id": "requirement-1-problem-statement-can-emit-projections-for-those-systems-but-it-must-preserve-a-tool-neutral",
    "type": "requirement",
    "title": "can emit projections for those systems, but it MUST preserve a tool-neutral",
    "text": "can emit projections for those systems, but it MUST preserve a tool-neutral",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 82,
      "lineEnd": 82
    }
  },
  {
    "id": "requirement-3-transform-model-transforms-must-be-treated-as-non-deterministic-at-the-product-boundary",
    "type": "requirement",
    "title": "Transforms MUST be treated as non-deterministic at the product boundary.",
    "text": "Transforms MUST be treated as non-deterministic at the product boundary.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 151,
      "lineEnd": 151
    }
  },
  {
    "id": "requirement-3-transform-model-when-one-implementation-path-uses-local-code-users-must-not-rely-on-byte-for",
    "type": "requirement",
    "title": "when one implementation path uses local code, users MUST NOT rely on byte-for-",
    "text": "when one implementation path uses local code, users MUST NOT rely on byte-for-",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 152,
      "lineEnd": 152
    }
  },
  {
    "id": "requirement-3-1-form-registry-a-form-declaration-must-include",
    "type": "requirement",
    "title": "A form declaration MUST include:",
    "text": "A form declaration MUST include:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 158,
      "lineEnd": 158
    }
  },
  {
    "id": "test-3-1-form-registry-validation-command-or-manual-check",
    "type": "test",
    "title": "validation command or manual check",
    "text": "validation command or manual check",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 166,
      "lineEnd": 166
    }
  },
  {
    "id": "requirement-3-2-projection-registry-a-projection-declaration-must-be-a-markdown-file-under-projections-with",
    "type": "requirement",
    "title": "A projection declaration MUST be a Markdown file under projections/ with",
    "text": "A projection declaration MUST be a Markdown file under `projections/` with",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 189,
      "lineEnd": 189
    }
  },
  {
    "id": "requirement-3-2-projection-registry-a-projection-declaration-must-include",
    "type": "requirement",
    "title": "A projection declaration MUST include:",
    "text": "A projection declaration MUST include:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 192,
      "lineEnd": 192
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0007-heading-normative-language",
    "type": "heading",
    "lineStart": 10,
    "lineEnd": 10,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## Normative Language"
  },
  {
    "id": "block-0008-blank-blank",
    "type": "blank",
    "lineStart": 11,
    "lineEnd": 11,
    "generatedClaimIds": [
      "requirement-normative-language-the-key-words-must-must-not-required-should-should-not"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0039-heading-1-problem-statement",
    "type": "heading",
    "lineStart": 64,
    "lineEnd": 64,
    "semanticRole": "problem",
    "generatedClaimIds": [],
    "rawMarkdown": "## 1. Problem Statement"
  },
  {
    "id": "block-0047-paragraph-spec-gym-is-not-a-diagram-product-project-management-system-prover-whiteboard-gr",
    "type": "paragraph",
    "lineStart": 81,
    "lineEnd": 84,
    "generatedClaimIds": [
      "requirement-1-problem-statement-can-emit-projections-for-those-systems-but-it-must-preserve-a-tool-neutral"
    ],
    "rawMarkdown": "Spec Gym is not a diagram product, project-management system, prover,\nwhiteboard, graph database, interface-definition language, or agent runner. It\ncan emit projections for those systems, but it MUST preserve a tool-neutral\ncore."
  },
  {
    "id": "block-0059-heading-3-transform-model",
    "type": "heading",
    "lineStart": 146,
    "lineEnd": 146,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 3. Transform Model"
  },
  {
    "id": "block-0062-blank-blank",
    "type": "blank",
    "lineStart": 151,
    "lineEnd": 151,
    "generatedClaimIds": [
      "requirement-3-transform-model-transforms-must-be-treated-as-non-deterministic-at-the-product-boundary"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0063-paragraph-transforms-must-be-treated-as-non-deterministic-at-the-product-boundary-even-whe",
    "type": "paragraph",
    "lineStart": 152,
    "lineEnd": 155,
    "generatedClaimIds": [
      "requirement-3-transform-model-when-one-implementation-path-uses-local-code-users-must-not-rely-on-byte-for"
    ],
    "rawMarkdown": "Transforms MUST be treated as non-deterministic at the product boundary. Even\nwhen one implementation path uses local code, users MUST NOT rely on byte-for-\nbyte identical output from repeated runs. The durable contract is provenance,\ntraceability, reviewability, and measured loss, not deterministic replay."
  },
  {
    "id": "block-0065-heading-3-1-form-registry",
    "type": "heading",
    "lineStart": 157,
    "lineEnd": 157,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.1 Form Registry"
  },
  {
    "id": "block-0066-blank-blank",
    "type": "blank",
    "lineStart": 158,
    "lineEnd": 158,
    "generatedClaimIds": [
      "requirement-3-1-form-registry-a-form-declaration-must-include"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0069-list-form-id-purpose-accepted-input-forms-emitted-artifact-or-api-shape-schema-v",
    "type": "list",
    "lineStart": 161,
    "lineEnd": 167,
    "generatedClaimIds": [
      "claim-3-1-form-registry-purpose",
      "claim-3-1-form-registry-accepted-input-forms",
      "dependency-3-1-form-registry-emitted-artifact-or-api-shape",
      "claim-3-1-form-registry-schema-version-when-machine-readable",
      "claim-3-1-form-registry-lossy-transformations",
      "test-3-1-form-registry-validation-command-or-manual-check"
    ],
    "rawMarkdown": "- form ID\n- purpose\n- accepted input forms\n- emitted artifact or API shape\n- schema version when machine-readable\n- lossy transformations\n- validation command or manual check"
  },
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
    "id": "block-0078-blank-blank",
    "type": "blank",
    "lineStart": 189,
    "lineEnd": 189,
    "generatedClaimIds": [
      "requirement-3-2-projection-registry-a-projection-declaration-must-be-a-markdown-file-under-projections-with"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0080-blank-blank",
    "type": "blank",
    "lineStart": 192,
    "lineEnd": 192,
    "generatedClaimIds": [
      "requirement-3-2-projection-registry-a-projection-declaration-must-include"
    ],
    "rawMarkdown": ""
  }
]
```
