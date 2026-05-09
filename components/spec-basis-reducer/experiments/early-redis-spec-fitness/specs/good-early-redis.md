# Good Spec: Early Redis Compatible Server

Build `server.mjs`, a Node.js TCP server. It is started as:

```sh
REDIS_PORT=<port> node server.mjs
```

Listen on `127.0.0.1:<REDIS_PORT>`. Keep running until the process is killed.
Use only Node standard libraries.

## Protocol

Implement RESP2 request parsing and response writing.

Requests from the client are RESP arrays of bulk strings:

```text
*<count>\r\n
$<len>\r\n
<bytes>\r\n
...
```

Parse commands case-insensitively. Preserve key and value bytes exactly. Support
multiple commands arriving in one socket chunk and partial commands split across
chunks.

Responses required:

- simple string: `+OK\r\n`
- error: `-ERR <message>\r\n`
- integer: `:<number>\r\n`
- bulk string: `$<len>\r\n<bytes>\r\n`
- null bulk string: `$-1\r\n`
- array: `*<count>\r\n...`

The server may ignore inline command syntax.

## Data Model

Store keys as binary strings. Values are either:

- string bytes
- list of string-byte elements

Each key may have an optional absolute expiration timestamp in milliseconds.
Expired keys behave as missing and should be lazily deleted before command
execution.

Use one logical database. `FLUSHDB` clears all keys and expirations.

## Client Compatibility Commands

`redis-py` may send client metadata commands. Support:

- `CLIENT SETINFO ...`: reply `+OK`
- `CLIENT ID`: reply integer `1`

Unknown `CLIENT` subcommands may return an error.

## Connection Commands

- `PING`: with no argument, reply `+PONG`; with one argument, reply that argument
  as a bulk string.
- `ECHO value`: reply `value` as a bulk string.
- `QUIT`: reply `+OK` and close the socket after flushing.

## String Commands

- `SET key value`: set string value, clear previous type and expiration, reply
  `+OK`.
- `SET key value EX seconds`: set value and expiration seconds from now.
- `SET key value PX milliseconds`: set value and expiration milliseconds from
  now.
- `SET key value NX`: set only if key is absent; reply null bulk string when not
  set.
- `SET key value XX`: set only if key exists; reply null bulk string when not
  set.
- Options may be combined as `SET key value EX 10 NX`.
- `GET key`: reply bulk string or null bulk string. If key holds a list, reply
  `-WRONGTYPE Operation against a key holding the wrong kind of value`.
- `MSET key value [key value ...]`: set all pairs, reply `+OK`.
- `MGET key [key ...]`: reply array of bulk strings/nulls. Wrong-type list keys
  produce null entries for this fixture.
- `DEL key [key ...]`: delete keys, reply count deleted.
- `EXISTS key [key ...]`: reply count of existing keys.
- `TYPE key`: reply simple string `none`, `string`, or `list`.
- `DBSIZE`: reply number of existing unexpired keys.

## Integer Commands

For string values interpreted as signed base-10 integers:

- `INCR key`: increment by `1`
- `DECR key`: decrement by `1`
- `INCRBY key delta`: increment by signed integer `delta`
- `DECRBY key delta`: decrement by signed integer `delta`

Missing keys start at `0`. Store the resulting integer as its decimal ASCII
string and reply as integer. Non-integer string values or list values return:

```text
-ERR value is not an integer or out of range
```

## Expiration Commands

- `EXPIRE key seconds`: set expiration in seconds, reply `1`; missing key
  replies `0`.
- `TTL key`: reply `-2` if missing, `-1` if present with no expiration, otherwise
  integer seconds remaining rounded down but never below `0`.
- `PERSIST key`: remove expiration, reply `1`; missing key or key without
  expiration replies `0`.

## List Commands

- `LPUSH key value [value ...]`: create list if missing; push values to the head
  in argument order; reply new length.
- `RPUSH key value [value ...]`: create list if missing; push values to the tail
  in argument order; reply new length.
- `LLEN key`: reply length, or `0` when missing.
- `LRANGE key start stop`: inclusive indexes; negative indexes count from end;
  clamp out-of-range bounds; reply array of bulk strings.
- `LPOP key`: remove and return head, or null bulk string if missing/empty.
- `RPOP key`: remove and return tail, or null bulk string if missing/empty.

String commands against list keys and list commands against string keys return
the same `WRONGTYPE` error above, except where this spec explicitly says
otherwise.

## Transactions And Pipelining

Support pipelining naturally by parsing all complete requests from the socket
buffer and replying in order.

Support one connection-local transaction queue:

- `MULTI`: enter transaction mode, reply `+OK`
- While in transaction mode, queue supported commands and reply `+QUEUED`
- `EXEC`: execute queued commands in order and reply with an array of their
  normal replies
- `DISCARD`: clear queue, leave transaction mode, reply `+OK`

Do not queue `MULTI`, `EXEC`, `DISCARD`, `QUIT`, or unsupported commands.

## Errors

Wrong arity returns `-ERR wrong number of arguments for '<command>' command`.
Unknown commands return `-ERR unknown command '<command>'`.

Error text only needs to match where this spec gives exact text.
