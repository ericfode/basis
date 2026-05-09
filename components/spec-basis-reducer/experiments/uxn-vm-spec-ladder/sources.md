# Uxn Ladder Source Notes

Date: 2026-05-08

This file records the prior art used to shape the first Uxn VM ladder fixture.
It is not accepted Basis state; it is source/provenance for this experiment.

## Sources

- Uxn overview: <https://permacomputing.net/Uxn/>
  - Uxn is a simple stack VM with no registers.
  - It has RAM, devices, a program counter, a working stack, and a return stack.
  - The compact opcode summary makes it suitable for byte-level hidden tests.

- Uxntal opcode reference: <https://wiki.xxiivv.com/site/uxntal_reference.html>
  - The reference enumerates the 32 standard opcodes plus immediate forms.
  - It describes the `2`, `k`, and `r` modes and gives stack-effect examples.
  - It gives concrete examples for arithmetic, comparison, memory, jump, and
    device opcodes.

- Uxntal opcode overview: <https://wiki.xxiivv.com/site/uxntal_opcodes.html>
  - Useful for explaining the compact table, mode flags, and immediate opcodes
    to builders.

- Varvara device specification: <https://wiki.xxiivv.com/site/varvara.html>
  - Varvara is the device system around Uxn.
  - Device addresses include system at `0x00`, console at `0x10`, screen at
    `0x20`, audio at `0x30`, controller at `0x80`, mouse at `0x90`, file at
    `0xa0`, and datetime at `0xc0`.
  - Console write is port `0x18`; system state is port `0x0f`.

- Raven implementation notes: <https://www.mattkeeter.com/projects/raven/index.html>
  - Independent implementation notes confirm useful pitfalls for an evaluator:
    wrapping stack indexes, fixed RAM size, device trait boundaries, and `DEI` /
    `DEO` direction.

## Experiment Boundary

The first executable evaluator does not require a full graphical Varvara host.
It tests Uxn CPU behavior and a minimal device boundary with raw ROM bytes. L5
adds headless Varvara-style programs that use console/system ports and
subroutines, but still avoids screen, audio, file, mouse, controller, and
datetime integration.

Full graphical/audio/file ROM compatibility belongs after this headless L5. That
later level should wait until the L0-L5 evaluator proves it can distinguish spec
quality without turning into a platform-integration project.
