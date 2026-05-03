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
    "id": "claim-11-projection-boundary-formalmodel",
    "type": "claim",
    "title": "formalmodel",
    "text": "`formal_model`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 732,
      "lineEnd": 732
    }
  },
  {
    "id": "claim-11-projection-boundary-input-schema-version",
    "type": "claim",
    "title": "input schema version",
    "text": "input schema version",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 739,
      "lineEnd": 739
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
  },
  {
    "id": "block-0339-list-capability-served-input-schema-version-emitted-files-or-api-calls-import-or-e",
    "type": "list",
    "lineStart": 739,
    "lineEnd": 744,
    "generatedClaimIds": [
      "claim-11-projection-boundary-input-schema-version",
      "dependency-11-projection-boundary-emitted-files-or-api-calls",
      "claim-11-projection-boundary-import-or-execution-instructions",
      "claim-11-projection-boundary-lossy-transformations",
      "test-11-projection-boundary-verification-command-or-manual-check"
    ],
    "rawMarkdown": "- capability served\n- input schema version\n- emitted files or API calls\n- import or execution instructions\n- lossy transformations\n- verification command or manual check"
  }
]
```
