import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";

const CASES = [
  {
    name: "get trims quote and inline comment",
    args: ["get", "database.host"],
    stdin: `
# production config
[database]
host = "db.internal" # primary
port = 5432
`,
    expect: out("db.internal\n")
  },
  {
    name: "json get",
    args: ["get", "database.port", "--format=json"],
    stdin: "[database]\nport = 5432\n",
    expect: out('{"path":"database.port","value":"5432"}\n')
  },
  {
    name: "default section path",
    args: ["get", "default.name"],
    stdin: "name = alpha\n[other]\nname = beta\n",
    expect: out("alpha\n")
  },
  {
    name: "list all sorted full paths",
    args: ["list"],
    stdin: "[z]\nb=2\n[a]\nc=3\na=1\n",
    expect: out("a.a=1\na.c=3\nz.b=2\n")
  },
  {
    name: "list section json",
    args: ["list", "app", "--format", "json"],
    stdin: "[app]\nz = last\na = first\n",
    expect: out('[{"key":"a","value":"first"},{"key":"z","value":"last"}]\n')
  },
  {
    name: "summary duplicates",
    args: ["summary"],
    stdin: "root = yes\n[app]\na=1\na=2\n[empty]\n# no keys\n",
    expect: out("sections:2\nkeys:2\nduplicates:1\n")
  },
  {
    name: "strict invalid line",
    args: ["summary", "--strict"],
    stdin: "[app]\nvalid = yes\nthis is broken\n",
    expect: err(2, "cfgtool: invalid line 3: this is broken\n")
  },
  {
    name: "lenient ignores invalid line",
    args: ["summary"],
    stdin: "[app]\nvalid = yes\nthis is broken\n",
    expect: out("sections:1\nkeys:1\nduplicates:0\n")
  },
  {
    name: "missing key",
    args: ["get", "app.missing"],
    stdin: "[app]\nname = demo\n",
    expect: err(1, "cfgtool: missing key app.missing\n")
  },
  {
    name: "missing section",
    args: ["list", "missing"],
    stdin: "[app]\nname = demo\n",
    expect: err(1, "cfgtool: missing section missing\n")
  },
  {
    name: "usage bad format",
    args: ["summary", "--format", "yaml"],
    stdin: "",
    expect: err(2, "cfgtool: usage\n")
  },
  {
    name: "reads file argument",
    args: ["summary", "__FILE__"],
    fileText: "[one]\na=1\n[two]\nb=2\n",
    expect: out("sections:2\nkeys:2\nduplicates:0\n")
  }
];

const WEIGHTS = {
  interface: 0.1,
  behavior: 0.3,
  edgeCases: 0.2,
  errors: 0.15,
  json: 0.15,
  fileInput: 0.1
};

function main() {
  const files = process.argv.slice(2);
  if (!files.length) {
    console.error("Usage: node evaluator.mjs <solution.mjs>...");
    process.exit(2);
  }

  const results = files.map(evaluateFile);
  console.log(JSON.stringify({ results, summary: summarize(results) }, null, 2));
}

function evaluateFile(file) {
  const vector = {
    interface: 0,
    behavior: 0,
    edgeCases: 0,
    errors: 0,
    json: 0,
    fileInput: 0
  };
  const failures = [];

  if (!fs.existsSync(file)) {
    failures.push("missing solution file");
    return finish(file, vector, failures);
  }

  const syntax = spawnSync(process.execPath, ["--check", file], { encoding: "utf8" });
  if (syntax.status === 0) vector.interface = 1;
  else {
    failures.push(`syntax check failed: ${syntax.stderr || syntax.stdout}`.trim());
    return finish(file, vector, failures);
  }

  const buckets = {
    behavior: [0, 1, 2, 3, 5, 7],
    edgeCases: [0, 2, 5, 7],
    errors: [6, 8, 9, 10],
    json: [1, 4],
    fileInput: [11]
  };
  const pass = new Set();

  CASES.forEach((testCase, index) => {
    const actual = runCase(file, testCase);
    if (matches(actual, testCase.expect)) {
      pass.add(index);
    } else {
      failures.push(`${testCase.name}: expected status ${testCase.expect.status}, stdout ${JSON.stringify(testCase.expect.stdout)}, stderr ${JSON.stringify(testCase.expect.stderr)}; got status ${actual.status}, stdout ${JSON.stringify(actual.stdout)}, stderr ${JSON.stringify(actual.stderr)}`);
    }
  });

  for (const [bucket, indexes] of Object.entries(buckets)) {
    vector[bucket] = indexes.filter(index => pass.has(index)).length / indexes.length;
  }

  return finish(file, vector, failures);
}

function runCase(file, testCase) {
  const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), "cfgtool-case-"));
  const args = [...testCase.args];
  let stdin = testCase.stdin || "";
  const fileIndex = args.indexOf("__FILE__");
  if (fileIndex >= 0) {
    const inputPath = path.join(tempDir, "input.conf");
    fs.writeFileSync(inputPath, testCase.fileText || "", "utf8");
    args[fileIndex] = inputPath;
    stdin = "";
  }

  const child = spawnSync(process.execPath, [file, ...args], {
    input: stdin,
    encoding: "utf8",
    timeout: 4_000
  });

  return {
    status: child.status ?? 124,
    stdout: child.stdout || "",
    stderr: child.stderr || ""
  };
}

function out(stdout) {
  return { status: 0, stdout, stderr: "" };
}

function err(status, stderr) {
  return { status, stdout: "", stderr };
}

function matches(actual, expected) {
  return actual.status === expected.status &&
    actual.stdout === expected.stdout &&
    actual.stderr === expected.stderr;
}

function finish(file, vector, failures) {
  const total = Object.entries(WEIGHTS)
    .reduce((sum, [key, weight]) => sum + vector[key] * weight, 0);

  return {
    file,
    vector,
    total: Number(total.toFixed(4)),
    failures
  };
}

function summarize(results) {
  const groups = new Map();
  for (const result of results) {
    const condition = result.file.includes("/good-") ? "good" : result.file.includes("/bad-") ? "bad" : "unknown";
    if (!groups.has(condition)) groups.set(condition, []);
    groups.get(condition).push(result.total);
  }

  return Object.fromEntries([...groups].map(([condition, totals]) => {
    const sorted = [...totals].sort((a, b) => a - b);
    const mean = totals.reduce((sum, value) => sum + value, 0) / totals.length;
    return [condition, {
      n: totals.length,
      mean: Number(mean.toFixed(4)),
      median: sorted[Math.floor(sorted.length / 2)] ?? null,
      min: sorted[0] ?? null,
      max: sorted[sorted.length - 1] ?? null
    }];
  }));
}

main();
