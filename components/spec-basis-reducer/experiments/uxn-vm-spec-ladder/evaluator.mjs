import fs from "node:fs";
import path from "node:path";
import { pathToFileURL } from "node:url";

const LEVEL_ORDER = ["L0", "L1", "L2", "L3", "L4", "L5"];

const CASES = [
  {
    level: "L0",
    name: "LIT INC BRK",
    rom: [0x80, 0x01, 0x01, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x02])
  },
  {
    level: "L0",
    name: "LIT LIT ADD BRK",
    rom: [0x80, 0x1a, 0x80, 0x2e, 0x18, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x48])
  },
  {
    level: "L0",
    name: "DUP feeds ADD",
    rom: [0x80, 0x12, 0x06, 0x18, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x24])
  },
  {
    level: "L1",
    name: "SWP byte operand order",
    rom: [0x80, 0x12, 0x80, 0x34, 0x04, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x34, 0x12])
  },
  {
    level: "L1",
    name: "GTH compares lower stack item against top",
    rom: [0x80, 0x34, 0x80, 0x12, 0x0a, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x01])
  },
  {
    level: "L1",
    name: "DIV by zero pushes zero",
    rom: [0x80, 0x10, 0x80, 0x00, 0x1b, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x00])
  },
  {
    level: "L1",
    name: "SFT shifts right low nibble then left high nibble",
    rom: [0x80, 0x34, 0x80, 0x10, 0x1f, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x68])
  },
  {
    level: "L2",
    name: "LIT2 pushes high then low byte",
    rom: [0xa0, 0x12, 0x34, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x12, 0x34])
  },
  {
    level: "L2",
    name: "ADD2 consumes shorts and wraps to sixteen bits",
    rom: [0xa0, 0x00, 0x01, 0xa0, 0x00, 0x02, 0x38, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x00, 0x03])
  },
  {
    level: "L2",
    name: "keep mode preserves operands",
    rom: [0x80, 0x02, 0x80, 0x5d, 0x98, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x02, 0x5d, 0x5f])
  },
  {
    level: "L2",
    name: "return-mode literal can be stashed back",
    rom: [0xc0, 0x34, 0x4f, 0x00],
    expect: ({ vm }) => [
      ...expectStack(vm, "wst", [0x34]),
      ...expectStack(vm, "rst", [])
    ]
  },
  {
    level: "L3",
    name: "STZ then LDZ round trips zero-page byte",
    rom: [0x80, 0xab, 0x80, 0x10, 0x11, 0x80, 0x10, 0x10, 0x00],
    expect: ({ vm }) => [
      ...expectStack(vm, "wst", [0xab]),
      ...expectByte(vm.ram, 0x0010, 0xab, "ram[0x0010]")
    ]
  },
  {
    level: "L3",
    name: "STA then LDA round trips absolute byte",
    rom: [0x80, 0xcd, 0xa0, 0x02, 0x00, 0x15, 0xa0, 0x02, 0x00, 0x14, 0x00],
    expect: ({ vm }) => [
      ...expectStack(vm, "wst", [0xcd]),
      ...expectByte(vm.ram, 0x0200, 0xcd, "ram[0x0200]")
    ]
  },
  {
    level: "L3",
    name: "JCN byte mode uses signed offset from post-opcode PC",
    rom: [0x80, 0x01, 0x80, 0x02, 0x0d, 0x80, 0xff, 0x80, 0x2a, 0x00],
    expect: ({ vm }) => expectStack(vm, "wst", [0x2a])
  },
  {
    level: "L3",
    name: "JSR2 stores return address and JMP2r returns",
    rom: [0xa0, 0x01, 0x08, 0x2e, 0x80, 0x99, 0x00, 0x00, 0x80, 0x2a, 0x6c],
    expect: ({ vm }) => [
      ...expectStack(vm, "wst", [0x2a, 0x99]),
      ...expectStack(vm, "rst", [])
    ]
  },
  {
    level: "L4",
    name: "DEO writes console bytes in order",
    rom: [0x80, 0x48, 0x80, 0x18, 0x17, 0x80, 0x69, 0x80, 0x18, 0x17, 0x00],
    expect: ({ vm, writes }) => [
      ...expectArray(writes.map(write => [write.addr, write.value]), [[0x18, 0x48], [0x18, 0x69]], "device writes"),
      ...expectByte(vm.dev, 0x18, 0x69, "dev[0x18]")
    ]
  },
  {
    level: "L4",
    name: "DEI reads from host device hook",
    rom: [0x80, 0x12, 0x16, 0x00],
    dei: addr => (addr === 0x12 ? 0x7a : 0x00),
    expect: ({ vm }) => expectStack(vm, "wst", [0x7a])
  },
  {
    level: "L4",
    name: "DEO2 writes high byte then low byte",
    rom: [0xa0, 0x12, 0x34, 0x80, 0x18, 0x37, 0x00],
    expect: ({ vm, writes }) => [
      ...expectArray(writes.map(write => [write.addr, write.value]), [[0x18, 0x12], [0x19, 0x34]], "device writes"),
      ...expectByte(vm.dev, 0x18, 0x12, "dev[0x18]"),
      ...expectByte(vm.dev, 0x19, 0x34, "dev[0x19]")
    ]
  },
  {
    level: "L5",
    name: "Varvara console program writes Hi and success state",
    rom: [
      0x80, 0x48, 0x80, 0x18, 0x17,
      0x80, 0x69, 0x80, 0x18, 0x17,
      0x80, 0x80, 0x80, 0x0f, 0x17,
      0x00
    ],
    expect: ({ vm, writes }) => [
      ...expectArray(writes.map(write => [write.addr, write.value]), [[0x18, 0x48], [0x18, 0x69], [0x0f, 0x80]], "device writes"),
      ...expectByte(vm.dev, 0x0f, 0x80, "system state")
    ]
  },
  {
    level: "L5",
    name: "Varvara console error program writes error and failure state",
    rom: [
      0x80, 0x45, 0x80, 0x19, 0x17,
      0x80, 0x01, 0x80, 0x0f, 0x17,
      0x00
    ],
    expect: ({ vm, writes }) => [
      ...expectArray(writes.map(write => [write.addr, write.value]), [[0x19, 0x45], [0x0f, 0x01]], "device writes"),
      ...expectByte(vm.dev, 0x0f, 0x01, "system state")
    ]
  },
  {
    level: "L5",
    name: "Varvara ROM subroutine writes console then returns to success",
    rom: [
      0xa0, 0x01, 0x0b, 0x2e,
      0x80, 0x80, 0x80, 0x0f, 0x17, 0x00,
      0x00,
      0x80, 0x4f, 0x80, 0x18, 0x17, 0x6c
    ],
    expect: ({ vm, writes }) => [
      ...expectArray(writes.map(write => [write.addr, write.value]), [[0x18, 0x4f], [0x0f, 0x80]], "device writes"),
      ...expectStack(vm, "rst", [])
    ]
  }
];

