You are executing Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Output contract:
- Format: markdown
- Final artifact path after merge: tests/spec-derived-tests.md
- Type contracts: test-suite

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
    "id": "finding-misses-problem-low-overlap",
    "type": "finding",
    "title": "Problem, goals, and tests have weak lexical overlap",
    "text": "Problem-goal overlap 0.11, problem-test overlap 0.08. Low overlap is not proof of failure, but it is a good prompt to link goals and tests explicitly.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md"
    }
  }
]
```

Source Markdown blocks:
```json
[]
```
