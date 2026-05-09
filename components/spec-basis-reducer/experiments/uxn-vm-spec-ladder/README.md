# Uxn VM Spec Ladder Experiment

Date: 2026-05-08

Purpose: test whether spec quality remains discriminative as the target grows
from a tiny stack-machine core into a real VM boundary with devices.

This experiment follows the `ls-lite` result: final hidden behavior may not
separate technically correct bad specs on a small task, so the next benchmark
needs a ladder of increasing semantic complexity and explicit process-cost
signals.

Uxn is a good target because it is:

- small enough to rebuild in a single file
- real enough to have existing implementations and ROMs
- layered: stack core, opcode modes, memory/control flow, devices, Varvara
- precise enough for hidden byte-level tests

The first executable gate is a headless JavaScript VM API. It does not ask for a
graphical emulator or a full Varvara host yet.

## Candidate Contract

Each builder writes a Node.js ES module `solution.mjs`.

The evaluator imports it and expects:

```js
export function createUxn(options = {}) { ... }
```

`createUxn(options)` returns an object with:

- `ram`: `Uint8Array` of length `65536`
- `dev`: `Uint8Array` of length `256`
- `load(bytes, offset = 0x0100)`: copy ROM bytes into RAM
- `eval(pc = 0x0100, maxCycles = 100000)`: run until `BRK` or cycle limit
- `stack(name = "wst")`: return working or return stack bytes bottom-to-top

`options.dei(addr, vm)` may return a byte for `DEI`.
`options.deo(addr, value, vm)` may observe device writes for `DEO`.

## Complexity Ladder

| level | target | main risk |
| --- | --- | --- |
| L0 | minimal stack smoke | implements only examples, not VM shape |
| L1 | byte core | wrong operand order or arithmetic edge cases |
| L2 | modes | misreads `2`, `k`, `r`, and immediate opcodes |
| L3 | memory and control flow | PC-relative offsets, absolute vs relative, stack effects |
| L4 | device boundary | `DEI`/`DEO` direction, device page ownership, console/system ports |
| L5 | headless Varvara program smoke | ROMs using console/system ports and subroutines |

## Files

- `evaluator.mjs`: hidden-style evaluator for L0-L4 raw ROM cases
- `specs/l0-good-stack-smoke.md`: minimal stack smoke spec
- `specs/l1-good-byte-core.md`: byte opcode core spec
- `specs/l2-good-modes.md`: mode semantics spec
- `specs/l3-good-memory-control.md`: memory and control-flow spec
- `specs/l4-good-devices.md`: device boundary spec
- `specs/l5-good-varvara-program-smoke.md`: headless Varvara program spec
- `specs/ladder-bad-style-plan.md`: bad-spec transformations to apply per level
- `sources.md`: Uxn/Varvara source notes used to shape the fixture

## Intended Measurement

For each level and condition:

- final hidden behavior score
- first-pass perfect rate
- solution size
- elapsed build time
- number of self-check attempts
- repair iterations if the worker is allowed to revise
- failure bucket distribution

The first run should be small: one good spec and one degraded spec per level,
two builders each, then scale only the levels that separate.
