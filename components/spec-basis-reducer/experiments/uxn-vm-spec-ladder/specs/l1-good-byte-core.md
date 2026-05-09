# L1 Good Spec: Uxn Byte Core

Build on the L0 contract. The VM still exposes:

```js
export function createUxn(options = {}) { ... }
```

L1 implements byte-mode stack, comparison, arithmetic, and bitwise opcodes. It
does not require short mode, keep mode, return mode, memory opcodes, jumps, or
devices.

## Byte Opcodes Required

Stack:

- `0x00 BRK`
- `0x01 INC`: `a -- a+1`
- `0x02 POP`: `a --`
- `0x03 NIP`: `a b -- b`
- `0x04 SWP`: `a b -- b a`
- `0x05 ROT`: `a b c -- b c a`
- `0x06 DUP`: `a -- a a`
- `0x07 OVR`: `a b -- a b a`
- `0x80 LIT`: push next byte

Logic:

- `0x08 EQU`: `a b -- 1 if a == b else 0`
- `0x09 NEQ`: `a b -- 1 if a != b else 0`
- `0x0a GTH`: `a b -- 1 if a > b else 0`
- `0x0b LTH`: `a b -- 1 if a < b else 0`

Arithmetic:

- `0x18 ADD`: `(a + b) & 0xff`
- `0x19 SUB`: `(a - b) & 0xff`
- `0x1a MUL`: `(a * b) & 0xff`
- `0x1b DIV`: integer `a / b`, rounded toward zero; if `b == 0`, push `0`

Bitwise:

- `0x1c AND`
- `0x1d ORA`
- `0x1e EOR`
- `0x1f SFT`: pop shift byte `s`, then value `a`; first shift `a` right by
  `s & 0x0f`, then shift left by `(s >> 4) & 0x0f`; mask to one byte

All arithmetic wraps to one byte.
