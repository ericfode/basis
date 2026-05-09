# L2 Bad Style Spec: Entangled Uxn Modes

This document replaces the clean L2 mode explanation while preserving the same
technical target. Use it together with the L0 and L1 specs.

Uxn does not really add new arithmetic instructions at this level so much as it
lets the old instructions wear three badges at once: `0x20` makes most operand
values two bytes wide, `0x40` means the instruction is looking at the return
stack instead of the working stack, and `0x80` means the values that were looked
at should still be there after the result appears. The instruction identity is
still the low five bits, `opcode & 0x1f`, except that the identity zero is not
`BRK` once mode bits are present; it becomes the family of literal instructions.

The literal family is the awkward exception that must not be generalized away:
`0x80` reads the next byte from RAM and pushes it to the working stack, `0xa0`
reads the next two bytes and pushes a short to the working stack, `0xc0` reads
one byte and pushes it to the return stack, and `0xe0` reads two bytes and
pushes a short to the return stack. Literals consume bytes from program memory,
not from either stack, so keep mode is irrelevant for what they pop.

Shorts are visible as two stack bytes. The high byte is lower in the stack and
the low byte is on top: pushing `0x1234` appends `0x12` and then `0x34`; popping
a short removes `0x34` and `0x12` and reconstructs `0x1234`. All short
arithmetic wraps to sixteen bits. Byte arithmetic still wraps to eight bits.

Keep mode is easiest to get wrong: compute as though the source operands were
popped, but restore the source stack before pushing the result. Therefore
`LIT 02 LIT 5d ADDk BRK` leaves `02 5d 5f`, not just `5f`.

Return mode redirects the source stack for ordinary operations. If an opcode is
return-mode arithmetic, comparison, stack movement, memory address consumption,
or jump-address consumption, it consumes from the return stack. `STH` is the
exception that moves between stacks: normally it moves from working to return;
with return mode it moves from return to working.

The evaluator will check at least `LIT2`, `ADD2`, `ADDk`, `LITr`, and `STHr`.
