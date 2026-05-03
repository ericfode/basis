You are merging partial LLM outputs for Spec Gym projection `network-requirements`: Network Requirements.

Projection instructions:
# Network Requirements

Extract all requirements, dependencies, risks, and validation surfaces related
to networking.

The projection should include source-backed requirements first, then inferred
network obligations and missing validation questions.

Final output contract:
- Format: json
- Path: projections/network-requirements.json
- Types: requirement

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- network-requirements-call-001.json / network-requirements-call-001.md
- network-requirements-call-002.json / network-requirements-call-002.md
- network-requirements-call-003.json / network-requirements-call-003.md
- network-requirements-call-004.json / network-requirements-call-004.md
- network-requirements-call-005.json / network-requirements-call-005.md
- network-requirements-call-006.json / network-requirements-call-006.md
- network-requirements-call-007.json / network-requirements-call-007.md
- network-requirements-call-008.json / network-requirements-call-008.md
- network-requirements-call-009.json / network-requirements-call-009.md
- network-requirements-call-010.json / network-requirements-call-010.md
- network-requirements-call-011.json / network-requirements-call-011.md
- network-requirements-call-012.json / network-requirements-call-012.md
