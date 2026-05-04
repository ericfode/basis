import fs from "node:fs";
import path from "node:path";
import { execFileSync } from "node:child_process";

const DAY_MS = 24 * 60 * 60 * 1000;

export const HISTORICAL_FEATURE_CATALOG = [
  {
    id: "networked_command_server",
    title: "Networked command server",
    category: "core",
    essenceWeight: 10,
    claim: "Redis MUST provide a long-running network server that accepts client commands over the Redis protocol.",
    pathAny: [/^redis\.c$/, /^src\/server\.c$/, /^src\/networking\.c$/, /^anet\.c$/, /^src\/anet\.c$/, /^ae\.c$/, /^src\/ae\.c$/, /ProtocolSpecification/i],
    textAny: [/\bRedis protocol\b/i, /\bTCP\b/i, /\bport 6379\b/i, /\btelnet localhost 6379\b/i]
  },
  {
    id: "in_memory_primary_dataset",
    title: "In-memory primary dataset",
    category: "core",
    essenceWeight: 10,
    claim: "Redis MUST keep the active dataset in memory while serving commands.",
    pathAny: [/^dict\.c$/, /^src\/dict\.c$/, /^redis\.c$/, /^src\/server\.c$/],
    textAny: [/\bwhole dataset in memory\b/i, /\bin-memory\b/i, /\bdataset.*fit in.*memory\b/i]
  },
  {
    id: "key_value_namespace",
    title: "Key-value namespace",
    category: "core",
    essenceWeight: 9,
    claim: "Redis MUST expose a key-addressed namespace where string keys are associated with typed values.",
    pathAny: [/DbsizeCommand/i, /ExistsCommand/i, /KeysCommand/i, /DelCommand/i, /^src\/commands\/(?:dbsize|exists|keys|del)\.json$/],
    textAny: [/\bkeys are associated with values\b/i, /\bkey-value\b/i, /\bthe key\b/i]
  },
  {
    id: "typed_data_structures",
    title: "Typed data structures",
    category: "core",
    essenceWeight: 10,
    claim: "Redis MUST treat values as data structures rather than only opaque strings.",
    pathAny: [/LpushCommand/i, /SaddCommand/i, /^src\/t_(?:string|list|set|hash|zset|stream)\.c$/, /^src\/commands\/(?:lpush|sadd|hset|zadd|xadd)\.json$/],
    textAny: [/\bdata structures server\b/i, /\bStrings, Lists and Sets\b/i, /\bassociated values can be\b/i]
  },
  {
    id: "atomic_commands",
    title: "Atomic command primitives",
    category: "core",
    essenceWeight: 8,
    claim: "Redis SHOULD provide atomic server-side primitives so clients can coordinate without external locks for common operations.",
    pathAny: [/IncrCommand/i, /DecrCommand/i, /LpopCommand/i, /^src\/commands\/(?:incr|decr|lpop|rpop|sinter)\.json$/],
    textAny: [/\batomic primitives\b/i, /\batomically increment/i, /\blocking free algorithms\b/i, /\bcomplex atomic operations\b/i]
  },
  {
    id: "redis_protocol",
    title: "Redis protocol",
    category: "interface",
    essenceWeight: 8,
    claim: "Redis MUST define a client/server protocol with parseable command requests and explicit replies.",
    pathAny: [/ProtocolSpecification/i, /^src\/resp_parser\.c$/, /^src\/networking\.c$/, /^redis\.c$/],
    textAny: [/\bprotocol specification\b/i, /\bcommands terminated by/i, /\bRESP\b/i, /\bRedis protocol\b/i]
  },
  {
    id: "configuration_file",
    title: "Configuration file",
    category: "interface",
    essenceWeight: 6,
    claim: "Redis SHOULD allow server behavior to be selected through a configuration file while retaining built-in defaults.",
    pathAny: [/^redis\.conf$/, /^src\/config\.c$/],
    textAny: [/\bconfiguration file\b/i, /\bdefault built-in configuration\b/i, /\bredis\.conf\b/i]
  },
  {
    id: "rdb_persistence",
    title: "Snapshot persistence",
    category: "durability",
    essenceWeight: 9,
    claim: "Redis MUST support snapshot persistence that can reload the dataset after restart.",
    pathAny: [/^src\/rdb\.c$/, /^rdb\.c$/, /BgsaveCommand/i, /^src\/commands\/(?:bgsave|save|lastsave)\.json$/],
    textAny: [/\bdump of the dataset\b/i, /\bloaded every time the server is restarted\b/i, /\bRDB\b/i, /\bsnapshot/i]
  },
  {
    id: "replication",
    title: "Replication",
    category: "durability",
    essenceWeight: 8,
    claim: "Redis SHOULD support master-replica replication for availability and data-copy propagation.",
    pathAny: [/^src\/replication\.c$/, /SlaveofCommand/i, /^src\/commands\/(?:slaveof|replicaof|sync|psync)\.json$/],
    textAny: [/\bmaster-slave replication\b/i, /\bmaster-replica\b/i, /\breplication\b/i, /\bREDIS_SLAVE\b/]
  },
  {
    id: "append_only_file",
    title: "Append-only persistence",
    category: "durability",
    essenceWeight: 7,
    claim: "Redis MAY provide append-only persistence as a durability mode distinct from snapshots.",
    pathAny: [/^src\/aof\.c$/, /^aof\.c$/, /BgrewriteaofCommand/i, /^src\/commands\/(?:bgrewriteaof)\.json$/],
    textAny: [/\bappend only\b/i, /\bAOF\b/i, /\bappendonly\b/i]
  },
  {
    id: "client_cli",
    title: "Interactive client",
    category: "tooling",
    essenceWeight: 5,
    claim: "Redis SHOULD ship client tooling for interactive or scripted command execution.",
    pathAny: [/^redis-cli\.c$/, /^src\/redis-cli\.c$/],
    textAny: [/\bredis-cli\b/i]
  },
  {
    id: "benchmark_tool",
    title: "Benchmark tooling",
    category: "tooling",
    essenceWeight: 4,
    claim: "Redis MAY ship benchmark tooling for measuring command throughput.",
    pathAny: [/^benchmark\.c$/, /^redis-benchmark\.c$/, /^src\/redis-benchmark\.c$/, /Benchmarks/i],
    textAny: [/\bbenchmark\b/i]
  },
  {
    id: "test_suite",
    title: "Regression test suite",
    category: "validation",
    essenceWeight: 7,
    claim: "Redis SHOULD preserve executable tests or scripted validation for command behavior.",
    pathAny: [/^test-redis\.tcl$/, /^tests\//, /\/tests?\//],
    textAny: [/\btest suite\b/i, /\bregression test/i]
  },
  {
    id: "transactions",
    title: "Transactions",
    category: "extension",
    essenceWeight: 5,
    claim: "Redis MAY support transaction commands that queue and execute command groups.",
    pathAny: [/^src\/multi\.c$/, /MultiCommand/i, /ExecCommand/i, /^src\/commands\/(?:multi|exec|discard|watch|unwatch)\.json$/],
    textAny: [/\bMULTI\b/, /\bEXEC\b/, /\btransaction/i]
  },
  {
    id: "pubsub",
    title: "Pub/sub",
    category: "extension",
    essenceWeight: 5,
    claim: "Redis MAY support publish/subscribe messaging over client connections.",
    pathAny: [/^src\/pubsub\.c$/, /PublishCommand/i, /^src\/commands\/(?:publish|subscribe|unsubscribe|psubscribe)\.json$/],
    textAny: [/\bpub\/sub\b/i, /\bpublish\/subscribe\b/i]
  },
  {
    id: "lua_scripting",
    title: "Lua scripting",
    category: "extension",
    essenceWeight: 4,
    claim: "Redis MAY support server-side scripting for programmable command execution.",
    pathAny: [/^src\/scripting\.c$/, /^deps\/lua\//, /EvalCommand/i, /^src\/commands\/(?:eval|evalsha)\.json$/],
    textAny: [/\bLua\b/, /\bscripting\b/i]
  },
  {
    id: "cluster_mode",
    title: "Cluster mode",
    category: "extension",
    essenceWeight: 5,
    claim: "Redis MAY support clustered deployment with slot ownership and node coordination.",
    pathAny: [/^src\/cluster\.c$/, /ClusterCommand/i, /^src\/commands\/cluster(?:-|\.json$)/],
    textAny: [/\bcluster\b/i, /\bhash slot/i]
  },
  {
    id: "sentinel",
    title: "Sentinel",
    category: "extension",
    essenceWeight: 4,
    claim: "Redis MAY support Sentinel-style monitoring and failover coordination.",
    pathAny: [/^src\/sentinel\.c$/],
    textAny: [/\bSentinel\b/]
  },
  {
    id: "modules",
    title: "Modules",
    category: "extension",
    essenceWeight: 4,
    claim: "Redis MAY expose a module API for extending server behavior.",
    pathAny: [/^src\/module\.c$/, /^src\/redismodule\.h$/, /^tests\/modules\//],
    textAny: [/\bmodule API\b/i, /\bRedis modules\b/i]
  },
  {
    id: "streams",
    title: "Streams",
    category: "extension",
    essenceWeight: 4,
    claim: "Redis MAY support stream data structures and consumer-group style processing.",
    pathAny: [/^src\/t_stream\.c$/, /^src\/commands\/x(?:add|read|group|ack|range)/],
    textAny: [/\bstreams\b/i, /\bconsumer group\b/i]
  },
  {
    id: "acl_security",
    title: "ACL security",
    category: "extension",
    essenceWeight: 4,
    claim: "Redis MAY support access-control lists for users and command permissions.",
    pathAny: [/^src\/acl\.c$/, /^src\/commands\/acl(?:-|\.json$)/],
    textAny: [/\bACL\b/, /\baccess-control\b/i]
  },
  {
    id: "tls_transport",
    title: "TLS transport",
    category: "extension",
    essenceWeight: 3,
    claim: "Redis MAY support TLS transport when built and configured for encrypted connections.",
    pathAny: [/^src\/tls\.c$/],
    textAny: [/\bTLS\b/, /\bSSL\b/]
  }
];

export function buildHistoricalSpecExperimentFromGit(repoPath, options = {}) {
  const repo = path.resolve(repoPath);
  const target = resolveGitRef(repo, options.branch ?? "HEAD");
  const root = options.since ? resolveGitRef(repo, options.since) : selectEarliestReachableRoot(repo, target);
  const commits = listFirstParentCommits(repo, root, target);
  const selectedCommits = pickHistoricalSamples(commits, options.samples ?? 12);
  const snapshots = selectedCommits.map((commit) => collectSnapshot(repo, commit, {
    maxEvidenceBytes: options.maxEvidenceBytes ?? 200000
  }));
  const loop = optimizeHistoricalSpecPrompt(snapshots, {
    iterations: options.iterations ?? 4,
    source: {
      repo,
      root,
      target,
      branch: options.branch ?? "HEAD"
    }
  });

  return {
    schemaVersion: "basis.historical-spec-experiment.v0",
    generatedAt: new Date().toISOString(),
    source: {
      repo,
      branch: options.branch ?? "HEAD",
      root,
      target,
      totalFirstParentCommits: commits.length,
      selectedSampleCount: snapshots.length
    },
    samples: snapshots.map(snapshotSummary),
    loop,
    bestSpec: {
      promptId: loop.best.prompt.id,
      reward: loop.best.judgement.reward,
      markdown: renderHistoricalSpecCandidate(loop.best, snapshots, {
        repo,
        root,
        target,
        branch: options.branch ?? "HEAD"
      })
    },
    judgeReport: renderHistoricalJudgeReport(loop, snapshots, {
      repo,
      root,
      target,
      branch: options.branch ?? "HEAD"
    })
  };
}

export function optimizeHistoricalSpecPrompt(snapshots, options = {}) {
  if (!snapshots.length) {
    throw new Error("historical spec mining requires at least one snapshot");
  }

  const episodes = [];
  let policies = basePromptPolicies();
  let best = null;
  const iterations = Math.max(1, Number(options.iterations ?? 4));

  for (let episode = 1; episode <= iterations; episode += 1) {
    const episodeResults = policies.map((policy) => {
      const prompt = { ...policy, id: `${policy.id}:e${episode}` };
      const candidate = writeCandidateSpecFromPrompt(prompt, snapshots);
      const judgement = judgeHistoricalCandidate(candidate, snapshots);
      const result = { episode, prompt, candidate, judgement };
      if (!best || judgement.reward > best.judgement.reward) best = result;
      return result;
    });
    episodes.push({
      episode,
      results: episodeResults.map(resultSummary)
    });
    policies = mutatePromptPolicies(best.prompt, episode);
  }

  return {
    schemaVersion: "basis.prompt-policy-loop.v0",
    objective: "maximize temporal validity from the initial commit while covering stable project essence",
    best: compactResult(best),
    episodes
  };
}

export function writeHistoricalSpecArtifacts(outDir, experiment) {
  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(path.join(outDir, "sample-manifest.json"), `${JSON.stringify({
    schemaVersion: "basis.historical-sample-manifest.v0",
    source: experiment.source,
    samples: experiment.samples
  }, null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, "prompt-rl-loop.json"), `${JSON.stringify(experiment.loop, null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, "temporal-coverage.json"), `${JSON.stringify({
    schemaVersion: "basis.temporal-coverage.v0",
    source: experiment.source,
    bestPromptId: experiment.bestSpec.promptId,
    reward: experiment.bestSpec.reward,
    selectedClaims: experiment.loop.best.candidate.selectedFeatureIds,
    judgement: experiment.loop.best.judgement
  }, null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, "mined-spec.md"), experiment.bestSpec.markdown);
  fs.writeFileSync(path.join(outDir, "judge-report.md"), experiment.judgeReport);
}

export function pickHistoricalSamples(commits, count) {
  const unique = Array.from(new Set(commits));
  if (unique.length <= count) return unique;
  const selected = new Set([unique[0], unique[unique.length - 1]]);
  for (let index = 1; index < count - 1; index += 1) {
    const position = Math.round((index * (unique.length - 1)) / (count - 1));
    selected.add(unique[position]);
  }
  return unique.filter((commit) => selected.has(commit));
}

function runGit(repo, args, options = {}) {
  return execFileSync("git", ["-C", repo, ...args], {
    encoding: "utf8",
    maxBuffer: options.maxBuffer ?? 30 * 1024 * 1024,
    stdio: ["ignore", "pipe", options.ignoreErrors ? "ignore" : "pipe"]
  }).trimEnd();
}

function tryGit(repo, args, options = {}) {
  try {
    return runGit(repo, args, options);
  } catch {
    return null;
  }
}

function resolveGitRef(repo, ref) {
  return runGit(repo, ["rev-parse", "--verify", ref]);
}

function selectEarliestReachableRoot(repo, target) {
  const roots = runGit(repo, ["rev-list", "--max-parents=0", target])
    .split("\n")
    .filter(Boolean)
    .filter((root) => isAncestor(repo, root, target))
    .map((root) => ({ commit: root, timestamp: Number(runGit(repo, ["show", "-s", "--format=%ct", root])) }))
    .sort((left, right) => left.timestamp - right.timestamp);
  if (!roots.length) {
    throw new Error(`No reachable root found for ${target}`);
  }
  return roots[0].commit;
}

function isAncestor(repo, ancestor, target) {
  try {
    execFileSync("git", ["-C", repo, "merge-base", "--is-ancestor", ancestor, target], {
      stdio: "ignore"
    });
    return true;
  } catch {
    return false;
  }
}

function listFirstParentCommits(repo, root, target) {
  const afterRoot = runGit(repo, ["rev-list", "--first-parent", "--reverse", `${root}..${target}`])
    .split("\n")
    .filter(Boolean);
  return [root, ...afterRoot];
}

function collectSnapshot(repo, commit, options = {}) {
  const files = runGit(repo, ["ls-tree", "-r", "--name-only", commit], { maxBuffer: 50 * 1024 * 1024 })
    .split("\n")
    .filter(Boolean);
  const meta = commitMeta(repo, commit);
  const evidenceFiles = selectEvidenceFiles(files);
  const evidenceTexts = {};
  let evidenceBudget = options.maxEvidenceBytes ?? 200000;
  for (const file of evidenceFiles) {
    if (evidenceBudget <= 0) break;
    const text = tryGit(repo, ["show", `${commit}:${file}`], {
      maxBuffer: Math.min(20 * 1024 * 1024, Math.max(evidenceBudget + 1024, 1024 * 1024)),
      ignoreErrors: true
    });
    if (!text) continue;
    const clipped = text.slice(0, Math.min(text.length, evidenceBudget));
    evidenceTexts[file] = clipped;
    evidenceBudget -= clipped.length;
  }
  const combinedText = Object.values(evidenceTexts).map(stripHtml).join("\n");
  const features = inferFeatures(files, combinedText);
  return {
    commit,
    short: commit.slice(0, 12),
    date: meta.date,
    timestamp: meta.timestamp,
    subject: meta.subject,
    fileCount: files.length,
    topLevelEntries: topLevelEntries(files),
    evidenceFiles,
    features
  };
}

function commitMeta(repo, commit) {
  const raw = runGit(repo, ["show", "-s", "--format=%ct%x00%ci%x00%s", commit]);
  const [timestamp, date, subject] = raw.split("\u0000");
  return {
    timestamp: Number(timestamp),
    date,
    subject
  };
}

function selectEvidenceFiles(files) {
  const preferred = [
    /^README(?:\.md|\.markdown|\.txt)?$/i,
    /^doc\/README\.html$/i,
    /^docs?\/.*README/i,
    /^redis\.conf$/i,
    /^redis\.c$/i,
    /^src\/server\.c$/i,
    /^src\/networking\.c$/i,
    /^src\/commands\.c$/i,
    /^src\/commands\/.*\.json$/i,
    /^test-redis\.tcl$/i,
    /^tests\/.*\.(tcl|py|c|json|md)$/i
  ];
  const selected = [];
  for (const regex of preferred) {
    for (const file of files) {
      if (selected.length >= 80) return selected;
      if (regex.test(file) && !selected.includes(file)) selected.push(file);
    }
  }
  return selected;
}

function inferFeatures(files, combinedText) {
  const features = [];
  for (const feature of HISTORICAL_FEATURE_CATALOG) {
    const pathEvidence = files.filter((file) => (feature.pathAny ?? []).some((regex) => regex.test(file))).slice(0, 10);
    const textEvidence = (feature.textAny ?? []).filter((regex) => regex.test(combinedText)).map((regex) => regex.source);
    if (!pathEvidence.length && !textEvidence.length) continue;
    features.push({
      id: feature.id,
      title: feature.title,
      category: feature.category,
      essenceWeight: feature.essenceWeight,
      claim: feature.claim,
      evidence: {
        paths: pathEvidence,
        textSignals: textEvidence.slice(0, 5)
      }
    });
  }
  return features;
}

function writeCandidateSpecFromPrompt(prompt, snapshots) {
  const featureStats = featurePresenceStats(snapshots);
  const candidates = Array.from(featureStats.values())
    .filter((stat) => !prompt.requireRoot || stat.presentAtRoot)
    .filter((stat) => stat.presence >= prompt.minPresence)
    .sort((left, right) => featureSelectionScore(right, prompt) - featureSelectionScore(left, prompt));
  const selected = candidates.slice(0, prompt.maxClaims);
  return {
    promptId: prompt.id,
    writerPrompt: prompt.writerPrompt,
    judgePrompt: prompt.judgePrompt,
    policy: {
      requireRoot: prompt.requireRoot,
      minPresence: prompt.minPresence,
      maxClaims: prompt.maxClaims,
      detailPenalty: prompt.detailPenalty
    },
    selectedFeatureIds: selected.map((stat) => stat.id),
    selectedFeatures: selected.map((stat) => ({
      id: stat.id,
      title: stat.title,
      category: stat.category,
      claim: stat.claim,
      essenceWeight: stat.essenceWeight,
      presence: Number(stat.presence.toFixed(3)),
      presentSnapshots: stat.presentSnapshots,
      firstSeenCommit: stat.firstSeenCommit,
      firstSeenDate: stat.firstSeenDate,
      evidencePaths: Array.from(stat.evidencePaths).slice(0, 8)
    })),
    rejectedFeatureIds: Array.from(featureStats.values())
      .filter((stat) => !selected.some((item) => item.id === stat.id))
      .map((stat) => stat.id)
  };
}

function judgeHistoricalCandidate(candidate, snapshots) {
  const selected = new Set(candidate.selectedFeatureIds);
  const totalDurationDays = Math.max(1, durationDays(snapshots[0], snapshots[snapshots.length - 1]));
  let validUntilIndex = snapshots.length - 1;
  let firstInvalidIndex = -1;
  let weightedValidDays = 0;
  let weightedTotalDays = 0;
  const snapshotResults = [];

  for (let index = 0; index < snapshots.length; index += 1) {
    const snapshot = snapshots[index];
    const next = snapshots[index + 1] ?? snapshot;
    const spanDays = Math.max(1, durationDays(snapshot, next));
    const present = new Set(snapshot.features.map((feature) => feature.id));
    const missing = Array.from(selected).filter((id) => !present.has(id));
    const supported = Array.from(selected).filter((id) => present.has(id));
    const observedWeight = snapshot.features.reduce((sum, feature) => sum + feature.essenceWeight, 0);
    const coveredWeight = snapshot.features
      .filter((feature) => selected.has(feature.id))
      .reduce((sum, feature) => sum + feature.essenceWeight, 0);
    const coverage = observedWeight ? coveredWeight / observedWeight : 0;
    const valid = missing.length === 0;
    if (valid) weightedValidDays += spanDays;
    weightedTotalDays += spanDays;
    if (!valid && firstInvalidIndex === -1) {
      firstInvalidIndex = index;
      validUntilIndex = Math.max(0, index - 1);
    }
    snapshotResults.push({
      commit: snapshot.commit,
      short: snapshot.short,
      date: snapshot.date,
      valid,
      coverage: Number(coverage.toFixed(3)),
      supportedFeatureIds: supported,
      missingFeatureIds: missing
    });
  }

  const validSnapshots = snapshotResults.filter((result) => result.valid).length;
  const averageCoverage = average(snapshotResults.map((result) => result.coverage));
  const stats = featurePresenceStats(snapshots);
  const selectedStats = Array.from(selected).map((id) => stats.get(id)).filter(Boolean);
  const stability = average(selectedStats.map((stat) => stat.presence));
  const rootFeatures = new Set(snapshots[0].features.map((feature) => feature.id));
  const selectedRootFeatures = Array.from(selected).filter((id) => rootFeatures.has(id)).length;
  const genesisCoverage = rootFeatures.size ? selectedRootFeatures / rootFeatures.size : 0;
  const compactness = candidate.selectedFeatureIds.length
    ? 1 / Math.sqrt(candidate.selectedFeatureIds.length)
    : 0;
  const timeValidity = weightedTotalDays ? weightedValidDays / weightedTotalDays : 0;
  const reward = (0.42 * timeValidity) +
    (0.30 * averageCoverage) +
    (0.18 * stability) +
    (0.08 * genesisCoverage) +
    (0.02 * compactness) -
    (candidate.policy.detailPenalty * candidate.selectedFeatureIds.length);

  return {
    reward: Number(Math.max(0, reward).toFixed(4)),
    validSnapshots,
    totalSnapshots: snapshots.length,
    timeValidity: Number(timeValidity.toFixed(4)),
    totalDurationDays,
    validThrough: {
      commit: snapshots[validUntilIndex]?.commit,
      date: snapshots[validUntilIndex]?.date,
      sampleIndex: validUntilIndex
    },
    firstInvalid: firstInvalidIndex === -1 ? null : {
      commit: snapshots[firstInvalidIndex].commit,
      date: snapshots[firstInvalidIndex].date,
      sampleIndex: firstInvalidIndex,
      missingFeatureIds: snapshotResults[firstInvalidIndex].missingFeatureIds
    },
    averageCoverage: Number(averageCoverage.toFixed(4)),
    stability: Number(stability.toFixed(4)),
    genesisCoverage: Number(genesisCoverage.toFixed(4)),
    compactness: Number(compactness.toFixed(4)),
    snapshotResults
  };
}

function renderHistoricalSpecCandidate(result, snapshots, source) {
  const candidate = result.candidate;
  const judgement = result.judgement;
  const selected = candidate.selectedFeatures;
  const lateFeatures = featuresSeenAfterRoot(snapshots, new Set(candidate.selectedFeatureIds));
  const root = snapshots[0];
  const head = snapshots[snapshots.length - 1];
  const lines = [];

  lines.push("# Redis Historical Mined Spec");
  lines.push("");
  lines.push("Status: Generated as-built genesis-stable draft");
  lines.push("");
  lines.push(`Source repo: \`${source.repo}\``);
  lines.push(`Branch/ref judged: \`${source.branch}\``);
  lines.push(`Root commit: \`${source.root}\` (${root.date}, ${root.subject})`);
  lines.push(`Latest judged commit: \`${source.target}\` (${head.date}, ${head.subject})`);
  lines.push(`Prompt policy: \`${candidate.promptId}\``);
  lines.push(`Reward: \`${judgement.reward}\`; time validity: \`${judgement.timeValidity}\`; average coverage: \`${judgement.averageCoverage}\``);
  lines.push("");
  lines.push("## Problem");
  lines.push("");
  lines.push("Redis needs a networked in-memory data-structure server whose command protocol, dataset, persistence, replication, configuration, and tests stay legible across project history.");
  lines.push("");
  lines.push("## Goals");
  lines.push("");
  lines.push("- Redis MUST preserve the role of a networked in-memory data-structure server across the judged history.");
  lines.push("- Redis MUST keep command behavior addressable through client-visible protocol, configuration, persistence, and validation surfaces.");
  lines.push("- Redis SHOULD prefer stable server semantics over implementation details that churn across files or releases.");
  lines.push("");
  lines.push("## Non-Goals");
  lines.push("");
  lines.push("- This mined spec does not claim that features introduced after the root commit existed at the root commit.");
  lines.push("- This mined spec does not describe every implementation file or every later extension.");
  lines.push("- This mined spec is not a release note, API reference, or proof that Redis has no undocumented behavior.");
  lines.push("");
  lines.push("## Stable Essence Requirements");
  lines.push("");
  for (const feature of selected) {
    lines.push(`- ${feature.claim}`);
    lines.push(`  Evidence: ${feature.evidencePaths.length ? feature.evidencePaths.map((item) => `\`${item}\``).join(", ") : "source text signal"}. Presence: ${(feature.presence * 100).toFixed(1)}% of judged samples; first seen ${feature.firstSeenDate}.`);
  }
  lines.push("");
  lines.push("## Validation Surfaces");
  lines.push("");
  lines.push("- The Redis spec MUST be judged against sampled Git snapshots without checking out or modifying the Redis repository.");
  lines.push("- A Redis command, protocol, dataset, persistence, replication, configuration, or test claim is valid for a snapshot only when its mined feature evidence is present in that snapshot.");
  lines.push("- The reward MUST prefer long temporal validity, then coverage of high-weight Redis essence features, then compactness.");
  lines.push("");
  lines.push("## Risks");
  lines.push("");
  lines.push("- A mined Redis spec risks overfitting file names, so stable claims SHOULD keep source-path or source-text evidence.");
  lines.push("- A root-stable Redis spec risks under-covering later features, so later-only features MUST be reported as drift instead of silently backdated.");
  lines.push("- A valid sampled history is not a proof of maintainer intent; human review remains REQUIRED before accepting the mined draft as a project spec.");
  lines.push("");
  lines.push("## Later Feature Drift Not Folded Into The Genesis Spec");
  lines.push("");
  if (!lateFeatures.length) {
    lines.push("No later-only feature candidates were detected outside the selected genesis-stable claims.");
  } else {
    for (const feature of lateFeatures.slice(0, 20)) {
      lines.push(`- \`${feature.id}\`: ${feature.title}; first seen ${feature.firstSeenDate}; presence ${(feature.presence * 100).toFixed(1)}%.`);
    }
  }
  lines.push("");
  lines.push("## Judge Result");
  lines.push("");
  lines.push(`- Valid sampled snapshots: ${judgement.validSnapshots}/${judgement.totalSnapshots}.`);
  lines.push(`- Valid through: ${judgement.validThrough.date} at \`${judgement.validThrough.commit}\`.`);
  if (judgement.firstInvalid) {
    lines.push(`- First invalid sample: ${judgement.firstInvalid.date} at \`${judgement.firstInvalid.commit}\`; missing ${judgement.firstInvalid.missingFeatureIds.join(", ")}.`);
  } else {
    lines.push("- First invalid sample: none in the judged sample set.");
  }
  lines.push("");
  return `${lines.join("\n")}\n`;
}

function renderHistoricalJudgeReport(loop, snapshots, source) {
  const best = loop.best;
  const lines = [];
  lines.push("# Historical Spec Mining Judge Report");
  lines.push("");
  lines.push(`Repo: \`${source.repo}\``);
  lines.push(`Root: \`${source.root}\``);
  lines.push(`Target: \`${source.target}\``);
  lines.push(`Samples: ${snapshots.length}`);
  lines.push("");
  lines.push("## Objective");
  lines.push("");
  lines.push("Maximize the amount of project history for which a spec written at the beginning remains valid, while still covering the high-weight essence of the system.");
  lines.push("");
  lines.push("## Best Prompt Policy");
  lines.push("");
  lines.push(`- Prompt ID: \`${best.prompt.id}\``);
  lines.push(`- Reward: \`${best.judgement.reward}\``);
  lines.push(`- Time validity: \`${best.judgement.timeValidity}\``);
  lines.push(`- Average coverage: \`${best.judgement.averageCoverage}\``);
  lines.push(`- Stability: \`${best.judgement.stability}\``);
  lines.push(`- Genesis coverage: \`${best.judgement.genesisCoverage}\``);
  lines.push("");
  lines.push("## Writer Prompt");
  lines.push("");
  lines.push(best.prompt.writerPrompt);
  lines.push("");
  lines.push("## Judge Prompt");
  lines.push("");
  lines.push(best.prompt.judgePrompt);
  lines.push("");
  lines.push("## Episode Scores");
  lines.push("");
  for (const episode of loop.episodes) {
    const ranked = episode.results.slice().sort((left, right) => right.reward - left.reward);
    const winner = ranked[0];
    lines.push(`- Episode ${episode.episode}: best \`${winner.promptId}\` reward \`${winner.reward}\`, valid ${winner.validSnapshots}/${winner.totalSnapshots}, coverage \`${winner.averageCoverage}\`.`);
  }
  lines.push("");
  lines.push("## Sample Validity");
  lines.push("");
  for (const result of best.judgement.snapshotResults) {
    lines.push(`- ${result.date} \`${result.short}\`: ${result.valid ? "valid" : "invalid"}, coverage \`${result.coverage}\`${result.missingFeatureIds.length ? `, missing ${result.missingFeatureIds.join(", ")}` : ""}.`);
  }
  lines.push("");
  return `${lines.join("\n")}\n`;
}

function basePromptPolicies() {
  return [
    {
      id: "genesis-stable-essence",
      requireRoot: true,
      minPresence: 0.82,
      maxClaims: 12,
      detailPenalty: 0.002,
      writerPrompt: "Write a compact as-built spec from the first snapshot. Include only high-essence claims that are evidenced at the root and remain stable through later snapshots.",
      judgePrompt: "Reward temporal validity first, then essence coverage. Penalize claims absent from the first snapshot."
    },
    {
      id: "broad-root-contract",
      requireRoot: true,
      minPresence: 0.62,
      maxClaims: 18,
      detailPenalty: 0.003,
      writerPrompt: "Write a broader root-era contract. Include root-evidenced claims unless they churn too much across history.",
      judgePrompt: "Reward coverage of root-visible behavior and tolerate moderate later drift only when essence coverage improves."
    },
    {
      id: "future-aware-project-spec",
      requireRoot: false,
      minPresence: 0.55,
      maxClaims: 20,
      detailPenalty: 0.004,
      writerPrompt: "Write a project-wide spec that covers as many later features as possible.",
      judgePrompt: "Reject future-only claims when they make the beginning-of-history spec false."
    },
    {
      id: "minimal-constitution",
      requireRoot: true,
      minPresence: 0.92,
      maxClaims: 8,
      detailPenalty: 0.001,
      writerPrompt: "Write only the constitution of the project: the smallest claims likely to stay true for the full history.",
      judgePrompt: "Reward long validity and compactness. Penalize low coverage."
    }
  ];
}

function mutatePromptPolicies(bestPrompt, episode) {
  const baseId = bestPrompt.id.split(":")[0];
  const threshold = bestPrompt.minPresence;
  const maxClaims = bestPrompt.maxClaims;
  return [
    {
      ...bestPrompt,
      id: `${baseId}-keep`,
      minPresence: threshold,
      maxClaims,
      writerPrompt: `${bestPrompt.writerPrompt} Keep the current threshold.`
    },
    {
      ...bestPrompt,
      id: `${baseId}-wider-${episode}`,
      minPresence: Math.max(0.45, threshold - 0.08),
      maxClaims: Math.min(24, maxClaims + 4),
      detailPenalty: bestPrompt.detailPenalty + 0.001,
      writerPrompt: `${bestPrompt.writerPrompt} Widen coverage if claims still stay valid.`
    },
    {
      ...bestPrompt,
      id: `${baseId}-stricter-${episode}`,
      minPresence: Math.min(0.98, threshold + 0.06),
      maxClaims: Math.max(6, maxClaims - 2),
      detailPenalty: Math.max(0.0005, bestPrompt.detailPenalty - 0.0005),
      writerPrompt: `${bestPrompt.writerPrompt} Tighten to claims with stronger temporal support.`
    },
    {
      ...bestPrompt,
      id: `${baseId}-probe-future-${episode}`,
      requireRoot: false,
      minPresence: Math.max(0.5, threshold - 0.14),
      maxClaims: Math.min(26, maxClaims + 6),
      detailPenalty: bestPrompt.detailPenalty + 0.002,
      writerPrompt: "Probe whether adding later-only project features improves reward without breaking root validity."
    }
  ];
}

function featurePresenceStats(snapshots) {
  const stats = new Map();
  snapshots.forEach((snapshot, index) => {
    for (const feature of snapshot.features) {
      const entry = stats.get(feature.id) ?? {
        id: feature.id,
        title: feature.title,
        category: feature.category,
        essenceWeight: feature.essenceWeight,
        claim: feature.claim,
        count: 0,
        presentSnapshots: [],
        firstSeenCommit: snapshot.commit,
        firstSeenDate: snapshot.date,
        firstSeenIndex: index,
        evidencePaths: new Set()
      };
      entry.count += 1;
      entry.presentSnapshots.push(snapshot.short);
      if (index < entry.firstSeenIndex) {
        entry.firstSeenCommit = snapshot.commit;
        entry.firstSeenDate = snapshot.date;
        entry.firstSeenIndex = index;
      }
      for (const evidencePath of feature.evidence.paths) entry.evidencePaths.add(evidencePath);
      stats.set(feature.id, entry);
    }
  });
  for (const entry of stats.values()) {
    entry.presence = entry.count / snapshots.length;
    entry.presentAtRoot = entry.presentSnapshots.includes(snapshots[0].short);
  }
  return stats;
}

function featureSelectionScore(stat, prompt) {
  const categoryBias = stat.category === "core" ? 1.2 : stat.category === "extension" ? 0.82 : 1;
  return (stat.essenceWeight * categoryBias * stat.presence) +
    (stat.presentAtRoot ? 1.5 : -2) -
    (prompt.detailPenalty * 10);
}

function featuresSeenAfterRoot(snapshots, selected) {
  const stats = Array.from(featurePresenceStats(snapshots).values());
  return stats
    .filter((feature) => !feature.presentAtRoot && !selected.has(feature.id))
    .sort((left, right) => left.firstSeenIndex - right.firstSeenIndex || right.essenceWeight - left.essenceWeight);
}

function resultSummary(result) {
  return {
    promptId: result.prompt.id,
    reward: result.judgement.reward,
    selectedFeatureIds: result.candidate.selectedFeatureIds,
    validSnapshots: result.judgement.validSnapshots,
    totalSnapshots: result.judgement.totalSnapshots,
    timeValidity: result.judgement.timeValidity,
    averageCoverage: result.judgement.averageCoverage,
    firstInvalid: result.judgement.firstInvalid
  };
}

function compactResult(result) {
  return {
    episode: result.episode,
    prompt: result.prompt,
    candidate: result.candidate,
    judgement: result.judgement
  };
}

function snapshotSummary(snapshot) {
  return {
    commit: snapshot.commit,
    short: snapshot.short,
    date: snapshot.date,
    subject: snapshot.subject,
    fileCount: snapshot.fileCount,
    topLevelEntries: snapshot.topLevelEntries,
    evidenceFiles: snapshot.evidenceFiles,
    featureIds: snapshot.features.map((feature) => feature.id)
  };
}

function topLevelEntries(files) {
  return Array.from(new Set(files.map((file) => file.split("/")[0]))).sort().slice(0, 80);
}

function stripHtml(text) {
  return String(text)
    .replace(/<script[\s\S]*?<\/script>/gi, " ")
    .replace(/<style[\s\S]*?<\/style>/gi, " ")
    .replace(/<[^>]+>/g, " ")
    .replace(/&quot;/g, '"')
    .replace(/&nbsp;/g, " ")
    .replace(/&amp;/g, "&")
    .replace(/\s+/g, " ");
}

function durationDays(left, right) {
  const leftMs = Number(left.timestamp) * 1000;
  const rightMs = Number(right.timestamp) * 1000;
  if (!Number.isFinite(leftMs) || !Number.isFinite(rightMs)) return 1;
  return Math.max(0, Math.round((rightMs - leftMs) / DAY_MS));
}

function average(values) {
  const finite = values.filter((value) => Number.isFinite(value));
  if (!finite.length) return 0;
  return finite.reduce((sum, value) => sum + value, 0) / finite.length;
}
