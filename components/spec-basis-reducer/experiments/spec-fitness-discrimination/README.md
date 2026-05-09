# Spec Fitness Discrimination Experiment

Hypothesis: a spec with explicit projection targets, invariants, edge cases,
and falsifiable scoring rules should produce higher-fitness builds than a vague
spec with the same purpose.

This experiment uses one build target and two specs:

- `good-spec.md`: explicit contract and deterministic scoring semantics
- `bad-spec.md`: same purpose and interface, but underspecified behavior

Builder agents receive only one spec and the directive to build it. They write a
single JavaScript module exporting `rankTickets(tickets, nowIso)`.

The evaluator in `evaluator.mjs` runs hidden cases against each build and emits a
score vector:

- interface
- scoring
- ordering
- reasons
- validation
- purity

The expected signal is not that every good-spec build passes. The signal is that
the good-spec distribution should separate from the bad-spec distribution. If
the distributions do not separate, these spec attributes are not discriminating
for this task.
