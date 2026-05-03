You are executing Spec Gym projection `protobuf-schema`: Protobuf Schema.

Projection instructions:
# Protobuf Schema

Derive a `.proto` schema from explicit data, protocol, request, response, and
event claims in the spec.

The projection should keep uncertain message or field names as comments or
questions rather than silently committing to an invented interface.

Output contract:
- Format: proto
- Final artifact path after merge: spec.proto
- Type contracts: protobuf-schema, data-type, protocol

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
    "id": "dependency-5-1-node-types-dependency-external-system-file-tool-api-or-host-assumption",
    "type": "dependency",
    "title": "dependency: external system, file, tool, API, or host assumption.",
    "text": "`dependency`: external system, file, tool, API, or host assumption.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 569,
      "lineEnd": 569
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
  },
  {
    "id": "requirement-6-codex-app-server-runner-implementations-should-use-codex-app-server-generate-json-schema-or-the",
    "type": "requirement",
    "title": "Implementations SHOULD use codex app-server generate-json-schema or the",
    "text": "Implementations SHOULD use `codex app-server generate-json-schema` or the",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 606,
      "lineEnd": 606
    }
  },
  {
    "id": "claim-6-codex-app-server-runner-target-schema-or-artifact-contract",
    "type": "claim",
    "title": "target schema or artifact contract",
    "text": "target schema or artifact contract",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 614,
      "lineEnd": 614
    }
  },
  {
    "id": "claim-6-codex-app-server-runner-invalidoutputschema",
    "type": "claim",
    "title": "invalidoutputschema",
    "text": "`invalid_output_schema`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 637,
      "lineEnd": 637
    }
  },
  {
    "id": "claim-11-projection-boundary-interfaceschema",
    "type": "claim",
    "title": "interfaceschema",
    "text": "`interface_schema`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 730,
      "lineEnd": 730
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0273-paragraph-implementations-must-follow-the-targeted-codex-app-server-protocol-this-specific",
    "type": "paragraph",
    "lineStart": 602,
    "lineEnd": 605,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-specification-must-not-be-treated-as-the-protocol-schema"
    ],
    "rawMarkdown": "Implementations MUST follow the targeted Codex `app-server` protocol. This\nspecification MUST NOT be treated as the protocol schema. If the targeted Codex\nprotocol conflicts with this document, the Codex protocol controls transport\nand message shape."
  },
  {
    "id": "block-0274-blank-blank",
    "type": "blank",
    "lineStart": 606,
    "lineEnd": 606,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-implementations-should-use-codex-app-server-generate-json-schema-or-the"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0279-list-source-artifact-path-or-content-source-form-target-form-target-schema-or-arti",
    "type": "list",
    "lineStart": 612,
    "lineEnd": 619,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-source-form",
      "claim-6-codex-app-server-runner-target-form",
      "claim-6-codex-app-server-runner-target-schema-or-artifact-contract",
      "claim-6-codex-app-server-runner-allowed-mutations",
      "requirement-6-codex-app-server-runner-required-source-anchor-preservation",
      "claim-6-codex-app-server-runner-validation-gates",
      "claim-6-codex-app-server-runner-honesty-boundary-for-uncertainty-and-rejected-transforms"
    ],
    "rawMarkdown": "- source artifact path or content\n- source form\n- target form\n- target schema or artifact contract\n- allowed mutations\n- required source-anchor preservation\n- validation gates\n- honesty boundary for uncertainty and rejected transforms"
  },
  {
    "id": "block-0289-list-appserverunavailable-protocolmismatch-invalidoutputschema-missingsourceanchor",
    "type": "list",
    "lineStart": 636,
    "lineEnd": 645,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-protocolmismatch",
      "claim-6-codex-app-server-runner-invalidoutputschema",
      "claim-6-codex-app-server-runner-missingsourceanchor",
      "claim-6-codex-app-server-runner-unsafesourcemutation",
      "claim-6-codex-app-server-runner-timeout",
      "claim-6-codex-app-server-runner-runnerrejected",
      "claim-6-codex-app-server-runner-roundtripmismatch",
      "claim-6-codex-app-server-runner-projectiondriftexceedsbudget",
      "claim-6-codex-app-server-runner-llmcallplaninvalid"
    ],
    "rawMarkdown": "- `app_server_unavailable`\n- `protocol_mismatch`\n- `invalid_output_schema`\n- `missing_source_anchor`\n- `unsafe_source_mutation`\n- `timeout`\n- `runner_rejected`\n- `roundtrip_mismatch`\n- `projection_drift_exceeds_budget`\n- `llm_call_plan_invalid`"
  },
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
    "id": "block-0335-list-collaborativemap-graphquery-requirementsdata-architecturedocument-interface",
    "type": "list",
    "lineStart": 727,
    "lineEnd": 735,
    "generatedClaimIds": [
      "claim-11-projection-boundary-graphquery",
      "claim-11-projection-boundary-requirementsdata",
      "claim-11-projection-boundary-architecturedocument",
      "claim-11-projection-boundary-interfaceschema",
      "claim-11-projection-boundary-knowledgevault",
      "claim-11-projection-boundary-formalmodel",
      "claim-11-projection-boundary-executionqueue",
      "claim-11-projection-boundary-transformrunner"
    ],
    "rawMarkdown": "- `collaborative_map`\n- `graph_query`\n- `requirements_data`\n- `architecture_document`\n- `interface_schema`\n- `knowledge_vault`\n- `formal_model`\n- `execution_queue`\n- `transform_runner`"
  }
]
```
