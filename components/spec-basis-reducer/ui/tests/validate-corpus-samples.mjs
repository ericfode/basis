import fs from "node:fs/promises";
import path from "node:path";
import vm from "node:vm";

const scriptDir = path.dirname(new URL(import.meta.url).pathname);
const repoRoot = path.resolve(scriptDir, "../../../..");
const samplesPath = path.resolve(scriptDir, "../reducer-corpus-samples.js");
const fixturePath = path.resolve(scriptDir, "../fixtures/corpus-samples.js");

const source = await fs.readFile(samplesPath, "utf8");
const fixture = await fs.readFile(fixturePath, "utf8");

if (!fixture.includes('export { CORPUS_SAMPLES } from "../reducer-corpus-samples.js";')) {
  fail("fixtures/corpus-samples.js must re-export reducer-corpus-samples.js to avoid dropdown drift.");
}

const samples = vm.runInNewContext(
  `${source.replace("export const CORPUS_SAMPLES =", "const CORPUS_SAMPLES =")}\nCORPUS_SAMPLES;`,
  {},
  { filename: samplesPath }
);

const bannedPathTerms = /\b(?:bad|badstyle|suboptimal|minimum-implied|degraded)\b/i;
const bannedLabelTerms = /\b(?:bad|suboptimal|minimum|degraded|toy|sketch)\b/i;
const labels = new Set();
const paths = new Set();

if (!Array.isArray(samples) || samples.length < 6) {
  fail("Expected at least six curated good specs in the dropdown.");
}

for (const [index, sample] of samples.entries()) {
  const prefix = `sample ${index + 1} (${sample?.label || "unlabeled"})`;
  requireText(sample.label, `${prefix}: label`);
  requireText(sample.dossier, `${prefix}: dossier`);
  requireText(sample.docType, `${prefix}: docType`);
  requireText(sample.path, `${prefix}: path`);
  requireText(sample.whyGood, `${prefix}: whyGood`);

  if (sample.quality !== "good_spec") {
    fail(`${prefix}: quality must be exactly "good_spec".`);
  }

  if (path.isAbsolute(sample.path)) {
    fail(`${prefix}: path must be repo-relative, not absolute.`);
  }

  if (bannedPathTerms.test(sample.path) || bannedLabelTerms.test(sample.label)) {
    fail(`${prefix}: dropdown defaults must not point at bad, degraded, or suboptimal specs.`);
  }

  if (labels.has(sample.label)) fail(`${prefix}: duplicate label.`);
  if (paths.has(sample.path)) fail(`${prefix}: duplicate path.`);
  labels.add(sample.label);
  paths.add(sample.path);

  const resolved = path.resolve(repoRoot, sample.path);
  if (!resolved.startsWith(`${repoRoot}${path.sep}`) && resolved !== repoRoot) {
    fail(`${prefix}: path escapes the repository.`);
  }

  let text;
  try {
    text = await fs.readFile(resolved, "utf8");
  } catch (error) {
    fail(`${prefix}: source file does not exist at ${sample.path}.`);
  }

  const lineCount = text.split(/\r?\n/).length;
  if (lineCount < 20) {
    fail(`${prefix}: source file is too small to be a useful reducer sample.`);
  }
}

console.log(`Validated ${samples.length} good reducer dropdown specs.`);

function requireText(value, label) {
  if (typeof value !== "string" || value.trim().length < 3) {
    fail(`${label} must be non-empty text.`);
  }
}

function fail(message) {
  console.error(message);
  process.exit(1);
}
