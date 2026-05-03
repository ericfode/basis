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
    "id": "dependency-3-1-form-registry-emitted-artifact-or-api-shape",
    "type": "dependency",
    "title": "emitted artifact or API shape",
    "text": "emitted artifact or API shape",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 163,
      "lineEnd": 163
    }
  },
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
    "id": "dependency-3-2-projection-registry-emitted-files-or-api-calls",
    "type": "dependency",
    "title": "emitted files or API calls",
    "text": "emitted files or API calls",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 197,
      "lineEnd": 197
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
  },
  {
    "id": "claim-3-3-type-registry-types-requirement-schema-json",
    "type": "claim",
    "title": "types/requirement.schema.json",
    "text": "`types/requirement.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 243,
      "lineEnd": 243
    }
  },
  {
    "id": "claim-3-3-type-registry-types-architecture-document-schema-json",
    "type": "claim",
    "title": "types/architecture-document.schema.json",
    "text": "`types/architecture-document.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 244,
      "lineEnd": 244
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