async function main() {
  const { maxLevel, files } = parseArgs(process.argv.slice(2));
  if (!files.length) {
    console.error("Usage: node evaluator.mjs [--level L0|L1|L2|L3|L4] <solution.mjs>...");
    process.exit(2);
  }

  const selectedCases = CASES.filter(testCase => levelIndex(testCase.level) <= levelIndex(maxLevel));
  const results = [];
  for (const file of files) {
    results.push(await evaluateFile(file, selectedCases));
  }

  console.log(JSON.stringify({ maxLevel, caseCount: selectedCases.length, results, summary: summarize(results) }, null, 2));
}

function parseArgs(args) {
  let maxLevel = "L5";
  const files = [];
  for (let index = 0; index < args.length; index += 1) {
    if (args[index] === "--level") {
      maxLevel = args[index + 1];
      index += 1;
    } else {
      files.push(args[index]);
    }
  }
  if (!LEVEL_ORDER.includes(maxLevel)) {
    throw new Error(`unknown level ${maxLevel}`);
  }
  return { maxLevel, files };
}

async function evaluateFile(file, selectedCases) {
  const result = {
    file,
    passed: 0,
    total: selectedCases.length,
    byLevel: Object.fromEntries(LEVEL_ORDER.map(level => [level, { passed: 0, total: 0 }])),
    failures: []
  };

  if (!fs.existsSync(file)) {
    result.failures.push("missing solution file");
    return finish(result);
  }

  let factory;
  try {
    const mod = await import(pathToFileURL(path.resolve(file)).href + `?t=${Date.now()}`);
    factory = mod.createUxn || mod.default?.createUxn || mod.default;
    if (typeof factory !== "function") throw new Error("no createUxn function export");
  } catch (error) {
    result.failures.push(`import failed: ${error.message}`);
    return finish(result);
  }

  for (const testCase of selectedCases) {
    result.byLevel[testCase.level].total += 1;
    const failure = runCase(factory, testCase);
    if (failure) {
      result.failures.push(`${testCase.level} ${testCase.name}: ${failure}`);
    } else {
      result.passed += 1;
      result.byLevel[testCase.level].passed += 1;
    }
  }

  return finish(result);
}

