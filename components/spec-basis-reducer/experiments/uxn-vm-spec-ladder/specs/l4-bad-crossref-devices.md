# L4 Bad Style Spec: Cross-Referenced Device Boundary

Use this with the L0-L3 specs. The numbered references are part of the document;
do not ignore late clauses.

## 1. Device Page

1.1. The VM owns `dev`, a `Uint8Array(256)`.

1.2. The host may provide `options.dei(addr, vm)` and
`options.deo(addr, value, vm)`.

1.3. Missing hooks are valid.

## 2. Device Input

2.1. `DEI` is base opcode `0x16`.

2.2. It consumes a device address byte from the active source stack defined by
the mode rules.

2.3. If the host provided `options.dei`, the byte returned by that hook is the
input value.

2.4. If no hook is present, the input value is `dev[addr]`.

2.5. The input value is pushed to the same active source stack.

2.6. `DEI2` follows 2.2-2.5 twice: first at `addr`, then at `(addr + 1) & 0xff`,
and pushes the two bytes as a short.

## 3. Device Output

3.1. `DEO` is base opcode `0x17`.

3.2. It consumes a device address byte and a value from the active source stack.

3.3. The value is written into `dev[addr]`.

3.4. After 3.3, call `options.deo(addr, value, vm)` if the hook exists.

3.5. `DEO2` writes the high byte to `addr`, then the low byte to
`(addr + 1) & 0xff`.

3.6. Each byte written by `DEO2` follows 3.3 and 3.4 in order.

## 4. Observable Ports

4.1. The evaluator observes system state at `0x0f`.

4.2. The evaluator observes console write at `0x18`.

4.3. The evaluator observes console error at `0x19`.

4.4. No screen, audio, file, datetime, controller, or mouse behavior is required
for L4.

## 5. Ordering Rule

5.1. If a hook reads `vm.dev`, it must see the post-write value for `DEO`.

5.2. If a hook records writes, `DEO2` must produce two records in high-byte then
low-byte order.
