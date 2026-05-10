import fs from "node:fs/promises";
import path from "node:path";

const scriptDir = path.dirname(new URL(import.meta.url).pathname);
const uiDir = path.resolve(scriptDir, "..");
const appPath = path.join(uiDir, "reducer-app.js");
const cssPath = path.join(uiDir, "reducer.css");
const htmlPath = path.join(uiDir, "reducer.html");

const app = await fs.readFile(appPath, "utf8");
const css = await fs.readFile(cssPath, "utf8");
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
assertIncludes(html, 'id="reasoningEffort"', "Reducer header must expose reasoning effort, not editable projection targets.");
assertIncludes(html, '<option value="low" selected>low</option>', "Reducer reasoning effort must default to low.");
assertIncludes(app, "const DEFAULT_TARGETS", "Projection targets must stay as internal reducer defaults.");
assertIncludes(app, "model_effort: selectedReasoningEffort()", "Started reducer runs must send the selected reasoning effort.");
assertIncludes(app, 'if (kind === "coupled") return "needs split";', "Coupled projection pressure must use clear split wording.");
assertIncludes(app, "impactMeaningForKind(active.kind)", "Selected projection impact must explain terse pressure labels.");
assertIncludes(app, 'renderSemanticActionButtons(detailRow, noteBody, "projection_impact")', "Projection detail actions must use model-suggested semantic actions.");
assertIncludes(app, 'renderSemanticActionButtons(row, `Review pressure: ${row.title}. ${row.impact}`, "decision")', "Decision cards must use model-suggested semantic actions.");
assertIncludes(app, "function reviewerActionLabel", "Reviewer action labels must normalize generic model actions into readable UI actions.");
assertIncludes(app, 'return "Ask split plan";', "Coupled synthesis actions must present an explicit split option.");
assertIncludes(app, "function openHintDetails", "Floating hint details must open a concrete job detail target.");
assertIncludes(app, "button.addEventListener(\"click\", openHintDetails)", "Floating hint details button must be bound to the detail opener.");
assertIncludes(app, '${job.id === selectedJobId ? "open" : ""}', "Selected thread card must render open for visible details.");
assertIncludes(app, "function streamEventLabel", "Thread stream counts must be labelled as projected recent events.");
assertIncludes(app, "recent ${count === 1 ? \"event\" : \"events\"} shown", "Thread stream labels must not read as total Codex event counts.");
assertIncludes(app, "not total Codex thread size or turn budget", "Thread cards must explain the projected stream-tail cap.");
assertIncludes(app, "function feedbackProjectImpact", "Feedback preview must compute project impact before apply.");
assertIncludes(app, "document.addEventListener(\"click\", handleLineFeedbackClick, true)", "Line feedback controls must use a stable delegated listener during live re-renders.");
assertIncludes(app, "installCorpusSamples();\nbindDocumentInteractions();\nconnectEvents();", "Line feedback delegation must be installed during app startup.");
assertIncludes(app, "document.body.dataset.lineFeedbackBound", "Line feedback startup binding must expose a cheap browser-verifiable state marker.");
assertIncludes(app, "event.target instanceof Element", "Line feedback delegation must tolerate text-node click targets.");
assertIncludes(app, "closest?.(\".line-marker\")", "Line feedback delegation must target source line markers.");
assertIncludes(app, "Preview is stale. Update it to compute project impact", "Feedback textarea edits must visibly stale the preview.");
assertIncludes(app, "renderFeedbackPreview(model, \"updated\")", "Update preview must render a computed impact state.");
assertIncludes(app, "Project impact", "Feedback preview must show target/project impact, not only recording mechanics.");
assertIncludes(css, ".feedback-composer", "Feedback modal must have an explicit overlay container.");
assertIncludes(css, "z-index: 70", "Feedback modal overlay must sit above rails and floating hints.");
assertIncludes(css, "backdrop-filter: blur(3px)", "Feedback modal must visually separate the layer behind it.");
assertIncludes(css, "scroll-margin-top: 240px", "Source line markers must not scroll under the sticky evidence header before clicks.");

if (html.includes('id="targets"') || html.includes("Projection targets")) {
  fail("Projection targets regressed into a user-facing header control.");
}

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
