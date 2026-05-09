# Early Redis Source Notes

Date: 2026-05-08

This experiment uses Redis as a mature server/protocol target, but not as a full
compatibility requirement.

## Sources

- RESP protocol specification: <https://redis.io/docs/latest/develop/reference/protocol-spec/>
  - RESP is the Redis Serialization Protocol used by clients and servers.
  - RESP2 arrays, bulk strings, simple strings, integers, errors, and null bulk
    strings are enough for this fixture.

- Redis command reference: <https://redis.io/docs/latest/commands/>
  - The command pages define behavior for `PING`, `SET`, `GET`, `DEL`, `EXISTS`,
    `INCR`, `EXPIRE`, `TTL`, lists, and transaction commands.

- redis-py documentation: <https://redis.readthedocs.io/>
  - The evaluator uses the real Python client as an external compatibility
    harness.

## Experiment Boundary

This is not full Redis:

- no replication
- no persistence
- no pub/sub
- no Lua
- no cluster
- no streams, hashes, sets, sorted sets, bitmaps, or HyperLogLog
- no ACL
- no RESP3

The point is to create a tractable but meaningfully server-shaped benchmark.
