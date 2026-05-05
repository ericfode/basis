# Gas-City Prior-Art Mapping

Status: implementation note

This note records what the live Spec Basis Reducer should borrow from
`/Users/ericfode/src/gas-city-but-its-just-codex`.

## Mapping

| Reducer need | Gas-city surface |
| --- | --- |
| Live reducer run | workflow instance |
| Root source read | initial worker node and app-server thread |
| Section manifest | shared-workspace artifact |
| Section reducer | claimed workflow node with app-server thread provenance |
| Thread fork tree | worker binding plus durable fork-topology record |
| Proposed records | shared-workspace entries or artifact payloads |
| Human intervention | typed workflow event, node mutation, or steer event |
| UI watch surface | operator projection over ledger state |

## Required Correction

The app-server is not the state model. It supplies execution containers.

The reducer needs a durable fork-topology record that binds parent thread, parent
turn, child thread, source snapshot, section job, inherited context, excluded
context, and merge policy. Without that record, the UI can show that work ran,
but not why a result is allowed to participate in synthesis.

That record is still only audit infrastructure. It does not prove that a
proposed `pivot`, `derived`, `redundant`, or `coupled` label is correct. Every
semantic record also needs a falsifiable witness: target projection, source
evidence, removal or derivation test, split rationale when applicable, and known
loss.

## Completion Test

A live implementation should pass this test:

1. Start from a full-spec root read.
2. Fork section reducers from the pre-split root context.
3. Record each fork in the durable run log.
4. Emit proposed records with source and fork provenance.
5. Attach falsifiable semantic witnesses to proposed records.
6. Synthesize only from records whose fork topology, source provenance, and
   semantic witness are inspectable.

If any step depends on raw chat history as authority, the design has collapsed
back into transcript management instead of Basis reduction.
