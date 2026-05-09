# Uxn Ladder Bad-Style Plan

The `ls-lite` experiment showed that technically correct bad specs may pass
final behavior tests under strong agents. Uxn lets us retry that claim across
increasing semantic load.

For each level, generate at least these conditions:

1. `good`: compact operational spec
2. `entangled`: independent obligations fused into dense paragraphs
3. `scattered`: edge cases delayed into late notes
4. `crossref`: numbered clauses with heavy back-references
5. `metaphor`: non-technical naming around still-correct facts
6. `verbose`: redundant restatement with equivalent facts

## Level-Specific Badness

L0 can only test simple omission. It is too small for process-cost claims.

L1 should stress operand order and arithmetic edge cases:

- `a b -- result` stack notation
- division by zero
- `SFT` nibble order
- byte wraparound

L2 should stress mode interactions:

- short byte order
- keep-mode stack restoration
- return-mode stack selection
- immediate opcodes as special cases of base `0x00`

L3 should stress projection pressure:

- PC after opcode vs PC before opcode
- signed byte relative offsets
- absolute jump in short mode
- memory load/store value/address pop order
- `JSR` return address

L4 should stress adapter boundaries:

- whether `DEI` reads before or after hook
- whether `DEO` writes `dev` before calling hook
- short device writes order
- console write vs error port
- system state termination as projection, not CPU semantics

L5 is now headless Varvara program smoke: raw ROM byte programs using console,
system state, and subroutine behavior.

L6 should use broader real ROMs only after L0-L5 are stable. Candidate ROM
classes:

- console echo
- system state exit
- screen sprite smoke
- datetime read
- small public example ROMs from the Uxn/Varvara ecosystem

## Acceptance For Next Run

Do not run a 60-agent sweep first. Run:

- L0-L5
- good vs one bad style per level
- two builders per condition

Then scale only levels where either behavior score or process cost separates.
