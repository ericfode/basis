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
  "data-pin-section",
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
assertIncludes(app, "function recordDecisionConfig", "Record review buttons must share explicit action semantics.");
assertIncludes(app, "data-action-effect", "Reviewer action buttons must expose what the click will do before submission.");
assertIncludes(app, "Review event persisted: rejected as pressure", "Rejected proposal records must show persisted review state.");
assertIncludes(app, "source text and accepted Basis state are unchanged", "Record action copy must preserve the proposal/acceptance boundary.");
assertIncludes(app, "renderRecordActionHelp", "Proposal record cards must explain that actions append review events.");
assertIncludes(css, ".record-action-help", "Proposal record action effect help must be visibly styled.");
assertIncludes(app, "function buildShapeProjection", "Build-shape diagram must be sourced from explicit thread output.");
assertIncludes(app, "rootOrientationJob()", "Build-shape diagram must prefer the root orientation thread created on spec load.");
assertIncludes(app, "result.build_shape", "Build-shape diagram must render an explicit build_shape result packet.");
assertIncludes(app, "function buildShapeFromThreadResult", "Old completed threads without explicit build_shape must derive the diagram from their own result.");
assertIncludes(app, "derived from completed lens output", "Derived build-shape fallback must cite thread output, not static document structure.");
assertIncludes(app, "function renderDerivedPanelEmpty", "Derived panels must render empty until model output exists.");
assertIncludes(app, "Waiting for root-generated build shape.", "Build-shape panel must stay empty until the root thread generates the diagram.");
assertIncludes(app, "Waiting for source-derived interpretation.", "Narrative panel must stay empty on newly loaded specs before reducer output.");
assertIncludes(app, "let pinnedSectionId = null", "Source sections must have an explicit pinned focus state.");
assertIncludes(app, "data-pin-section", "Section gutters must expose pin controls.");
assertIncludes(app, "if (pinnedSectionId) return;", "Pinned sections must disable scroll-driven focus changes.");
assertIncludes(css, ".section-pin-toggle", "Section pin controls must be visibly styled.");
assertIncludes(app, "function threadJobsForInspector", "Thread inspector must include global synthesis jobs as well as visible-section jobs.");
assertIncludes(app, "function renderJobImpactSummary", "Thread cards must expose result impacts and source anchors.");
assertIncludes(app, "Spec impact", "Thread cards must label what each thread changed or proposed against the spec.");
assertIncludes(html, 'id="topbarActivity"', "Run activity/details control must live in the top bar.");
assertOrder(html, 'id="reasoningEffort"', 'id="topbarActivity"', "Run activity must sit after reasoning in the header controls.");
assertOrder(html, 'id="topbarActivity"', 'id="maxConcurrency"', "Run activity must sit to the left of the concurrency selector.");
assertIncludes(css, ".topbar-activity", "Top bar activity panel must be styled outside the document body.");
assertIncludes(css, ".topbar-activity:empty", "Empty run activity must not reserve a second header row.");
assertIncludes(css, ".studio-state:empty", "Empty hero state chips must be hidden.");
assertIncludes(css, ".studio-source-title", "Hero lead text must be styled as the loaded spec title.");
assertIncludes(app, "function studioTitleText", "Hero lead text must be derived from the loaded spec title.");
assertIncludes(app, 'els.studioRunState.innerHTML = "";', "Useless hero state chips must not render.");
assertIncludes(html, 'id="reasoningEffort"', "Reducer header must expose reasoning effort, not editable projection targets.");
assertIncludes(html, '<option value="low" selected>low</option>', "Reducer reasoning effort must default to low.");
assertIncludes(html, 'id="maxConcurrency" type="number" min="1" max="10" value="10"', "Reducer concurrency must default to 10 in the header.");
assertIncludes(app, "const DEFAULT_TARGETS", "Projection targets must stay as internal reducer defaults.");
assertIncludes(app, "const DEFAULT_CONCURRENCY = 10", "Reducer start payload must own the concurrency default.");
assertIncludes(app, "model_effort: selectedReasoningEffort()", "Started reducer runs must send the selected reasoning effort.");
assertIncludes(app, "max_concurrency: Number(els.maxConcurrency.value || DEFAULT_CONCURRENCY)", "Started reducer runs must send the selected concurrency value.");
assertIncludes(app, 'if (kind === "coupled") return "needs split";', "Coupled projection pressure must use clear split wording.");
assertIncludes(app, "impactMeaningForKind(active.kind)", "Selected projection impact must explain terse pressure labels.");
assertIncludes(app, 'renderSemanticActionButtons(detailRow, noteBody, "projection_impact")', "Projection detail actions must use model-suggested semantic actions.");
assertIncludes(app, 'renderSemanticActionButtons(row, `Review pressure: ${row.title}. ${row.impact}`, "decision")', "Decision cards must use model-suggested semantic actions.");
assertIncludes(app, "function reviewerActionLabel", "Reviewer action labels must normalize generic model actions into readable UI actions.");
assertIncludes(app, 'return "Ask split plan";', "Coupled synthesis actions must present an explicit split option.");
assertIncludes(app, "function decisionPrompt", "Right sidebar decision cards must present reviewer choices, not factual claims.");
assertIncludes(app, "Proposal under review", "Decision cards must label claims as proposals under review.");
assertIncludes(app, "Should this proposal stay in the working packet?", "Decision cards must be phrased as choices.");
assertIncludes(css, ".decision-proposal-label", "Decision proposal labels must be visibly styled.");
assertIncludes(app, "function openHintDetails", "Top bar activity details must open a concrete job detail target.");
assertIncludes(app, "button.addEventListener(\"click\", openHintDetails)", "Top bar activity details button must be bound to the detail opener.");
assertIncludes(app, '${job.id === selectedJobId ? "open" : ""}', "Selected thread card must render open for visible details.");
assertIncludes(app, '<summary data-focus-job=', "Every thread summary must focus its own job when clicked.");
assertIncludes(app, "function streamEventLabel", "Thread stream counts must be labelled as projected recent events.");
assertIncludes(app, "recent ${count === 1 ? \"event\" : \"events\"} shown", "Thread stream labels must not read as total Codex event counts.");
assertIncludes(app, "not total Codex thread size or turn budget", "Thread cards must explain the projected stream-tail cap.");
assertIncludes(app, "function feedbackProjectImpact", "Feedback preview must compute projection pressure before apply.");
assertIncludes(app, "function feedbackDocumentChangePlan", "Feedback preview must compute document-level changes before apply.");
assertIncludes(app, "function feedbackModelContextForLine", "Feedback preview must use current reducer lens output for the selected source line.");
assertIncludes(app, "Source quote", "Feedback preview must quote the selected source text.");
assertIncludes(app, "Model reading", "Feedback preview must show the current model reading.");
assertIncludes(app, "Guidance says", "Feedback preview must quote the entered guidance.");
assertIncludes(app, "Would change", "Feedback preview must explain the document-level change.");
assertIncludes(app, "document.addEventListener(\"click\", handleLineFeedbackClick, true)", "Line feedback controls must use a stable delegated listener during live re-renders.");
assertIncludes(app, "installCorpusSamples();\nbindDocumentInteractions();\nconnectEvents();", "Line feedback delegation must be installed during app startup.");
assertIncludes(app, "document.body.dataset.lineFeedbackBound", "Line feedback startup binding must expose a cheap browser-verifiable state marker.");
assertIncludes(app, "event.target instanceof Element", "Line feedback delegation must tolerate text-node click targets.");
assertIncludes(app, "closest?.(\".line-marker\")", "Line feedback delegation must target source line markers.");
assertIncludes(app, "Preview is stale. Update it to compute document changes", "Feedback textarea edits must visibly stale the preview.");
assertIncludes(app, "renderFeedbackPreview(model, \"updated\")", "Update preview must render a computed impact state.");
assertIncludes(app, "Projection pressure", "Feedback preview must show target pressure, not only recording mechanics.");
assertIncludes(css, ".feedback-composer", "Feedback modal must have an explicit overlay container.");
assertIncludes(css, ".feedback-doc-change", "Feedback modal must render document-change quotes distinctly.");
assertIncludes(css, "z-index: 70", "Feedback modal overlay must sit above rails and floating hints.");
assertIncludes(css, "backdrop-filter: blur(3px)", "Feedback modal must visually separate the layer behind it.");
assertIncludes(css, "scroll-margin-top: 240px", "Source line markers must not scroll under the sticky evidence header before clicks.");

