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
  },
  {
    "id": "claim-3-3-type-registry-types-implementation-question-schema-json",
    "type": "claim",
    "title": "types/implementation-question.schema.json",
    "text": "`types/implementation-question.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 245,
      "lineEnd": 245
    }
  },
  {
    "id": "claim-3-3-type-registry-types-protobuf-schema-schema-json",
    "type": "claim",
    "title": "types/protobuf-schema.schema.json",
    "text": "`types/protobuf-schema.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 246,
      "lineEnd": 246
    }
  },
  {
    "id": "claim-3-3-type-registry-types-spec-draft-schema-json",
    "type": "claim",
    "title": "types/spec-draft.schema.json",
    "text": "`types/spec-draft.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 247,
      "lineEnd": 247
    }
  },
  {
    "id": "claim-3-3-type-registry-types-projection-cycle-schema-json",
    "type": "claim",
    "title": "types/projection-cycle.schema.json",
    "text": "`types/projection-cycle.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 249,
      "lineEnd": 249
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
    "id": "block-0095-heading-3-3-type-registry",
    "type": "heading",
    "lineStart": 236,
    "lineEnd": 236,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 Type Registry"
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
