You are executing reverse Spec Gym projection `tests-to-spec`: Tests To Spec Draft.

Training round: round-001

Source artifact contract:
- Read the intermediate artifact produced by `spec-tests`.
- Intermediate artifact path: tests/spec-derived-tests.md
- Use only that intermediate artifact content for reconstruction.
- Do not use the original spec content; the judge handles comparison later.

Reverse projection instructions:
# Tests To Spec Draft

Infer a reviewable `spec.md` draft from focused tests or test-plan slices.

The projection should describe behavior proven by tests, behavior implied by
fixtures, explicit negative cases, missing product intent, and open questions.
It must distinguish observed test behavior from inferred requirements and keep
file, line, or case anchors.

Output contract:
- Format: markdown
- Final artifact path after merge: spec-draft.md
- Type contracts: spec-draft

Rules:
- Preserve source anchors from the intermediate artifact when present.
- Mark inferred product intent explicitly.
- Carry assumptions and open questions forward instead of collapsing them into certainty.
- Return only the reverse projection artifact content.
