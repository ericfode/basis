import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";

const CASES = [
  {
    name: "default current directory hides dotfiles",
    setup: standardTree,
    cwd: "root",
    args: [],
    expect: out("Beta.txt\nalpha.txt\ndir\nlink-alpha\nrun.sh\n")
  },
  {
    name: "all includes dot dotdot and hidden",
    setup: standardTree,
    cwd: "root",
    args: ["-a"],
    expect: out(".\n..\n.hidden\nBeta.txt\nalpha.txt\ndir\nlink-alpha\nrun.sh\n")
  },
  {
    name: "almost all excludes dot dotdot",
    setup: standardTree,
    cwd: "root",
    args: ["-A"],
    expect: out(".hidden\nBeta.txt\nalpha.txt\ndir\nlink-alpha\nrun.sh\n")
  },
  {
    name: "type indicators",
    setup: standardTree,
    cwd: "root",
    args: ["-F"],
    expect: out("Beta.txt\nalpha.txt\ndir/\nlink-alpha@\nrun.sh*\n")
  },
  {
    name: "directory as file",
    setup: standardTree,
    cwd: "root",
    args: ["-dF", "dir"],
    expect: out("dir/\n")
  },
  {
    name: "single directory operand no header",
    setup: standardTree,
    cwd: "root",
    args: ["dir"],
    expect: out("child.txt\nnested\n")
  },
  {
    name: "multiple operands mixed",
    setup: standardTree,
    cwd: "root",
    args: ["dir", "alpha.txt", "Beta.txt"],
    expect: out("Beta.txt\nalpha.txt\n\ndir:\nchild.txt\nnested\n")
  },
  {
    name: "reverse order",
    setup: standardTree,
    cwd: "root",
    args: ["-r"],
    expect: out("run.sh\nlink-alpha\ndir\nalpha.txt\nBeta.txt\n")
  },
  {
    name: "recursive listing",
    setup: standardTree,
    cwd: "root",
    args: ["-R", "dir"],
    expect: out("dir:\nchild.txt\nnested\n\ndir/nested:\ndeep.txt\n")
  },
  {
    name: "recursive all traverses hidden directory",
    setup: standardTree,
    cwd: "root",
    args: ["-aR", "dir"],
    expect: out("dir:\n.\n..\n.hidden-child\nchild.txt\nnested\n\ndir/.hidden-child:\n.\n..\nsecret.txt\n\ndir/nested:\n.\n..\ndeep.txt\n")
  },
  {
    name: "missing operand continues",
    setup: standardTree,
    cwd: "root",
    args: ["missing", "alpha.txt"],
    expect: {
      status: 1,
      stdout: "alpha.txt\n",
      stderr: "ls-lite: cannot access 'missing': No such file or directory\n"
    }
  },
  {
    name: "usage invalid option",
    setup: standardTree,
    cwd: "root",
    args: ["-z"],
    expect: err(2, "ls-lite: usage\n")
  }
];

const WEIGHTS = {
  sourcePolicy: 0.1,
  interface: 0.1,
  listing: 0.25,
  hidden: 0.15,
  indicators: 0.1,
  operands: 0.15,
  recursive: 0.1,
  errors: 0.05
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
    sourcePolicy: 0,
    interface: 0,
    listing: 0,
    hidden: 0,
    indicators: 0,
    operands: 0,
    recursive: 0,
    errors: 0
  };
  const failures = [];

  if (!fs.existsSync(file)) {
    failures.push("missing solution file");
    return finish(file, vector, failures);
  }

  const source = fs.readFileSync(file, "utf8");
  if (!/\bchild_process\b|\bspawnSync\b|\bspawn\b|\bexecFile\b|\bexecSync\b|\bexec\b/.test(source)) {
    vector.sourcePolicy = 1;
  } else {
    failures.push("source policy: delegates to child_process or external command");
  }

  const syntax = spawnSync(process.execPath, ["--check", file], { encoding: "utf8" });
  if (syntax.status === 0) vector.interface = 1;
  else {
    failures.push(`syntax check failed: ${syntax.stderr || syntax.stdout}`.trim());
    return finish(file, vector, failures);
  }

  const pass = new Set();
  CASES.forEach((testCase, index) => {
    const actual = runCase(file, testCase);
    if (matches(actual, testCase.expect)) {
      pass.add(index);
    } else {
      failures.push(`${testCase.name}: expected status ${testCase.expect.status}, stdout ${JSON.stringify(testCase.expect.stdout)}, stderr ${JSON.stringify(testCase.expect.stderr)}; got status ${actual.status}, stdout ${JSON.stringify(actual.stdout)}, stderr ${JSON.stringify(actual.stderr)}`);
    }
  });

  vector.listing = fraction(pass, [0, 5, 7]);
  vector.hidden = fraction(pass, [1, 2, 9]);
  vector.indicators = fraction(pass, [3, 4]);
  vector.operands = fraction(pass, [4, 5, 6, 10]);
  vector.recursive = fraction(pass, [8, 9]);
  vector.errors = fraction(pass, [10, 11]);

  return finish(file, vector, failures);
}

function runCase(file, testCase) {
  const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), "ls-lite-case-"));
  const dirs = testCase.setup(tempDir);
  const cwd = dirs[testCase.cwd] || tempDir;
  const child = spawnSync(process.execPath, [file, ...testCase.args], {
    cwd,
    encoding: "utf8",
    timeout: 4_000
  });

  return {
    status: child.status ?? 124,
    stdout: child.stdout || "",
    stderr: child.stderr || ""
  };
}

function standardTree(base) {
  const root = path.join(base, "root");
  fs.mkdirSync(root, { recursive: true });
  fs.writeFileSync(path.join(root, "alpha.txt"), "alpha\n");
  fs.writeFileSync(path.join(root, "Beta.txt"), "beta\n");
  fs.writeFileSync(path.join(root, ".hidden"), "hidden\n");
  fs.writeFileSync(path.join(root, "run.sh"), "#!/bin/sh\n");
  fs.chmodSync(path.join(root, "run.sh"), 0o755);
  fs.symlinkSync("alpha.txt", path.join(root, "link-alpha"));

  const dir = path.join(root, "dir");
  fs.mkdirSync(dir);
  fs.writeFileSync(path.join(dir, "child.txt"), "child\n");
  fs.mkdirSync(path.join(dir, "nested"));
  fs.writeFileSync(path.join(dir, "nested", "deep.txt"), "deep\n");
  fs.mkdirSync(path.join(dir, ".hidden-child"));
  fs.writeFileSync(path.join(dir, ".hidden-child", "secret.txt"), "secret\n");

  return { root, dir };
}

function fraction(pass, indexes) {
  return indexes.filter(index => pass.has(index)).length / indexes.length;
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
    const condition = result.file.includes("/good-")
      ? "good"
      : result.file.includes("/suboptimal-")
        ? "suboptimal"
        : result.file.includes("/bad-")
          ? "bad"
          : "unknown";
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
