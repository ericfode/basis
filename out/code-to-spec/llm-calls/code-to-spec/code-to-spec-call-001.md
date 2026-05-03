You are executing Spec Gym projection `code-to-spec`: Code To Spec Draft.

Projection instructions:
# Code To Spec Draft

Infer a reviewable `spec.md` draft from focused code slices.

The projection should describe observed behavior, interfaces, configuration,
data models, commands, tests, and unresolved implementation questions. It must
preserve file and line anchors and distinguish observed behavior from inferred
intent.

Output contract:
- Format: markdown
- Final artifact path after merge: spec-draft.md
- Type contracts: spec-draft

Rules:
- Use only the source slice below.
- Preserve source anchors for every emitted item.
- Mark inferred items explicitly.
- Do not fill missing facts with invented certainty.
- Return only the partial projection payload for this slice.

Source nodes:
```json
[
  {
    "id": "requirement-historical-spec-mjs-claim-redis-must-provide-a-long-running-network-server-that-accepts-client-comma",
    "type": "requirement",
    "title": "claim: \"Redis MUST provide a long-running network server that accepts client commands...",
    "text": "claim: \"Redis MUST provide a long-running network server that accepts client commands over the Redis protocol.\",",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/src",
      "lineStart": 24,
      "lineEnd": 24
    }
  },
  {
    "id": "requirement-historical-spec-mjs-claim-redis-must-define-a-client-server-protocol-with-parseable-command-requests",
    "type": "requirement",
    "title": "claim: \"Redis MUST define a client/server protocol with parseable command requests an...",
    "text": "claim: \"Redis MUST define a client/server protocol with parseable command requests and explicit replies.\",",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/src",
      "lineStart": 69,
      "lineEnd": 69
    }
  },
  {
    "id": "requirement-historical-spec-mjs-claim-redis-should-ship-client-tooling-for-interactive-or-scripted-command-execu",
    "type": "requirement",
    "title": "claim: \"Redis SHOULD ship client tooling for interactive or scripted command executio...",
    "text": "claim: \"Redis SHOULD ship client tooling for interactive or scripted command execution.\",",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/src",
      "lineStart": 114,
      "lineEnd": 114
    }
  },
  {
    "id": "requirement-historical-spec-mjs-claim-redis-may-ship-benchmark-tooling-for-measuring-command-throughput",
    "type": "requirement",
    "title": "claim: \"Redis MAY ship benchmark tooling for measuring command throughput.\",",
    "text": "claim: \"Redis MAY ship benchmark tooling for measuring command throughput.\",",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/src",
      "lineStart": 123,
      "lineEnd": 123
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0007-heading-historical-spec-mjs",
    "type": "heading",
    "lineStart": 8,
    "lineEnd": 8,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## historical-spec.mjs"
  },
  {
    "id": "block-0011-fenced_code-js-import-fs-from-node-fs-import-path-from-node-path-import-execfilesync-fr",
    "type": "fenced_code",
    "lineStart": 12,
    "lineEnd": 133,
    "generatedClaimIds": [
      "requirement-historical-spec-mjs-claim-redis-must-provide-a-long-running-network-server-that-accepts-client-comma",
      "requirement-historical-spec-mjs-claim-redis-must-keep-the-active-dataset-in-memory-while-serving-commands",
      "requirement-historical-spec-mjs-claim-redis-must-expose-a-key-addressed-namespace-where-string-keys-are-associat",
      "requirement-historical-spec-mjs-claim-redis-must-treat-values-as-data-structures-rather-than-only-opaque-strings",
      "requirement-historical-spec-mjs-claim-redis-should-provide-atomic-server-side-primitives-so-clients-can-coordina",
      "requirement-historical-spec-mjs-claim-redis-must-define-a-client-server-protocol-with-parseable-command-requests",
      "requirement-historical-spec-mjs-claim-redis-should-allow-server-behavior-to-be-selected-through-a-configuration-",
      "requirement-historical-spec-mjs-claim-redis-must-support-snapshot-persistence-that-can-reload-the-dataset-after-",
      "requirement-historical-spec-mjs-claim-redis-should-support-master-replica-replication-for-availability-and-data-",
      "requirement-historical-spec-mjs-claim-redis-may-provide-append-only-persistence-as-a-durability-mode-distinct-fr",
      "requirement-historical-spec-mjs-claim-redis-should-ship-client-tooling-for-interactive-or-scripted-command-execu",
      "requirement-historical-spec-mjs-claim-redis-may-ship-benchmark-tooling-for-measuring-command-throughput"
    ],
    "rawMarkdown": "```js\nimport fs from \"node:fs\";\nimport path from \"node:path\";\nimport { execFileSync } from \"node:child_process\";\n\nconst DAY_MS = 24 * 60 * 60 * 1000;\n\nexport const HISTORICAL_FEATURE_CATALOG = [\n  {\n    id: \"networked_command_server\",\n    title: \"Networked command server\",\n    category: \"core\",\n    essenceWeight: 10,\n    claim: \"Redis MUST provide a long-running network server that accepts client commands over the Redis protocol.\",\n    pathAny: [/^redis\\.c$/, /^src\\/server\\.c$/, /^src\\/networking\\.c$/, /^anet\\.c$/, /^src\\/anet\\.c$/, /^ae\\.c$/, /^src\\/ae\\.c$/, /ProtocolSpecification/i],\n    textAny: [/\\bRedis protocol\\b/i, /\\bTCP\\b/i, /\\bport 6379\\b/i, /\\btelnet localhost 6379\\b/i]\n  },\n  {\n    id: \"in_memory_primary_dataset\",\n    title: \"In-memory primary dataset\",\n    category: \"core\",\n    essenceWeight: 10,\n    claim: \"Redis MUST keep the active dataset in memory while serving commands.\",\n    pathAny: [/^dict\\.c$/, /^src\\/dict\\.c$/, /^redis\\.c$/, /^src\\/server\\.c$/],\n    textAny: [/\\bwhole dataset in memory\\b/i, /\\bin-memory\\b/i, /\\bdataset.*fit in.*memory\\b/i]\n  },\n  {\n    id: \"key_value_namespace\",\n    title: \"Key-value namespace\",\n    category: \"core\",\n    essenceWeight: 9,\n    claim: \"Redis MUST expose a key-addressed namespace where string keys are associated with typed values.\",\n    pathAny: [/DbsizeCommand/i, /ExistsCommand/i, /KeysCommand/i, /DelCommand/i, /^src\\/commands\\/(?:dbsize|exists|keys|del)\\.json$/],\n    textAny: [/\\bkeys are associated with values\\b/i, /\\bkey-value\\b/i, /\\bthe key\\b/i]\n  },\n  {\n    id: \"typed_data_structures\",\n    title: \"Typed data structures\",\n    category: \"core\",\n    essenceWeight: 10,\n    claim: \"Redis MUST treat values as data structures rather than only opaque strings.\",\n    pathAny: [/LpushCommand/i, /SaddCommand/i, /^src\\/t_(?:string|list|set|hash|zset|stream)\\.c$/, /^src\\/commands\\/(?:lpush|sadd|hset|zadd|xadd)\\.json$/],\n    textAny: [/\\bdata structures server\\b/i, /\\bStrings, Lists and Sets\\b/i, /\\bassociated values can be\\b/i]\n  },\n  {\n    id: \"atomic_commands\",\n    title: \"Atomic command primitives\",\n    category: \"core\",\n    essenceWeight: 8,\n    claim: \"Redis SHOULD provide atomic server-side primitives so clients can coordinate without external locks for common operations.\",\n    pathAny: [/IncrCommand/i, /DecrCommand/i, /LpopCommand/i, /^src\\/commands\\/(?:incr|decr|lpop|rpop|sinter)\\.json$/],\n    textAny: [/\\batomic primitives\\b/i, /\\batomically increment/i, /\\blocking free algorithms\\b/i, /\\bcomplex atomic operations\\b/i]\n  },\n  {\n    id: \"redis_protocol\",\n    title: \"Redis protocol\",\n    category: \"interface\",\n    essenceWeight: 8,\n    claim: \"Redis MUST define a client/server protocol with parseable command requests and explicit replies.\",\n    pathAny: [/ProtocolSpecification/i, /^src\\/resp_parser\\.c$/, /^src\\/networking\\.c$/, /^redis\\.c$/],\n    textAny: [/\\bprotocol specification\\b/i, /\\bcommands terminated by/i, /\\bRESP\\b/i, /\\bRedis protocol\\b/i]\n  },\n  {\n    id: \"configuration_file\",\n    title: \"Configuration file\",\n    category: \"interface\",\n    essenceWeight: 6,\n    claim: \"Redis SHOULD allow server behavior to be selected through a configuration file while retaining built-in defaults.\",\n    pathAny: [/^redis\\.conf$/, /^src\\/config\\.c$/],\n    textAny: [/\\bconfiguration file\\b/i, /\\bdefault built-in configuration\\b/i, /\\bredis\\.conf\\b/i]\n  },\n  {\n    id: \"rdb_persistence\",\n    title: \"Snapshot persistence\",\n    category: \"durability\",\n    essenceWeight: 9,\n    claim: \"Redis MUST support snapshot persistence that can reload the dataset after restart.\",\n    pathAny: [/^src\\/rdb\\.c$/, /^rdb\\.c$/, /BgsaveCommand/i, /^src\\/commands\\/(?:bgsave|save|lastsave)\\.json$/],\n    textAny: [/\\bdump of the dataset\\b/i, /\\bloaded every time the server is restarted\\b/i, /\\bRDB\\b/i, /\\bsnapshot/i]\n  },\n  {\n    id: \"replication\",\n    title: \"Replication\",\n    category: \"durability\",\n    essenceWeight: 8,\n    claim: \"Redis SHOULD support master-replica replication for availability and data-copy propagation.\",\n    pathAny: [/^src\\/replication\\.c$/, /SlaveofCommand/i, /^src\\/commands\\/(?:slaveof|replicaof|sync|psync)\\.json$/],\n    textAny: [/\\bmaster-slave replication\\b/i, /\\bmaster-replica\\b/i, /\\breplication\\b/i, /\\bREDIS_SLAVE\\b/]\n  },\n  {\n    id: \"append_only_file\",\n    title: \"Append-only persistence\",\n    category: \"durability\",\n    essenceWeight: 7,\n    claim: \"Redis MAY provide append-only persistence as a durability mode distinct from snapshots.\",\n    pathAny: [/^src\\/aof\\.c$/, /^aof\\.c$/, /BgrewriteaofCommand/i, /^src\\/commands\\/(?:bgrewriteaof)\\.json$/],\n    textAny: [/\\bappend only\\b/i, /\\bAOF\\b/i, /\\bappendonly\\b/i]\n  },\n  {\n    id: \"client_cli\",\n    title: \"Interactive client\",\n    category: \"tooling\",\n    essenceWeight: 5,\n    claim: \"Redis SHOULD ship client tooling for interactive or scripted command execution.\",\n    pathAny: [/^redis-cli\\.c$/, /^src\\/redis-cli\\.c$/],\n    textAny: [/\\bredis-cli\\b/i]\n  },\n  {\n    id: \"benchmark_tool\",\n    title: \"Benchmark tooling\",\n    category: \"tooling\",\n    essenceWeight: 4,\n    claim: \"Redis MAY ship benchmark tooling for measuring command throughput.\",\n    pathAny: [/^benchmark\\.c$/, /^redis-benchmark\\.c$/, /^src\\/redis-benchmark\\.c$/, /Benchmarks/i],\n    textAny: [/\\bbenchmark\\b/i]\n  },\n  {\n    id: \"test_suite\",\n    title: \"Regression test suite\",\n    category: \"validation\",\n    essenceWeight: 7,\n```"
  }
]
```
