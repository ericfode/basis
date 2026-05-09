# Spec Fitness Discrimination Report

Date: 2026-05-07

## Question

Can spec quality attributes discriminate downstream build quality?

The tested claim was narrow: if two specs name the same artifact, but one spec
has explicit projection targets, edge cases, invariants, validation behavior,
and scoring semantics while the other keeps those points vague, then independent
builders given only the better spec should produce builds with higher measured
fitness.

## Method

Artifact target:

- JavaScript ES module exporting `rankTickets(tickets, nowIso)`

Conditions:

- `good-spec.md`: explicit interface, input schema, scoring formula, ordering
  rules, reason requirements, validation behavior, purity requirement
- `bad-spec.md`: same purpose and export, but vague scoring, ordering, reasons,
  and validation rules

Execution:

- 10 independent workers received only `good-spec.md`
- 10 independent workers received only `bad-spec.md`
- Workers wrote outputs under `/private/tmp/basis-spec-fitness-discrimination/runs`
- The deterministic evaluator in `evaluator.mjs` ran hidden cases and emitted a
  score vector

Score vector:

- interface
- scoring
- ordering
- reasons
- validation
- purity

## Result

Saved raw result:

- `results/run-2026-05-07.json`

Distribution:

| condition | n | mean | median | min | max |
| --- | ---: | ---: | ---: | ---: | ---: |
| good | 10 | 0.9375 | 1.0 | 0.8 | 1.0 |
| bad | 10 | 0.2775 | 0.25 | 0.25 | 0.35 |

The two conditions separated completely in this first pass:

- lowest good-spec score: `0.8`
- highest bad-spec score: `0.35`

## Interpretation

The hypothesis survived this narrow test. For this build target, the attributes
we called "good spec" attributes were discriminative: independent builders using
the explicit spec produced substantially fitter builds than builders using the
vague spec.

The result should be read as evidence for an operational point:

> A spec becomes usable as a fitness function when it names enough executable
> semantics that builders can converge without guessing hidden evaluator policy.

It should not be overread as a general proof that the chosen good-spec template
is sufficient across domains.

## Caveats

- The evaluator intentionally checked semantics made explicit by the good spec.
  That is correct for testing operationalization, but it means the experiment
  favors specs that expose evaluator-relevant details.
- The target was small and deterministic.
- The builders were all from the same agent family, so this does not test
  cross-model or human implementation variance.
- The bad spec still named an interface, so even weak specs scored interface and
  purity points.

## Next Stronger Test

Run the same design across several domains where the hidden evaluator checks
purpose-level behavior rather than a literal formula:

- parser normalization
- UI state reducer
- schema migration planner
- small scheduling policy
- proof-obligation generator

Then test whether spec attributes predict fitness across domains instead of
only on this ticket-ranking fixture.
