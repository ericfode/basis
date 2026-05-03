# Redis Historical Mined Spec

Status: Generated as-built genesis-stable draft

Source repo: `/private/tmp/testing-rl-external/redis`
Branch/ref judged: `unstable`
Root commit: `ed9b544e10b84cd43348ddfab7068b610a5df1f7` (2009-03-22 10:30:00 +0100, first commit)
Latest judged commit: `2432f55278b8fd01a4f7c4b9f5a9e2dcc5ddd4f8` (2026-04-30 21:38:25 +0800, Fix CI Codecov v6 coverage upload configuration (#15147))
Prompt policy: `genesis-stable-essence-stricter-1:e2`
Reward: `0.8547`; time validity: `1`; average coverage: `0.6729`

## Problem

Redis needs a networked in-memory data-structure server whose command protocol, dataset, persistence, replication, configuration, and tests stay legible across project history.

## Goals

- Redis MUST preserve the role of a networked in-memory data-structure server across the judged history.
- Redis MUST keep command behavior addressable through client-visible protocol, configuration, persistence, and validation surfaces.
- Redis SHOULD prefer stable server semantics over implementation details that churn across files or releases.

## Non-Goals

- This mined spec does not claim that features introduced after the root commit existed at the root commit.
- This mined spec does not describe every implementation file or every later extension.
- This mined spec is not a release note, API reference, or proof that Redis has no undocumented behavior.

## Stable Essence Requirements

- Redis MUST provide a long-running network server that accepts client commands over the Redis protocol.
  Evidence: `ae.c`, `anet.c`, `doc/ProtocolSpecification.html`, `redis.c`, `src/ae.c`, `src/anet.c`, `src/networking.c`, `src/server.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis MUST keep the active dataset in memory while serving commands.
  Evidence: `dict.c`, `redis.c`, `src/dict.c`, `src/server.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis MUST treat values as data structures rather than only opaque strings.
  Evidence: `doc/SaddCommand.html`, `doc/RpoplpushCommand.html`, `src/t_hash.c`, `src/t_list.c`, `src/t_set.c`, `src/t_string.c`, `src/t_zset.c`, `src/t_stream.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis MUST expose a key-addressed namespace where string keys are associated with typed values.
  Evidence: `doc/DbsizeCommand.html`, `doc/DelCommand.html`, `doc/ExistsCommand.html`, `doc/KeysCommand.html`, `doc/HdelCommand.html`, `doc/HexistsCommand.html`, `src/commands/dbsize.json`, `src/commands/del.json`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis MUST support snapshot persistence that can reload the dataset after restart.
  Evidence: `doc/BgsaveCommand.html`, `src/rdb.c`, `src/commands/bgsave.json`, `src/commands/lastsave.json`, `src/commands/save.json`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis MUST define a client/server protocol with parseable command requests and explicit replies.
  Evidence: `doc/ProtocolSpecification.html`, `redis.c`, `src/networking.c`, `src/resp_parser.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis SHOULD support master-replica replication for availability and data-copy propagation.
  Evidence: `doc/SlaveofCommand.html`, `src/replication.c`, `src/commands/psync.json`, `src/commands/replicaof.json`, `src/commands/slaveof.json`, `src/commands/sync.json`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis SHOULD preserve executable tests or scripted validation for command behavior.
  Evidence: `client-libraries/erlang/test/Makefile`, `client-libraries/erlang/test/erldis_tests.erl`, `client-libraries/erlang/test/proto_tests.erl`, `test-redis.tcl`, `tests/assets/default.conf`, `tests/integration/aof.tcl`, `tests/integration/replication.tcl`, `tests/support/redis.tcl`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis SHOULD allow server behavior to be selected through a configuration file while retaining built-in defaults.
  Evidence: `redis.conf`, `src/config.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.
- Redis SHOULD ship client tooling for interactive or scripted command execution.
  Evidence: `redis-cli.c`, `src/redis-cli.c`. Presence: 100.0% of judged samples; first seen 2009-03-22 10:30:00 +0100.

## Validation Surfaces

- The Redis spec MUST be judged against sampled Git snapshots without checking out or modifying the Redis repository.
- A Redis command, protocol, dataset, persistence, replication, configuration, or test claim is valid for a snapshot only when its mined feature evidence is present in that snapshot.
- The reward MUST prefer long temporal validity, then coverage of high-weight Redis essence features, then compactness.

## Risks

- A mined Redis spec risks overfitting file names, so stable claims SHOULD keep source-path or source-text evidence.
- A root-stable Redis spec risks under-covering later features, so later-only features MUST be reported as drift instead of silently backdated.
- A valid sampled history is not a proof of maintainer intent; human review remains REQUIRED before accepting the mined draft as a project spec.

## Later Feature Drift Not Folded Into The Genesis Spec

- `append_only_file`: Append-only persistence; first seen 2010-05-26 17:55:28 +0200; presence 92.9%.
- `transactions`: Transactions; first seen 2010-05-26 17:55:28 +0200; presence 92.9%.
- `pubsub`: Pub/sub; first seen 2010-05-26 17:55:28 +0200; presence 92.9%.
- `cluster_mode`: Cluster mode; first seen 2011-11-09 21:59:27 +0100; presence 85.7%.
- `sentinel`: Sentinel; first seen 2013-03-14 21:27:12 +0100; presence 78.6%.
- `modules`: Modules; first seen 2017-01-10 11:33:50 +0100; presence 57.1%.
- `streams`: Streams; first seen 2018-09-25 12:31:46 +0200; presence 50.0%.
- `acl_security`: ACL security; first seen 2019-11-19 11:23:43 +0100; presence 42.9%.
- `tls_transport`: TLS transport; first seen 2019-11-19 11:23:43 +0100; presence 42.9%.

## Judge Result

- Valid sampled snapshots: 14/14.
- Valid through: 2026-04-30 21:38:25 +0800 at `2432f55278b8fd01a4f7c4b9f5a9e2dcc5ddd4f8`.
- First invalid sample: none in the judged sample set.

