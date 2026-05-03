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
    "id": "requirement-3-4-transform-request-the-request-must-not-rely-on-conversation-context-that-is-absent-from-the-source",
    "type": "requirement",
    "title": "The request MUST NOT rely on conversation context that is absent from the source",
    "text": "The request MUST NOT rely on conversation context that is absent from the source",
    "normative": [
      "MUST NOT"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 292,
      "lineEnd": 292
    }
  },
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
    "id": "block-0114-blank-blank",
    "type": "blank",
    "lineStart": 292,
    "lineEnd": 292,
    "generatedClaimIds": [
      "requirement-3-4-transform-request-the-request-must-not-rely-on-conversation-context-that-is-absent-from-the-source"
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
  }
]
```
