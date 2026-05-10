import { CORPUS_SAMPLES } from "./reducer-corpus-samples.js";
import { renderSpecDocument } from "./reducer-spec-document.js";

const els = {
  runMeta: document.querySelector("#runMeta"),
  startForm: document.querySelector("#startForm"),
  corpusSample: document.querySelector("#corpusSample"),
  sourcePath: document.querySelector("#sourcePath"),
  reasoningEffort: document.querySelector("#reasoningEffort"),
  maxConcurrency: document.querySelector("#maxConcurrency"),
  toggleInspector: document.querySelector("#toggleInspector"),
  documentStatus: document.querySelector("#documentStatus"),
  studioEvidenceList: document.querySelector("#studioEvidenceList"),
  hintLayer: document.querySelector("#hintLayer"),
  feedbackComposer: document.querySelector("#feedbackComposer"),
  documentSections: document.querySelector("#documentSections"),
  studioIntro: document.querySelector("#studioIntro"),
  studioRunState: document.querySelector("#studioRunState"),
  studioNarrative: document.querySelector("#studioNarrative"),
  studioBuildShape: document.querySelector("#studioBuildShape"),
  studioProjectionMatrix: document.querySelector("#studioProjectionMatrix"),
  studioDecisionQueue: document.querySelector("#studioDecisionQueue"),
  activeSectionTitle: document.querySelector("#activeSectionTitle"),
  activeSectionMeta: document.querySelector("#activeSectionMeta"),
  connectionState: document.querySelector("#connectionState"),
  threadCount: document.querySelector("#threadCount"),
  threadList: document.querySelector("#threadList"),
  selectedJobLabel: document.querySelector("#selectedJobLabel"),
  visibleOutputs: document.querySelector("#visibleOutputs"),
  liveStream: document.querySelector("#liveStream"),
  contextHash: document.querySelector("#contextHash"),
  contextPacket: document.querySelector("#contextPacket"),
  resultCount: document.querySelector("#resultCount"),
  resultEvidence: document.querySelector("#resultEvidence"),
  pauseRun: document.querySelector("#pauseRun"),
  resumeRun: document.querySelector("#resumeRun"),
  noteForm: document.querySelector("#noteForm"),
  noteBody: document.querySelector("#noteBody")
};

let snapshot = null;
let selectedSectionId = null;
let selectedJobId = null;
let observer = null;
let mermaidPromise = null;
let mermaidRenderCounter = 0;
let refreshInFlight = false;
let refreshPending = false;
let selectedFeedbackLine = null;
let previewTimer = null;
let previewRequestSeq = 0;
let autoBuildTimer = null;
let autoBuildInFlight = false;
let autoBuildMessage = "";
let lastAutoBuildKey = "";
let excludedSectionIds = new Set();
let localFeedbackEvents = [];
let localActionStatuses = new Map();
let activeSourceReference = null;
let activeChoicePreview = null;
let activeProjectionImpact = null;
let suppressSectionObserverUntil = 0;

const API_ORIGIN = window.location.protocol === "file:" ? "http://127.0.0.1:8767" : "";
const REDUCER_MODE = "reducer";
const DEFAULT_TARGETS = ["code", "schema", "proof", "runbook"];
const DEFAULT_REASONING_EFFORT = "low";

function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;");
}

function escapeAttr(value) {
  return escapeHtml(value).replaceAll("'", "&#39;").replace(/\r?\n/g, "&#10;");
}

async function getRun() {
  if (refreshInFlight) {
    refreshPending = true;
    return;
  }

  refreshInFlight = true;
  try {
    const response = await fetch(apiUrl("/api/run"), { cache: "no-store" });
    applySnapshot(await response.json());
  } finally {
    refreshInFlight = false;
    if (refreshPending) {
      refreshPending = false;
      getRun();
    }
  }
}

async function loadPreview(options = {}) {
  if (snapshot?.run_id && !options.force) return;
  const requestId = ++previewRequestSeq;
  const requestedPath = els.sourcePath.value.trim();
  const params = new URLSearchParams({
    source_path: requestedPath
  });
  const response = await fetch(apiUrl(`/api/preview?${params.toString()}`), { cache: "no-store" });
  const preview = await response.json();
  if (requestId !== previewRequestSeq || requestedPath !== els.sourcePath.value.trim()) return;
  if (snapshot?.run_id && snapshot.source?.path === requestedPath) return;
  if (!snapshot?.run_id || options.force) {
    applySnapshot(preview, { force: true, allowPreview: true });
    scheduleAutomaticBuild(preview, options);
  }
}

async function postJson(path, payload) {
  const response = await fetch(apiUrl(path), {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify(payload)
  });
  if (!response.ok) throw new Error(`${path} failed with HTTP ${response.status}`);
  const next = await response.json();
  applySnapshot(next, { force: true });
  return next;
}

function selectedTargets() {
  return DEFAULT_TARGETS;
}

function selectedReasoningEffort() {
  return els.reasoningEffort?.value || DEFAULT_REASONING_EFFORT;
}

function runStartPayload() {
  return {
    mode: REDUCER_MODE,
    source_path: els.sourcePath.value.trim(),
    targets: selectedTargets(),
    model_effort: selectedReasoningEffort(),
    max_concurrency: Number(els.maxConcurrency.value || 4),
    excluded_section_ids: [...excludedSectionIds]
  };
}

function emptyRunCounts() {
  return {
    events: 0,
    sections: 0,
    jobs: 0,
    queued: 0,
    running: 0,
    completed: 0,
    failed: 0,
    stopped: 0,
    codex_threads: 0,
    active_codex_turns: 0,
    records: 0,
    questions: 0
  };
}

function clearRunViewState() {
  selectedSectionId = null;
  selectedJobId = null;
  activeSourceReference = null;
  activeChoicePreview = null;
  activeProjectionImpact = null;
  selectedFeedbackLine = null;
  localFeedbackEvents = [];
  localActionStatuses.clear();
}

function resetProjectionForSourceChange(message) {
  clearRunViewState();
  const sourcePath = els.sourcePath.value.trim();
  if (!snapshot) return;
  snapshot = {
    ...snapshot,
    run_id: null,
    status: "preview",
    provider: "Preview",
    started_at: null,
    updated_at: null,
    source: { path: sourcePath, hash: null, line_count: 0 },
    target_projections: selectedTargets(),
    reasoning_effort: selectedReasoningEffort(),
    counts: emptyRunCounts(),
    sections: [],
    document_sections: [],
    jobs: [],
    context_packets: [],
    streams: {},
    results: [],
    proposed_records: [],
    questions: [],
    imaginer: null,
    interventions: [],
    events: []
  };
  autoBuildMessage = message;
  render();
}

function autoBuildKey() {
  const payload = runStartPayload();
  if (!payload.source_path) return "";
  return JSON.stringify({
    source_path: payload.source_path,
    targets: payload.targets,
    model_effort: payload.model_effort,
    max_concurrency: payload.max_concurrency,
    excluded_section_ids: [...payload.excluded_section_ids].sort()
  });
}

function scheduleAutomaticBuild(preview, options = {}) {
  if (options.autoBuild === false) return;
  if (preview?.run_id) return;
  if (!Array.isArray(preview?.document_sections) || preview.document_sections.length === 0) return;

  const key = autoBuildKey();
  if (!key || key === lastAutoBuildKey || autoBuildInFlight) return;

  clearTimeout(autoBuildTimer);
  autoBuildTimer = setTimeout(startAutomaticBuild, 260);
}

async function startAutomaticBuild() {
  const key = autoBuildKey();
  if (!key || key === lastAutoBuildKey || autoBuildInFlight || snapshot?.run_id) return;

  autoBuildInFlight = true;
  autoBuildMessage = "Starting generated interpretation for this spec.";
  lastAutoBuildKey = key;
  render();

  try {
    await postJson("/api/start", runStartPayload());
    autoBuildMessage = "";
  } catch (error) {
    lastAutoBuildKey = "";
    autoBuildMessage = `Automatic reducer start failed: ${error.message || error}`;
    console.error(error);
  } finally {
    autoBuildInFlight = false;
    render();
  }
}

function connectEvents() {
  const events = new EventSource(apiUrl("/api/events"));
  events.addEventListener("open", () => setConnection("live"));
  events.addEventListener("error", () => setConnection("offline"));
  events.addEventListener("snapshot", event => {
    applySnapshot(JSON.parse(event.data));
  });
  events.addEventListener("event", () => getRun());
}

function apiUrl(path) {
  return `${API_ORIGIN}${path}`;
}

function applySnapshot(next, options = {}) {
  if (!options.allowForeign && isForeignRun(next)) {
    if (!snapshot || snapshot.run_id) {
      snapshot = null;
      loadPreview({ force: true });
    }
    return;
  }

  if (!options.force && !shouldApplySnapshot(next)) return;
  if (next?.run_id && next.run_id !== snapshot?.run_id) {
    localFeedbackEvents = loadLocalFeedbackEvents(next.run_id);
    localActionStatuses.clear();
    activeProjectionImpact = null;
  } else if (!next?.run_id) {
    localFeedbackEvents = [];
    localActionStatuses.clear();
  }
  snapshot = next;
  render();
}

function shouldApplySnapshot(next) {
  if (!next) return false;
  if (isForeignRun(next)) return false;
  if (!snapshot) return true;
  if (!snapshot.run_id) return true;
  if (!next.run_id) return false;

  if (next.run_id !== snapshot.run_id) {
    return timestampValue(next.started_at) >= timestampValue(snapshot.started_at);
  }

  const currentEvents = Number(snapshot.counts?.events || 0);
  const nextEvents = Number(next.counts?.events || 0);
  if (nextEvents < currentEvents) return false;

  const currentUpdated = timestampValue(snapshot.updated_at);
  const nextUpdated = timestampValue(next.updated_at);
  return !currentUpdated || !nextUpdated || nextUpdated >= currentUpdated;
}

function isForeignRun(next) {
  return Boolean(next?.run_id && next.mode && next.mode !== REDUCER_MODE);
}

function timestampValue(value) {
  if (!value) return 0;
  const parsed = Date.parse(value);
  return Number.isNaN(parsed) ? 0 : parsed;
}

function setConnection(state) {
  els.connectionState.textContent = state;
  els.connectionState.classList.toggle("live", state === "live");
}

function setInspectorOpen(open) {
  document.body.dataset.inspectorOpen = String(open);
  els.toggleInspector?.setAttribute("aria-label", open ? "Close inspector" : "Open inspector");
  els.toggleInspector?.setAttribute("title", open ? "Close inspector" : "Open inspector");
}

function render() {
  if (!snapshot) return;
  const source = snapshot.source || {};
  els.runMeta.textContent = snapshot.run_id
    ? `${source.path || "unknown source"} | ${snapshot.run_id} | ${snapshot.provider} | ${snapshot.status}`
    : source.path
      ? `${source.path} | preview`
      : "No run loaded.";

  ensureSelectedSection();
  renderDocument();
  renderHints();
  renderRail();
}

function installCorpusSamples() {
  if (!els.corpusSample) return;
  const options = CORPUS_SAMPLES.map((sample, index) => {
    const label = `${sample.label} (${sample.docType})`;
    return `<option value="${index}">${escapeHtml(label)}</option>`;
  }).join("");
  els.corpusSample.innerHTML = options;
  els.corpusSample.value = "0";
}

function renderDocument() {
  const sections = snapshot.document_sections || [];
  const includedCount = sections.filter(section => !isSectionExcluded(section)).length;
  els.documentStatus.textContent = snapshot.run_id
    ? statusSummary(sections.length, snapshot.counts || {})
    : `Previewing source before the run starts. ${includedCount}/${sections.length} sections included.`;

  if (sections.length === 0) {
    els.documentSections.innerHTML = `<section class="doc-section"><div></div><div class="section-body"><h2>No document loaded</h2><p>Start a run to stream Codex app-server work beside the source.</p></div></section>`;
    return;
  }

  els.documentSections.innerHTML = sections.map(section => {
    const excluded = isSectionExcluded(section);
    const jobs = jobsForSection(section.id);
    const running = jobs.filter(job => job.status === "running").length;
    const completed = jobs.filter(job => job.status === "completed").length;
    const queued = jobs.filter(job => job.status === "queued").length;
    const failed = jobs.filter(job => job.status === "failed").length;
    return `
      <section id="${escapeHtml(section.id)}" class="doc-section" data-section-id="${escapeHtml(section.id)}" data-active="${section.id === selectedSectionId}" data-excluded="${excluded}">
        <div class="section-gutter">
          <button class="section-include-toggle" type="button" data-toggle-section="${escapeHtml(section.id)}" aria-pressed="${excluded ? "false" : "true"}" title="${excluded ? "Include section in analysis" : "Exclude section from analysis"}">
            <span aria-hidden="true">${excluded ? "+" : "−"}</span>
            <span class="sr-only">${excluded ? "Include" : "Exclude"} ${escapeHtml(section.id)}</span>
          </button>
          <strong>${escapeHtml(section.id)}</strong>
          <span>${escapeHtml(section.start_line)}-${escapeHtml(section.end_line)}</span>
          ${excluded ? `<span class="excluded-label">excluded</span>` : ""}
          <span>${running} active</span>
          <span>${queued} queued</span>
          <span>${completed}/${jobs.length} done</span>
          ${failed ? `<span>${failed} failed</span>` : ""}
        </div>
        <div class="section-body">
          <h2>${escapeHtml(section.title)}</h2>
          ${renderSourceText(section)}
        </div>
      </section>
    `;
  }).join("");

  installSectionObserver();
  bindDocumentInteractions();
  bindSectionToggleButtons();
}

function isSectionExcluded(section) {
  return excludedSectionIds.has(section.id) || section.analysis_included === false;
}

function bindSectionToggleButtons() {
  document.querySelectorAll("[data-toggle-section]").forEach(button => {
    button.addEventListener("click", () => {
      const sectionId = button.dataset.toggleSection;
      if (!sectionId) return;
      if (excludedSectionIds.has(sectionId)) {
        excludedSectionIds.delete(sectionId);
      } else {
        excludedSectionIds.add(sectionId);
      }
      render();
    });
  });
}

function statusSummary(sectionCount, counts) {
  const scheduled = counts.sections || 0;
  return [
    `${scheduled} scheduled of ${sectionCount} sections`,
    `${counts.running || 0} active LLM jobs`,
    `${counts.active_codex_turns || 0} active app-server turns`,
    `${counts.codex_threads || 0} Codex threads`,
    `${counts.queued || 0} queued`,
    `${counts.failed || 0} failed`
  ].join(" | ");
}

