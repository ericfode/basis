You are merging partial LLM outputs for Spec Gym projection `aws-architecture`: AWS Architecture Document.

Projection instructions:
# AWS Architecture Document

Transform the spec into an `architecture.md` document using AWS vocabulary.

The projection should map spec components and dependencies to plausible AWS
service roles only when the source supports the mapping. Unsupported mappings
should remain questions instead of invented architecture.

Final output contract:
- Format: markdown
- Path: architecture.md
- Types: architecture-document

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- aws-architecture-call-001.json / aws-architecture-call-001.md
- aws-architecture-call-002.json / aws-architecture-call-002.md
- aws-architecture-call-003.json / aws-architecture-call-003.md
- aws-architecture-call-004.json / aws-architecture-call-004.md
- aws-architecture-call-005.json / aws-architecture-call-005.md
- aws-architecture-call-006.json / aws-architecture-call-006.md
- aws-architecture-call-007.json / aws-architecture-call-007.md
