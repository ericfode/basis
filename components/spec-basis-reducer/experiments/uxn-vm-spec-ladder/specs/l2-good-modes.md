# L2 Good Spec: Uxn Modes

Build on L1. L2 adds Uxn mode flags.

Every non-`BRK` base opcode uses these mode bits:

- `0x20`: short mode, operating on 16-bit values
- `0x40`: return mode, operating on the return stack instead of working stack
- `0x80`: keep mode, leaving consumed operands on the source stack

The base opcode is `opcode & 0x1f`.

Exception: opcodes with base `0x00` and mode bits are immediate opcodes:

- `0x80 LIT`: push next byte to the selected stack
- `0xa0 LIT2`: push next two bytes to the selected stack
- `0xc0 LITr`: push next byte to return stack
- `0xe0 LIT2r`: push next two bytes to return stack

`LIT` always behaves as if keep mode is set, because it consumes no stack item.

## Short Values

Shorts are stored on stacks as high byte then low byte. Pushing `0x1234` appends
`0x12`, then `0x34`. Popping a short removes low byte then high byte and forms
`0x1234`.

## Keep Mode

Keep mode computes using operands from the source stack but restores the source
stack before pushing results. Example:

```text
LIT 02 LIT 5d ADDk BRK
```

leaves `[0x02, 0x5d, 0x5f]` on the working stack.

## Return Mode

Return mode swaps the source stack for the opcode. For normal operations it
operates on the return stack. For `STH`, return mode moves from return stack to
working stack.

Required L2 coverage includes:

- `LIT2`
- short arithmetic such as `ADD2`
- keep mode such as `ADDk`
- return-stack literal and stash movement such as `LITr` followed by `STHr`
