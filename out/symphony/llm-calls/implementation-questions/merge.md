You are merging partial LLM outputs for Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Final output contract:
- Format: markdown
- Path: projections/implementation-questions.md
- Types: implementation-question

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- implementation-questions-call-001.json / implementation-questions-call-001.md
- implementation-questions-call-002.json / implementation-questions-call-002.md
- implementation-questions-call-003.json / implementation-questions-call-003.md
- implementation-questions-call-004.json / implementation-questions-call-004.md
- implementation-questions-call-005.json / implementation-questions-call-005.md
- implementation-questions-call-006.json / implementation-questions-call-006.md
- implementation-questions-call-007.json / implementation-questions-call-007.md
- implementation-questions-call-008.json / implementation-questions-call-008.md
- implementation-questions-call-009.json / implementation-questions-call-009.md
- implementation-questions-call-010.json / implementation-questions-call-010.md
- implementation-questions-call-011.json / implementation-questions-call-011.md
- implementation-questions-call-012.json / implementation-questions-call-012.md
- implementation-questions-call-013.json / implementation-questions-call-013.md
