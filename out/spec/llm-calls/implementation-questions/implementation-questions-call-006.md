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
    "id": "requirement-3-10-projection-composition-and-determinism-training-a-cycle-must-name",
    "type": "requirement",
    "title": "A cycle MUST name:",
    "text": "A cycle MUST name:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 468,
      "lineEnd": 468
    }
  },
  {
    "id": "requirement-3-10-projection-composition-and-determinism-training-the-cli-should-emit-one-directory-per-cycle-round-with",
    "type": "requirement",
    "title": "The CLI SHOULD emit one directory per cycle round with:",
    "text": "The CLI SHOULD emit one directory per cycle round with:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 493,
      "lineEnd": 493
    }
  },
  {
    "id": "requirement-3-10-projection-composition-and-determinism-training-the-cycle-runner-must-not-silently-accept-the-returned-draft-as-spec-md",
    "type": "requirement",
    "title": "The cycle runner MUST NOT silently accept the returned draft as spec.md.",
    "text": "The cycle runner MUST NOT silently accept the returned draft as `spec.md`.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 501,
      "lineEnd": 501
    }
  },
  {
    "id": "requirement-3-11-historical-spec-mining-the-mining-record-should-include",
    "type": "requirement",
    "title": "The mining record SHOULD include:",
    "text": "The mining record SHOULD include:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 511,
      "lineEnd": 511
    }
  },
  {
    "id": "requirement-3-11-historical-spec-mining-the-reward-should-prioritize",
    "type": "requirement",
    "title": "The reward SHOULD prioritize:",
    "text": "The reward SHOULD prioritize:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 525,
      "lineEnd": 525
    }
  },
  {
    "id": "requirement-3-11-historical-spec-mining-a-mined-spec-must-distinguish-root-stable-claims-from-later-only-drift",
    "type": "requirement",
    "title": "A mined spec MUST distinguish root-stable claims from later-only drift.",
    "text": "A mined spec MUST distinguish root-stable claims from later-only drift.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 531,
      "lineEnd": 531
    }
  },
  {
    "id": "requirement-3-12-registry-changes-output-types-beyond-the-registries-in-this-document-must-be-proposed-and",
    "type": "requirement",
    "title": "output types beyond the registries in this document MUST be proposed and",
    "text": "output types beyond the registries in this document MUST be proposed and",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 537,
      "lineEnd": 537
    }
  },
  {
    "id": "requirement-4-core-artifacts-default-spec-to-dataifiedspec-to-claim-generation-must-emit-only-core",
    "type": "requirement",
    "title": "Default spec to dataifiedspec to claim generation MUST emit only core",
    "text": "Default `spec` to `dataified_spec` to `claim` generation MUST emit only core",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 543,
      "lineEnd": 543
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0202-blank-blank",
    "type": "blank",
    "lineStart": 468,
    "lineEnd": 468,
    "generatedClaimIds": [
      "requirement-3-10-projection-composition-and-determinism-training-a-cycle-must-name"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0212-blank-blank",
    "type": "blank",
    "lineStart": 493,
    "lineEnd": 493,
    "generatedClaimIds": [
      "requirement-3-10-projection-composition-and-determinism-training-the-cli-should-emit-one-directory-per-cycle-round-with"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0216-blank-blank",
    "type": "blank",
    "lineStart": 501,
    "lineEnd": 501,
    "generatedClaimIds": [
      "requirement-3-10-projection-composition-and-determinism-training-the-cycle-runner-must-not-silently-accept-the-returned-draft-as-spec-md"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0219-heading-3-11-historical-spec-mining",
    "type": "heading",
    "lineStart": 505,
    "lineEnd": 505,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.11 Historical Spec Mining"
  },
  {
    "id": "block-0222-blank-blank",
    "type": "blank",
    "lineStart": 511,
    "lineEnd": 511,
    "generatedClaimIds": [
      "requirement-3-11-historical-spec-mining-the-mining-record-should-include"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0226-blank-blank",
    "type": "blank",
    "lineStart": 525,
    "lineEnd": 525,
    "generatedClaimIds": [
      "requirement-3-11-historical-spec-mining-the-reward-should-prioritize"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0230-blank-blank",
    "type": "blank",
    "lineStart": 531,
    "lineEnd": 531,
    "generatedClaimIds": [
      "requirement-3-11-historical-spec-mining-a-mined-spec-must-distinguish-root-stable-claims-from-later-only-drift"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0233-heading-3-12-registry-changes",
    "type": "heading",
    "lineStart": 535,
    "lineEnd": 535,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.12 Registry Changes"
  },
  {
    "id": "block-0235-paragraph-the-form-and-type-registries-are-intentionally-small-new-internal-forms-or-outpu",
    "type": "paragraph",
    "lineStart": 537,
    "lineEnd": 540,
    "generatedClaimIds": [
      "requirement-3-12-registry-changes-output-types-beyond-the-registries-in-this-document-must-be-proposed-and",
      "requirement-3-12-registry-changes-new-projection-markdown-files-may-be-added-when"
    ],
    "rawMarkdown": "The form and type registries are intentionally small. New internal forms or\noutput types beyond the registries in this document MUST be proposed and\naccepted before implementation. New projection Markdown files MAY be added when\nthey reuse existing forms and types."
  },
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
    "id": "block-0238-blank-blank",
    "type": "blank",
    "lineStart": 543,
    "lineEnd": 543,
    "generatedClaimIds": [
      "requirement-4-core-artifacts-default-spec-to-dataifiedspec-to-claim-generation-must-emit-only-core"
    ],
    "rawMarkdown": ""
  }
]
```
