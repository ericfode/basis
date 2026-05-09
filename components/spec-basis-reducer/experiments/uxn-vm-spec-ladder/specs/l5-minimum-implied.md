# L5 Minimum Implied Spec: Uxn Headless Core

Build a Node.js ES module `solution.mjs` exposing:

```js
export function createUxn(options = {}) { ... }
```

The returned VM has:

- `ram`: `Uint8Array(65536)`
- `dev`: `Uint8Array(256)`
- `load(bytes, offset = 0x0100)`: copy bytes into RAM
- `eval(pc = 0x0100, maxCycles = 100000)`: execute until `BRK` or cycle limit
- `stack(name = "wst")`: return working or return stack bytes bottom-to-top

No external packages. No host command delegation.

## Core Model

Uxn is a no-register, two-stack, 16-bit-address VM. RAM addresses wrap at
`0xffff`. Device addresses wrap at `0xff`. Stack values are bytes unless short
mode is active. Shorts are represented on stacks and in memory as high byte then
low byte.

For stack effects, the rightmost item is top of stack: `a b -- c` pops `b`,
then `a`, and pushes `c`.

Instruction decoding:

- `base = opcode & 0x1f`
- `short = opcode & 0x20`
- `return = opcode & 0x40`
- `keep = opcode & 0x80`

The return bit selects the return stack instead of the working stack. Keep mode
computes from the selected stack without consuming its operands, then appends
the result. `STH` is directional: normal moves working to return; return mode
moves return to working.

`0x00` is `BRK`. `base == 0` with mode bits is the literal family:

- `0x80 LIT`: push next byte to working stack
- `0xa0 LIT2`: push next two bytes to working stack as a short
- `0xc0 LITr`: push next byte to return stack
- `0xe0 LIT2r`: push next two bytes to return stack as a short

`LIT*` advances PC past immediate bytes.

## Opcode Table

| base | name | byte meaning |
| --- | --- | --- |
| `00` | BRK/LIT* | stop if exactly `00`; otherwise literal family |
| `01` | INC | `a -- a+1` |
| `02` | POP | `a --` |
| `03` | NIP | `a b -- b` |
| `04` | SWP | `a b -- b a` |
| `05` | ROT | `a b c -- b c a` |
| `06` | DUP | `a -- a a` |
| `07` | OVR | `a b -- a b a` |
| `08` | EQU | `a b -- a==b` |
| `09` | NEQ | `a b -- a!=b` |
| `0a` | GTH | `a b -- a>b` |
| `0b` | LTH | `a b -- a<b` |
| `0c` | JMP | byte: signed relative jump; short: absolute jump |
| `0d` | JCN | `cond addr --`; jump when `cond != 0` |
| `0e` | JSR | push post-op PC to return stack, then jump |
| `0f` | STH | move one value between stacks |
| `10` | LDZ | `addr8 -- ram[addr8]` |
| `11` | STZ | `value addr8 --` |
| `12` | LDR | `rel8 -- ram[post-op PC + signed(rel8)]` |
| `13` | STR | `value rel8 --` |
| `14` | LDA | `addr16 -- ram[addr16]` |
| `15` | STA | `value addr16 --` |
| `16` | DEI | `addr8 -- dev byte` |
| `17` | DEO | `value addr8 --` |
| `18` | ADD | `a b -- a+b` |
| `19` | SUB | `a b -- a-b` |
| `1a` | MUL | `a b -- a*b` |
| `1b` | DIV | `a b -- a/b`, zero when `b == 0` |
| `1c` | AND | `a b -- a&b` |
| `1d` | ORA | `a b -- a|b` |
| `1e` | EOR | `a b -- a^b` |
| `1f` | SFT | `a s -- (a >> (s & 0x0f)) << (s >> 4)` |

Arithmetic, bitwise, comparison, loads, stores, and stack effects generalize
under short mode. Byte results mask to `0xff`; short results mask to `0xffff`.
`DIV` rounds toward zero.

Relative offsets are signed bytes. Relative operations use the PC after reading
the opcode byte. `JSR` stores that same post-op PC as the return address.

`DEI` reads from `options.dei(addr, vm)` when present, otherwise `dev[addr]`.
`DEO` first writes `dev[addr] = value`, then calls
`options.deo(addr, value, vm)` when present. `DEI2` / `DEO2` use consecutive
device bytes, high byte first, wrapping the second address.

Headless Varvara ports used here:

- system state: `0x0f`
- console write: `0x18`
- console error: `0x19`

Writing system state does not itself have to stop execution; ROMs still use
`BRK`.
