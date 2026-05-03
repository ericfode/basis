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
    "id": "claim-3-1-form-registry-schema-version-when-machine-readable",
    "type": "claim",
    "title": "schema version when machine-readable",
    "text": "schema version when machine-readable",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 164,
      "lineEnd": 164
    }
  },
  {
    "id": "claim-3-1-form-registry-provermock-prover-facing-model-derived-from-the-claim-form",
    "type": "claim",
    "title": "provermock: prover-facing model derived from the claim form.",
    "text": "`prover_mock`: prover-facing model derived from the claim form.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 176,
      "lineEnd": 176
    }
  },
  {
    "id": "claim-3-2-projection-registry-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-and",
    "type": "claim",
    "title": "requirementsjson: emits requirements.json from requirement, goal, non-goal, risk, and...",
    "text": "`requirements_json`: emits `requirements.json` from requirement, goal, non-goal, risk, and validation claims.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 208,
      "lineEnd": 208
    }
  },
  {
    "id": "claim-3-2-projection-registry-protobufschema-emits-a-proto-schema-for-the-selected-spec-interface-or-interchan",
    "type": "claim",
    "title": "protobufschema: emits a .proto schema for the selected spec interface or interchange...",
    "text": "`protobuf_schema`: emits a `.proto` schema for the selected spec interface or interchange model.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 212,
      "lineEnd": 212
    }
  },
  {
    "id": "claim-3-2-projection-registry-provermodel-emits-prover-facing-facts-and-mock-models",
    "type": "claim",
    "title": "provermodel: emits prover-facing facts and mock models.",
    "text": "`prover_model`: emits prover-facing facts and mock models.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 216,
      "lineEnd": 216
    }
  },
  {
    "id": "claim-3-2-projection-registry-projections-all-data-types-md",
    "type": "claim",
    "title": "projections/all-data-types.md",
    "text": "`projections/all-data-types.md`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 222,
      "lineEnd": 222
    }
  },
  {
    "id": "claim-3-3-type-registry-types-data-type-schema-json",
    "type": "claim",
    "title": "types/data-type.schema.json",
    "text": "`types/data-type.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 241,
      "lineEnd": 241
    }
  },
  {
    "id": "claim-3-3-type-registry-types-protocol-schema-json",
    "type": "claim",
    "title": "types/protocol.schema.json",
    "text": "`types/protocol.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 242,
      "lineEnd": 242
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0073-list-spec-normalized-markdown-input-with-source-anchors-dataifiedspec-low-loss-stru",
    "type": "list",
    "lineStart": 171,
    "lineEnd": 181,
    "generatedClaimIds": [
      "claim-3-1-form-registry-dataifiedspec-low-loss-structured-spec-with-raw-markdown-preservation",
      "claim-3-1-form-registry-specdraft-generated-markdown-awaiting-review-or-acceptance-as-source",
      "claim-3-1-form-registry-claim-typed-claim-lattice-and-source-backed-graph",
      "claim-3-1-form-registry-critique-bad-idea-pressure-over-the-claim-form",
      "claim-3-1-form-registry-refinement-the-next-narrow-correction-packet",
      "claim-3-1-form-registry-provermock-prover-facing-model-derived-from-the-claim-form",
      "claim-3-1-form-registry-architecturedocument-architecture-markdown-or-structured-architecture-extracted-",
      "test-3-1-form-registry-testsuite-test-plan-executable-test-outline-or-focused-test-slices-used-as-proje"
    ],
    "rawMarkdown": "- `spec`: normalized Markdown input with source anchors.\n- `dataified_spec`: low-loss structured spec with raw Markdown preservation.\n- `spec_draft`: generated Markdown awaiting review or acceptance as source.\n- `claim`: typed claim lattice and source-backed graph.\n- `critique`: bad-idea pressure over the claim form.\n- `refinement`: the next narrow correction packet.\n- `prover_mock`: prover-facing model derived from the claim form.\n- `architecture_document`: architecture Markdown or structured architecture\n  extracted from the spec or used as reverse input.\n- `test_suite`: test plan, executable-test outline, or focused test slices used\n  as projection output or reverse input."
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
    "id": "block-0086-blank-blank",
    "type": "blank",
    "lineStart": 208,
    "lineEnd": 208,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-and"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0087-list-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-a",
    "type": "list",
    "lineStart": 209,
    "lineEnd": 219,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-architecturemarkdown-emits-architecture-md-from-component-dependency-risk-and-va",
      "claim-3-2-projection-registry-protobufschema-emits-a-proto-schema-for-the-selected-spec-interface-or-interchan",
      "claim-3-2-projection-registry-graphdataset-emits-graph-import-files-for-graph-query-or-collaborative-map-tools",
      "claim-3-2-projection-registry-provermodel-emits-prover-facing-facts-and-mock-models",
      "claim-3-2-projection-registry-executionpacket-emits-work-packets-for-humans-agents-or-orchestration-systems"
    ],
    "rawMarkdown": "- `requirements_json`: emits `requirements.json` from requirement, goal,\n  non-goal, risk, and validation claims.\n- `architecture_markdown`: emits `architecture.md` from component, dependency,\n  risk, and validation claims.\n- `protobuf_schema`: emits a `.proto` schema for the selected spec interface or\n  interchange model.\n- `graph_dataset`: emits graph import files for graph-query or collaborative\n  map tools.\n- `prover_model`: emits prover-facing facts and mock models.\n- `execution_packet`: emits work packets for humans, agents, or orchestration\n  systems."
  },
  {
    "id": "block-0090-blank-blank",
    "type": "blank",
    "lineStart": 222,
    "lineEnd": 222,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-projections-all-data-types-md"
    ],
    "rawMarkdown": ""
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
    "id": "block-0100-blank-blank",
    "type": "blank",
    "lineStart": 241,
    "lineEnd": 241,
    "generatedClaimIds": [
      "claim-3-3-type-registry-types-data-type-schema-json"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0101-list-types-data-type-schema-json-types-protocol-schema-json-types-requirement-schema",
    "type": "list",
    "lineStart": 242,
    "lineEnd": 250,
    "generatedClaimIds": [
      "claim-3-3-type-registry-types-protocol-schema-json",
      "claim-3-3-type-registry-types-requirement-schema-json",
      "claim-3-3-type-registry-types-architecture-document-schema-json",
      "claim-3-3-type-registry-types-implementation-question-schema-json",
      "claim-3-3-type-registry-types-protobuf-schema-schema-json",
      "claim-3-3-type-registry-types-spec-draft-schema-json",
      "test-3-3-type-registry-types-test-suite-schema-json",
      "claim-3-3-type-registry-types-projection-cycle-schema-json"
    ],
    "rawMarkdown": "- `types/data-type.schema.json`\n- `types/protocol.schema.json`\n- `types/requirement.schema.json`\n- `types/architecture-document.schema.json`\n- `types/implementation-question.schema.json`\n- `types/protobuf-schema.schema.json`\n- `types/spec-draft.schema.json`\n- `types/test-suite.schema.json`\n- `types/projection-cycle.schema.json`"
  }
]
```
