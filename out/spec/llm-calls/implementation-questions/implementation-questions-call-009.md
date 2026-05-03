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
    "id": "requirement-6-codex-app-server-runner-failure-states-should-be-normalized-as",
    "type": "requirement",
    "title": "Failure states SHOULD be normalized as:",
    "text": "Failure states SHOULD be normalized as:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 633,
      "lineEnd": 633
    }
  },
  {
    "id": "requirement-7-environment-boundary-spec-gym-must-treat-the-human-as-a-first-class-player-not-an-external-approver",
    "type": "requirement",
    "title": "Spec Gym MUST treat the human as a first-class player, not an external approver.",
    "text": "Spec Gym MUST treat the human as a first-class player, not an external approver.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 648,
      "lineEnd": 648
    }
  },
  {
    "id": "requirement-7-environment-boundary-the-environment-state-should-expose",
    "type": "requirement",
    "title": "The environment state SHOULD expose:",
    "text": "The environment state SHOULD expose:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 650,
      "lineEnd": 650
    }
  },
  {
    "id": "requirement-8-bad-idea-pressure-the-toolkit-should-detect-at-least-these-failure-modes",
    "type": "requirement",
    "title": "The toolkit SHOULD detect at least these failure modes:",
    "text": "The toolkit SHOULD detect at least these failure modes:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 668,
      "lineEnd": 668
    }
  },
  {
    "id": "requirement-8-bad-idea-pressure-findings-must-include",
    "type": "requirement",
    "title": "Findings MUST include:",
    "text": "Findings MUST include:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 677,
      "lineEnd": 677
    }
  },
  {
    "id": "requirement-9-refinement-packet-it-should",
    "type": "requirement",
    "title": "It SHOULD:",
    "text": "It SHOULD:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 693,
      "lineEnd": 693
    }
  },
  {
    "id": "requirement-10-formalization-boundary-the-prover-facing-artifact-should-model-the-algebra-of-the-claim-lattice-rather",
    "type": "requirement",
    "title": "The prover-facing artifact SHOULD model the algebra of the claim lattice rather",
    "text": "The prover-facing artifact SHOULD model the algebra of the claim lattice rather",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 705,
      "lineEnd": 705
    }
  },
  {
    "id": "requirement-10-formalization-boundary-the-toolkit-should-separate-generated-facts-from-handwritten-theory-once-the",
    "type": "requirement",
    "title": "The toolkit SHOULD separate generated facts from handwritten theory once the",
    "text": "The toolkit SHOULD separate generated facts from handwritten theory once the",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 716,
      "lineEnd": 716
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0286-blank-blank",
    "type": "blank",
    "lineStart": 633,
    "lineEnd": 633,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-failure-states-should-be-normalized-as"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0291-heading-7-environment-boundary",
    "type": "heading",
    "lineStart": 647,
    "lineEnd": 647,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 7. Environment Boundary"
  },
  {
    "id": "block-0292-blank-blank",
    "type": "blank",
    "lineStart": 648,
    "lineEnd": 648,
    "generatedClaimIds": [
      "requirement-7-environment-boundary-spec-gym-must-treat-the-human-as-a-first-class-player-not-an-external-approver"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0294-blank-blank",
    "type": "blank",
    "lineStart": 650,
    "lineEnd": 650,
    "generatedClaimIds": [
      "requirement-7-environment-boundary-the-environment-state-should-expose"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0299-heading-8-bad-idea-pressure",
    "type": "heading",
    "lineStart": 667,
    "lineEnd": 667,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 8. Bad-Idea Pressure"
  },
  {
    "id": "block-0300-blank-blank",
    "type": "blank",
    "lineStart": 668,
    "lineEnd": 668,
    "generatedClaimIds": [
      "requirement-8-bad-idea-pressure-the-toolkit-should-detect-at-least-these-failure-modes"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0304-blank-blank",
    "type": "blank",
    "lineStart": 677,
    "lineEnd": 677,
    "generatedClaimIds": [
      "requirement-8-bad-idea-pressure-findings-must-include"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0311-heading-9-refinement-packet",
    "type": "heading",
    "lineStart": 689,
    "lineEnd": 689,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 9. Refinement Packet"
  },
  {
    "id": "block-0314-blank-blank",
    "type": "blank",
    "lineStart": 693,
    "lineEnd": 693,
    "generatedClaimIds": [
      "requirement-9-refinement-packet-it-should"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0319-heading-10-formalization-boundary",
    "type": "heading",
    "lineStart": 704,
    "lineEnd": 704,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 10. Formalization Boundary"
  },
  {
    "id": "block-0320-blank-blank",
    "type": "blank",
    "lineStart": 705,
    "lineEnd": 705,
    "generatedClaimIds": [
      "requirement-10-formalization-boundary-the-prover-facing-artifact-should-model-the-algebra-of-the-claim-lattice-rather"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0326-blank-blank",
    "type": "blank",
    "lineStart": 716,
    "lineEnd": 716,
    "generatedClaimIds": [
      "requirement-10-formalization-boundary-the-toolkit-should-separate-generated-facts-from-handwritten-theory-once-the"
    ],
    "rawMarkdown": ""
  }
]
```
