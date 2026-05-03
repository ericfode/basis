You are executing Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Output contract:
- Format: markdown
- Final artifact path after merge: projections/implementation-questions.md
- Type contracts: implementation-question

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
    "id": "finding-underspecified-vague-norms",
    "type": "finding",
    "title": "Normative claims contain vague qualifiers",
    "text": "Normative language with vague qualifiers needs defaults, measurable thresholds, or a named implementation-defined policy.",
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
