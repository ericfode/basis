You are executing Spec Gym projection `all-data-types`: All Data Types.

Projection instructions:
# All Data Types

Extract every data type, field, schema, enum, message, model, and structured
payload implied by the spec.

The projection should preserve source anchors and distinguish explicit source
text from inferred type candidates.

Output contract:
- Format: json
- Final artifact path after merge: projections/all-data-types.json
- Type contracts: data-type

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
    "id": "claim-3-5-transform-record-target-schema-version",
    "type": "claim",
    "title": "target schema version",
    "text": "target schema version",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 304,
      "lineEnd": 304
    }
  },
  {
    "id": "claim-3-5-transform-record-codex-app-server-protocol-evidence-or-generated-schema-path-when-available",
    "type": "claim",
    "title": "Codex app-server protocol evidence or generated schema path when available",
    "text": "Codex `app-server` protocol evidence or generated schema path when available",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 307,
      "lineEnd": 307
    }
  },
  {
    "id": "claim-3-6-dataified-spec-contract-normalized-block-type",
    "type": "claim",
    "title": "normalized block type",
    "text": "normalized block type",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 331,
      "lineEnd": 331
    }
  },
  {
    "id": "claim-4-core-artifacts-dataified-spec-json",
    "type": "claim",
    "title": "dataified-spec.json",
    "text": "`dataified-spec.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 546,
      "lineEnd": 546
    }
  },
  {
    "id": "claim-4-core-artifacts-claim-lattice-json",
    "type": "claim",
    "title": "claim-lattice.json",
    "text": "`claim-lattice.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 547,
      "lineEnd": 547
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
    "id": "requirement-6-codex-app-server-runner-must-allow-the-command-model-sandbox-policy-approval-policy-timeout-and",
    "type": "requirement",
    "title": "MUST allow the command, model, sandbox policy, approval policy, timeout, and",
    "text": "MUST allow the command, model, sandbox policy, approval policy, timeout, and",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 598,
      "lineEnd": 598
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-specification-must-not-be-treated-as-the-protocol-schema",
    "type": "requirement",
    "title": "specification MUST NOT be treated as the protocol schema.",
    "text": "specification MUST NOT be treated as the protocol schema.",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 602,
      "lineEnd": 602
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
    "id": "block-0127-heading-3-6-dataified-spec-contract",
    "type": "heading",
    "lineStart": 322,
    "lineEnd": 322,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.6 Dataified Spec Contract"
  },
  {
    "id": "block-0133-list-document-order-heading-hierarchy-raw-markdown-for-every-source-block-normaliz",
    "type": "list",
    "lineStart": 329,
    "lineEnd": 338,
    "generatedClaimIds": [
      "claim-3-6-dataified-spec-contract-heading-hierarchy",
      "claim-3-6-dataified-spec-contract-raw-markdown-for-every-source-block",
      "claim-3-6-dataified-spec-contract-normalized-block-type",
      "claim-3-6-dataified-spec-contract-source-path-and-source-hash",
      "claim-3-6-dataified-spec-contract-line-anchors-when-available",
      "claim-3-6-dataified-spec-contract-source-anchored-block-ids-for-review-and-diffing",
      "claim-3-6-dataified-spec-contract-semantic-role-when-known",
      "claim-3-6-dataified-spec-contract-generated-claim-ids-when-available",
      "claim-3-6-dataified-spec-contract-unresolved-findings-or-review-notes-attached-to-affected-blocks"
    ],
    "rawMarkdown": "- document order\n- heading hierarchy\n- raw Markdown for every source block\n- normalized block type\n- source path and source hash\n- line anchors when available\n- source-anchored block IDs for review and diffing\n- semantic role when known\n- generated claim IDs when available\n- unresolved findings or review notes attached to affected blocks"
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
    "id": "block-0240-blank-blank",
    "type": "blank",
    "lineStart": 546,
    "lineEnd": 546,
    "generatedClaimIds": [
      "claim-4-core-artifacts-dataified-spec-json"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0241-list-dataified-spec-json-claim-lattice-json-viability-critique-md-claimlattice-lea",
    "type": "list",
    "lineStart": 547,
    "lineEnd": 551,
    "generatedClaimIds": [
      "claim-4-core-artifacts-claim-lattice-json",
      "claim-4-core-artifacts-viability-critique-md",
      "claim-4-core-artifacts-claimlattice-lean",
      "claim-4-core-artifacts-refinement-packet-md"
    ],
    "rawMarkdown": "- `dataified-spec.json`\n- `claim-lattice.json`\n- `viability-critique.md`\n- `ClaimLattice.lean`\n- `refinement-packet.md`"
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
    "id": "block-0267-heading-6-codex-app-server-runner",
    "type": "heading",
    "lineStart": 593,
    "lineEnd": 593,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 6. Codex App-Server Runner"
  },
  {
    "id": "block-0271-paragraph-the-default-launch-command-should-be-codex-app-server-but-implementations-must-a",
    "type": "paragraph",
    "lineStart": 598,
    "lineEnd": 600,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-must-allow-the-command-model-sandbox-policy-approval-policy-timeout-and"
    ],
    "rawMarkdown": "The default launch command SHOULD be `codex app-server`, but implementations\nMUST allow the command, model, sandbox policy, approval policy, timeout, and\ntransport to be configured."
  },
  {
    "id": "block-0273-paragraph-implementations-must-follow-the-targeted-codex-app-server-protocol-this-specific",
    "type": "paragraph",
    "lineStart": 602,
    "lineEnd": 605,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-specification-must-not-be-treated-as-the-protocol-schema"
    ],
    "rawMarkdown": "Implementations MUST follow the targeted Codex `app-server` protocol. This\nspecification MUST NOT be treated as the protocol schema. If the targeted Codex\nprotocol conflicts with this document, the Codex protocol controls transport\nand message shape."
  }
]
```
