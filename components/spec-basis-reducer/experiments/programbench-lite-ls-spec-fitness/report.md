# ProgramBench-Lite `ls` Spec Fitness Pilot Report

Date: 2026-05-07

## Question

Can spec quality discriminate downstream implementation fitness on a more real
programming-benchmark-shaped task?

This pilot uses a bounded `ls` reconstruction task because `ls` is a mature,
widely implemented command with stable behavior expectations. The fixture is not
full GNU or POSIX `ls`; it is a portable subset.

## Conditions

- `good-spec.md`: fully specifies a POSIX-like subset, including output layout,
  sorting, hidden-file semantics, indicators, recursive traversal, operand
  grouping, and errors.
- `suboptimal-spec.md`: technically correct and familiar, but relies on "usual
  ls style" and leaves output layout, exact sorting, diagnostic strings, and
  several edge policies implicit.
- `bad-spec.md`: vague purpose and common options, with less behavioral
  structure.

## Pilot Method

- 3 workers received only `good-spec.md`
- 3 workers received only `suboptimal-spec.md`
- 3 workers received only `bad-spec.md`
- each wrote a Node.js CLI to `/private/tmp/basis-ls-spec-fitness/runs/<condition>-NN/solution.mjs`
- `evaluator.mjs` created hidden filesystem trees and checked stdout, stderr,
  exit status, source-policy compliance, and behavior buckets

Score vector:

- source policy
- interface
- listing
- hidden names
- indicators
- operands
- recursion
- errors

## Result

Raw result:

- `results/pilot-2026-05-07.json`

Distribution:

| condition | n | mean | median | min | max |
| --- | ---: | ---: | ---: | ---: | ---: |
| good | 3 | 1.0 | 1.0 | 1.0 | 1.0 |
| suboptimal | 3 | 0.468 | 0.5583 | 0.2875 | 0.5583 |
| bad | 3 | 0.418 | 0.4083 | 0.2875 | 0.5583 |

## Interpretation

The pilot strongly separates fully specified `ls` behavior from underspecified
behavior. Every good-spec build passed all hidden cases.

The pilot does **not** yet clearly separate the technically correct suboptimal
spec from the vague bad spec. Their score ranges overlap:

- suboptimal max: `0.5583`
- bad max: `0.5583`
- suboptimal min: `0.2875`
- bad min: `0.2875`

That is an important result. The current evaluator can discriminate "good
operational spec" from "not enough operational semantics." It cannot yet
reliably discriminate "technically correct but suboptimal" from "vague" on this
sample size and hidden case set.

## Observed Failure Shape

Most non-good failures were not about knowing what `ls` is. They were about
unspecified operational choices:

- one-column output vs multi-column output
- code-point sorting vs locale or default JavaScript sorting assumptions
- exact diagnostic strings
- `-A` support
- whether recursive directory operands print root headers
- whether hidden recursive directories are traversed

This supports the Basis framing: mature purpose alone is not enough. The spec
must name the projection-relevant choices that downstream implementation would
otherwise invent.

## Next Step

To test "technically correct but suboptimal" more sharply, the middle condition
should be changed from merely familiar prose into a spec that is internally
correct but structurally bad:

- scatter requirements across sections
- duplicate and restate rules
- mix normative and explanatory text
- specify examples but omit general rules
- include correct but low-signal background
- bury edge cases in prose rather than tables

Then evaluate whether agents with that spec produce lower-fitness builds than
agents with the compact explicit spec, despite both specs being technically
true.

## Follow-Up: Suboptimal V2

I then added `suboptimal-v2-spec.md`, a technically correct but worse organized
spec. It preserved the needed facts but moved them into a more prose-heavy,
example-driven structure.

Raw result:

- `results/suboptimal-v2-pilot-2026-05-07.json`

Distribution:

| condition | n | mean | median | min | max |
| --- | ---: | ---: | ---: | ---: | ---: |
| good | 3 | 1.0 | 1.0 | 1.0 | 1.0 |
| suboptimal-v2 | 3 | 1.0 | 1.0 | 1.0 | 1.0 |

This follow-up did **not** discriminate. The worse-organized but technically
complete spec produced the same hidden-test fitness as the compact good spec in
this small pilot.

That narrows the claim:

- Explicit operational facts discriminate strongly against vague specs.
- Current hidden behavioral tests do not detect spec organization quality when
  the needed operational facts are still present.

To discriminate technically correct but suboptimal specs, the evaluation needs a
second objective beyond final program behavior, such as implementation time,
number of repair iterations, context-token load, rate of first-pass success
under lower-capability agents, or robustness under spec perturbation.

## Follow-Up: Bad Style Catalog Pilot

I then generated five technically correct but stylistically degraded specs from
`bad-spec-style-catalog.md`:

- `badstyle-entangled-spec.md`
- `badstyle-scattered-edge-cases-spec.md`
- `badstyle-cross-reference-maze-spec.md`
- `badstyle-nontechnical-metaphor-spec.md`
- `badstyle-verbose-redundant-spec.md`

The first pass ran two builder agents per style. It produced this distribution:

| condition | n | mean | median | min | max |
| --- | ---: | ---: | ---: | ---: | ---: |
| entangled | 2 | 0.85 | 0.85 | 0.85 | 0.85 |
| scattered edge cases | 2 | 1.0 | 1.0 | 1.0 | 1.0 |
| cross-reference maze | 2 | 0.85 | 0.85 | 0.85 | 0.85 |
| nontechnical metaphor | 2 | 0.85 | 0.85 | 0.85 | 0.85 |
| verbose redundant | 2 | 0.85 | 0.85 | 0.85 | 0.85 |

That result was not clean evidence against the styles themselves. It exposed a
spec defect: four degraded specs failed to operationally anchor the recursive
single-directory header rule. Builders consistently omitted the initial
`<operand>:` header for `-R dir`.

I corrected those degraded specs to state that rule explicitly while preserving
their bad organization/style, then ran one fresh builder per style.

Corrected pass:

| condition | n | score |
| --- | ---: | ---: |
| entangled | 1 | 1.0 |
| scattered edge cases | 1 | 1.0 |
| cross-reference maze | 1 | 1.0 |
| nontechnical metaphor | 1 | 1.0 |
| verbose redundant | 1 | 0.9625 |

Raw summarized result:

- `results/style-pilot-2026-05-08.json`

The corrected behavioral result mostly collapses back to perfect. This supports
the narrower claim from `suboptimal-v2`: for this small `ls-lite` task, strong
agents can recover correct behavior from ugly-but-complete specs.

However, a crude process proxy moved:

| condition group | solution line counts | mean lines |
| --- | --- | ---: |
| prior good spec | 195, 190, 187 | 190.7 |
| prior suboptimal-v2 spec | 185, 170, 206 | 187.0 |
| first bad-style pass | 257, 212, 240, 258, 295, 264, 254, 186, 275, 276 | 251.7 |
| corrected bad-style pass | 277, 326, 267, 274, 291 | 287.0 |

So the best current hypothesis is:

- final hidden behavior catches missing operational facts
- reduction is useful for finding those missing or weakly anchored facts
- technically correct bad specs may primarily degrade process cost rather than
  final behavior under strong agents

The next experiment should make process cost first-class: elapsed time, solution
size, edit attempts, self-check count, ambiguity questions, and weaker-agent
variance.
