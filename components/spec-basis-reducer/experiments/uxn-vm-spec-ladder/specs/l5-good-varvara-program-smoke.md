# L5 Good Spec: Headless Varvara Program Smoke

Build on L4. L5 is still headless: no screen, audio, file, controller, mouse, or
datetime devices are required. It tests whether the VM can run small ROM
programs that use the Varvara console and system ports.

## Required Ports

Use the L4 `DEI` / `DEO` semantics.

Observable ports for L5:

- `0x18`: console write
- `0x19`: console error
- `0x0f`: system state

When `DEO` writes to these ports:

- update `vm.dev[addr]`
- call `options.deo(addr, value, vm)` after the byte has been written

The evaluator observes the hook calls.

## System State

A program may write `0x80` to system state (`0x0f`) to mark successful
termination, or `0x01` to mark failure. For this level, writing system state does
not need to stop the CPU immediately. The ROMs also contain `BRK`.

## Program Compatibility Required

The VM must correctly execute ROM byte programs that:

- write multiple bytes to console write
- write one byte to console error
- write system state
- call a subroutine with `JSR2`
- return from that subroutine with `JMP2r`

No assembler is required. The evaluator supplies ROM bytes directly and loads
them at `0x0100`.
