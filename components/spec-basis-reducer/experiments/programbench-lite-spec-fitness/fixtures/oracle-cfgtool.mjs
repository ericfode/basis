#!/usr/bin/env node
import fs from "node:fs";

function main() {
  const parsed = parseArgs(process.argv.slice(2));
  if (parsed.error) return usage();

  const input = readInput(parsed.file);
  if (input.error) return usage();

  const config = parseConfig(input.text, parsed.strict);
  if (config.error) {
    console.error(`cfgtool: invalid line ${config.line}: ${config.original}`);
    process.exit(2);
  }

  if (parsed.command === "get") return runGet(parsed, config);
  if (parsed.command === "list") return runList(parsed, config);
  if (parsed.command === "summary") return runSummary(parsed, config);
  return usage();
}

function parseArgs(args) {
  const out = { format: "text", strict: false, positional: [] };
  for (let index = 0; index < args.length; index += 1) {
    const arg = args[index];
    if (arg === "--strict") {
      out.strict = true;
    } else if (arg === "--format") {
      const value = args[index + 1];
      if (value !== "text" && value !== "json") return { error: true };
      out.format = value;
      index += 1;
    } else if (arg.startsWith("--format=")) {
      const value = arg.slice("--format=".length);
      if (value !== "text" && value !== "json") return { error: true };
      out.format = value;
    } else if (arg.startsWith("--")) {
      return { error: true };
    } else {
      out.positional.push(arg);
    }
  }

  out.command = out.positional[0];
  if (!out.command) return { error: true };

  if (out.command === "get") {
    if (out.positional.length < 2 || out.positional.length > 3) return { error: true };
    out.path = out.positional[1];
    out.file = out.positional[2] || null;
  } else if (out.command === "list") {
    if (out.positional.length > 3) return { error: true };
    out.section = out.positional.length === 3 ? out.positional[1] : null;
    out.file = out.positional.length === 3 ? out.positional[2] : out.positional[1] || null;
  } else if (out.command === "summary") {
    if (out.positional.length > 2) return { error: true };
    out.file = out.positional[1] || null;
  } else {
    return { error: true };
  }

  return out;
}

function readInput(file) {
  try {
    return { text: file ? fs.readFileSync(file, "utf8") : fs.readFileSync(0, "utf8") };
  } catch {
    return { error: true };
  }
}

function parseConfig(text, strict) {
  const sections = new Map();
  let current = "default";
  let duplicates = 0;

  const lines = String(text).split(/\r?\n/);
  for (let index = 0; index < lines.length; index += 1) {
    const original = lines[index];
    const trimmed = original.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;

    if (trimmed.startsWith("[") && trimmed.endsWith("]")) {
      const name = trimmed.slice(1, -1).trim();
      if (!name) {
        if (strict) return { error: true, line: index + 1, original };
        continue;
      }
      current = name;
      continue;
    }

    const eq = original.indexOf("=");
    if (eq < 0) {
      if (strict) return { error: true, line: index + 1, original };
      continue;
    }

    const key = original.slice(0, eq).trim();
    let value = original.slice(eq + 1).trim();
    if (!key) {
      if (strict) return { error: true, line: index + 1, original };
      continue;
    }

    value = normalizeValue(value);
    if (!sections.has(current)) sections.set(current, new Map());
    const section = sections.get(current);
    if (section.has(key)) duplicates += 1;
    section.set(key, value);
  }

  return { sections, duplicates };
}

function normalizeValue(value) {
  if (
    value.length >= 2 &&
    ((value.startsWith('"') && value.endsWith('"')) ||
      (value.startsWith("'") && value.endsWith("'")))
  ) {
    return value.slice(1, -1);
  }

  const comment = value.search(/\s#/);
  if (comment >= 0) return value.slice(0, comment).trim();
  return value;
}

function runGet(parsed, config) {
  const [sectionName, key] = splitPath(parsed.path);
  const section = config.sections.get(sectionName);
  if (!section || !section.has(key)) {
    console.error(`cfgtool: missing key ${parsed.path}`);
    process.exit(1);
  }

  const value = section.get(key);
  if (parsed.format === "json") console.log(JSON.stringify({ path: parsed.path, value }));
  else console.log(value);
}

function runList(parsed, config) {
  if (parsed.section) {
    const section = config.sections.get(parsed.section);
    if (!section || section.size === 0) {
      console.error(`cfgtool: missing section ${parsed.section}`);
      process.exit(1);
    }
    const rows = [...section.entries()]
      .sort(([a], [b]) => a.localeCompare(b))
      .map(([key, value]) => ({ key, value }));
    if (parsed.format === "json") console.log(JSON.stringify(rows));
    else console.log(rows.map(row => `${row.key}=${row.value}`).join("\n"));
    return;
  }

  const rows = [];
  for (const [sectionName, section] of config.sections) {
    for (const [key, value] of section) rows.push({ path: `${sectionName}.${key}`, value });
  }
  rows.sort((a, b) => a.path.localeCompare(b.path));
  if (parsed.format === "json") console.log(JSON.stringify(rows));
  else console.log(rows.map(row => `${row.path}=${row.value}`).join("\n"));
}

function runSummary(parsed, config) {
  let sectionCount = 0;
  let keyCount = 0;
  for (const section of config.sections.values()) {
    if (section.size > 0) sectionCount += 1;
    keyCount += section.size;
  }

  const summary = { sections: sectionCount, keys: keyCount, duplicates: config.duplicates };
  if (parsed.format === "json") console.log(JSON.stringify(summary));
  else console.log(`sections:${summary.sections}\nkeys:${summary.keys}\nduplicates:${summary.duplicates}`);
}

function splitPath(path) {
  const index = String(path).indexOf(".");
  if (index < 0) return ["default", path];
  return [path.slice(0, index), path.slice(index + 1)];
}

function usage() {
  console.error("cfgtool: usage");
  process.exit(2);
}

main();
