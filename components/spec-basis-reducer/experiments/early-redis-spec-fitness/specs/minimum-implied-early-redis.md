# Minimum-Implied Spec: Early Redis Compatible Server

Build `server.mjs`, a Node.js TCP server started as:

```sh
REDIS_PORT=<port> node server.mjs
```

Listen on `127.0.0.1`. Use only Node standard libraries. The server is
single-process, in-memory, RESP2, one logical database, and binary-safe.

## RESP2

Accept client requests as arrays of bulk strings. Parse incrementally: commands
may be split across reads or pipelined in one read. Command names are
case-insensitive. Keys and values are byte strings.

Write RESP2 simple strings, errors, integers, bulk strings, null bulk strings,
and arrays. Use `\r\n` terminators.

## Values

A key is absent, a string, or a list of strings. Each key may also have an
absolute millisecond expiration. Expired keys are missing. A command should check
expiration for keys it touches.

## Commands

Connection/client:

- `PING [message]`, `ECHO message`, `QUIT`
- `CLIENT SETINFO ...` -> `OK`
- `CLIENT ID` -> integer `1`

Strings:

- `SET key value [EX seconds|PX ms] [NX|XX]`
- `GET key`
- `MSET key value [key value ...]`
- `MGET key [key ...]`
- `DEL key [key ...]`
- `EXISTS key [key ...]`
- `TYPE key`
- `DBSIZE`

Integers:

- `INCR key`
- `DECR key`
- `INCRBY key delta`
- `DECRBY key delta`

Expiration:

- `EXPIRE key seconds`
- `TTL key`
- `PERSIST key`

Lists:

- `LPUSH key value [value ...]`
- `RPUSH key value [value ...]`
- `LLEN key`
- `LRANGE key start stop`
- `LPOP key`
- `RPOP key`

Transactions:

- `MULTI`
- queue normal supported commands and reply `QUEUED`
- `EXEC` returns an array of queued command replies
- `DISCARD`

## Redis Semantics To Infer

Use ordinary Redis behavior for the commands above:

- `PING` without message returns `PONG`; with message returns the message.
- missing `GET`, `LPOP`, and `RPOP` return null bulk strings.
- missing `LLEN` returns `0`.
- `DEL` / `EXISTS` count affected existing keys.
- `TYPE` is `none`, `string`, or `list`.
- `TTL` is `-2` for missing, `-1` for no expiration, otherwise whole seconds
  remaining.
- `SET` clears old type and old expiration unless a new expiration option is
  supplied.
- `NX` means only absent; `XX` means only present; failed conditional `SET`
  returns null bulk.
- Integer commands create missing keys from zero and store decimal strings.
- Non-integer values and wrong key types produce Redis-style errors.
- List pushes preserve Redis argument order; `LRANGE` uses inclusive indexes and
  negative indexes from the end.
- `FLUSHDB` clears the database.

Exact error text is not important except errors must be RESP errors and
`redis-py` must raise an error for wrong type or invalid integer operations.