function renderHints() {
  if (!els.hintLayer || !snapshot?.run_id) {
    if (els.hintLayer) els.hintLayer.innerHTML = "";
    return;
  }

  const job = selectedJob();
  const runningJobs = (snapshot.jobs || []).filter(item => item.status === "running");
  const queuedJobs = (snapshot.jobs || []).filter(item => item.status === "queued");
  const latestFeedback = latestEvent("human_line_feedback");
  const latestSynthesis = latestEvent("synthesis_requested");
  const latestPressure = latestEvent("human_pressure_decision");
  const latestRecordDecision = latestEvent("human_record_decision");
  const latestOutputCount = job ? visibleToolsWithFallback(job).length : 0;

  const messages = [];
  if (runningJobs.length) messages.push(`${runningJobs.length} ${runningJobs.length === 1 ? "lens is" : "lenses are"} generating`);
  if (job?.status === "queued") messages.push(`${job.title || job.lens_role} is queued behind active work`);
  if (latestOutputCount) messages.push(`${latestOutputCount} visible projection ${latestOutputCount === 1 ? "is" : "are"} ready`);
  if (latestFeedback) {
    messages.push(`Intent feedback recorded for line ${latestFeedback.payload?.line_number || "unknown"}`);
  }
  if (latestSynthesis) messages.push("Synthesis request recorded");
  if (latestPressure) messages.push(`Pressure marked ${humanDecisionLabel(latestPressure.payload?.decision || "recorded").toLowerCase()}`);
  if (latestRecordDecision) messages.push(`Record marked ${humanDecisionLabel(latestRecordDecision.payload?.decision || "recorded").toLowerCase()}`);

  if (!messages.length && !queuedJobs.length) {
    els.hintLayer.innerHTML = "";
    return;
  }

  const isActive = runningJobs.length > 0;
  const subject = hintSubject(job);
  const headline = latestFeedback
    ? `Guidance on ${subject}`
    : latestSynthesis
      ? `Synthesis for ${subject}`
      : latestPressure || latestRecordDecision
        ? `Action on ${subject}`
        : isActive
          ? `Reducing ${subject}`
          : snapshot.status === "complete"
            ? `Reduced ${subject}`
            : `Ready: ${subject}`;
  const fullDetail = messages.join(" · ") || `${queuedJobs.length} ${queuedJobs.length === 1 ? "lens is" : "lenses are"} queued`;
  const compactDetail = messages.length > 1
    ? `${messages.length} updates`
    : fullDetail.replace("Intent feedback recorded for ", "").replace("visible projection is ready", "projection ready");
  els.hintLayer.innerHTML = `
    <div class="floating-hint" title="${escapeAttr(`${headline}: ${fullDetail}`)}">
      <div class="activity-gif" data-active="${isActive ? "true" : "false"}" aria-hidden="true"><span></span></div>
      <div class="floating-hint-body">
        <strong>${escapeHtml(headline)}</strong>
        <span>${escapeHtml(compactDetail)}</span>
      </div>
      <div class="floating-hint-actions">
        ${runningJobs.length ? `<button type="button" data-focus-job="${escapeHtml(runningJobs[0].id)}">Focus</button>` : ""}
        <button type="button" data-open-inspector aria-label="Open details">Details</button>
      </div>
    </div>
  `;
  bindHintButtons();
}

function hintSubject(job) {
  const section = sectionForJob(job) || (snapshot.document_sections || []).find(item => item.id === selectedSectionId);
  const title = section?.title || (snapshot.document_sections || [])[0]?.title || displayPath(snapshot.source?.path || els.sourcePath?.value || "spec");
  return conciseLabel(title, 34);
}

function latestEvent(type) {
  return [...projectionEvents()].reverse().find(event => event.type === type) || null;
}

function latestSubjectEvent(types, subjectId) {
  if (!subjectId) return null;
  const wanted = Array.isArray(types) ? types : [types];
  return [...projectionEvents()].reverse().find(event =>
    wanted.includes(event.type) &&
    String(event.payload?.subject_id || event.payload?.record_id || "") === String(subjectId)
  ) || null;
}

function actionStatus(subjectId) {
  if (!subjectId) return null;
  const local = localActionStatuses.get(String(subjectId));
  const event = latestSubjectEvent(
    ["synthesis_requested", "human_note", "human_record_decision", "human_pressure_decision"],
    subjectId
  );
  if (local && (!event || timestampValue(local.timestamp) >= timestampValue(event.timestamp))) return local;
  if (!event) return null;
  return actionStatusFromEvent(event);
}

function actionStatusFromEvent(event) {
  if (event.type === "synthesis_requested") {
    return { state: "recorded", message: "Synthesis request recorded.", timestamp: event.timestamp };
  }
  if (event.type === "human_note") {
    return { state: "recorded", message: "Blocker note recorded.", timestamp: event.timestamp };
  }
  if (event.type === "human_record_decision") {
    return {
      state: "recorded",
      message: `Record marked ${humanDecisionLabel(event.payload?.decision).toLowerCase()}.`,
      timestamp: event.timestamp
    };
  }
  if (event.type === "human_pressure_decision") {
    return {
      state: "recorded",
      message: `Pressure marked ${humanDecisionLabel(event.payload?.decision).toLowerCase()}.`,
      timestamp: event.timestamp
    };
  }
  return null;
}

function setActionStatus(subjectId, state, message) {
  if (!subjectId) return;
  localActionStatuses.set(String(subjectId), {
    state,
    message,
    timestamp: new Date().toISOString()
  });
  render();
}

function renderActionStatus(subjectId) {
  const status = actionStatus(subjectId);
  if (!status) return "";
  return `<div class="action-feedback" data-state="${escapeAttr(status.state)}">${escapeHtml(status.message)}</div>`;
}

function humanDecisionLabel(decision) {
  if (decision === "accept_record" || decision === "keep_pressure") return "Kept";
  if (decision === "defer_record" || decision === "defer_pressure") return "Deferred";
  if (decision === "reject_record" || decision === "reject_pressure") return "Rejected";
  if (decision === "merge_pressure") return "Merged";
  return "Recorded";
}

function projectionEvents() {
  const seen = new Set();
  return [...(snapshot.events || []), ...(snapshot.interventions || []), ...localFeedbackEvents]
    .filter(event => {
      const id = projectionEventKey(event);
      if (seen.has(id)) return false;
      seen.add(id);
      return true;
    })
    .sort((a, b) => timestampValue(a.timestamp) - timestampValue(b.timestamp));
}

function projectionEventKey(event) {
  if (event.type === "human_line_feedback") {
    return [
      event.type,
      event.payload?.section_id || "",
      event.payload?.line_number || "",
      event.message || ""
    ].join("|");
  }

  return event.id || `${event.type}-${event.timestamp}-${event.message}`;
}

function bindHintButtons() {
  els.hintLayer.querySelectorAll("[data-open-inspector]").forEach(button => {
    button.addEventListener("click", openHintDetails);
  });
  els.hintLayer.querySelectorAll("[data-focus-job]").forEach(button => {
    button.addEventListener("click", () => {
      selectedJobId = button.dataset.focusJob;
      setInspectorOpen(true);
      render();
    });
  });
}

function openHintDetails() {
  const job =
    (snapshot.jobs || []).find(item => item.status === "running") ||
    selectedJob() ||
    (snapshot.jobs || []).find(item => item.status === "completed") ||
    (snapshot.jobs || [])[0];
  if (job) selectedJobId = job.id;
  setInspectorOpen(true);
  render();
  requestAnimationFrame(() => {
    const selected = selectedJobId
      ? document.querySelector(`.thread-card[data-job-id="${CSS.escape(selectedJobId)}"]`)
      : null;
    if (selected && "open" in selected) selected.open = true;
    (selected || document.querySelector(".thread-pane"))?.scrollIntoView({ block: "nearest", behavior: "smooth" });
  });
}

function renderSourceText(section) {
  const anchors = [
    ...diagramAnchorsForSection(section),
    ...feedbackAnchorsForSection(section),
    ...sourceReferenceAnchorsForSection(section),
    ...choicePreviewAnchorsForSection(section)
  ];
  return renderSpecDocument(section, anchors);
}

function sourceReferenceAnchorsForSection(section) {
  if (!activeSourceReference || activeSourceReference.section_id !== section.id) return [];
  return [activeSourceReference];
}

function choicePreviewAnchorsForSection(section) {
  if (!activeChoicePreview || activeChoicePreview.section_id !== section.id) return [];
  return [activeChoicePreview];
}

function feedbackAnchorsForSection(section) {
  return projectionEvents()
    .filter(event => event.type === "human_line_feedback")
    .filter(event => event.payload?.section_id === section.id)
    .map(event => ({
      kind: "feedback",
      section_id: section.id,
      start_line: Number(event.payload?.line_number),
      end_line: Number(event.payload?.line_number),
      quote: event.payload?.source_text || "",
      title: "Intent guidance applied",
      body: feedbackImpactText(event)
    }));
}

function feedbackImpactText(event) {
  const line = event.payload?.line_number || "the selected line";
  const mode = event.payload?.mode || "additive";
  const effect = event.payload?.preview_effect;
  if (effect) return `${effect} Recorded as ${mode} guidance for line ${line}.`;
  return `Recorded ${mode} guidance for line ${line}; an intent refinement lens is now queued or running.`;
}

function diagramAnchorsForSection(section) {
  const job = selectedJob();
  const sectionId = section.id;
  const tools = visibleToolsForJob(job).filter(tool => isMermaidTool(tool.tool));

  return tools
    .map(tool => normalizeSourceAnchor(tool, job))
    .filter(anchor => !anchor.section_id || anchor.section_id === sectionId)
    .map(anchor => ({
      ...anchor,
      section_id: anchor.section_id || sectionId
    }));
}

function visibleToolsForJob(job) {
  if (!job) return [];
  return (snapshot.streams?.[job.id] || [])
    .filter(item => item.type === "item/tool/call")
    .map(item => parseRawEvent(item.raw))
    .filter(Boolean)
    .map(parsed => normalizeToolParams(parsed.params || {}, job));
}

function visibleToolsWithFallback(job) {
  const tools = visibleToolsForJob(job);
  const semanticMap = semanticStateToolForJob(job);
  const usefulTools = tools.filter(tool => !isWeakMermaidTool(tool, job));

  return semanticMap ? [semanticMap, ...usefulTools] : usefulTools;
}

function semanticStateToolForJob(job) {
  const result = resultForJob(job);
  if (!job || !result) return null;
  const graph = buildSemanticStateGraph(job, result);
  if (!graph.rows.length) return null;

  return {
    tool: "basis_semantic_state_map",
    title: "Semantic Reduction Map",
    graph,
    source_anchor: sourceRefForJob(job)
  };
}

