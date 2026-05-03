You are merging partial LLM outputs for Spec Gym projection `protobuf-schema`: Protobuf Schema.

Projection instructions:
# Protobuf Schema

Derive a `.proto` schema from explicit data, protocol, request, response, and
event claims in the spec.

The projection should keep uncertain message or field names as comments or
questions rather than silently committing to an invented interface.

Final output contract:
- Format: proto
- Path: spec.proto
- Types: protobuf-schema, data-type, protocol

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- protobuf-schema-call-001.json / protobuf-schema-call-001.md
- protobuf-schema-call-002.json / protobuf-schema-call-002.md
- protobuf-schema-call-003.json / protobuf-schema-call-003.md
- protobuf-schema-call-004.json / protobuf-schema-call-004.md