function runCase(factory, testCase) {
  const writes = [];
  let vm;
  try {
    vm = factory({
      dei: (addr, currentVm) => byte(testCase.dei ? testCase.dei(addr, currentVm) : currentVm?.dev?.[addr] ?? 0),
      deo: (addr, value) => writes.push({ addr: byte(addr), value: byte(value) })
    });
  } catch (error) {
    return `createUxn threw: ${error.message}`;
  }

  const shapeErrors = validateVmShape(vm);
  if (shapeErrors.length) return shapeErrors.join("; ");

  try {
    vm.load(Uint8Array.from(testCase.rom), 0x0100);
    vm.eval(0x0100, 100000);
  } catch (error) {
    return `runtime threw: ${error.message}`;
  }

  const failures = testCase.expect({ vm, writes });
  return failures.length ? failures.join("; ") : "";
}

function validateVmShape(vm) {
  const failures = [];
  if (!vm || typeof vm !== "object") failures.push("createUxn did not return an object");
  if (!(vm?.ram instanceof Uint8Array) || vm.ram.length !== 65536) failures.push("ram must be Uint8Array(65536)");
  if (!(vm?.dev instanceof Uint8Array) || vm.dev.length !== 256) failures.push("dev must be Uint8Array(256)");
  if (typeof vm?.load !== "function") failures.push("missing load(bytes, offset)");
  if (typeof vm?.eval !== "function") failures.push("missing eval(pc, maxCycles)");
  if (typeof vm?.stack !== "function") failures.push("missing stack(name)");
  return failures;
}

function finish(result) {
  result.score = result.total ? result.passed / result.total : 0;
  for (const level of LEVEL_ORDER) {
    const bucket = result.byLevel[level];
    bucket.score = bucket.total ? bucket.passed / bucket.total : null;
  }
  return result;
}

function expectStack(vm, name, expected) {
  let actual;
  try {
    actual = Array.from(vm.stack(name));
  } catch (error) {
    return [`stack(${name}) threw: ${error.message}`];
  }
  return expectArray(actual, expected, `${name} stack`);
}

function expectArray(actual, expected, label) {
  if (JSON.stringify(actual) === JSON.stringify(expected)) return [];
  return [`${label} expected ${hexArray(expected)}, got ${hexArray(actual)}`];
}

function expectByte(buffer, offset, expected, label) {
  if (byte(buffer[offset]) === byte(expected)) return [];
  return [`${label} expected ${hex(expected)}, got ${hex(buffer[offset])}`];
}

function summarize(results) {
  const scores = results.map(result => result.score);
  return {
    n: results.length,
    mean: scores.reduce((sum, score) => sum + score, 0) / scores.length,
    min: Math.min(...scores),
    max: Math.max(...scores)
  };
}

function levelIndex(level) {
  return LEVEL_ORDER.indexOf(level);
}

function byte(value) {
  return Number(value ?? 0) & 0xff;
}

function hex(value) {
  return `0x${byte(value).toString(16).padStart(2, "0")}`;
}

function hexArray(values) {
  return `[${values.map(value => Array.isArray(value) ? hexArray(value) : hex(value)).join(", ")}]`;
}

main().catch(error => {
  console.error(error.stack || error.message);
  process.exit(1);
});
