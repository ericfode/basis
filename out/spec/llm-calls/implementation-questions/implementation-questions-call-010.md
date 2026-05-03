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
    "id": "requirement-11-projection-boundary-model-must-remain-tool-neutral",
    "type": "requirement",
    "title": "model MUST remain tool-neutral.",
    "text": "model MUST remain tool-neutral.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 722,
      "lineEnd": 722
    }
  },
  {
    "id": "requirement-11-projection-boundary-each-projection-must-state",
    "type": "requirement",
    "title": "Each projection MUST state:",
    "text": "Each projection MUST state:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 736,
      "lineEnd": 736
    }
  },
  {
    "id": "requirement-11-projection-boundary-a-projection-must-not-introduce-required-core-node-types-or-change",
    "type": "requirement",
    "title": "A projection MUST NOT introduce required core node types or change",
    "text": "A projection MUST NOT introduce required core node types or change",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 745,
      "lineEnd": 745
    }
  },
  {
    "id": "requirement-12-reference-inputs-the-toolkit-should-be-validated-against-specifications-that-are-already-useful",
    "type": "requirement",
    "title": "The toolkit SHOULD be validated against specifications that are already useful",
    "text": "The toolkit SHOULD be validated against specifications that are already useful",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 750,
      "lineEnd": 750
    }
  },
  {
    "id": "requirement-12-reference-inputs-their-local-tool-choices-must-not-become-toolkit",
    "type": "requirement",
    "title": "Their local tool choices MUST NOT become toolkit",
    "text": "Their local tool choices MUST NOT become toolkit",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 758,
      "lineEnd": 758
    }
  },
  {
    "id": "finding-underspecified-risk-surface",
    "type": "finding",
    "title": "Risk vocabulary appears without extracted risk nodes",
    "text": "The parser saw risk vocabulary, but the graph did not classify any risk claims. The source likely needs explicit risk sections or sharper bullets.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md"
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0329-heading-11-projection-boundary",
    "type": "heading",
    "lineStart": 720,
    "lineEnd": 720,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 11. Projection Boundary"
  },
  {
    "id": "block-0331-paragraph-projections-may-target-specific-tools-files-protocols-or-apis-but-the-core-model",
    "type": "paragraph",
    "lineStart": 722,
    "lineEnd": 723,
    "generatedClaimIds": [
      "requirement-11-projection-boundary-model-must-remain-tool-neutral"
    ],
    "rawMarkdown": "Projections MAY target specific tools, files, protocols, or APIs, but the core\nmodel MUST remain tool-neutral."
  },
  {
    "id": "block-0336-blank-blank",
    "type": "blank",
    "lineStart": 736,
    "lineEnd": 736,
    "generatedClaimIds": [
      "requirement-11-projection-boundary-each-projection-must-state"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0340-blank-blank",
    "type": "blank",
    "lineStart": 745,
    "lineEnd": 745,
    "generatedClaimIds": [
      "requirement-11-projection-boundary-a-projection-must-not-introduce-required-core-node-types-or-change"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0343-heading-12-reference-inputs",
    "type": "heading",
    "lineStart": 749,
    "lineEnd": 749,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 12. Reference Inputs"
  },
  {
    "id": "block-0344-blank-blank",
    "type": "blank",
    "lineStart": 750,
    "lineEnd": 750,
    "generatedClaimIds": [
      "requirement-12-reference-inputs-the-toolkit-should-be-validated-against-specifications-that-are-already-useful"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0350-blank-blank",
    "type": "blank",
    "lineStart": 758,
    "lineEnd": 758,
    "generatedClaimIds": [
      "requirement-12-reference-inputs-their-local-tool-choices-must-not-become-toolkit"
    ],
    "rawMarkdown": ""
  }
]
```
