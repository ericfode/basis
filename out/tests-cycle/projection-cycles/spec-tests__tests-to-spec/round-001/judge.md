You are judging Spec Gym projection cycle `spec-tests__tests-to-spec` for round-001.

Inputs the runner must attach:
- original dataified-spec.json
- original claim-lattice.json
- intermediate artifact from `spec-tests`: tests/spec-derived-tests.md
- returned spec draft from `tests-to-spec`: spec-draft.md
- regenerated dataified-spec.json from the returned spec draft
- regenerated claim-lattice.json from the returned spec draft

Judge task:
- Compare semantic coverage, not byte equality.
- Identify source anchors preserved, renamed, retired, lost, or invented.
- Identify claims lost, claims invented, and claims weakened.
- Identify assumptions or open questions that disappeared.
- Identify test or architecture facts that came back as unsupported spec certainty.
- Decide whether this round should be accepted for training data.

Return JSON only with fields:
`cycleId`, `roundId`, `acceptedForTraining`, `coverageScore`, `driftScore`, `lostAnchors`, `inventedClaims`, `weakenedClaims`, `collapsedUncertainty`, `notes`.
