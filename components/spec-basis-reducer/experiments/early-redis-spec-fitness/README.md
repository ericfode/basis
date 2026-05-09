# Early Redis Spec Fitness Experiment

Date: 2026-05-08

Purpose: test spec-fitness discrimination on a more complex server target than
`ls-lite` or the Uxn headless VM.

The target is an early-Redis-shaped in-memory server:

- RESP2 wire protocol
- TCP server
- string keys and list keys
- integer mutation
- expiration
- pipelining
- simple `MULTI` / `EXEC`
- client compatibility with `redis-py`

This intentionally stops short of full Redis. It is a bounded compatibility
surface with an external client suite.

## Candidate Contract

Each builder writes:

```text
server.mjs
```

The evaluator starts it as:

```sh
node server.mjs
```

Environment:

- `REDIS_PORT`: TCP port to listen on `127.0.0.1`

The server must keep running until killed by the evaluator.

## External Suite

The evaluator is Python and uses the real `redis` client package installed in
the workspace `.venv`.

It tests behavior by connecting over TCP, not by importing implementation code.

## Files

- `evaluator.py`: external `redis-py` client suite
- `specs/good-early-redis.md`: operational spec
- `specs/minimum-implied-early-redis.md`: compact spec with many details implied
- `sources.md`: source notes

## Why This Is More Complex

Unlike the earlier fixtures, this has concurrent-ish protocol pressure:

- streaming RESP parsing
- multiple commands in one socket read
- long-lived TCP connections
- binary-safe bulk strings
- type errors
- wall-clock expiration
- transaction queues
- client-library handshake quirks

If clean and implied specs both pass here, final behavior is probably still too
weak as the sole discriminator. If one fails, this gives a better point for
spec-reduction value.
