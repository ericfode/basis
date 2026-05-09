# L3 Bad Style Spec: Scattered Memory And Control Notes

Use this with the L0, L1, and L2 specs. It describes the L3 target, but its edge
rules are deliberately scattered.

## The Main Idea

Add memory access and control flow. The VM already has `ram`, stacks, literals,
byte operations, short mode, keep mode, and return mode. L3 makes programs able
to write RAM, read RAM, jump, call subroutines, and move values between the
working and return stacks.

## Memory Family

- `LDZ` (`0x10`) reads from zero page.
- `STZ` (`0x11`) writes to zero page.
- `LDR` (`0x12`) reads relative to the program counter.
- `STR` (`0x13`) writes relative to the program counter.
- `LDA` (`0x14`) reads from an absolute address.
- `STA` (`0x15`) writes to an absolute address.

Short mode means read or write two bytes in big-endian memory order. Byte mode
means read or write one byte.

## Control Family

- `JMP` (`0x0c`) changes the program counter.
- `JCN` (`0x0d`) changes the program counter only when its condition is nonzero.
- `JSR` (`0x0e`) saves a return address on the return stack, then jumps.
- `STH` (`0x0f`) moves values between stacks.

## Notes That Still Count

- For zero-page memory, the address is a byte popped from the active source
  stack.
- For absolute memory, the address is a short popped from the active source
  stack.
- For stores, the address is consumed and the value is also consumed; the stored
  value is the other operand. Do not leave either operand on the stack unless
  keep mode says to.
- Relative offsets are signed bytes in the range `-128..127`.
- Relative memory and relative jumps use the program counter after the opcode
  byte has been read.
- `JMP` in byte mode uses a signed relative byte. `JMP2` uses an absolute short.
- `JCN` consumes a condition byte and an address. The jump is taken only when
  the condition is not zero.
- `JSR` pushes the return address as a short to the return stack. The return
  address is the program counter after reading the `JSR` opcode.
- `STH` normally moves from working stack to return stack. `STHr` moves from
  return stack to working stack.
- `eval` stops on `BRK` or when `maxCycles` is exceeded.
