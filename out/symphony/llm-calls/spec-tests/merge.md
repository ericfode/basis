You are merging partial LLM outputs for Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Final output contract:
- Format: markdown
- Path: tests/spec-derived-tests.md
- Types: test-suite

Merge rules:
- Preserve source anchors.
- Deduplicate by source anchor and semantic identity.
- Keep uncertainty explicit.
- Report conflicts instead of hiding them.
- Return only the final projection artifact content.

Expected partial call files:
- spec-tests-call-001.json / spec-tests-call-001.md
- spec-tests-call-002.json / spec-tests-call-002.md
- spec-tests-call-003.json / spec-tests-call-003.md
- spec-tests-call-004.json / spec-tests-call-004.md
- spec-tests-call-005.json / spec-tests-call-005.md
- spec-tests-call-006.json / spec-tests-call-006.md
- spec-tests-call-007.json / spec-tests-call-007.md
- spec-tests-call-008.json / spec-tests-call-008.md
