# L0 Good Spec: Uxn Stack Smoke

Build `solution.mjs`, a Node.js ES module that exposes:

```js
export function createUxn(options = {}) { ... }
```

This level is a minimal Uxn-like execution core. It only needs enough behavior
to prove the API, program loading, working stack, and byte arithmetic path.

## Required VM Shape

`createUxn()` returns an object with:

- `ram`: `Uint8Array(65536)`
- `dev`: `Uint8Array(256)`
- `load(bytes, offset = 0x0100)`: copy bytes into `ram` beginning at `offset`
- `eval(pc = 0x0100, maxCycles = 100000)`: execute until `BRK`
- `stack(name = "wst")`: return working-stack bytes bottom-to-top

At L0, `stack("rst")` may return an empty array.

## L0 Opcodes

Implement these byte opcodes:

- `0x00 BRK`: stop evaluation
- `0x80 LIT`: push the next byte from RAM to the working stack and advance PC
- `0x01 INC`: pop byte `a`, push `(a + 1) & 0xff`
- `0x06 DUP`: pop byte `a`, push `a`, then `a`
- `0x18 ADD`: pop `b`, then `a`, push `(a + b) & 0xff`

The program counter starts at the `eval` argument. After reading an opcode, it
points to the next byte unless the opcode consumes immediate data.

Stack output order is bottom-to-top. If the stack contains `0x12` then `0x34`,
`stack("wst")` returns `[0x12, 0x34]`.
