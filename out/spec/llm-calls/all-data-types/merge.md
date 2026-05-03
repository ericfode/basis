You are merging partial LLM outputs for Spec Gym projection `all-data-types`: All Data Types.

Projection instructions:
# All Data Types

Extract every data type, field, schema, enum, message, model, and structured
payload implied by the spec.

The projection should preserve source anchors and distinguish explicit source
text from inferred type candidates.

Final output contract:
- Format: json
- Path: projections/all-data-types.json
- Types: data-type

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- all-data-types-call-001.json / all-data-types-call-001.md
- all-data-types-call-002.json / all-data-types-call-002.md
- all-data-types-call-003.json / all-data-types-call-003.md
- all-data-types-call-004.json / all-data-types-call-004.md
- all-data-types-call-005.json / all-data-types-call-005.md