if (html.includes('id="targets"') || html.includes("Projection targets")) {
  fail("Projection targets regressed into a user-facing header control.");
}

if (html.includes("What This Wants To Become")) {
  fail("Hero title regressed to the unclear wording.");
}

if (html.includes("Understand This Spec") || app.includes("studioIntroText") || app.includes("accepted Basis state unchanged")) {
  fail("Hero copy regressed to static explainer text or useless state chips.");
}

if (app.includes("Derived from the loaded spec through the current lens summary")) {
  fail("Build-shape panel regressed to a generic local diagram instead of thread-generated build_shape.");
}

if (app.includes("Actions below update proposal")) {
  fail("Narrative regressed into tool-use instructions instead of spec interpretation.");
}

console.log(`Validated ${buttonTags.length} reducer buttons and ${handledControls.length + handledIds.length} control bindings.`);

function assertIncludes(source, needle, message) {
  if (!source.includes(needle)) fail(message);
}

function assertOrder(source, first, second, message) {
  const firstIndex = source.indexOf(first);
  const secondIndex = source.indexOf(second);
  if (firstIndex === -1 || secondIndex === -1 || firstIndex >= secondIndex) fail(message);
}

function compact(value) {
  return value.replace(/\s+/g, " ").trim();
}

function fail(message) {
  console.error(message);
  process.exit(1);
}
