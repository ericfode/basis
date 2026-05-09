# Early Redis Spec Fitness Pilot Report

Date: 2026-05-08

## Question

Are the `ls-lite` and Uxn fixtures too simple for spec quality to matter?

This pilot moves to a server-shaped target: an early-Redis-compatible in-memory
TCP server with RESP2, strings, lists, expirations, pipelining, and simple
transactions.

## External Suite

The evaluator starts each candidate as:

```sh
REDIS_PORT=<port> node server.mjs
```

Then it connects with the real Python `redis` client package (`redis-py`
7.4.0). This is a stronger compatibility check than custom raw-socket tests
alone.

Buckets:

- connection
- strings
- integers
- expiry
- lists
- pipeline
- transaction
- meta

## Pilot

Two fresh builders were run after copying worker-visible specs to `/private/tmp`:

- clean operational spec
- minimum-implied spec

The first run exposed a spec/evaluator mismatch: `redis-py`'s `decr()` path used
`DECRBY`, while the spec named `DECR` but not `DECRBY`. I corrected the spec and
evaluator, then reran fresh builders.

Raw result:

- `results/pilot-2026-05-08.json`

Corrected run:

| condition | score | server lines | spec words |
| --- | ---: | ---: | ---: |
| good | 1.0 | 645 | 792 |
| minimum implied | 1.0 | 727 | 425 |

No obvious evaluator/result/prior-solution strings were found in the corrected
server files.

## Interpretation

Even this more complex server target did not separate final behavior for one
clean builder vs one minimum-implied builder. Both passed the external
`redis-py` suite.

The process-cost signal did move: the implied spec was shorter, but the
implementation was longer (`727` lines vs `645`). That matches the Uxn finding:
strong builders can recover behavior when enough facts are present, but more
implicit specs push cost into reconstruction.

## Evaluator-Only Condition

I then ran a white-box condition where the worker saw no prose spec and was
allowed to inspect only `evaluator.py`.

Result:

| condition | score | server lines |
| --- | ---: | ---: |
| evaluator only | 1.0 | 462 |

This is not a product-spec condition. It measures whether a builder can build to
the visible tests. It passed and produced the shortest implementation so far.

Interpretation: a visible evaluator is a very compact target, but it is a poor
substitute for a spec if we care about behavior outside the suite. It shifts the
system from "build Redis-like behavior" to "satisfy these observed cases." That
is useful as a lower bound and overfitting probe, not as evidence that prose
specs are unnecessary.

## Next Pressure

The next useful Redis pass should add cases that are harder to infer from
"ordinary Redis behavior":

- malformed RESP and partial bulk strings
- concurrent clients
- blocking command absence
- transaction errors and queued command errors
- expiration during transaction
- binary keys with embedded CRLF
- large pipelined request streams
- memory of selected database deliberately excluded or included

If final behavior still stays green, the experiment should stop treating final
pass/fail as the primary signal and make process metrics first-class.
