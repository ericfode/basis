You are merging partial LLM outputs for Spec Gym projection `code-to-spec`: Code To Spec Draft.

Projection instructions:
# Code To Spec Draft

Infer a reviewable `spec.md` draft from focused code slices.

The projection should describe observed behavior, interfaces, configuration,
data models, commands, tests, and unresolved implementation questions. It must
preserve file and line anchors and distinguish observed behavior from inferred
intent.

Final output contract:
- Format: markdown
- Path: spec-draft.md
- Types: spec-draft

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- code-to-spec-call-001.json / code-to-spec-call-001.md
