# L3 Good Spec: Uxn Memory And Control

Build on L2. L3 adds memory and control-flow opcodes.

## Memory

Implement byte and short variants through the mode system:

- `0x10 LDZ`: pop zero-page byte address, push memory at `addr`
- `0x11 STZ`: pop zero-page byte address, pop value, store value at `addr`
- `0x12 LDR`: pop signed relative byte, push memory at `PC + rel`
- `0x13 STR`: pop signed relative byte, pop value, store at `PC + rel`
- `0x14 LDA`: pop absolute short address, push memory at `addr`
- `0x15 STA`: pop absolute short address, pop value, store at `addr`

Short mode loads or stores two bytes in big-endian order.

Relative offsets are signed 8-bit values. The `PC` used by relative memory and
jump operations is the program counter after reading the opcode.

## Control Flow

Implement:

- `0x0c JMP`: byte mode jumps by signed relative byte; short mode jumps to
  absolute address
- `0x0d JCN`: pop condition and address; jump only when condition is non-zero
- `0x0e JSR`: push return address to return stack, then jump like `JMP`
- `0x0f STH`: move value from working stack to return stack; in return mode,
  move from return stack to working stack

The return address for `JSR` is the `PC` after the opcode.

At L3, `eval` must stop on `BRK` or when `maxCycles` is exceeded.
