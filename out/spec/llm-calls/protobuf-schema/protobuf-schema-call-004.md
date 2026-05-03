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
  },
  {
    "id": "dependency-11-projection-boundary-emitted-files-or-api-calls",
    "type": "dependency",
    "title": "emitted files or API calls",
    "text": "emitted files or API calls",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 740,
      "lineEnd": 740
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
