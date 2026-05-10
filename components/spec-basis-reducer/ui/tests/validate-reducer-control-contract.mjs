import fs from "node:fs/promises";
import path from "node:path";

const scriptDir = path.dirname(new URL(import.meta.url).pathname);
const uiDir = path.resolve(scriptDir, "..");
const appPath = path.join(uiDir, "reducer-app.js");
const htmlPath = path.join(uiDir, "reducer.html");

const app = await fs.readFile(appPath, "utf8");
const html = await fs.readFile(htmlPath, "utf8");
const combined = `${html}\n${app}`;

const handledControls = [
  "data-toggle-section",
  "data-open-inspector",
  "data-focus-job",
  "data-stop-job",
  "data-rerun-job",
  "data-update-feedback-preview",
  "data-cancel-feedback",
  "data-request-synthesis",
  "data-record-note",
  "data-record-decision",
  "data-pressure-decision",
  "data-projection-impact",
  "data-scroll-anchor",
  "data-source-ref",
  "data-semantic-ref",
  "data-preview-choice",
  "data-apply-choice"
];

const handledIds = ["pauseRun", "resumeRun", "toggleInspector"];
const buttonTags = [...combined.matchAll(/<button\b[\s\S]*?>/g)].map(match => match[0]);

if (buttonTags.length < 20) {
  fail(`Expected at least 20 reducer buttons, found ${buttonTags.length}.`);
}

for (const control of handledControls) {
  const allSelector = `querySelectorAll("[${control}`;
  const oneSelector = `querySelector("[${control}`;
  if (!app.includes(allSelector) && !app.includes(oneSelector)) {
    fail(`Missing event binding for ${control}.`);
  }
}

for (const id of handledIds) {
  if (!app.includes(`els.${id}.addEventListener`) && !app.includes(`els.${id}?.addEventListener`)) {
    fail(`Missing explicit listener for #${id}.`);
  }
}

buttonTags.forEach((tag, index) => {
  const handledByData = handledControls.some(control => tag.includes(control));
  const handledById = handledIds.some(id => tag.includes(`id="${id}"`));
  const submitButton = tag.includes('type="submit"');
  const iconSubmit = tag.includes('aria-label="Start run"');

  if (!handledByData && !handledById && !submitButton && !iconSubmit) {
    fail(`Button ${index + 1} has no known control contract: ${compact(tag)}`);
  }
});

assertIncludes(app, "function previewProjectionImpact", "Projection matrix cells must have an explicit preview handler.");
assertIncludes(app, "data-selected", "Projection clicks must expose a visible selected state.");
assertIncludes(app, "renderActionStatus", "Action buttons must render immediate status feedback.");
assertIncludes(app, "setActionStatus(subjectId, \"pending\"", "Long-running actions must show pending feedback.");
assertIncludes(app, "modelBuildShape(job, result, targets, decisions)", "Build-shape diagram must be generated from current lens output.");

if (html.includes("What This Wants To Become")) {
  fail("Hero title regressed to the unclear wording.");
}

console.log(`Validated ${buttonTags.length} reducer buttons and ${handledControls.length + handledIds.length} control bindings.`);

function assertIncludes(source, needle, message) {
  if (!source.includes(needle)) fail(message);
}

function compact(value) {
  return value.replace(/\s+/g, " ").trim();
}

function fail(message) {
  console.error(message);
  process.exit(1);
}
