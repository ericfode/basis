# L5 Bad Style Spec: Varvara Program Smoke In Folk Terms

Use this with the L0-L4 specs. This level asks the little Uxn machine to behave
like a headless Varvara guest for a few tiny programs. There is no screen, no
sound, no files, no clock, no mouse, and no controller. The machine only needs a
mouth and a status lamp.

The mouth has two slots:

- slot `0x18` says a normal console byte
- slot `0x19` says an error console byte

The status lamp is slot `0x0f`. A program may put `0x80` there to mean success
or `0x01` there to mean failure. The lamp does not have to stop time by itself
in this test; the tiny programs also end with `BRK`.

When a program uses `DEO` to speak or set the lamp, the machine must first place
the byte into `vm.dev[slot]`, then let the host hear it by calling
`options.deo(slot, byte, vm)`. This order matters because the host may inspect
the device page when the call happens.

The tested programs are raw ROM bytes loaded at `0x0100`. They will:

- say two normal console bytes
- say one error console byte
- set the status lamp
- call a small subroutine with `JSR2`
- return with `JMP2r`

If L0-L4 are implemented correctly, this level should mostly be about preserving
the device-write order while running a real ROM-shaped byte sequence.