function mermaidLabel(value, maxLength = 72) {
  return String(value || "")
    .replace(/[\[\]{}"]/g, "'")
    .replace(/\s+/g, " ")
    .trim()
    .slice(0, maxLength);
}

function isWeakMermaidTool(tool, job) {
  if (!isMermaidTool(tool.tool)) return false;
  if (tool.generated_fallback) return true;

  const source = String(tool.body || tool.diagram || tool.source || "");
  const title = String(sectionForJob(job)?.title || "");
  const lens = String(job?.title || job?.lens_role || "");
  const lower = source.toLowerCase();

  return (
    lower.includes("evidence map") ||
    (title && source.includes(title)) ||
    (lens && source.includes(lens)) ||
    /source\s+lines?\s+\d/i.test(source)
  );
}

function normalizeToolParams(params, job = null) {
  return normalizeVisibleTool({
    ...(params.arguments || {}),
    tool: params.tool,
    call_id: params.callId,
    turn_id: params.turnId,
    thread_id: params.threadId,
    fallback_section_id: job?.section_id || selectedSectionId,
    fallback_source_range: contextPacketForJob(job)?.source_range
  });
}

function contextPacketForJob(job) {
  if (!job) return null;
  return (snapshot.context_packets || []).find(item => item.id === job.context_packet) || null;
}

function normalizeSourceAnchor(tool, job = null) {
  const raw = tool.source_anchor && typeof tool.source_anchor === "object" ? tool.source_anchor : tool;
  const fallbackRange = tool.fallback_source_range || contextPacketForJob(job)?.source_range || "";
  const parsedFallback = parseLineRange(fallbackRange);
  const parsedExplicit = parseLineRange(raw.source_range || raw.range || "");

  return {
    section_id: raw.section_id || tool.section_id || tool.fallback_section_id || job?.section_id || "",
    start_line:
      numberOrNull(raw.start_line ?? raw.line_start ?? raw.start) ??
      parsedExplicit.start_line ??
      parsedFallback.start_line,
    end_line:
      numberOrNull(raw.end_line ?? raw.line_end ?? raw.end) ??
      parsedExplicit.end_line ??
      parsedFallback.end_line,
    quote: raw.quote || tool.quote || ""
  };
}

function parseLineRange(value) {
  const match = String(value || "").match(/(\d+)\s*(?:-|:|to|–)\s*(\d+)/i);
  if (!match) return {};
  const start = Number(match[1]);
  const end = Number(match[2]);
  return {
    start_line: Number.isFinite(start) ? Math.min(start, end) : null,
    end_line: Number.isFinite(end) ? Math.max(start, end) : null
  };
}

function numberOrNull(value) {
  const number = Number(value);
  return Number.isFinite(number) && number > 0 ? number : null;
}

function resultForJob(job) {
  if (!job) return null;
  return (snapshot.results || []).find(item => item.job_id === job.id) || null;
}

function sectionForJob(job) {
  if (!job) return null;
  return (snapshot.document_sections || []).find(item => item.id === job.section_id) || null;
}

function sectionForLine(line) {
  const number = Number(line);
  if (!Number.isFinite(number)) return null;
  return (snapshot.document_sections || []).find(section => {
    return number >= Number(section.start_line) && number <= Number(section.end_line);
  }) || null;
}

function sourceRefForJob(job) {
  const section = sectionForJob(job);
  const packetRange = parseLineRange(contextPacketForJob(job)?.source_range || "");
  return {
    kind: "source_reference",
    section_id: job?.section_id || section?.id || "",
    start_line: packetRange.start_line || Number(section?.start_line) || null,
    end_line: packetRange.end_line || Number(section?.end_line) || null,
    title: "Source reference",
    body: section ? `${section.title} source range` : "Job source range"
  };
}

function sourceRefFromText(text, job = null) {
  return lineReferencesInText(text, job)[0] || null;
}

function lineReferencesInText(text, job = null) {
  const refs = [];
  const pattern = /\b[Ll]ines?\s+(\d+)(?:\s*(?:-|–|to)\s*(\d+))?/g;
  let match;

  while ((match = pattern.exec(String(text || ""))) !== null) {
    const start = Number(match[1]);
    const end = Number(match[2] || match[1]);
    const section = sectionForLine(start) || sectionForJob(job);
    refs.push({
      label: match[0],
      index: match.index,
      end_index: match.index + match[0].length,
      kind: "source_reference",
      section_id: section?.id || job?.section_id || "",
      start_line: Math.min(start, end),
      end_line: Math.max(start, end),
      title: "Source reference",
      body: match[0]
    });
  }

  const filePattern = /\b((?:[\w.-]+\/)+[\w.-]+\.\w+):(\d+)(?:-(\d+))?/g;
  while ((match = filePattern.exec(String(text || ""))) !== null) {
    const path = match[1];
    const start = Number(match[2]);
    const end = Number(match[3] || match[2]);
    const section = sectionForLine(start) || sectionForJob(job);
    refs.push({
      label: match[0],
      index: match.index,
      end_index: match.index + match[0].length,
      kind: "source_reference",
      section_id: section?.id || job?.section_id || "",
      source_path: path,
      start_line: Math.min(start, end),
      end_line: Math.max(start, end),
      title: "Source reference",
      body: match[0]
    });
  }

  return refs.sort((a, b) => a.index - b.index);
}

function installSectionObserver() {
  if (observer) observer.disconnect();
  const sections = [...document.querySelectorAll(".doc-section[data-section-id]")];
  observer = new IntersectionObserver(entries => {
    const visible = entries
      .filter(entry => entry.isIntersecting)
      .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
    if (!visible) return;
    if (Date.now() < suppressSectionObserverUntil) return;
    const id = visible.target.dataset.sectionId;
    if (id && id !== selectedSectionId) {
      selectedSectionId = id;
      selectedJobId = defaultJobForSection(id)?.id || selectedJobId;
      renderDocument();
      renderRail();
      document.querySelectorAll(".doc-section").forEach(section => {
        section.dataset.active = String(section.dataset.sectionId === selectedSectionId);
      });
    }
  }, { rootMargin: "-110px 0px -45% 0px", threshold: [0.1, 0.35, 0.65] });
  sections.forEach(section => observer.observe(section));
}

function bindDocumentInteractions() {
  document.querySelectorAll(".line-marker").forEach(button => {
    button.addEventListener("click", event => {
      event.preventDefault();
      selectedFeedbackLine = {
        section_id: button.dataset.sectionId,
        line_number: Number(button.dataset.line),
        source_text: button.dataset.sourceText || ""
      };
      renderFeedbackComposer();
    });
  });
}

function renderFeedbackComposer() {
  if (!els.feedbackComposer || !selectedFeedbackLine) return;
  const line = selectedFeedbackLine;
  const initialPreview = feedbackPreviewModel(line, "");
  els.feedbackComposer.hidden = false;
  els.feedbackComposer.innerHTML = `
    <form class="feedback-card" id="lineFeedbackForm">
      <div>
        <strong>Line ${escapeHtml(line.line_number)}</strong>
        <p class="thread-meta">Guide the reducer search from this source line. Feedback is additive unless you say to replace or remove something.</p>
      </div>
      <div class="feedback-source">${escapeHtml(line.source_text || "Blank source line")}</div>
      <textarea id="lineFeedbackBody" placeholder="Example: the reducer should own an interface for intelligence to guide the reduction search and refine intent."></textarea>
      <div class="impact-preview">
        <div class="impact-preview-head">
          <strong>Preview effect</strong>
          <button type="button" data-update-feedback-preview>Update preview</button>
        </div>
        <div id="feedbackImpact">${renderFeedbackPreview(initialPreview)}</div>
      </div>
      <div class="feedback-actions">
        <button type="button" data-cancel-feedback>Cancel</button>
        <button type="submit">Apply guidance</button>
      </div>
    </form>
  `;

  const textarea = els.feedbackComposer.querySelector("#lineFeedbackBody");
  const updatePreview = () => {
    const model = feedbackPreviewModel(line, textarea.value.trim());
    const preview = els.feedbackComposer.querySelector("#feedbackImpact");
    if (preview) preview.innerHTML = renderFeedbackPreview(model);
    const button = els.feedbackComposer.querySelector("[data-update-feedback-preview]");
    if (button) delete button.dataset.dirty;
  };
  els.feedbackComposer.querySelector("[data-update-feedback-preview]").addEventListener("click", updatePreview);
  els.feedbackComposer.addEventListener("click", event => {
    if (!event.target?.matches?.("[data-update-feedback-preview]")) return;
    event.preventDefault();
    updatePreview();
  });
  textarea.addEventListener("input", updatePreview);
  els.feedbackComposer.querySelector("[data-cancel-feedback]").addEventListener("click", closeFeedbackComposer);
  els.feedbackComposer.querySelector("#lineFeedbackForm").addEventListener("submit", async event => {
    event.preventDefault();
    const body = textarea.value.trim();
    if (!body) return;
    const preview = feedbackPreviewModel(line, body);
    recordLocalFeedback(line, body, preview);
    renderFeedbackApplied(line, body, "submitting");

    try {
      await postJson("/api/actions", {
        type: "line_feedback",
        body,
        mode: "additive",
        section_id: line.section_id,
        line_number: line.line_number,
        source_text: line.source_text,
        preview_effect: preview.summary,
        target_projection: preview.targets,
        feedback_kind: preview.kind
      });
      renderFeedbackApplied(line, body, "applied");
    } catch (error) {
      renderFeedbackApplied(line, body, "failed", error);
    }
  });
}

function feedbackPreviewModel(line, body) {
  const text = `${body || ""} ${line?.source_text || ""}`.toLowerCase();
  const targets = targetProjectionList(selectedJob()).length
    ? targetProjectionList(selectedJob()).slice(0, 5)
    : targetProjectionList().slice(0, 5);
  const mentionedTargets = targets.filter(target => text.includes(target.toLowerCase()));
  const kind = text.includes("delete") || text.includes("remove") || text.includes("redundan") || text.includes("duplicate")
    ? "redundant"
    : text.includes("split") || text.includes("coupl") || text.includes("separate")
      ? "coupled"
      : text.includes("missing") || text.includes("define") || text.includes("invent") || text.includes("schema")
        ? "missing"
        : text.includes("policy") || text.includes("choose") || text.includes("conflict")
          ? "conflict"
          : "guidance";
  const affectedTargets = mentionedTargets.length ? mentionedTargets : targets;
  const summary = body
    ? `Record guidance for line ${line.line_number}, classify it as ${kind} pressure, and re-score ${affectedTargets.join(", ") || "the active targets"}.`
    : `Draft guidance for line ${line.line_number}, then update this preview to see target pressure before applying it.`;
  return {
    kind,
    targets: affectedTargets,
    summary,
    actions: feedbackPreviewActions(kind)
  };
}

function feedbackPreviewActions(kind) {
  if (kind === "redundant") return ["mark duplicate pressure", "check schema/runbook impact"];
  if (kind === "coupled") return ["ask synthesis to split", "review projection precision"];
  if (kind === "missing") return ["record blocker", "check invented behavior"];
  if (kind === "conflict") return ["choose policy", "ask synthesis to reconcile"];
  return ["queue intent lens", "refresh projection impact"];
}

function renderFeedbackPreview(model) {
  return `
    <p>${escapeHtml(model.summary)}</p>
    <div class="impact-preview-grid">
      <span><strong>Kind</strong>${escapeHtml(model.kind)}</span>
      <span><strong>Targets</strong>${escapeHtml(model.targets.join(", ") || "active targets")}</span>
      <span><strong>Next</strong>${escapeHtml(model.actions.join(" · "))}</span>
    </div>
  `;
}

function recordLocalFeedback(line, body, preview = feedbackPreviewModel(line, body)) {
  localFeedbackEvents = [
    ...localFeedbackEvents,
    {
      id: `local-feedback-${Date.now()}-${line.line_number}`,
      type: "human_line_feedback",
      actor: "human",
      message: body,
      payload: {
        mode: "additive",
        section_id: line.section_id,
        line_number: line.line_number,
        source_text: line.source_text || "",
        preview_effect: preview.summary,
        target_projection: preview.targets,
        feedback_kind: preview.kind
      },
      timestamp: new Date().toISOString()
    }
  ].slice(-50);
  saveLocalFeedbackEvents(snapshot?.run_id, localFeedbackEvents);
}

function localFeedbackStorageKey(runId) {
  return runId ? `basis.feedbackImpacts.${runId}` : "";
}

function loadLocalFeedbackEvents(runId) {
  const key = localFeedbackStorageKey(runId);
  if (!key) return [];
  try {
    const parsed = JSON.parse(localStorage.getItem(key) || "[]");
    return Array.isArray(parsed) ? parsed.slice(-50) : [];
  } catch {
    return [];
  }
}

function saveLocalFeedbackEvents(runId, events) {
  const key = localFeedbackStorageKey(runId);
  if (!key) return;
  try {
    localStorage.setItem(key, JSON.stringify(events.slice(-50)));
  } catch {
    // The impact card is still visible in memory if local storage is unavailable.
  }
}

function renderFeedbackApplied(line, body, state, error = null) {
  if (!els.feedbackComposer) return;
  els.feedbackComposer.hidden = false;
  const preview = feedbackPreviewModel(line, body);

  const title = state === "failed" ? "Guidance was not recorded" : state === "submitting" ? "Applying guidance" : "Guidance applied";
  const detail = state === "failed"
    ? `The request failed: ${error?.message || error || "unknown error"}`
    : state === "submitting"
      ? "Recording the intervention event and preparing an intent refinement lens."
      : `Recorded additive guidance for line ${line.line_number}; an intent refinement lens is queued or running for ${line.section_id}.`;

  els.feedbackComposer.innerHTML = `
    <div class="feedback-card feedback-applied-card" role="status">
      <div>
        <strong>${escapeHtml(title)}</strong>
        <p class="thread-meta">${escapeHtml(detail)}</p>
      </div>
      <div class="impact-preview">
        <strong>Impact</strong>
        ${renderFeedbackPreview(preview)}
      </div>
      <div class="feedback-actions">
        <button type="button" data-cancel-feedback>${state === "failed" ? "Close" : "Done"}</button>
      </div>
    </div>
  `;
  els.feedbackComposer.querySelector("[data-cancel-feedback]").addEventListener("click", closeFeedbackComposer);
}

function closeFeedbackComposer() {
  selectedFeedbackLine = null;
  if (els.feedbackComposer) {
    els.feedbackComposer.hidden = true;
    els.feedbackComposer.innerHTML = "";
  }
}

function ensureSelectedSection() {
  if (selectedSectionId) return;
  const first = (snapshot.document_sections || [])[0];
  if (first) {
    selectedSectionId = first.id;
    selectedJobId = defaultJobForSection(first.id)?.id || null;
  }
}

function jobsForSection(sectionId) {
  return (snapshot.jobs || []).filter(job => job.section_id === sectionId);
}

function defaultJobForSection(sectionId) {
  const jobs = jobsForSection(sectionId);
  return jobs.find(job => job.status === "running") || jobs.find(job => job.status === "queued") || jobs[0] || null;
}

function selectedJob() {
  const jobs = snapshot.jobs || [];
  const selected = jobs.find(job => job.id === selectedJobId);
  const sectionDefault = defaultJobForSection(selectedSectionId);
  const activeWithStream = jobs.find(job => job.status === "running" && streamForJob(job).length > 0);

  if (selected && (streamForJob(selected).length > 0 || selected.status === "running")) return selected;
  if (sectionDefault && (streamForJob(sectionDefault).length > 0 || sectionDefault.status === "running")) return sectionDefault;
  return activeWithStream || selected || sectionDefault || jobs[0] || null;
}

function renderRail() {
  const section = (snapshot.document_sections || []).find(item => item.id === selectedSectionId);
  const sectionJobs = jobsForSection(selectedSectionId);
  const jobs = sectionJobs.length ? sectionJobs : fallbackJobs();
  const job = selectedJob();
  if (job) selectedJobId = job.id;

  els.activeSectionTitle.textContent = section ? section.title : "No section selected";
  els.activeSectionMeta.textContent = section
    ? `${section.id} | lines ${section.start_line}-${section.end_line}`
    : "Scroll the document to focus a section.";
  els.threadCount.textContent = String(jobs.length);
  els.threadList.innerHTML = jobs.length
    ? jobs.map(renderJobCard).join("")
    : `<p>No lens jobs queued for this section yet.</p>`;
  els.selectedJobLabel.textContent = job ? `${job.id} ${job.lens_role}` : "no job";
  renderStudio(job, section);
  renderStream(job);
  renderContext(job);
  renderResults(job);
  bindRailButtons();
}

function renderStudio(job, section) {
  const result = resultForJob(job);
  const targets = targetProjectionList(job);
  const currentSection = section || sectionForJob(job) || (snapshot.document_sections || [])[0];
  const resultDecisions = decisionRowsForResult(job, result);
  const decisions = [
    ...feedbackRowsForSection(currentSection, targets),
    ...resultDecisions
  ];

  els.studioIntro.textContent = studioIntroText(job, result, currentSection);
  els.studioRunState.innerHTML = renderStudioState(job, result, targets);
  els.studioNarrative.innerHTML = renderStudioNarrative(job, result, currentSection, targets, decisions);
  els.studioBuildShape.innerHTML = renderBuildShapeDiagram(job, result, targets, decisions);
  els.studioProjectionMatrix.innerHTML = renderProjectionImpactMatrix(job, result, targets, decisions);
  els.studioDecisionQueue.innerHTML = renderDecisionQueue(decisions);
  els.studioEvidenceList.innerHTML = renderStudioEvidenceList(decisions);
}

function studioIntroText(job, result, section) {
  if (autoBuildMessage) return autoBuildMessage;
  if (result?.summary) {
    return `Focused on ${section?.title || job?.title || "the current reducer lens"}: generated interpretation is ready to read before choosing what to build.`;
  }
  if (job?.status === "running") return "The reducer is generating interpretation prose, diagrams, and source-backed proposal pressure.";
  if (job?.status === "queued") return "The selected lens is queued; the source preview remains available for orientation.";
  if (snapshot?.run_id) return "The run is loaded. Select a completed lens to read generated understanding and projection impacts.";
  return "Preview the source, choose reasoning level, then start a reducer run to generate build understanding.";
}

function renderStudioState(job, result, targets) {
  const status = job?.status || snapshot?.status || "preview";
  const resultState = result ? "understanding ready" : snapshot?.run_id ? "waiting for result" : "source preview";
  const reasoning = snapshot?.reasoning_effort || selectedReasoningEffort();
  return `
    <span class="state-badge">${escapeHtml(status)}</span>
    ${autoBuildInFlight ? `<span class="state-badge active">auto starting</span>` : ""}
    <span class="state-badge stable">proposal only</span>
    <span class="state-badge stable">accepted Basis state unchanged</span>
    <span class="state-badge stable">reasoning ${escapeHtml(reasoning)}</span>
    <span class="state-badge">${escapeHtml(resultState)}</span>
    ${targets.slice(0, 4).map(target => `<span class="target-chip">${escapeHtml(target)}</span>`).join("")}
  `;
}

function renderStudioNarrative(job, result, section, targets, decisions) {
  const title = section?.title || job?.title || "selected source";
  if (!result) {
    return `
      ${renderNarrativeBlock("State", "The source is loaded as evidence, but this lens has not produced build understanding yet.")}
      ${renderNarrativeBlock("Next read", "Start or focus a reducer run to turn the prose into an interpretation: what component is implied, which target projections are pressured, and which choices remain open.")}
      ${renderNarrativeBlock("Boundary", "The UI will keep source evidence and proposal actions visible without treating them as accepted Basis state.")}
    `;
  }

  const summaryParagraphs = proseParagraphs(result.summary || "").slice(0, 2);
  const primaryDecision = decisions[0];
  const recordCount = (result.proposed_records || []).length;
  const findingCount = (result.findings || []).length;
  const pressure = primaryDecision
    ? `The strongest current pressure is ${primaryDecision.kind}: ${primaryDecision.title}. It affects ${primaryDecision.targets.join(", ")} and should be resolved before those projections pretend the policy is known.`
    : `This lens produced ${findingCount} findings and ${recordCount} proposed records; no high-pressure decision is visible for the selected target set.`;

  return `
    ${renderNarrativeBlock("Reading frame", `<strong>${escapeHtml(title)}</strong> is being read as a buildable system shape, not as a document inventory.`, true)}
    ${summaryParagraphs.map((paragraph, index) => renderNarrativeBlock(index === 0 ? "Interpretation" : "Implication", renderSourceLinkedText(paragraph, job), true)).join("")}
    ${renderNarrativeBlock("Current pressure", escapeHtml(pressure), true)}
    ${renderNarrativeBlock("Acceptance boundary", `The active targets are ${escapeHtml(targets.join(", ") || "not named")}. Actions below update proposal or guidance state only; a separate acceptance record is still required for durable Basis state.`, true)}
  `;
}

function renderNarrativeBlock(label, body, bodyIsHtml = false) {
  return `
    <section class="narrative-block">
      <span>${escapeHtml(label)}</span>
      <p>${bodyIsHtml ? body : escapeHtml(body)}</p>
    </section>
  `;
}

function proseParagraphs(text) {
  const compact = String(text || "").replace(/\s+/g, " ").trim();
  if (!compact) return [];
  const sentences = compact.match(/[^.!?]+(?:[.!?]+|$)/g) || [compact];
  const paragraphs = [];
  for (let index = 0; index < sentences.length; index += 2) {
    paragraphs.push(sentences.slice(index, index + 2).join(" ").trim());
  }
  return paragraphs.filter(Boolean);
}

function renderBuildShapeDiagram(job, result, targets, decisions = []) {
  const shape = modelBuildShape(job, result, targets, decisions);
  return `
    <div class="build-shape-diagram" role="img" aria-label="${escapeAttr(shape.ariaLabel)}">
      <div class="shape-diagram-note">
        <span>${escapeHtml(shape.source)}</span>
        <span>${escapeHtml(shape.boundary)}</span>
      </div>
      <div class="shape-mainline">
        ${renderShapeNode(shape.nodes[0].title, shape.nodes[0].body, shape.nodes[0].kind)}
        ${renderShapeEdge(shape.edges[0])}
        ${renderShapeNode(shape.nodes[1].title, shape.nodes[1].body, shape.nodes[1].kind)}
        ${renderShapeEdge(shape.edges[1])}
        ${renderShapeNode(shape.nodes[2].title, shape.nodes[2].body, shape.nodes[2].kind)}
        ${renderShapeEdge(shape.edges[2])}
        ${renderShapeNode(shape.nodes[3].title, shape.nodes[3].body, shape.nodes[3].kind)}
      </div>
      <div class="shape-support">
        ${shape.support.map(node => renderShapeNode(node.title, node.body, node.kind)).join("")}
      </div>
    </div>
  `;
}

function modelBuildShape(job, result, targets, decisions) {
  const sourceRef = sourceRefForJob(job);
  const sourceLabel = sourceRefLabel(sourceRef) === "source"
    ? displayPath(snapshot.source?.path || els.sourcePath.value || "source spec")
    : sourceRefLabel(sourceRef);
  const primaryDecision = decisions[0];
  const primaryRecord = (result?.proposed_records || [])[0];
  const summary = firstSentence(result?.summary || "");
  const claimTitle = primaryDecision?.title || (result ? "Model interpretation" : "Waiting for model output");
  const claimBody = summary || "The model has not produced the current lens interpretation yet.";
  const proposalTitle = primaryRecord?.title || primaryDecision?.title || "Proposal state pending";
  const proposalBody = primaryRecord?.body || primaryDecision?.impact || `${(result?.proposed_records || []).length} records · ${(result?.findings || []).length} findings`;
  const targetBody = primaryDecision?.targets?.length
    ? primaryDecision.targets.join(", ")
    : targets.join(", ") || "targets pending";

  return {
    ariaLabel: result
      ? "Generated from the current lens summary, findings, proposed records, and target projections."
      : "Waiting for generated lens output before drawing a model-derived build shape.",
    source: result ? "generated from model output" : "waiting for model output",
    boundary: "proposal state, not accepted Basis state",
    nodes: [
      { title: "Evidence Span", body: sourceLabel, kind: "source" },
      { title: "Interpretation Claim", body: conciseLabel(claimTitle || claimBody, 58), kind: result ? "run" : "support" },
      { title: "Proposed State", body: conciseLabel(proposalTitle || proposalBody, 58), kind: "records" },
      { title: "Projection Impact", body: conciseLabel(targetBody, 58), kind: "targets" }
    ],
    edges: ["supports", primaryDecision?.kind || "reduces to", primaryRecord ? "pressures" : "would affect"],
    support: [
      { title: "Model Summary", body: conciseLabel(claimBody, 72), kind: "support" },
      { title: "Open Pressure", body: primaryDecision ? `${primaryDecision.kind}: ${primaryDecision.impact}` : "No completed decision pressure yet", kind: primaryDecision?.kind || "support" },
      { title: "Acceptance Gate", body: "durable state still requires a separate acceptance record", kind: "gate" }
    ]
  };
}

function firstSentence(text) {
  const compact = String(text || "").replace(/\s+/g, " ").trim();
  return (compact.match(/[^.!?]+(?:[.!?]+|$)/) || [""])[0].trim();
}

function renderShapeNode(title, body, kind) {
  return `
    <div class="shape-node" data-kind="${escapeAttr(kind)}">
      <strong>${escapeHtml(title)}</strong>
      <span>${escapeHtml(body)}</span>
    </div>
  `;
}

function renderShapeEdge(label) {
  return `<div class="shape-edge"><span>${escapeHtml(label)}</span></div>`;
}

function renderProjectionImpactMatrix(job, result, targets, decisions) {
  const rows = decisions.length ? decisions.slice(0, 5) : fallbackDecisionRows(job, result, targets);
  if (!rows.length) {
    return `<p class="empty-state">No projection pressure yet. Completed lenses will populate choices, blockers, and diagram implications here.</p>`;
  }

  return `
    ${renderProjectionImpactDetail(rows)}
    <table class="projection-matrix">
      <thead>
        <tr>
          <th>Choice or record</th>
          <th>Kind</th>
          ${targets.slice(0, 5).map(target => `<th>${escapeHtml(target)}</th>`).join("")}
        </tr>
      </thead>
      <tbody>
        ${rows.map(row => `
          <tr>
            <th>${escapeHtml(row.title)}</th>
            <td>${renderProjectionKindButton(row)}</td>
            ${targets.slice(0, 5).map(target => renderProjectionCell(row, target)).join("")}
          </tr>
        `).join("")}
      </tbody>
    </table>
  `;
}

function renderProjectionKindButton(row) {
  const selected = activeProjectionImpact?.row_id === row.id && !activeProjectionImpact?.target;
  return `
    <button type="button"
      class="kind-chip kind-chip-button"
      data-projection-impact
      aria-pressed="${selected ? "true" : "false"}"
      data-selected="${selected ? "true" : "false"}"
      ${projectionImpactAttrs(row, "")}>${escapeHtml(row.kind)}</button>
  `;
}

function renderProjectionCell(row, target) {
  const pressured = row.targets.length === 0 || row.targets.includes(target);
  const label = pressured ? impactLabelForKind(row.kind) : "not pressured";
  const help = projectionCellHelp(row, target, pressured);
  const selected = activeProjectionImpact?.row_id === row.id && activeProjectionImpact.target === target;
  return `
    <td data-pressure="${pressured ? "true" : "false"}">
      <button type="button"
        class="projection-cell"
        data-projection-impact
        aria-pressed="${selected ? "true" : "false"}"
        aria-label="${escapeAttr(help)}"
        title="${escapeAttr(help)}"
        ${projectionImpactAttrs(row, target)}
        data-selected="${selected ? "true" : "false"}"
        data-pressure="${pressured ? "true" : "false"}">${escapeHtml(label)}</button>
    </td>
  `;
}

function projectionImpactAttrs(row, target) {
  const ref = row.source_ref || {};
  return `
    data-row-id="${escapeAttr(row.id)}"
    data-kind="${escapeAttr(row.kind)}"
    data-title="${escapeAttr(row.title)}"
    data-target="${escapeAttr(target)}"
    data-impact="${escapeAttr(row.impact || "")}"
    data-evidence="${escapeAttr(row.evidence || "")}"
    data-section-id="${escapeAttr(ref.section_id || "")}"
    data-source-path="${escapeAttr(ref.source_path || "")}"
    data-start-line="${escapeAttr(ref.start_line || "")}"
    data-end-line="${escapeAttr(ref.end_line || ref.start_line || "")}"
  `;
}

function renderProjectionImpactDetail(rows) {
  const active = activeProjectionImpact;
  const row = rows.find(item => item.id === active?.row_id);
  if (!active || !row) {
    return `<p class="projection-help">Click any cell to inspect the pressure, source evidence, and available reviewer actions.</p>`;
  }

  const noteBody = `Projection pressure: ${active.title}. ${active.impact}`;
  const targetLabel = active.target ? `${active.target} projection` : "all affected projections";
  const detailRow = {
    ...row,
    source_ref: {
      ...(row.source_ref || {}),
      section_id: active.section_id || row.source_ref?.section_id || "",
      source_path: active.source_path || row.source_ref?.source_path || "",
      start_line: active.start_line || row.source_ref?.start_line || "",
      end_line: active.end_line || row.source_ref?.end_line || row.source_ref?.start_line || ""
    }
  };
  return `
    <article class="projection-impact-detail" data-kind="${escapeAttr(active.kind)}">
      <div>
        <span class="studio-eyebrow">Selected impact</span>
        <strong>${escapeHtml(active.title)}</strong>
        <p>${escapeHtml(targetLabel)} · ${escapeHtml(active.kind)}</p>
      </div>
      <p>${escapeHtml(active.impact || "Review this pressure before treating the projection as known.")}</p>
      <p class="projection-impact-meaning">${escapeHtml(impactMeaningForKind(active.kind))}</p>
      <div class="decision-actions">${renderSemanticActionButtons(detailRow, noteBody, "projection_impact")}</div>
      ${renderActionStatus(active.row_id)}
    </article>
  `;
}

function impactLabelForKind(kind) {
  if (kind === "missing") return "would invent";
  if (kind === "coupled") return "needs split";
  if (kind === "conflict") return "policy needed";
  if (kind === "redundant") return "duplicate";
  if (kind === "loss") return "loss risk";
  if (kind === "guidance") return "recheck";
  return "readable";
}

function projectionCellHelp(row, target, pressured) {
  if (!pressured) return `${target} is not currently pressured by ${row.title}.`;
  return `${target}: ${impactLabelForKind(row.kind)}. ${impactMeaningForKind(row.kind)}`;
}

function impactMeaningForKind(kind) {
  if (kind === "coupled") {
    return "This means the source claim appears to carry multiple obligations; ask the reducer to split it into separate proposal records before trusting this projection.";
  }
  if (kind === "missing") return "This projection would have to invent behavior or policy unless a missing record is added.";
  if (kind === "conflict") return "This projection needs an explicit policy choice before implementation can treat it as settled.";
  if (kind === "redundant") return "This pressure appears to duplicate another record and should be merged or deleted.";
  if (kind === "loss") return "This projection may drop source meaning unless the reviewer preserves it explicitly.";
  if (kind === "guidance") return "This projection should be rechecked against the latest human guidance.";
  return "This projection has enough source-backed pressure to read, but it is still proposal state.";
}

function renderDecisionQueue(decisions) {
  if (!decisions.length) {
    return `<p class="empty-state">No decisions yet. Run or focus a lens that has completed reducer output.</p>`;
  }
  return decisions.slice(0, 6).map(row => {
    return `
      <article class="decision-card" data-kind="${escapeAttr(row.kind)}">
        <div class="decision-card-head">
          <span class="kind-chip" data-kind="${escapeAttr(row.kind)}">${escapeHtml(row.kind)}</span>
          <span>${escapeHtml(row.targets.join(", ") || "review")}</span>
        </div>
        <strong>${escapeHtml(row.title)}</strong>
        <p>${escapeHtml(row.impact)}</p>
        <div class="decision-actions">${renderSemanticActionButtons(row, `Review pressure: ${row.title}. ${row.impact}`, "decision")}</div>
        ${renderActionStatus(row.id)}
      </article>
    `;
  }).join("");
}

function renderStudioEvidenceList(decisions) {
  const refs = [];
  decisions.forEach(row => {
    const ref = row.source_ref || {};
    if (!ref.start_line) return;
    const key = `${ref.section_id}:${ref.start_line}:${ref.end_line || ref.start_line}`;
    if (refs.some(item => item.key === key)) return;
    refs.push({ key, ref, title: row.title });
  });

  if (!refs.length) return `<p>No evidence pinned yet.</p>`;
  return refs.slice(0, 5).map(({ ref, title }) => `
    <button type="button"
      class="evidence-chip"
      data-source-ref
      data-section-id="${escapeAttr(ref.section_id || "")}"
      data-source-path="${escapeAttr(ref.source_path || "")}"
      data-start-line="${escapeAttr(ref.start_line || "")}"
      data-end-line="${escapeAttr(ref.end_line || ref.start_line || "")}"
      data-choice-title="${escapeAttr(title)}"
      data-choice-body="${escapeAttr(title)}">
      <span>${escapeHtml(sourceRefLabel(ref))}</span>
      <strong>${escapeHtml(conciseLabel(title, 42))}</strong>
    </button>
  `).join("");
}

function feedbackRowsForSection(section, fallbackTargets = []) {
  if (!section?.id) return [];
  return projectionEvents()
    .filter(event => event.type === "human_line_feedback")
    .filter(event => event.payload?.section_id === section.id)
    .slice(-3)
    .reverse()
    .map(event => {
      const line = Number(event.payload?.line_number);
      const targets = arrayField(event.payload?.target_projection).length
        ? arrayField(event.payload?.target_projection).slice(0, 5)
        : fallbackTargets.slice(0, 5);
      const body = event.message || event.payload?.preview_effect || "";
      const kind = event.payload?.feedback_kind || feedbackPreviewModel({
        line_number: line,
        source_text: event.payload?.source_text || ""
      }, body).kind;
      return {
        id: `${event.id}:feedback-decision`,
        kind,
        title: `Intent guidance line ${line || "?"}`,
        evidence: body,
        targets,
        source_ref: {
          section_id: section.id,
          source_path: snapshot.source?.path || "",
          start_line: Number.isFinite(line) ? line : section.start_line,
          end_line: Number.isFinite(line) ? line : section.start_line,
          title: "Intent guidance",
          body
        },
        record: null,
        impact: event.payload?.preview_effect || `Reviewer guidance should be folded into ${targets.join(", ") || "the active projections"}.`,
        suggested_actions: []
      };
    });
}

function decisionRowsForResult(job, result) {
  const findings = result?.findings || [];
  const records = result?.proposed_records || [];
  const fallbackTargets = targetProjectionList(job).slice(0, 4);
  return findings.map((finding, index) => {
    const evidence = finding.evidence || finding.falsifiable_test || finding.body || "";
    const targets = arrayField(finding.target_projection || finding.target_projections);
    const rowTargets = targets.length ? targets.slice(0, 4) : fallbackTargets.slice(0, 3);
    const kind = semanticKind(finding);
    const title = conciseLabel(finding.title || finding.kind || `finding ${index + 1}`, 64);
    const record = recordForFinding(finding, records, rowTargets, index);
    const impact = decisionImpact(kind, rowTargets, record);
    const row = {
      id: `${result.id || result.job_id || job?.id || "result"}:decision:${index + 1}`,
      kind,
      title,
      evidence,
      targets: rowTargets,
      source_ref: sourceRefFromText(evidence, job) || sourceRefForJob(job),
      record,
      impact,
      suggested_actions: suggestedActionsForFinding(finding)
    };
    return {
      ...row,
      actions: semanticActionsForRow(row)
    };
  });
}

function decisionImpact(kind, targets, record) {
  const targetText = targets.length ? targets.join(", ") : "selected targets";
  if (kind === "missing") return `${targetText} would invent behavior unless this missing record is resolved.`;
  if (kind === "coupled") return `${targetText} needs the obligation split before projection can stay precise.`;
  if (kind === "conflict") return `${targetText} needs a policy decision before projection is trustworthy.`;
  if (kind === "redundant") return `${targetText} may be simplified by merging duplicate pressure.`;
  if (kind === "loss") return `${targetText} risks losing source meaning during reduction.`;
  if (record?.id) return `${targetText} has a source-backed proposal ready for working-packet review.`;
  return `${targetText} has readable reducer pressure.`;
}

function fallbackDecisionRows(job, result, targets) {
  if (result) return [];
  return targets.slice(0, 4).map((target, index) => ({
    id: `pending:${target}:${index}`,
    kind: "pending",
    title: `${target} projection understanding`,
    evidence: "",
    targets: [target],
    source_ref: sourceRefForJob(job),
    record: null,
    impact: "Waiting for completed reducer output."
  }));
}

function targetProjectionList(job) {
  const packetTargets = arrayField(contextPacketForJob(job)?.target_projections);
  const snapshotTargets = arrayField(snapshot?.target_projections);
  return [...new Set([...packetTargets, ...snapshotTargets, ...DEFAULT_TARGETS])].filter(Boolean);
}

function fallbackJobs() {
  const jobs = snapshot.jobs || [];
  return jobs.filter(job => job.kind === "root_read" || job.status === "running" || job.status === "failed").slice(0, 4);
}

function renderJobCard(job) {
  const streamCount = (snapshot.streams?.[job.id] || []).length;
  const cwdLabel = job.execution_cwd ? displayPath(job.execution_cwd) : "cwd pending";
  const threadLink = job.codex_thread_url
    ? `<a href="${escapeHtml(job.codex_thread_url)}">Open Codex Thread</a>`
    : `<span class="thread-meta">app-server thread pending</span>`;
  const turnLabel = job.codex_turn_id ? `turn ${job.codex_turn_id}` : "turn pending";
  return `
    <details class="thread-card" data-job-id="${escapeHtml(job.id)}" data-status="${escapeHtml(job.status)}" data-selected="${job.id === selectedJobId}" ${job.id === selectedJobId ? "open" : ""}>
      <summary>
        <span>
          <strong>${escapeHtml(job.title || job.lens_role)}</strong>
          <span class="thread-meta">${escapeHtml(job.id)} | ${streamCount} events</span>
        </span>
        <span class="job-status ${escapeHtml(job.status)}">${escapeHtml(job.status)}</span>
      </summary>
      <div class="thread-card-body">
        <div class="thread-meta">${escapeHtml(job.provider || snapshot.provider)} | ${escapeHtml(job.codex_thread_id || "thread pending")} | ${escapeHtml(turnLabel)}</div>
        <div class="thread-meta">cwd ${escapeHtml(cwdLabel)}</div>
        <div class="thread-actions">
          <button type="button" data-focus-job="${escapeHtml(job.id)}">Focus</button>
          <button type="button" data-stop-job="${escapeHtml(job.id)}">Stop</button>
          <button type="button" data-rerun-job="${escapeHtml(job.id)}">Rerun</button>
          ${threadLink}
        </div>
      </div>
    </details>
  `;
}

function renderStream(job) {
  if (!job) {
    els.liveStream.innerHTML = "";
    return;
  }
  const stream = streamForJob(job);
  const visibleOutputs = visibleToolsWithFallback(job).map(tool => renderVisibleTool(tool, job));
  els.visibleOutputs.innerHTML = visibleOutputs.length
    ? `
      <div class="visible-outputs-head">
        <strong>Prose And Diagrams</strong>
        <span>${visibleOutputs.length}</span>
      </div>
      ${visibleOutputs.join("")}
    `
    : `<div class="visible-outputs-empty">No generated prose or diagram projection yet.</div>`;
  els.liveStream.innerHTML = stream.length
    ? renderGeneratedSurface(stream)
    : renderStreamEmpty(job);
  hydrateMermaid();
}

function streamForJob(job) {
  return job ? (snapshot.streams?.[job.id] || []) : [];
}

function renderStreamEmpty(job) {
  const activeJobs = (snapshot.jobs || []).filter(item => item.status === "running");
  const activeElsewhere = activeJobs.filter(item => item.id !== job.id);
  const activeTurnCount = Number(snapshot.counts?.active_codex_turns || 0);
  const headline = job.status === "queued"
    ? "This lens is queued."
    : job.status === "running"
      ? "Codex turn is starting."
      : "No stream events for this lens.";

  return `
    <div class="generation-stage" data-active="${job.status === "running" || activeTurnCount > 0}">
      <div class="activity-strip">
        <span class="activity-gif" aria-hidden="true"><span></span></span>
        <span>${escapeHtml(headline)}</span>
      </div>
      <div class="generated-transcript">
        ${job.codex_thread_id ? `<div class="generated-placeholder">thread ${escapeHtml(job.codex_thread_id)}</div>` : ""}
        ${job.codex_turn_id ? `<div class="generated-placeholder">turn ${escapeHtml(job.codex_turn_id)}</div>` : ""}
        ${activeElsewhere.length ? `<div class="generated-placeholder">${activeElsewhere.length} other Codex ${activeElsewhere.length === 1 ? "lens is" : "lenses are"} running. Focus a running thread to see its text.</div>` : ""}
        ${!activeTurnCount && !activeElsewhere.length ? `<div class="generated-placeholder">No active app-server turn is attached to this selected lens yet.</div>` : ""}
      </div>
    </div>
  `;
}

function renderGeneratedSurface(stream) {
  const generated = generatedTextChunks(stream);
  const isActive = stream.some(item => item.type === "turn/started") && !stream.some(item => item.type === "turn/completed" || item.type === "turn/failed" || item.type === "turn/cancelled");
  const text = generated.length
    ? renderGeneratedText(generated)
    : `<span class="generated-placeholder">Waiting for model text.</span>`;

  return `
    <div class="generation-stage compact-activity" data-active="${isActive}">
      <div class="activity-strip">
        <span class="activity-gif" aria-hidden="true"><span></span></span>
        <span>${isActive ? "Codex is generating" : "Codex turn text is available"}</span>
      </div>
    </div>
    <details class="generated-text-log">
      <summary>Generated text</summary>
      <div class="generated-transcript">${text}</div>
    </details>
    <details class="raw-stream-log">
      <summary>Protocol log (${stream.length} events)</summary>
      <div class="raw-stream-events">${stream.map(renderStreamEvent).join("")}</div>
    </details>
  `;
}

function renderGeneratedText(chunks) {
  const joined = chunks.join("");
  const parsed = parseJsonText(joined.trim());
  if (isChoicePacket(parsed)) return renderChoicePacket(parsed, selectedJob());

  return chunks
    .map((chunk, index) => `<span class="generation-chunk" style="--fade-delay:${Math.min(index * 35, 700)}ms">${escapeHtml(chunk)}</span>`)
    .join("");
}

function generatedTextChunks(stream) {
  const chunks = stream
    .map(item => {
      const parsed = parseRawEvent(item.raw);
      if (parsed?.method === "item/agentMessage/delta") return parsed.params?.delta || "";
      if (parsed?.method === "item/reasoning/summaryTextDelta") return "";
      if (item.type === "item/agentMessage/delta") return item.summary || "";
      return "";
    })
    .filter(Boolean);

  if (chunks.length) return chunks;

  return stream
    .filter(item => item.type === "item/reasoning/summaryTextDelta" || item.type === "item/reasoning/textDelta")
    .map(item => formattedStreamMessage(item, parseRawEvent(item.raw)))
    .filter(Boolean);
}

function renderStreamEvent(item) {
  const parsed = parseRawEvent(item.raw);
  const type = item.type || parsed?.method || parsed?.type || "event";
  const threadId = item.thread_id || parsed?.params?.threadId || parsed?.params?.thread?.id || parsed?.thread_id || "";
  const turnId = item.turn_id || parsed?.params?.turnId || parsed?.params?.turn?.id || "";
  const message = formattedStreamMessage(item, parsed);
  const raw = item.raw || "";
  const kind = streamEventKind(type);
  const body = renderStreamBody(item, parsed, type, message);
  return `
    <article class="stream-event" data-event-type="${escapeHtml(type)}" data-event-kind="${escapeHtml(kind)}">
      <div class="stream-event-head">
        <span class="stream-type">${escapeHtml(type)}</span>
        <span>${escapeHtml(formatTime(item.at))}</span>
      </div>
      ${threadId ? `<div class="stream-thread">thread ${escapeHtml(threadId)}</div>` : ""}
      ${turnId ? `<div class="stream-thread">turn ${escapeHtml(turnId)}</div>` : ""}
      <div class="stream-message">${body}</div>
      ${raw ? `<details class="stream-raw"><summary>raw protocol message</summary><pre>${escapeHtml(formatRaw(raw, parsed))}</pre></details>` : ""}
    </article>
  `;
}

function parseRawEvent(raw) {
  if (!raw) return null;
  try {
    return JSON.parse(raw);
  } catch {
    return null;
  }
}

function formattedStreamMessage(item, parsed) {
  if (!parsed) return item.summary || item.raw || "Provider event.";
  if (parsed.method === "thread/started") return `Created Codex app-server thread ${parsed.params?.thread?.id || item.thread_id || ""}.`;
  if (parsed.method === "turn/started") return `Started Codex app-server turn ${parsed.params?.turn?.id || item.turn_id || ""}.`;
  if (parsed.method === "item/agentMessage/delta") return parsed.params?.delta || item.summary || "";
  if (parsed.method === "item/tool/call") return item.summary || `${parsed.params?.tool || "dynamic tool"} requested.`;
  if (parsed.method === "item/reasoning/summaryTextDelta") return parsed.params?.delta || item.summary || "";
  if (parsed.method === "item/reasoning/textDelta") return parsed.params?.delta || item.summary || "";
  if (parsed.method === "item/plan/delta") return parsed.params?.delta || item.summary || "";
  if (parsed.method === "item/reasoning/summaryPartAdded") return item.summary || "Started reasoning summary.";
  if (parsed.method === "turn/completed") return "Turn completed.";
  if (parsed.method === "turn/failed") return "Turn failed.";
  if (parsed.method === "turn/cancelled") return "Turn cancelled.";
  return item.summary || parsed.method || parsed.type || "Provider event.";
}

function streamEventKind(type) {
  if (type.startsWith("item/reasoning/")) return "thought";
  if (type === "item/plan/delta") return "thought";
  if (type === "item/tool/call") return "tool";
  if (type === "item/agentMessage/delta") return "model";
  return "protocol";
}

function renderStreamBody(item, parsed, type, message) {
  if (parsed?.method === "item/tool/call") return renderDynamicToolCall(parsed.params || {});
  return renderRichMessage(message, type);
}

function renderDynamicToolCall(params) {
  const tool = normalizeToolParams(params);
  return renderVisibleTool(tool);
}

function renderRichMessage(message, type) {
  const text = String(message || "");
  const parts = splitVisibleToolLines(text);
  return parts.map(part => {
    if (part.kind === "tool") return renderVisibleTool(part.tool);
    return renderMermaidAndText(part.text, type);
  }).join("");
}

function splitVisibleToolLines(text) {
  const parts = [];
  let buffer = [];
  text.split(/\r?\n/).forEach(line => {
    const match = line.match(/^\s*BASIS_STREAM\s+({.*})\s*$/);
    if (!match) {
      buffer.push(line);
      return;
    }
    if (buffer.length) {
      parts.push({ kind: "text", text: buffer.join("\n") });
      buffer = [];
    }
    try {
      parts.push({ kind: "tool", tool: normalizeVisibleTool(JSON.parse(match[1])) });
    } catch {
      parts.push({ kind: "text", text: line });
    }
  });
  if (buffer.length) parts.push({ kind: "text", text: buffer.join("\n") });
  return parts;
}

function normalizeVisibleTool(tool) {
  const name = String(tool.tool || tool.type || tool.name || "").toLowerCase().replaceAll("-", "_");
  return { ...tool, tool: name || "unknown" };
}

function renderVisibleTool(tool) {
  if (["thought", "show_thought", "basis_show_thought"].includes(tool.tool)) {
    return renderThoughtCard(tool.body || tool.message || tool.text || "", tool.title || "Thought");
  }
  if (tool.tool === "basis_semantic_state_map") {
    return renderSemanticStateMap(tool.graph, tool.title || "Semantic Reduction Map");
  }
  if (isMermaidTool(tool.tool)) {
    return renderMermaidBlock(tool.body || tool.diagram || tool.source || "", tool.title || "Mermaid", tool);
  }
  if (["delegate", "delegate_lens", "spawn_delegate", "basis_delegate_lens"].includes(tool.tool)) {
    return renderDelegateCard(tool);
  }
  return `
    <div class="visible-tool-card">
      <div class="visible-tool-label">${escapeHtml(tool.tool || "tool")}</div>
      <pre>${escapeHtml(JSON.stringify(tool, null, 2))}</pre>
    </div>
  `;
}

function isMermaidTool(name) {
  return ["mermaid", "show_mermaid", "diagram", "basis_show_mermaid"].includes(name);
}

function buildSemanticStateGraph(job, result) {
  const findings = (result.findings || []).slice(0, 8);
  const records = result.proposed_records || [];
  const fallbackTargets = arrayField(contextPacketForJob(job)?.target_projections || snapshot.target_projections).slice(0, 4);
  const rows = findings.map((finding, index) => {
    const body = finding.evidence || finding.falsifiable_test || finding.body || "";
    const sourceRef = sourceRefFromText(body, job) || sourceRefForJob(job);
    const targets = arrayField(finding.target_projection || finding.target_projections).length
      ? arrayField(finding.target_projection || finding.target_projections)
      : fallbackTargets;
    const record = recordForFinding(finding, records, targets, index);
    const actionable = isActionableFinding(finding, body);
    const row = {
      id: `semantic-row-${job.id}-${index + 1}`,
      kind: semanticKind(finding),
      relation: semanticRelation(finding),
      title: conciseLabel(finding.title || finding.kind || "finding", 52),
      evidence: body,
      severity: finding.severity || "",
      source_ref: sourceRef,
      targets: targets.length ? targets.slice(0, 4) : ["review"],
      record,
      actionable,
      action: semanticAction(finding, body, record),
      suggested_actions: suggestedActionsForFinding(finding)
    };
    return {
      ...row,
      actions: semanticActionsForRow(row)
    };
  });

  return {
    rows,
    records,
    summary: result.summary || "",
    target_count: new Set(rows.flatMap(row => row.targets)).size
  };
}

function recordForFinding(finding, records, targets, index = -1) {
  if (!records.length) return null;
  const findingText = `${finding.kind || ""} ${finding.title || ""} ${finding.evidence || ""}`.toLowerCase();
  const kind = semanticKind(finding);
  const direct = records.find(record => {
    const title = String(record.title || "").toLowerCase();
    const recordKind = String(record.kind || "").toLowerCase();
    const titleTokens = title.split(/\W+/).filter(token => token.length > 4);
    const hasSpecificTitle = title && !isGenericRecordTitle(title);
    return (
      (hasSpecificTitle && findingText.includes(title)) ||
      (recordKind && recordKind === kind && titleTokens.some(token => findingText.includes(token))) ||
      (hasSpecificTitle && titleTokens.length >= 2 && titleTokens.some(token => findingText.includes(token)))
    );
  });
  if (direct) return direct;

  const indexed = records[index];
  if (indexed && String(indexed.kind || "").toLowerCase() === kind && !isGenericRecordTitle(indexed.title)) {
    return indexed;
  }

  return null;
}

function isGenericRecordTitle(title) {
  const value = String(title || "").toLowerCase().trim();
  return !value || [
    "proposed basis state output",
    "candidate basis proposal",
    "proposal state",
    "proposed record",
    "candidate record"
  ].includes(value);
}

function arrayField(value) {
  if (Array.isArray(value)) return value.filter(item => String(item || "").trim()).map(String);
  if (typeof value === "string") {
    return value.split(",").map(item => item.trim()).filter(Boolean);
  }
  return [];
}

function semanticKind(finding) {
  const text = `${finding.kind || ""} ${finding.title || ""}`.toLowerCase();
  if (text.includes("conflict")) return "conflict";
  if (text.includes("coupl")) return "coupled";
  if (text.includes("missing") || text.includes("absent") || text.includes("open")) return "missing";
  if (text.includes("redundan") || text.includes("duplicat")) return "redundant";
  if (text.includes("derived")) return "derived";
  if (text.includes("loss") || text.includes("fidelity")) return "loss";
  return "pivot";
}

function semanticRelation(finding) {
  const kind = semanticKind(finding);
  if (kind === "conflict") return "conflicts with";
  if (kind === "coupled") return "needs split";
  if (kind === "missing") return "blocks";
  if (kind === "redundant") return "duplicates";
  if (kind === "derived") return "derives from";
  if (kind === "loss") return "may lose";
  return "supports";
}

function semanticAction(finding, body, record) {
  const text = `${finding.kind || ""} ${finding.title || ""} ${body || ""}`.toLowerCase();
  if (record?.id) return "review proposal";
  if (text.includes("no accepted") || text.includes("acceptance")) return "record decision";
  if (isActionableFinding(finding, body)) return "ask synthesis";
  return "inspect";
}

function suggestedActionsForFinding(finding) {
  const actions = Array.isArray(finding.suggested_actions) ? finding.suggested_actions : [];
  return actions
    .map(action => ({
      label: conciseLabel(action.label || action.title || action.action_type || "", 32),
      action_type: String(action.action_type || action.type || "").trim(),
      rationale: action.rationale || action.why || "",
      source: "model"
    }))
    .filter(action => action.label && action.action_type);
}

function semanticActionsForRow(row) {
  const suggestedActions = Array.isArray(row.suggested_actions) ? row.suggested_actions : [];
  const modelActions = suggestedActions
    .map(action => normalizeSemanticAction(action, row))
    .filter(Boolean)
    .slice(0, 3);
  if (modelActions.length) return modelActions;
  return fallbackSemanticActions(row);
}

function normalizeSemanticAction(action, row) {
  const type = action.action_type.replaceAll("-", "_").toLowerCase();
  if (["inspect", "inspect_source", "show_evidence"].includes(type)) {
    return { ...action, type: "inspect_source" };
  }
  if (["ask_synthesis", "synthesize", "reconcile", "split", "make_buildable"].includes(type)) {
    return { ...action, type: "ask_synthesis" };
  }
  if (["record_blocker", "note", "blocker_note"].includes(type)) {
    return { ...action, type: "record_blocker" };
  }
  if (["reject_pressure", "delete", "remove", "discard"].includes(type)) {
    return { ...action, type: "reject_pressure" };
  }
  if (["defer", "defer_pressure"].includes(type)) {
    return { ...action, type: "defer_pressure" };
  }
  if (["keep", "keep_pressure"].includes(type)) {
    return { ...action, type: "keep_pressure" };
  }
  if (row.kind === "redundant" && type.includes("merge")) {
    return { ...action, type: "merge_pressure" };
  }
  return null;
}

function fallbackSemanticActions(row) {
  if (row.kind === "redundant") {
    return [
      { type: "merge_pressure", label: "Mark duplicate", source: "ui_fallback" },
      { type: "reject_pressure", label: "Delete pressure", source: "ui_fallback" },
      { type: "inspect_source", label: "Inspect source", source: "ui_fallback" }
    ];
  }
  if (row.kind === "coupled") {
    return [
      { type: "ask_synthesis", label: "Ask split plan", source: "ui_fallback" },
      { type: "record_blocker", label: "Record blocker", source: "ui_fallback" },
      { type: "inspect_source", label: "Inspect source", source: "ui_fallback" }
    ];
  }
  if (row.kind === "missing" || row.kind === "conflict") {
    return [
      { type: "record_blocker", label: "Record blocker", source: "ui_fallback" },
      { type: "ask_synthesis", label: "Ask synthesis", source: "ui_fallback" },
      { type: "inspect_source", label: "Inspect source", source: "ui_fallback" }
    ];
  }
  if (row.record?.id) {
    return [
      { type: "keep_pressure", label: "Keep pressure", source: "ui_fallback" },
      { type: "defer_pressure", label: "Defer", source: "ui_fallback" },
      { type: "inspect_source", label: "Inspect source", source: "ui_fallback" }
    ];
  }
  return [{ type: "inspect_source", label: "Inspect source", source: "ui_fallback" }];
}

function conciseLabel(value, maxLength = 44) {
  const compact = String(value || "")
    .replace(/[`*_#]/g, "")
    .replace(/\s+/g, " ")
    .trim();
  if (compact.length <= maxLength) return compact;
  const sliced = compact.slice(0, maxLength - 1).trim();
  return `${sliced}…`;
}

function renderSemanticStateMap(graph, title) {
  const rows = graph?.rows || [];
  if (!rows.length) return "";
  return `
    <section class="semantic-map-card">
      <div class="semantic-map-head">
        <div>
          <div class="visible-tool-label">${escapeHtml(title)}</div>
          <strong>Evidence -> reducer claim -> proposal -> projection action</strong>
        </div>
        <span>${escapeHtml(rows.length)} claims</span>
      </div>
      <div class="semantic-map-lanes" aria-hidden="true">
        <span>Evidence</span>
        <span>Semantic claim</span>
        <span>Proposal state</span>
        <span>Projection action</span>
      </div>
      <div class="semantic-map-rows">
        ${rows.map(row => renderSemanticMapRow(row)).join("")}
      </div>
    </section>
  `;
}

function renderSemanticMapRow(row) {
  const ref = row.source_ref || {};
  const record = row.record;
  const subjectId = row.id;
  const noteBody = `Review blocker: ${row.title}. ${row.evidence || ""}`;
  const decision = latestSubjectEvent("human_pressure_decision", subjectId);
  const recordTitle = semanticRecordTitle(row);
  const recordStatus = record?.id ? actionStatus(record.id) : null;
  return `
    <article class="semantic-map-row" data-kind="${escapeAttr(row.kind)}" data-actionable="${row.actionable ? "true" : "false"}" data-decision="${escapeAttr(decision?.payload?.decision || "")}">
      <button type="button"
        class="semantic-source-chip"
        data-semantic-ref
        data-section-id="${escapeAttr(ref.section_id || "")}"
        data-source-path="${escapeAttr(ref.source_path || "")}"
        data-start-line="${escapeAttr(ref.start_line || "")}"
        data-end-line="${escapeAttr(ref.end_line || ref.start_line || "")}"
        data-choice-title="${escapeAttr(row.title)}"
        data-choice-body="${escapeAttr(row.evidence || row.title)}">${escapeHtml(sourceRefLabel(ref))}</button>
      <div class="semantic-claim-node">
        <span class="semantic-kind">${escapeHtml(row.kind)}</span>
        <strong>${escapeHtml(row.title)}</strong>
        <span>${escapeHtml(row.relation)}</span>
      </div>
      <div class="semantic-record-node" data-empty="${record ? "false" : "true"}">
        ${record ? `
          <strong>${escapeHtml(recordTitle)}</strong>
          <span>${escapeHtml(record.kind || row.kind || "proposal")} · proposal only</span>
          ${recordBodyForRow(row) ? `<p>${escapeHtml(recordBodyForRow(row))}</p>` : ""}
          ${recordStatus ? `<div class="record-status" data-state="${escapeAttr(recordStatus.state)}">${escapeHtml(recordStatus.message)}</div>` : ""}
          ${record.id ? `
            <div class="semantic-record-actions">
              <button type="button" data-record-decision="accept_record" data-record-id="${escapeAttr(record.id)}">Keep pressure</button>
              <button type="button" data-record-decision="defer_record" data-record-id="${escapeAttr(record.id)}">Defer</button>
              <button type="button" data-record-decision="reject_record" data-record-id="${escapeAttr(record.id)}">${row.kind === "redundant" ? "Delete duplicate" : "Reject pressure"}</button>
            </div>
          ` : ""}
        ` : `
          <strong>${escapeHtml(recordTitle)}</strong>
          <span>No separate proposal record matched this claim.</span>
        `}
      </div>
      <div class="semantic-action-node">
        <div class="semantic-targets">
          ${row.targets.map(target => `<span>${escapeHtml(target)}</span>`).join("")}
        </div>
        <strong>${escapeHtml(actionTitleForRow(row))}</strong>
        <span class="action-source">${row.actions.some(action => action.source === "model") ? "model-suggested" : "derived fallback"}</span>
        <div class="semantic-action-buttons">${renderSemanticActionButtons(row, noteBody)}</div>
        ${renderActionStatus(subjectId)}
      </div>
    </article>
  `;
}

function semanticRecordTitle(row) {
  if (!row.record) return row.kind === "redundant" ? "Duplicate pressure only" : "No working-packet record yet";
  const title = row.record.title || "";
  if (!isGenericRecordTitle(title)) return conciseLabel(title, 44);
  return `${kindTitle(row.kind)}: ${conciseLabel(row.title, 34)}`;
}

function recordBodyForRow(row) {
  const record = row.record || {};
  const body = record.body || record.evidence || record.known_loss || "";
  if (body) return conciseLabel(body, 96);
  if (isGenericRecordTitle(record.title)) return `Matched to this claim by kind; review before keeping.`;
  return "";
}

function kindTitle(kind) {
  return {
    coupled: "Split proposal",
    missing: "Missing-record proposal",
    conflict: "Policy proposal",
    redundant: "Merge proposal",
    derived: "Derived-record proposal",
    loss: "Loss-risk proposal",
    pivot: "Pivot proposal"
  }[kind] || "Proposal";
}

function actionTitleForRow(row) {
  if (row.kind === "redundant") return "remove or merge duplicate pressure";
  if (row.kind === "coupled") return "split before projecting";
  if (row.kind === "missing") return "record missing dimension";
  if (row.kind === "conflict") return "choose policy before build";
  if (row.record?.id) return "review working-packet proposal";
  return row.action;
}

function renderSemanticActionButtons(row, noteBody, subjectKind = "semantic_row") {
  const ref = row.source_ref || {};
  const actions = Array.isArray(row.actions) ? row.actions : semanticActionsForRow(row);
  return actions.map(action => renderSemanticActionButton(row, action, ref, noteBody, subjectKind)).join("");
}

function renderSemanticActionButton(row, action, ref, noteBody, subjectKind) {
  const label = reviewerActionLabel(row, action);
  const synthesisBody = action.rationale
    ? `${label}: ${action.rationale}. ${row.kind}: ${row.title}. Evidence: ${row.evidence || ""}`
    : `Synthesize next action for ${row.kind}: ${row.title}. Evidence: ${row.evidence || ""}`;
  const common = `
    data-subject-kind="${escapeAttr(subjectKind)}"
    data-subject-id="${escapeAttr(row.id)}"
    data-action-key="${escapeAttr(row.id)}"
  `;
  if (action.type === "inspect_source") {
    return `<button type="button" data-semantic-ref ${common} data-section-id="${escapeAttr(ref.section_id || "")}" data-source-path="${escapeAttr(ref.source_path || "")}" data-start-line="${escapeAttr(ref.start_line || "")}" data-end-line="${escapeAttr(ref.end_line || ref.start_line || "")}" data-choice-title="${escapeAttr(row.title)}" data-choice-body="${escapeAttr(row.evidence || row.impact || row.title)}">${escapeHtml(label)}</button>`;
  }
  if (action.type === "record_blocker") {
    return `<button type="button" data-record-note ${common} data-note-body="${escapeAttr(noteBody)}">${escapeHtml(label)}</button>`;
  }
  if (action.type === "ask_synthesis") {
    return `<button type="button" data-request-synthesis ${common} data-synthesis-body="${escapeAttr(synthesisBody)}">${escapeHtml(label)}</button>`;
  }
  if (["reject_pressure", "defer_pressure", "keep_pressure", "merge_pressure"].includes(action.type)) {
    return `<button type="button" data-pressure-decision="${escapeAttr(action.type)}" ${common} data-decision-body="${escapeAttr(`${label}: ${row.kind} ${row.title}. ${row.evidence || ""}`)}">${escapeHtml(label)}</button>`;
  }
  return "";
}

function reviewerActionLabel(row, action) {
  const label = action.label || action.type || "Review";
  if (row.kind === "coupled" && action.type === "ask_synthesis" && /^ask synthesis$/i.test(label)) {
    return "Ask split plan";
  }
  return label;
}

function sourceRefLabel(ref) {
  if (!ref?.start_line) return "source";
  const end = ref.end_line && ref.end_line !== ref.start_line ? `-${ref.end_line}` : "";
  return `lines ${ref.start_line}${end}`;
}

function renderMermaidAndText(text, type) {
  if (!text) return "";
  const html = [];
  const pattern = /```mermaid\s*([\s\S]*?)```/gi;
  let cursor = 0;
  let match;
  while ((match = pattern.exec(text)) !== null) {
    html.push(renderTextChunk(text.slice(cursor, match.index), type));
    html.push(renderMermaidBlock(match[1], "Mermaid"));
    cursor = match.index + match[0].length;
  }
  html.push(renderTextChunk(text.slice(cursor), type));
  return html.join("");
}

function renderTextChunk(text, type) {
  const trimmed = text.trim();
  if (!trimmed) return "";

  if (streamEventKind(type) === "thought") {
    return renderThoughtCard(trimmed, type.includes("plan") ? "Plan" : "Reasoning");
  }

  const lines = text.split(/\r?\n/);
  const html = [];
  let buffer = [];
  lines.forEach(line => {
    const thought = line.match(/^\s*THOUGHT:\s*(.*)$/i);
    if (!thought) {
      buffer.push(line);
      return;
    }
    if (buffer.join("\n").trim()) {
      html.push(renderPlainText(buffer.join("\n")));
    }
    buffer = [];
    html.push(renderThoughtCard(thought[1], "Thought"));
  });
  if (buffer.join("\n").trim()) html.push(renderPlainText(buffer.join("\n")));
  return html.join("");
}

function renderPlainText(text) {
  const trimmed = text.trim();
  if (looksLikeJson(trimmed)) {
    const parsed = parseJsonText(trimmed);
    if (isChoicePacket(parsed)) return renderChoicePacket(parsed, selectedJob());
    return `<pre class="stream-json">${escapeHtml(prettyJson(trimmed))}</pre>`;
  }
  return `<div class="stream-text">${escapeHtml(text)}</div>`;
}

function parseJsonText(text) {
  try {
    return JSON.parse(text);
  } catch {
    return null;
  }
}

function isChoicePacket(value) {
  return value && Array.isArray(value.questions) && value.questions.length > 0;
}

function renderChoicePacket(packet, job) {
  const questions = packet.questions || [];
  const cards = questions.map((question, index) => {
    const ref = sourceRefFromText(JSON.stringify(question), job) || sourceRefForJob(job);
    const prompt = question.question || question.title || question.kind || `Choice ${index + 1}`;
    const effect = question.decision_effect || question.why_now || question.evidence || "";
    const draft = choiceDraftText(question);
    return `
      <article class="choice-card">
        <div class="choice-card-head">
          <strong>${escapeHtml(question.title || prompt)}</strong>
          ${ref?.start_line ? `<span>lines ${escapeHtml(ref.start_line)}-${escapeHtml(ref.end_line || ref.start_line)}</span>` : ""}
        </div>
        ${question.question ? `<p>${escapeHtml(question.question)}</p>` : ""}
        ${question.why_now ? `<p class="choice-note">${escapeHtml(question.why_now)}</p>` : ""}
        ${effect ? `<div class="draft-edit-preview"><strong>Effect</strong><span>${escapeHtml(effect)}</span></div>` : ""}
        <div class="choice-actions">
          <button type="button"
            data-preview-choice
            data-section-id="${escapeAttr(ref?.section_id || "")}"
            data-start-line="${escapeAttr(ref?.start_line || "")}"
            data-end-line="${escapeAttr(ref?.end_line || ref?.start_line || "")}"
            data-choice-title="${escapeAttr(prompt)}"
            data-choice-body="${escapeAttr(draft)}">Preview edit</button>
          <button type="button"
            data-apply-choice
            data-section-id="${escapeAttr(ref?.section_id || "")}"
            data-start-line="${escapeAttr(ref?.start_line || "")}"
            data-end-line="${escapeAttr(ref?.end_line || ref?.start_line || "")}"
            data-choice-title="${escapeAttr(prompt)}"
            data-choice-body="${escapeAttr(draft)}">Apply as guidance</button>
        </div>
      </article>
    `;
  }).join("");

  return `
    <div class="choice-packet">
      <div class="choice-packet-head">
        <strong>Choice Packet</strong>
        <span>${escapeHtml(questions.length)} ${questions.length === 1 ? "choice" : "choices"}</span>
      </div>
      ${packet.title ? `<p class="choice-note">${escapeHtml(packet.title)}</p>` : ""}
      ${cards}
      <details class="choice-raw">
        <summary>raw packet</summary>
        <pre>${escapeHtml(JSON.stringify(packet, null, 2))}</pre>
      </details>
    </div>
  `;
}

function choiceDraftText(question) {
  const parts = [
    question.question ? `Selected choice: ${question.question}` : "",
    question.decision_effect ? `Document effect: ${question.decision_effect}` : "",
    question.why_now ? `Why now: ${question.why_now}` : ""
  ].filter(Boolean);
  return parts.join("\n");
}

function renderThoughtCard(body, label) {
  return `
    <div class="thought-card">
      <div class="thought-label">${escapeHtml(label)}</div>
      <div>${escapeHtml(body)}</div>
    </div>
  `;
}

function renderDelegateCard(tool) {
  const rows = [
    ["role", tool.role || tool.lens_role || "visible_delegate_lens"],
    ["task", tool.task || tool.body || tool.message || ""],
    ["why", tool.why || ""],
    ["handoff", tool.handoff || ""]
  ].filter(([, value]) => String(value || "").trim());
  return `
    <div class="delegate-card">
      <div class="visible-tool-label">Delegate Requested</div>
      <dl>
        ${rows.map(([key, value]) => `<dt>${escapeHtml(key)}</dt><dd>${escapeHtml(value)}</dd>`).join("")}
      </dl>
    </div>
  `;
}

function renderMermaidBlock(code, title, tool = {}) {
  const source = String(code || "").trim();
  if (!source) return "";
  const anchor = normalizeSourceAnchor(tool);
  const hasAnchor = anchor.start_line || anchor.quote;
  return `
    <div class="mermaid-card" data-mermaid="${escapeHtml(encodeURIComponent(source))}" data-has-anchor="${hasAnchor ? "true" : "false"}">
      <div class="mermaid-card-head">
        <div class="visible-tool-label">${escapeHtml(title || "Mermaid")}</div>
        ${hasAnchor ? `<button type="button" data-scroll-anchor="${escapeHtml(anchor.section_id || "")}" data-start-line="${escapeHtml(anchor.start_line || "")}">Show source</button>` : ""}
      </div>
      ${hasAnchor ? `<div class="diagram-anchor">Projects ${escapeHtml(anchor.section_id || "source")} ${anchor.start_line ? `lines ${escapeHtml(anchor.start_line)}-${escapeHtml(anchor.end_line || anchor.start_line)}` : "quoted source"}</div>` : ""}
      <div class="mermaid-output"><pre class="mermaid-source-inline">${escapeHtml(source)}</pre></div>
      <details class="mermaid-source">
        <summary>mermaid source</summary>
        <pre>${escapeHtml(source)}</pre>
      </details>
    </div>
  `;
}

function looksLikeJson(text) {
  return text.startsWith("{") && text.endsWith("}");
}

function prettyJson(text) {
  try {
    return JSON.stringify(JSON.parse(text), null, 2);
  } catch {
    return text;
  }
}

async function hydrateMermaid() {
  const nodes = [...document.querySelectorAll(".mermaid-card:not([data-rendered])")];
  if (!nodes.length) return;
  const mermaid = await loadMermaid();
  nodes.forEach(async node => {
    node.dataset.rendered = "true";
    const output = node.querySelector(".mermaid-output");
    const source = decodeURIComponent(node.dataset.mermaid || "");
    if (!mermaid) {
      node.classList.add("mermaid-fallback");
      return;
    }
    try {
      const id = `basis-mermaid-${++mermaidRenderCounter}`;
      const rendered = await mermaid.render(id, source);
      output.innerHTML = rendered.svg;
      node.classList.add("mermaid-rendered");
    } catch (error) {
      output.textContent = `Mermaid render failed: ${error?.message || error}`;
      node.classList.add("mermaid-fallback");
    }
  });
}

function loadMermaid() {
  if (!mermaidPromise) {
    mermaidPromise = import("https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs")
      .then(module => {
        module.default.initialize({ startOnLoad: false, securityLevel: "strict" });
        return module.default;
      })
      .catch(() => null);
  }
  return mermaidPromise;
}

function formatRaw(raw, parsed) {
  return parsed ? JSON.stringify(parsed, null, 2) : raw;
}

function formatTime(value) {
  if (!value) return "";
  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return value;
  return date.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit", second: "2-digit" });
}

function displayPath(path) {
  const text = String(path || "");
  const marker = "components/spec-basis-reducer/";
  const index = text.indexOf(marker);
  return index >= 0 ? text.slice(index) : text;
}

function renderContext(job) {
  if (!job) {
    els.contextHash.textContent = "";
    els.contextPacket.innerHTML = "";
    return;
  }
  const packet = (snapshot.context_packets || []).find(item => item.id === job.context_packet);
  els.contextHash.textContent = packet ? packet.context_hash.slice(0, 10) : "";
  els.contextPacket.innerHTML = packet ? `
    <dl>
      <dt>packet</dt><dd>${escapeHtml(packet.id)}</dd>
      <dt>role</dt><dd>${escapeHtml(packet.lens_role)}</dd>
      <dt>source</dt><dd>${escapeHtml(packet.source_path)}</dd>
      <dt>absolute</dt><dd>${escapeHtml(packet.source_absolute_path ? displayPath(packet.source_absolute_path) : "")}</dd>
      <dt>range</dt><dd>${escapeHtml(packet.source_range)}</dd>
      <dt>targets</dt><dd>${escapeHtml((packet.target_projections || []).join(", "))}</dd>
      <dt>cwd</dt><dd>${escapeHtml(job.execution_cwd ? displayPath(job.execution_cwd) : "pending")}</dd>
      <dt>excluded</dt><dd>${escapeHtml((packet.excluded_context || []).join(", "))}</dd>
    </dl>
  ` : `<p>No packet found.</p>`;
}

function renderResults(job) {
  if (!job) {
    els.resultCount.textContent = "0";
    els.resultEvidence.innerHTML = "";
    return;
  }
  const result = resultForJob(job);
  const findings = result?.findings || [];
  const records = result?.proposed_records || [];
  els.resultCount.textContent = String(findings.length);
  els.resultEvidence.innerHTML = result ? `
    <article class="finding finding-summary">
      <strong>Summary</strong>
      <span>${renderSourceLinkedText(result.summary || "No summary.", job)}</span>
    </article>
    ${result.error ? `<article class="finding error"><strong>Error</strong><span>${renderSourceLinkedText(result.error, job)}</span></article>` : ""}
    ${findings.map((finding, index) => renderFinding(job, result, finding, index)).join("")}
    ${records.length ? `
      <section class="proposal-records" aria-label="Proposed records">
        <div class="proposal-records-head">
          <strong>Proposed Records</strong>
          <span>${escapeHtml(records.length)}</span>
        </div>
        ${records.map(record => renderProposalRecord(record)).join("")}
      </section>
    ` : ""}
  ` : `<p>No completed result yet.</p>`;
}

function renderFinding(job, result, finding, index) {
  const title = finding.title || finding.kind || "finding";
  const body = finding.evidence || finding.falsifiable_test || "";
  const actionable = isActionableFinding(finding, body);
  const subjectId = `${result.id || result.job_id || job.id}:finding:${index + 1}`;

  return `
    <article class="finding" data-actionable="${actionable ? "true" : "false"}">
      <strong>${escapeHtml(title)}</strong>
      <span>${renderSourceLinkedText(body, job)}</span>
      ${actionable ? `
        <div class="finding-actions">
          <button type="button"
            data-record-note
            data-subject-kind="finding"
            data-subject-id="${escapeAttr(subjectId)}"
            data-action-key="${escapeAttr(subjectId)}"
            data-note-body="${escapeAttr(`Review blocker: ${title}. ${body}`)}">Record blocker note</button>
          <button type="button"
            data-request-synthesis
            data-subject-kind="finding"
            data-subject-id="${escapeAttr(subjectId)}"
            data-action-key="${escapeAttr(subjectId)}"
            data-synthesis-body="${escapeAttr(`Reconcile finding: ${title}. ${body}`)}">Ask synthesis to reconcile</button>
        </div>
        ${renderActionStatus(subjectId)}
      ` : ""}
    </article>
  `;
}

function renderProposalRecord(record) {
  const id = record.id || "";
  const title = record.title || record.kind || id || "proposed record";
  const body = record.body || record.evidence || record.falsifiable_test || "";
  return `
    <article class="proposal-record">
      <div>
        <strong>${escapeHtml(title)}</strong>
        <span>${escapeHtml(record.kind || "proposal")} | ${escapeHtml(record.acceptance_boundary || "proposal state")}</span>
      </div>
      ${body ? `<p>${escapeHtml(body)}</p>` : ""}
      ${id ? `
        <div class="record-actions">
          <button type="button" data-record-decision="accept_record" data-record-id="${escapeAttr(id)}">Keep in working packet</button>
          <button type="button" data-record-decision="defer_record" data-record-id="${escapeAttr(id)}">Defer</button>
          <button type="button" data-record-decision="reject_record" data-record-id="${escapeAttr(id)}">Reject pressure</button>
        </div>
      ` : ""}
    </article>
  `;
}

function isActionableFinding(finding, body) {
  const text = `${finding.kind || ""} ${finding.title || ""} ${body || ""}`.toLowerCase();
  return [
    "missing",
    "open_question",
    "conflict",
    "no accepted",
    "requires",
    "must",
    "unresolved",
    "block"
  ].some(token => text.includes(token));
}

function renderSourceLinkedText(text, job) {
  const value = String(text || "");
  const refs = lineReferencesInText(value, job);
  if (!refs.length) return escapeHtml(value);

  let cursor = 0;
  const html = [];
  refs.forEach(ref => {
    html.push(escapeHtml(value.slice(cursor, ref.index)));
    html.push(`
      <button type="button"
        class="source-ref"
        data-source-ref
        data-section-id="${escapeAttr(ref.section_id)}"
        data-source-path="${escapeAttr(ref.source_path || "")}"
        data-start-line="${escapeAttr(ref.start_line)}"
        data-end-line="${escapeAttr(ref.end_line)}">${escapeHtml(ref.label)}</button>
    `);
    cursor = ref.end_index;
  });
  html.push(escapeHtml(value.slice(cursor)));
  return html.join("");
}

function bindRailButtons() {
  document.querySelectorAll("[data-focus-job]").forEach(button => {
    button.addEventListener("click", () => {
      selectedJobId = button.dataset.focusJob;
      render();
    });
  });
  document.querySelectorAll("[data-stop-job]").forEach(button => {
    button.addEventListener("click", () => postJson("/api/actions", { type: "stop_lens", job_id: button.dataset.stopJob }));
  });
  document.querySelectorAll("[data-rerun-job]").forEach(button => {
    button.addEventListener("click", () => postJson("/api/actions", { type: "rerun_lens", job_id: button.dataset.rerunJob }));
  });
  document.querySelectorAll("[data-request-synthesis]").forEach(button => {
    button.addEventListener("click", () => requestSynthesisFromButton(button));
  });
  document.querySelectorAll("[data-record-note]").forEach(button => {
    button.addEventListener("click", () => recordNoteFromButton(button));
  });
  document.querySelectorAll("[data-record-decision]").forEach(button => {
    button.addEventListener("click", () => recordDecisionFromButton(button));
  });
  document.querySelectorAll("[data-pressure-decision]").forEach(button => {
    button.addEventListener("click", () => pressureDecisionFromButton(button));
  });
  document.querySelectorAll("[data-projection-impact]").forEach(button => {
    button.addEventListener("click", () => previewProjectionImpact(button));
  });
  document.querySelectorAll("[data-scroll-anchor]").forEach(button => {
    button.addEventListener("click", () => {
      const sectionId = button.dataset.scrollAnchor || selectedSectionId;
      const line = button.dataset.startLine;
      const target =
        (line && document.querySelector(`.source-line[data-line="${CSS.escape(line)}"]`)) ||
        document.querySelector(`.doc-section[data-section-id="${CSS.escape(sectionId)}"]`);
      target?.scrollIntoView({ block: "center", behavior: "smooth" });
    });
  });
  document.querySelectorAll("[data-source-ref]").forEach(button => {
    button.addEventListener("mouseenter", () => previewSourceReference(button));
    button.addEventListener("focus", () => previewSourceReference(button));
    button.addEventListener("click", () => previewSourceReference(button));
    button.addEventListener("mouseleave", clearSourceReference);
    button.addEventListener("blur", clearSourceReference);
  });
  document.querySelectorAll("[data-semantic-ref]").forEach(button => {
    button.addEventListener("mouseenter", () => previewSourceReference(button));
    button.addEventListener("focus", () => previewSourceReference(button));
    button.addEventListener("click", () => previewSourceReference(button));
    button.addEventListener("mouseleave", clearSourceReference);
    button.addEventListener("blur", clearSourceReference);
  });
  document.querySelectorAll("[data-preview-choice]").forEach(button => {
    button.addEventListener("click", () => previewChoice(button));
  });
  document.querySelectorAll("[data-apply-choice]").forEach(button => {
    button.addEventListener("click", () => applyChoice(button));
  });
}

async function requestSynthesisFromButton(button) {
  const subjectId = actionSubjectId(button);
  setActionStatus(subjectId, "pending", "Requesting synthesis for this item...");
  try {
    await postJson("/api/actions", {
      type: "request_synthesis",
      subject_kind: button.dataset.subjectKind || "run",
      subject_id: subjectId,
      body: button.dataset.synthesisBody || "Synthesize next reducer action for this item."
    });
    setActionStatus(subjectId, "recorded", "Synthesis request recorded.");
  } catch (error) {
    setActionStatus(subjectId, "failed", `Synthesis request failed: ${error.message || error}`);
  }
}

async function recordNoteFromButton(button) {
  const subjectId = actionSubjectId(button);
  setActionStatus(subjectId, "pending", "Recording blocker note...");
  try {
    await postJson("/api/actions", {
      type: "note",
      body: button.dataset.noteBody || "Review blocker.",
      subject_kind: button.dataset.subjectKind || "finding",
      subject_id: subjectId
    });
    setActionStatus(subjectId, "recorded", "Blocker note recorded.");
  } catch (error) {
    setActionStatus(subjectId, "failed", `Blocker note failed: ${error.message || error}`);
  }
}

async function recordDecisionFromButton(button) {
  const recordId = button.dataset.recordId;
  const decision = button.dataset.recordDecision;
  setActionStatus(recordId, "pending", `${humanDecisionLabel(decision)} record...`);
  try {
    await postJson("/api/actions", {
      type: decision,
      record_id: recordId
    });
    setActionStatus(recordId, "recorded", `Record marked ${humanDecisionLabel(decision).toLowerCase()}.`);
  } catch (error) {
    setActionStatus(recordId, "failed", `Record action failed: ${error.message || error}`);
  }
}

async function pressureDecisionFromButton(button) {
  const subjectId = actionSubjectId(button);
  const decision = button.dataset.pressureDecision;
  setActionStatus(subjectId, "pending", `${humanDecisionLabel(decision)} pressure...`);
  try {
    await postJson("/api/actions", {
      type: "pressure_decision",
      decision,
      subject_kind: button.dataset.subjectKind || "semantic_row",
      subject_id: subjectId,
      body: button.dataset.decisionBody || ""
    });
    setActionStatus(subjectId, "recorded", `Pressure marked ${humanDecisionLabel(decision).toLowerCase()}.`);
  } catch (error) {
    setActionStatus(subjectId, "failed", `Pressure action failed: ${error.message || error}`);
  }
}

function actionSubjectId(button) {
  return button.dataset.actionKey || button.dataset.subjectId || selectedJobId || selectedSectionId || "run";
}

function previewProjectionImpact(button) {
  activeProjectionImpact = {
    row_id: button.dataset.rowId,
    kind: button.dataset.kind || "pressure",
    title: button.dataset.title || "Projection impact",
    target: button.dataset.target || "",
    impact: button.dataset.impact || "",
    evidence: button.dataset.evidence || "",
    section_id: button.dataset.sectionId || selectedSectionId || "",
    source_path: button.dataset.sourcePath || "",
    start_line: button.dataset.startLine || "",
    end_line: button.dataset.endLine || button.dataset.startLine || ""
  };

  activeSourceReference = {
    kind: "projection_impact",
    section_id: activeProjectionImpact.section_id,
    source_path: activeProjectionImpact.source_path,
    start_line: Number(activeProjectionImpact.start_line) || null,
    end_line: Number(activeProjectionImpact.end_line || activeProjectionImpact.start_line) || null,
    title: activeProjectionImpact.title,
    body: activeProjectionImpact.evidence || activeProjectionImpact.impact
  };

  renderDocument();
  renderRail();
  scrollToSourceReference(activeSourceReference);
  requestAnimationFrame(() => {
    document.querySelector(".projection-impact-detail")?.scrollIntoView({ block: "nearest", behavior: "smooth" });
  });
}

function referenceFromButton(button, kind = "source_reference") {
  const start = Number(button.dataset.startLine);
  const end = Number(button.dataset.endLine || button.dataset.startLine);
  return {
    kind,
    section_id: button.dataset.sectionId || selectedSectionId || "",
    source_path: button.dataset.sourcePath || "",
    start_line: Number.isFinite(start) ? start : null,
    end_line: Number.isFinite(end) ? end : start,
    title: button.dataset.choiceTitle || "Source reference",
    body: button.dataset.choiceBody || ""
  };
}

function previewSourceReference(button) {
  activeSourceReference = referenceFromButton(button, "source_reference");
  renderDocument();
  scrollToSourceReference(activeSourceReference);
}

function clearSourceReference() {
  if (!activeSourceReference) return;
  activeSourceReference = null;
  renderDocument();
}

function previewChoice(button) {
  activeChoicePreview = {
    ...referenceFromButton(button, "choice_preview"),
    title: "Choice preview",
    body: button.dataset.choiceBody || "Previewing the selected choice as source-anchored guidance."
  };
  renderDocument();
  scrollToSourceReference(activeChoicePreview);
}

async function applyChoice(button) {
  const anchor = referenceFromButton(button, "choice_preview");
  const body = button.dataset.choiceBody || button.dataset.choiceTitle || "Choice selected.";
  activeChoicePreview = {
    ...anchor,
    title: "Choice selected",
    body
  };
  renderDocument();
  scrollToSourceReference(activeChoicePreview);

  const line = {
    section_id: anchor.section_id,
    line_number: anchor.start_line,
    source_text: button.dataset.choiceTitle || "choice packet"
  };
  recordLocalFeedback(line, body);
  renderFeedbackApplied(line, body, "submitting");

  try {
    await postJson("/api/actions", {
      type: "line_feedback",
      body,
      mode: "additive",
      section_id: line.section_id,
      line_number: line.line_number,
      source_text: line.source_text
    });
    renderFeedbackApplied(line, body, "applied");
  } catch (error) {
    renderFeedbackApplied(line, body, "failed", error);
  }
}

function scrollToSourceReference(anchor) {
  if (!anchor) return;
  suppressSectionObserverUntil = Date.now() + 900;
  requestAnimationFrame(() => {
    const line = anchor.start_line ? String(anchor.start_line) : "";
    const target =
      (line && document.querySelector(`.source-line[data-line="${CSS.escape(line)}"]`)) ||
      (anchor.section_id && document.querySelector(`.doc-section[data-section-id="${CSS.escape(anchor.section_id)}"]`));
    target?.scrollIntoView({ block: "center", behavior: "smooth" });
  });
}

els.startForm.addEventListener("submit", event => {
  event.preventDefault();
  previewRequestSeq += 1;
  clearRunViewState();
  clearTimeout(autoBuildTimer);
  autoBuildMessage = "";
  lastAutoBuildKey = autoBuildKey();
  postJson("/api/start", runStartPayload());
});

els.corpusSample?.addEventListener("change", () => {
  const sample = CORPUS_SAMPLES[Number(els.corpusSample.value)];
  els.sourcePath.value = sample?.path || "components/spec-basis-reducer/spec.md";
  excludedSectionIds = new Set();
  queueNewSourceLoad();
});

function queueNewSourceLoad() {
  resetProjectionForSourceChange("Source changed. Creating a fresh reducer thread pool for this spec.");
  lastAutoBuildKey = "";
  clearTimeout(autoBuildTimer);
  queuePreview({ force: true });
}

function queuePreview(options = {}) {
  clearTimeout(previewTimer);
  previewTimer = setTimeout(() => loadPreview(options), 160);
}

els.sourcePath.addEventListener("change", queueNewSourceLoad);

els.pauseRun.addEventListener("click", () => postJson("/api/actions", { type: "pause" }));
els.resumeRun.addEventListener("click", () => postJson("/api/actions", { type: "resume" }));
els.toggleInspector?.addEventListener("click", () => {
  setInspectorOpen(document.body.dataset.inspectorOpen !== "true");
});
els.noteForm.addEventListener("submit", event => {
  event.preventDefault();
  const body = els.noteBody.value.trim();
  if (!body) return;
  const job = selectedJob();
  postJson("/api/actions", {
    type: "note",
    body,
    subject_kind: job ? "lens_job" : "section",
    subject_id: job?.id || selectedSectionId
  });
  els.noteBody.value = "";
});

installCorpusSamples();
connectEvents();
getRun().then(() => loadPreview());
