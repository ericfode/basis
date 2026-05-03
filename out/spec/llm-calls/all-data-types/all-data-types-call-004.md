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
    "id": "claim-6-codex-app-server-runner-model-and-configuration-summary",
    "type": "claim",
    "title": "model and configuration summary",
    "text": "model and configuration summary",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 627,
      "lineEnd": 627
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
    "id": "claim-11-projection-boundary-requirementsdata",
    "type": "claim",
    "title": "requirementsdata",
    "text": "`requirements_data`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 728,
      "lineEnd": 728
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
    "id": "block-0267-heading-6-codex-app-server-runner",
    "type": "heading",
    "lineStart": 593,
    "lineEnd": 593,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 6. Codex App-Server Runner"
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
    "id": "block-0285-list-thread-id-turn-id-model-and-configuration-summary-workspace-directory-app-s",
    "type": "list",
    "lineStart": 626,
    "lineEnd": 632,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-turn-id",
      "claim-6-codex-app-server-runner-model-and-configuration-summary",
      "claim-6-codex-app-server-runner-workspace-directory",
      "claim-6-codex-app-server-runner-app-server-process-identity",
      "claim-6-codex-app-server-runner-token-or-rate-limit-telemetry",
      "claim-6-codex-app-server-runner-terminal-error-state"
    ],
    "rawMarkdown": "- thread ID\n- turn ID\n- model and configuration summary\n- workspace directory\n- app-server process identity\n- token or rate-limit telemetry\n- terminal error state"
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
