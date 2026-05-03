You are executing reverse Spec Gym projection `architecture-to-spec`: Architecture Document To Spec Draft.

Training round: round-002

Source artifact contract:
- Read the intermediate artifact produced by `aws-architecture`.
- Intermediate artifact path: architecture.md
- Use only that intermediate artifact content for reconstruction.
- Do not use the original spec content; the judge handles comparison later.

Reverse projection instructions:
# Architecture Document To Spec Draft

Infer a reviewable `spec.md` draft from an architecture document.

The projection should preserve architecture sections, source anchors, open
questions, assumptions, and unsupported mappings. It should reconstruct
problem, goals, requirements, components, dependencies, validation, risks, and
open questions only when they are supported by the architecture source. It must
mark inferred product intent explicitly.

Output contract:
- Format: markdown
- Final artifact path after merge: spec-draft.md
- Type contracts: spec-draft

Rules:
- Preserve source anchors from the intermediate artifact when present.
- Mark inferred product intent explicitly.
- Carry assumptions and open questions forward instead of collapsing them into certainty.
- Return only the reverse projection artifact content.
