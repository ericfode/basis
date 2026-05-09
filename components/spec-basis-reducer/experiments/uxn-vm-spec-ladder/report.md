# Uxn VM Spec Ladder Pilot Report

Date: 2026-05-08

## Question

Can spec-fitness discrimination be tested across a ladder of real VM complexity
rather than a single small CLI task?

The target is Uxn because it is small, implemented many times, byte-testable,
and naturally layered: stack core, byte opcodes, mode bits, memory/control flow,
device boundary, then Varvara ROM compatibility.

## Fixture

The first fixture is headless. It asks builders to expose:

```js
export function createUxn(options = {}) { ... }
```

The evaluator imports the module and runs raw ROM byte sequences against the VM.
It checks stack contents, RAM writes, device writes, and per-level behavior.

Levels:

| level | cases | surface |
| --- | ---: | --- |
| L0 | 3 | minimal stack smoke |
| L1 | 4 more | byte core |
| L2 | 4 more | short/keep/return modes |
| L3 | 4 more | memory and control flow |
| L4 | 3 more | device boundary |
| L5 | 3 more | headless Varvara program smoke |

## Oracle Check

I wrote a local oracle implementation at `/private/tmp/uxn-ladder-oracle-solution.mjs`
and used it to validate the evaluator.

Oracle result after adding L5: `21/21`.

## Good-Spec Baseline

One builder was run per level. Each builder received only the specs up to that
level, and each solution was scored only up to that level.

Raw result:

- `results/good-ladder-pilot-2026-05-08.json`

Distribution:

| level | score | solution lines |
| --- | ---: | ---: |
| L0 | 1.0 | 78 |
| L1 | 1.0 | 193 |
| L2 | 1.0 | 231 |
| L3 | 1.0 | 335 |
| L4 | 1.0 | 362 |
| L5 | 1.0 | 342 |

## Interpretation

The good spec ladder is green through L5. That matters because it means the
fixture is not too hard for the agent pool when the spec is clean.

## Degraded-Spec Pilot

I added degraded overlays for the complex levels:

- L2: entangled mode bits
- L3: scattered PC-relative and value/address rules
- L4: cross-referenced device boundary
- L5: non-technical Varvara program wording

One builder ran per degraded level and each solution was scored only up to that
level.

Raw result:

- `results/degraded-ladder-pilot-2026-05-08.json`

Distribution:

| condition | score | lines | clean-level lines |
| --- | ---: | ---: | ---: |
| L2 entangled modes | 1.0 | 239 | 231 |
| L3 scattered memory/control | 1.0 | 328 | 335 |
| L4 crossref devices | 1.0 | 372 | 362 |
| L5 metaphor Varvara programs | 1.0 | 400 | 342 |

The degraded overlays did not separate final behavior in this single-builder
pilot. The strongest process-cost movement was L5: `400` lines for the degraded
program-level spec versus `342` for clean L5.

## Minimum-Implied L5 Spec

I then added `specs/l5-minimum-implied.md`, a compact Uxn/Varvara spec where
most examples and step-by-step explanation are removed. It keeps the operational
facts but relies on stack-effect notation, mode-bit generalization, and a dense
opcode table.

To reduce accidental context leakage, the worker received only a temporary copy
of the spec at `/private/tmp/uxn-minimum-implied-spec.md` and wrote to a fresh
output directory. This is better isolated than the previous run, but not a
formal sandbox because the evaluator still existed in the parent repo.

Raw result:

- `results/minimum-implied-l5-2026-05-08.json`

Outcome:

| condition | score | lines |
| --- | ---: | ---: |
| clean L5 | 1.0 | 342 |
| degraded metaphor L5 | 1.0 | 400 |
| minimum-implied L5 | 1.0 | 408 |

No obvious leakage strings were found in the minimum-implied solution.

Interpretation: the current L5 evaluator still passes when many details are
implied, provided the compact semantic table is accurate. But the process proxy
gets worse, not better: the builder wrote `408` lines.

If final behavior stays green in a larger run, process-cost metrics become the
target:

- solution size
- elapsed time
- first-pass perfect rate
- repair count
- failure bucket distribution

## Boundary

This is not yet full Varvara compatibility. L5 should add real ROM-driven tests
only after the L0-L4 ladder has enough signal.
