# L4 Good Spec: Uxn Device Boundary

Build on L3. L4 adds the Uxn device page and `DEI` / `DEO`.

## Device Page

The VM has `dev`, a `Uint8Array(256)`.

`createUxn(options)` accepts:

```js
{
  dei(addr, vm) { return byte; },
  deo(addr, value, vm) { ... }
}
```

Both hooks are optional.

## Opcodes

- `0x16 DEI`: pop device address byte, read one byte from the device page or
  `options.dei`, push the byte
- `0x17 DEO`: pop device address byte, pop value, write value to `dev[addr]`,
  then call `options.deo(addr, value, vm)` if present

Short mode for `DEI2` reads two consecutive device bytes and pushes a short.
Short mode for `DEO2` writes high byte to `addr`, then low byte to `addr + 1`
with byte wrapping.

## Minimal Varvara Ports For This Level

The evaluator treats these as observable ports:

- system state: `0x0f`
- console write: `0x18`
- console error: `0x19`

No screen, audio, file, datetime, controller, or mouse behavior is required at
L4. Those belong to L5.
