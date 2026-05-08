import {
  buildFrontierGraph,
  firstFrontierNodeId,
  frontierNodeById,
  nextFrontierNodeId,
  renderArchitectureDiagram,
  renderFrontierGraph,
  selectedClusterDetails
} from "./frontier.js";
import { renderSpecDocument } from "./renderers/spec-document.js";

const els = {
  runMeta: document.querySelector("#runMeta"),
  startForm: document.querySelector("#startForm"),
  mode: document.querySelector("#mode"),
  sourcePath: document.querySelector("#sourcePath"),
  targets: document.querySelector("#targets"),
  implementationTarget: document.querySelector("#implementationTarget"),
  sectionLimit: document.querySelector("#sectionLimit"),
  maxConcurrency: document.querySelector("#maxConcurrency"),
  branchCount: document.querySelector("#branchCount"),
  maxDepth: document.querySelector("#maxDepth"),
  documentStatus: document.querySelector("#documentStatus"),
  documentSections: document.querySelector("#documentSections"),
  threadPane: document.querySelector("#threadPane"),
  activeSectionTitle: document.querySelector("#activeSectionTitle"),
  activeSectionMeta: document.querySelector("#activeSectionMeta"),
  connectionState: document.querySelector("#connectionState"),
  closeThreadInspector: document.querySelector("#closeThreadInspector"),
  threadDock: document.querySelector("#threadDock"),
  selectedJobLabel: document.querySelector("#selectedJobLabel"),
  liveStream: document.querySelector("#liveStream"),
  contextHash: document.querySelector("#contextHash"),
  contextPacket: document.querySelector("#contextPacket"),
  resultCount: document.querySelector("#resultCount"),
  resultEvidence: document.querySelector("#resultEvidence"),
  pauseRun: document.querySelector("#pauseRun"),
  resumeRun: document.querySelector("#resumeRun"),
  requestSynthesis: document.querySelector("#requestSynthesis"),
  imaginerPanel: document.querySelector("#imaginerPanel"),
  imaginerMetrics: document.querySelector("#imaginerMetrics"),
  frontierFocus: document.querySelector("#frontierFocus"),
  frontierViewport: document.querySelector("#frontierViewport"),
  frontierGraph: document.querySelector("#frontierGraph"),
  decisionGraphStats: document.querySelector("#decisionGraphStats"),
  decisionGraph: document.querySelector("#decisionGraph"),
  closeSelectedPanel: document.querySelector("#closeSelectedPanel"),
  branchRollupStats: document.querySelector("#branchRollupStats"),
  branchRollups: document.querySelector("#branchRollups"),
  planTraceStats: document.querySelector("#planTraceStats"),
  planTrace: document.querySelector("#planTrace"),
  sourceDrawer: document.querySelector("#sourceDrawer"),
  steerForm: document.querySelector("#steerForm"),
  steerTarget: document.querySelector("#steerTarget"),
  steerBody: document.querySelector("#steerBody"),
  queueBranch: document.querySelector("#queueBranch"),
  rejectBranch: document.querySelector("#rejectBranch"),
  noteForm: document.querySelector("#noteForm"),
  noteBody: document.querySelector("#noteBody")
};

let snapshot = null;
let selectedSectionId = null;
let selectedJobId = null;
let selectedBranchId = null;
let selectedGraphNodeId = null;
let currentFrontierGraph = null;
let selectedCluster = null;
let inspectorOpen = document.body.dataset.appShell === "reducer";
let selectedPanelOpen = true;
let selectedPanelScroll = { clusterId: null, top: 0, left: 0 };
let observer = null;
let panState = null;
let activeSourceReference = null;
let activeChoicePreview = null;
let suppressSectionObserverUntil = 0;

const API_ORIGIN = window.location.protocol === "file:" ? "http://127.0.0.1:8767" : "";

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
  const response = await fetch(apiUrl("/api/run"));
  snapshot = await response.json();
  render();
}

async function postJson(path, payload) {
  const response = await fetch(apiUrl(path), {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify(payload)
  });
  snapshot = await response.json();
  render();
}

function connectEvents() {
  const events = new EventSource(apiUrl("/api/events"));
  events.addEventListener("open", () => setConnection("live"));
  events.addEventListener("error", () => setConnection("offline"));
  events.addEventListener("snapshot", event => {
    snapshot = JSON.parse(event.data);
    render();
  });
  events.addEventListener("event", () => getRun());
}

function apiUrl(path) {
  return `${API_ORIGIN}${path}`;
}

function startPollingFallback() {
  window.setInterval(() => {
    if (document.hidden) return;
    getRun();
  }, 1800);
}

function setConnection(state) {
  els.connectionState.textContent = state;
  els.connectionState.classList.toggle("live", state === "live");
}

function render() {
  if (!snapshot) return;

  const source = snapshot.source || {};
  els.runMeta.textContent = snapshot.run_id
    ? `${snapshot.mode || "reducer"} | ${source.path || "unknown source"} | ${snapshot.run_id} | ${snapshot.provider} | ${snapshot.status}`
    : "No run loaded.";

  renderDocument();
  ensureSelectedSection();
  renderImaginer();
  renderRail();
}

function renderDocument() {
  const sections = snapshot.document_sections || [];
  els.documentStatus.textContent = snapshot.run_id
    ? statusSummary(sections.length, snapshot.counts || {})
    : "Start a run to load the document.";

  if (sections.length === 0) {
    els.documentSections.innerHTML = `<section class="doc-section"><div></div><div class="section-body"><h2>No document loaded</h2><p>Start a run to stream Codex lens work beside the source.</p></div></section>`;
    return;
  }

  els.documentSections.innerHTML = sections.map(section => {
    const jobs = jobsForSection(section.id);
    const running = jobs.filter(job => job.status === "running").length;
    const completed = jobs.filter(job => job.status === "completed").length;
    const failed = jobs.filter(job => job.status === "failed").length;
    const queued = jobs.filter(job => job.status === "queued").length;
    return `
      <section id="${escapeHtml(section.id)}" class="doc-section" data-section-id="${escapeHtml(section.id)}" data-active="${section.id === selectedSectionId}">
        <div class="section-gutter">
          <strong>${escapeHtml(section.id)}</strong>
          <span>${escapeHtml(section.start_line)}-${escapeHtml(section.end_line)}</span>
          <span>${running} running</span>
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
}

function renderSourceText(section) {
  const anchors = [
    ...feedbackAnchorsForSection(section),
    ...sourceReferenceAnchorsForSection(section),
    ...choicePreviewAnchorsForSection(section)
  ];
  return renderSpecDocument(section, anchors);
}

function projectionEvents() {
  const seen = new Set();
  return [...(snapshot.events || []), ...(snapshot.interventions || [])]
    .filter(event => {
      const id = event.id || `${event.type}-${event.timestamp}-${event.message}`;
      if (seen.has(id)) return false;
      seen.add(id);
      return true;
    })
    .sort((a, b) => timestampValue(a.timestamp) - timestampValue(b.timestamp));
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
      body: `Recorded ${event.payload?.mode || "additive"} guidance for line ${event.payload?.line_number || "the selected line"}.`
    }));
}

function sourceReferenceAnchorsForSection(section) {
  if (!activeSourceReference || activeSourceReference.section_id !== section.id) return [];
  return [activeSourceReference];
}

function choicePreviewAnchorsForSection(section) {
  if (!activeChoicePreview || activeChoicePreview.section_id !== section.id) return [];
  return [activeChoicePreview];
}

function statusSummary(sectionCount, counts) {
  return [
    `${sectionCount} scheduled sections`,
    `${counts.running || 0} active LLM jobs`,
    `${counts.active_codex_turns || 0} active app-server turns`,
    `${counts.codex_threads || 0} Codex threads`,
    `${counts.queued || 0} queued`,
    `${counts.failed || 0} failed`
  ].join(" | ");
}

function renderImaginer() {
  if (!els.imaginerPanel) return;
  const imaginer = snapshot.imaginer;
  const isImaginer = snapshot.mode === "imaginer" && imaginer;
  els.imaginerPanel.hidden = !isImaginer;
  if (!isImaginer) return;

  const metrics = imaginer.metrics || {};
  currentFrontierGraph = buildFrontierGraph(snapshot);
  if (!selectedGraphNodeId || !frontierNodeById(currentFrontierGraph, selectedGraphNodeId)) {
    selectedGraphNodeId = firstFrontierNodeId(currentFrontierGraph);
  }

  els.imaginerMetrics.textContent = [
    `${metrics.branch_count || 0}/${metrics.configured_branch_count || snapshot.branch_count || 0} branches`,
    `depth ${metrics.max_depth || 0}/${metrics.configured_max_depth || snapshot.max_depth || 0}`,
    `evidence ${metrics.evidence_density ?? 0}`,
    `baseline delta ${metrics.baseline_delta || 0}`
  ].join(" | ");

  renderFrontier(currentFrontierGraph);

  const rollups = imaginer.branch_rollups || [];
  selectedCluster = selectedClusterDetails(currentFrontierGraph, selectedGraphNodeId);
  if (selectedCluster?.branch_id) selectedBranchId = selectedCluster.branch_id;
  if (!selectedBranchId && rollups[0]) selectedBranchId = rollups[0].branch_id;

  renderClusterSupport(currentFrontierGraph, selectedCluster);
  renderSteeringTarget(selectedCluster);
}

function renderFrontier(frontierGraph) {
  if (!els.frontierFocus || !els.frontierGraph) return;
  const selected = frontierNodeById(frontierGraph, selectedGraphNodeId);
  els.frontierFocus.textContent = selected
    ? `${selected.eyebrow} | ${selected.label}`
    : "No frontier selected.";

  els.frontierGraph.innerHTML = renderFrontierGraph(frontierGraph, selectedGraphNodeId, escapeHtml);

  document.querySelectorAll("[data-graph-node]").forEach(button => {
    button.addEventListener("click", () => selectFrontierNode(button.dataset.graphNode, { postFocus: true }));
  });
}

function renderClusterSupport(frontierGraph, cluster) {
  if (!els.decisionGraph || !els.decisionGraphStats || !els.branchRollupStats || !els.branchRollups || !els.planTraceStats || !els.planTrace) return;
  const selectedPanel = els.decisionGraph.closest("section");

  if (!cluster) {
    els.decisionGraphStats.textContent = "none";
    els.decisionGraph.innerHTML = `<p>No state selected.</p>`;
    els.branchRollupStats.textContent = "0 layers";
    els.branchRollups.innerHTML = "";
    els.planTraceStats.textContent = "0 ideas";
    els.planTrace.innerHTML = "";
    if (selectedPanel) selectedPanel.dataset.popover = "closed";
    return;
  }

  const previousClusterId = els.decisionGraph.dataset.clusterId || "";
  const previousDetail = els.decisionGraph.querySelector(".cluster-detail");
  const previousScroll = {
    top: els.decisionGraph.scrollTop,
    left: els.decisionGraph.scrollLeft,
    detailTop: previousDetail?.scrollTop || 0,
    detailLeft: previousDetail?.scrollLeft || 0
  };

  if (selectedPanel) selectedPanel.dataset.popover = selectedPanelOpen ? "open" : "closed";
  els.decisionGraph.dataset.clusterId = cluster.id;
  els.decisionGraphStats.textContent = `${cluster.kind} | ${cluster.status}`;
  els.decisionGraph.innerHTML = `
    <article class="cluster-detail">
      <div>
        <span class="cluster-eyebrow">${escapeHtml(cluster.eyebrow)}</span>
        <strong>${escapeHtml(cluster.label)}</strong>
        ${cluster.attention?.reason ? `
          <div class="cluster-attention">
            <span>${escapeHtml(cluster.attention.label)}</span>
            <strong>${escapeHtml(cluster.attention.reason)}</strong>
          </div>
        ` : ""}
      </div>
      ${cluster.diagram ? renderArchitectureDiagram(cluster.diagram, escapeHtml, { compact: false }) : ""}
      <p>${escapeHtml(cluster.summary)}</p>
      <div class="cluster-detail-metrics">
        ${cluster.metrics.map(metric => `
          <span title="${escapeHtml(metricTooltip(metric))}">${escapeHtml(metric)}</span>
        `).join("")}
      </div>
      ${renderClusterLinks(cluster)}
      <div class="cluster-detail-items">
        ${cluster.details?.length
          ? cluster.details.slice(0, 6).map(renderClusterDetailItem).join("")
          : `<p>No state details yet.</p>`}
      </div>
    </article>
  `;

  if (previousClusterId === cluster.id) {
    selectedPanelScroll = { clusterId: cluster.id, ...previousScroll };
    window.requestAnimationFrame(() => {
      if (els.decisionGraph.dataset.clusterId !== selectedPanelScroll.clusterId) return;
      els.decisionGraph.scrollTop = selectedPanelScroll.top;
      els.decisionGraph.scrollLeft = selectedPanelScroll.left;
      const detail = els.decisionGraph.querySelector(".cluster-detail");
      if (detail) {
        detail.scrollTop = selectedPanelScroll.detailTop || 0;
        detail.scrollLeft = selectedPanelScroll.detailLeft || 0;
      }
    });
  } else {
    selectedPanelScroll = { clusterId: cluster.id, top: 0, left: 0 };
  }

  els.branchRollupStats.textContent = `${cluster.layers.length} icons`;
  els.branchRollups.innerHTML = cluster.layers.length
    ? cluster.layers.map(layer => `
      <button
        type="button"
        class="layer-icon"
        data-layer="${escapeHtml(layer.label)}"
        data-layer-action="${escapeHtml(layerAction(layer.label))}"
        data-tooltip="${escapeHtml(layerTooltip(layer))}"
        title="${escapeHtml(layerTooltip(layer))}"
        aria-label="${escapeHtml(layerTooltip(layer))}"
      >
        <span>${escapeHtml(layerGlyph(layer.label))}</span>
        <strong>${escapeHtml(layer.count)}</strong>
      </button>
    `).join("")
    : `<p>No state layers yet.</p>`;

  document.querySelectorAll("[data-layer-action]").forEach(button => {
    button.addEventListener("click", () => {
      selectedPanelOpen = true;
      if (selectedPanel) selectedPanel.dataset.popover = "open";
      focusClusterLayer(button.dataset.layerAction);
    });
  });

  const queue = frontierGraph.nodes
    .filter(node => node.frontier || node.kind === "branch")
    .filter(node => node.id !== cluster.id)
    .slice(0, 8);

  els.planTraceStats.textContent = `${queue.length} targets`;
  els.planTrace.innerHTML = queue.length
    ? queue.map(node => `
      <button
        class="queue-card"
        type="button"
        data-queue-node="${escapeHtml(node.id)}"
        title="${escapeHtml(`Select ${node.label} as the steering target`)}"
        aria-label="${escapeHtml(`Select ${node.label} as the steering target`)}"
      >
        <span>${escapeHtml(node.eyebrow)}</span>
        <strong>${escapeHtml(node.label)}</strong>
        <small>${escapeHtml(node.status)} | ${escapeHtml(node.metrics.slice(0, 2).join(" | "))}</small>
        <em>Select</em>
      </button>
    `).join("")
    : `<p>No frontier targets yet.</p>`;

  document.querySelectorAll("[data-queue-node]").forEach(button => {
    button.addEventListener("click", () => selectFrontierNode(button.dataset.queueNode, { postFocus: true }));
  });
}

function renderClusterLinks(cluster) {
  const relations = cluster.diagram?.relations || [];
  if (!relations.length) return `<p class="cluster-empty-note">No visible architecture links yet.</p>`;

  return `
    <section class="cluster-link-list" aria-label="Visible architecture links">
      <div>
        <strong>Links</strong>
        <span>${escapeHtml(relations.length)}</span>
      </div>
      ${relations.slice(0, 10).map(relation => `
        <span>
          <strong>${escapeHtml(relation.from || relation.source || "state")}</strong>
          <em>${escapeHtml(relation.label || relation.kind || "feeds")}</em>
          <strong>${escapeHtml(relation.to || relation.target || "state")}</strong>
        </span>
      `).join("")}
    </section>
  `;
}

function focusClusterLayer(action) {
  const targets = {
    components: ".architecture-board",
    links: ".cluster-link-list",
    impacts: ".architecture-facets, .cluster-attention",
    records: ".cluster-detail-items"
  };
  const selector = targets[action] || ".cluster-detail";
  const target = els.decisionGraph.querySelector(selector) || els.decisionGraph.querySelector(".cluster-detail");
  if (!target) return;

  target.scrollIntoView({ block: "nearest", inline: "nearest" });
  target.animate(
    [
      { outlineColor: "rgba(15, 118, 110, 0.75)" },
      { outlineColor: "rgba(15, 118, 110, 0)" }
    ],
    { duration: 900, easing: "ease-out" }
  );
}

function layerAction(label) {
  const key = String(label || "").toLowerCase();
  if (key.includes("link")) return "links";
  if (key.includes("record")) return "records";
  if (key.includes("impact") || key.includes("blocker") || key.includes("risk") || key.includes("gate")) return "impacts";
  return "components";
}

function metricTooltip(metric) {
  if (/links/i.test(metric)) return "Architecture links are listed in the selected-state inspector.";
  if (/records/i.test(metric)) return "Proposal records are shown below the links in the selected-state inspector.";
  if (/components/i.test(metric)) return "Component groups are shown in the selected-state diagram.";
  return metric;
}

function layerGlyph(label) {
  const key = String(label || "").toLowerCase();
  const glyphs = {
    blockers: "B",
    components: "C",
    findings: "F",
    gates: "G",
    impacts: "I",
    links: "L",
    notes: "N",
    records: "R",
    reality: "!",
    risks: "!",
    steers: "S",
    threads: "T",
    validation: "V"
  };

  return glyphs[key] || key.slice(0, 1).toUpperCase() || "?";
}

function layerTooltip(layer) {
  return `${layer.label}: ${layer.count}. Click to inspect this layer.`;
}

function renderSteeringTarget(cluster) {
  if (!els.steerTarget || !els.steerForm || !els.rejectBranch) return;
  if (!cluster) {
    els.steerTarget.textContent = "Target: no selected decision or impact.";
    els.steerForm.dataset.targetKind = "none";
    els.rejectBranch.disabled = true;
    updateSteerFormState();
    return;
  }

  const mutation = cluster.branch_id
    ? "branch path"
    : cluster.kind === "architecture_state"
      ? "architecture state"
      : "decision";

  els.steerTarget.textContent = `Target: ${cluster.label} | ${mutation}`;
  els.steerForm.dataset.targetKind = cluster.kind;
  els.rejectBranch.disabled = !cluster.branch_id;
  updateSteerFormState();
}

function updateSteerFormState() {
  if (!els.steerForm || !els.steerBody) return;
  els.steerForm.dataset.empty = els.steerBody.value.trim() ? "false" : "true";
}

function renderClusterDetailItem(item) {
  return `
    <article class="cluster-detail-item">
      <span>${escapeHtml(item.kind || item.status || "detail")}</span>
      <strong>${escapeHtml(item.title || "detail")}</strong>
      <p>${escapeHtml(item.body || "")}</p>
    </article>
  `;
}

function renderDecisionGraph(graph) {
  const candidates = graph.candidates || [];
  const alternatives = graph.alternatives || [];
  const conflicts = graph.conflicts || [];
  els.decisionGraphStats.textContent = `${candidates.length} candidates`;

  els.decisionGraph.innerHTML = `
    <div class="decision-stats">
      <span>${candidates.length} candidates</span>
      <span>${alternatives.length} alternatives</span>
      <span>${conflicts.length} conflicts/gaps</span>
    </div>
    ${[...candidates, ...alternatives, ...conflicts].slice(0, 8).map(renderDecisionItem).join("") || `<p>No mined decisions yet.</p>`}
  `;
}

function renderDecisionItem(item) {
  return `
    <article class="decision-item" data-kind="${escapeHtml(item.kind || "")}">
      <strong>${escapeHtml(item.title || item.kind || "decision")}</strong>
      <span>${escapeHtml(item.status || item.evidence_kind || "proposal")}</span>
      <p>${escapeHtml(item.body || item.evidence || "")}</p>
    </article>
  `;
}

function renderBranchRollups(rollups) {
  els.branchRollupStats.textContent = `${rollups.length} branches`;

  els.branchRollups.innerHTML = rollups.length
    ? rollups.map(rollup => `
      <article class="branch-card" data-selected="${rollup.branch_id === selectedBranchId}">
        <button type="button" data-focus-branch="${escapeHtml(rollup.branch_id)}">${escapeHtml(rollup.title || rollup.branch_id)}</button>
        <div>${rollup.completed || 0} done | ${rollup.running || 0} running | depth ${rollup.max_depth || 0}</div>
        <div>${rollup.reality_checks || 0} reality checks | ${rollup.records || 0} records | ${rollup.blockers?.length || 0} blockers</div>
      </article>
    `).join("")
    : `<p>No branches queued yet.</p>`;

  document.querySelectorAll("[data-focus-branch]").forEach(button => {
    button.addEventListener("click", () => {
      selectedBranchId = button.dataset.focusBranch;
      selectedGraphNodeId = `branch-${selectedBranchId}`;
      postJson("/api/actions", { type: "focus_branch", branch_id: selectedBranchId });
    });
  });
}

function renderPlanTrace(trace) {
  const visible = selectedBranchId
    ? trace.filter(node => !node.branch_id || node.branch_id === selectedBranchId || node.kind === "imaginer_synthesis")
    : trace;
  els.planTraceStats.textContent = `${visible.length} nodes`;

  els.planTrace.innerHTML = visible.length
    ? visible.map(node => `
      <article class="trace-node" data-role="${escapeHtml(node.role || "")}" data-status="${escapeHtml(node.status || "")}">
        <div>
          <strong>${escapeHtml(node.role || node.kind)}</strong>
          <span>${escapeHtml(node.branch_title || node.branch_id || "run")} ${node.depth ? `d${node.depth}` : ""}</span>
        </div>
        <p>${escapeHtml(node.summary || node.status || "")}</p>
        <div class="trace-meta">${escapeHtml(node.job_id)} | records ${node.record_count || 0} | questions ${node.question_count || 0}</div>
      </article>
    `).join("")
    : `<p>No plan trace yet.</p>`;
}

function selectFrontierNode(nodeId, options = {}) {
  if (!currentFrontierGraph) return;
  const node = frontierNodeById(currentFrontierGraph, nodeId);
  if (!node) return;

  selectedGraphNodeId = node.id;
  selectedPanelOpen = true;
  if (node.branch_id) selectedBranchId = node.branch_id;
  if (node.job_ids?.length) selectedJobId = node.job_ids[node.job_ids.length - 1];

  renderImaginer();
  renderRail();
  focusSelectedFrontierNode();

  if (options.postFocus && node.branch_id) {
    postJson("/api/actions", { type: "focus_branch", branch_id: node.branch_id });
  }
}

function focusSelectedFrontierNode() {
  window.requestAnimationFrame(() => {
    const node = document.querySelector(`[data-graph-node="${CSS.escape(selectedGraphNodeId || "")}"]`);
    if (!node) return;
    node.focus({ preventScroll: true });
    scrollNodeIntoFrontier(node);
  });
}

function scrollNodeIntoFrontier(node) {
  const viewport = els.frontierViewport;
  if (!viewport) return;
  const nodeRect = node.getBoundingClientRect();
  const viewportRect = viewport.getBoundingClientRect();
  const margin = 42;
  let left = 0;
  let top = 0;

  if (nodeRect.left < viewportRect.left + margin) {
    left = nodeRect.left - viewportRect.left - margin;
  } else if (nodeRect.right > viewportRect.right - margin) {
    left = nodeRect.right - viewportRect.right + margin;
  }

  if (nodeRect.top < viewportRect.top + margin) {
    top = nodeRect.top - viewportRect.top - margin;
  } else if (nodeRect.bottom > viewportRect.bottom - margin) {
    top = nodeRect.bottom - viewportRect.bottom + margin;
  }

  if (left || top) viewport.scrollBy({ left, top, behavior: "smooth" });
}

function bindDocumentInteractions() {
  document.querySelectorAll(".line-marker").forEach(button => {
    button.addEventListener("click", () => {
      const line = Number(button.dataset.line);
      const body = `Line ${line} guidance: `;
      els.noteBody.value = body;
      els.noteBody.focus();
    });
  });
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
      renderRail();
      document.querySelectorAll(".doc-section").forEach(section => {
        section.dataset.active = String(section.dataset.sectionId === selectedSectionId);
      });
    }
  }, { rootMargin: "-120px 0px -45% 0px", threshold: [0.1, 0.35, 0.65] });

  sections.forEach(section => observer.observe(section));
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
  const clusterJobIds = new Set(selectedCluster?.job_ids || []);
  if (clusterJobIds.size) {
    return jobs.find(job => job.id === selectedJobId && clusterJobIds.has(job.id)) ||
      jobs.filter(job => clusterJobIds.has(job.id)).slice(-1)[0] ||
      null;
  }
  return jobs.find(job => job.id === selectedJobId) || defaultJobForSection(selectedSectionId) || jobs.find(job => job.status === "running") || jobs[0] || null;
}

function renderRail() {
  const section = (snapshot.document_sections || []).find(item => item.id === selectedSectionId);
  const jobs = dockJobs();
  const job = selectedJob();
  if (job) selectedJobId = job.id;

  renderThreadDock(jobs);

  els.threadPane.dataset.open = String(inspectorOpen && Boolean(job));
  els.activeSectionTitle.textContent = job ? job.title || job.lens_role : "No thread selected";
  els.activeSectionMeta.textContent = job
    ? `${job.id} | ${job.status} | ${job.branch_title || job.branch_id || section?.id || "run"}`
    : "Choose a thread icon from the dock.";

  els.selectedJobLabel.textContent = job ? `${job.id} ${job.lens_role}` : "no job";
  renderStream(job);
  renderContext(job);
  renderResults(job);
  bindRailButtons();
}

function renderThreadDock(jobs) {
  const visibleJobs = jobs.slice(-18);
  els.threadDock.innerHTML = visibleJobs.length
    ? visibleJobs.map(renderThreadIcon).join("")
    : `<span class="thread-dock-empty">No threads</span>`;

  document.querySelectorAll("[data-open-job]").forEach(button => {
    button.addEventListener("click", () => {
      selectedJobId = button.dataset.openJob;
      inspectorOpen = true;
      renderRail();
    });
  });
}

function renderThreadIcon(job) {
  const label = threadIconLabel(job);
  const streamCount = (snapshot.streams?.[job.id] || []).length;
  const title = [job.title || job.lens_role, job.status, `${streamCount} events`].join(" | ");
  return `
    <button
      type="button"
      class="thread-icon"
      data-open-job="${escapeHtml(job.id)}"
      data-status="${escapeHtml(job.status)}"
      data-selected="${job.id === selectedJobId && inspectorOpen ? "true" : "false"}"
      aria-label="${escapeHtml(title)}"
      title="${escapeHtml(title)}"
    >
      <span>${escapeHtml(label)}</span>
      <i></i>
    </button>
  `;
}

function threadIconLabel(job) {
  if (job.lens_role === "engineer_lens") return "E";
  if (job.lens_role === "reality_lens") return "R";
  if (job.lens_role === "imaginer_synthesis_lens") return "S";
  if (job.lens_role === "architecture_state_lens") return "A";
  if (job.lens_role === "decision_mining_lens") return "D";
  if (job.lens_role === "ordinary_plan_baseline_lens") return "B";
  return "T";
}

function fallbackJobs() {
  const jobs = snapshot.jobs || [];
  if (snapshot.mode === "imaginer") {
    return jobs
      .filter(job => !selectedBranchId || !job.branch_id || job.branch_id === selectedBranchId || job.kind === "imaginer_synthesis")
      .slice(-8);
  }
  return jobs.filter(job => job.kind === "root_read" || job.status === "running" || job.status === "failed").slice(0, 4);
}

function dockJobs() {
  const jobs = snapshot.jobs || [];
  if (snapshot.mode === "imaginer") return jobs;
  const clusterJobIds = new Set(selectedCluster?.job_ids || []);
  if (clusterJobIds.size) return jobs.filter(job => clusterJobIds.has(job.id));
  return fallbackJobs();
}

function renderJobCard(job) {
  const streamCount = (snapshot.streams?.[job.id] || []).length;
  const threadLink = job.codex_thread_url
    ? `<a href="${escapeHtml(job.codex_thread_url)}">Open Codex Thread</a>`
    : `<span class="thread-meta">app-server thread pending</span>`;
  const turnLabel = job.codex_turn_id ? `turn ${job.codex_turn_id}` : "turn pending";
  return `
    <article class="thread-card" data-job-id="${escapeHtml(job.id)}" data-status="${escapeHtml(job.status)}" data-selected="${job.id === selectedJobId}">
      <div class="thread-card-head">
        <h3>${escapeHtml(job.title || job.lens_role)}</h3>
        <span class="job-status ${escapeHtml(job.status)}">${escapeHtml(job.status)}</span>
      </div>
      <div class="thread-meta">${escapeHtml(job.id)} | ${escapeHtml(job.provider || snapshot.provider)} | stream events ${streamCount}</div>
      <div class="thread-meta">${escapeHtml(job.codex_thread_id || "thread pending")} | ${escapeHtml(turnLabel)}</div>
      <div class="thread-actions">
        <button type="button" data-focus-job="${escapeHtml(job.id)}">Focus</button>
        <button type="button" data-stop-job="${escapeHtml(job.id)}">Stop</button>
        <button type="button" data-rerun-job="${escapeHtml(job.id)}">Rerun</button>
        ${threadLink}
      </div>
    </article>
  `;
}

function renderStream(job) {
  if (!job) {
    els.liveStream.innerHTML = "";
    return;
  }

  const stream = snapshot.streams?.[job.id] || [];
  const evidenceMap = renderEvidenceMap(job);
  els.liveStream.innerHTML = stream.length
    ? `${evidenceMap}${stream.map(renderStreamEvent).join("")}`
    : evidenceMap || `<div class="stream-empty">Waiting for Codex app-server events.</div>`;
  els.liveStream.scrollTop = evidenceMap ? 0 : els.liveStream.scrollHeight;
}

function renderEvidenceMap(job) {
  const result = resultForJob(job);
  if (!result) return "";

  const findings = (result.findings || []).slice(0, 6);
  if (!findings.length) return "";

  return `
    <article class="evidence-map">
      <div class="evidence-map-head">
        <strong>Evidence Map</strong>
        <span>derived from completed result</span>
      </div>
      <div class="evidence-map-body">
        <div class="evidence-node source-node">${escapeHtml(job.section_title || job.title || job.lens_role || "source")}</div>
        <div class="evidence-edges">
          ${findings.map(finding => {
            const ref = sourceRefFromText(finding.evidence || finding.falsifiable_test || "", job) || sourceRefForJob(job);
            return `
              <button type="button"
                class="evidence-node"
                data-source-ref
                data-section-id="${escapeAttr(ref?.section_id || "")}"
                data-start-line="${escapeAttr(ref?.start_line || "")}"
                data-end-line="${escapeAttr(ref?.end_line || ref?.start_line || "")}">
                ${escapeHtml(finding.title || finding.kind || "finding")}
              </button>
            `;
          }).join("")}
        </div>
      </div>
    </article>
  `;
}

function renderStreamEvent(item) {
  const parsed = parseRawEvent(item.raw);
  const type = item.type || parsed?.method || parsed?.type || "event";
  const threadId = item.thread_id || parsed?.params?.threadId || parsed?.params?.thread?.id || parsed?.thread_id || "";
  const turnId = item.turn_id || parsed?.params?.turnId || parsed?.params?.turn?.id || "";
  const message = formattedStreamMessage(item, parsed);
  const raw = item.raw || "";

  return `
    <article class="stream-event" data-event-type="${escapeHtml(type)}">
      <div class="stream-event-head">
        <span class="stream-type">${escapeHtml(type)}</span>
        <span>${escapeHtml(formatTime(item.at))}</span>
      </div>
      ${threadId ? `<div class="stream-thread">thread ${escapeHtml(threadId)}</div>` : ""}
      ${turnId ? `<div class="stream-thread">turn ${escapeHtml(turnId)}</div>` : ""}
      <div class="stream-message">${formatMessage(message)}</div>
      ${raw ? `
        <details class="stream-raw">
          <summary>raw event</summary>
          <pre>${escapeHtml(formatRaw(raw, parsed))}</pre>
        </details>
      ` : ""}
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

  if (parsed.method === "thread/started") {
    return `Created Codex app-server thread ${parsed.params?.thread?.id || item.thread_id || ""}.`;
  }

  if (parsed.method === "turn/started") {
    return `Started Codex app-server turn ${parsed.params?.turn?.id || item.turn_id || ""}.`;
  }

  if (parsed.method === "item/agentMessage/delta") {
    return parsed.params?.delta || item.summary || "";
  }

  if (parsed.method === "turn/completed") return "Turn completed.";
  if (parsed.method === "turn/failed") return "Turn failed.";
  if (parsed.method === "turn/cancelled") return "Turn cancelled.";

  if (parsed.type === "thread.started") return `Created Codex thread ${parsed.thread_id}.`;
  if (parsed.type === "turn.started") return "Started a Codex turn.";

  if (parsed.type === "item.completed") {
    const completed = parsed.item || {};
    if (completed.type === "agent_message") return completed.text || "Agent message completed.";
    if (completed.type) return `${completed.type} completed.`;
    return "Codex item completed.";
  }

  if (parsed.type === "turn.completed") {
    const usage = parsed.usage || {};
    return [
      "Turn completed.",
      usage.input_tokens != null ? `${usage.input_tokens} input` : "",
      usage.output_tokens != null ? `${usage.output_tokens} output` : "",
      usage.reasoning_output_tokens != null ? `${usage.reasoning_output_tokens} reasoning` : ""
    ].filter(Boolean).join(" ");
  }

  if (parsed.message) return parsed.message;
  if (parsed.msg) return parsed.msg;
  return item.summary || parsed.type || "Provider event.";
}

function formatMessage(message) {
  const text = String(message || "");
  if (text.trim().startsWith("{") || text.trim().startsWith("[")) {
    try {
      const parsed = JSON.parse(text);
      if (isChoicePacket(parsed)) return renderChoicePacket(parsed, selectedJob());
      return `<pre>${escapeHtml(JSON.stringify(parsed, null, 2))}</pre>`;
    } catch {
      return escapeHtml(text);
    }
  }
  return escapeHtml(text);
}

function isChoicePacket(value) {
  return value && Array.isArray(value.questions) && value.questions.length > 0;
}

function renderChoicePacket(packet, job) {
  return `
    <div class="choice-packet">
      <div class="choice-packet-head">
        <strong>Choice Packet</strong>
        <span>${escapeHtml(packet.questions.length)} ${packet.questions.length === 1 ? "choice" : "choices"}</span>
      </div>
      ${packet.questions.map((question, index) => renderChoiceCard(question, index, job)).join("")}
      <details class="choice-raw">
        <summary>raw packet</summary>
        <pre>${escapeHtml(JSON.stringify(packet, null, 2))}</pre>
      </details>
    </div>
  `;
}

function renderChoiceCard(question, index, job) {
  const ref = sourceRefFromText(JSON.stringify(question), job) || sourceRefForJob(job);
  const title = question.title || question.question || `Choice ${index + 1}`;
  const body = choiceDraftText(question);

  return `
    <article class="choice-card">
      <div class="choice-card-head">
        <strong>${escapeHtml(title)}</strong>
        ${ref?.start_line ? `<span>lines ${escapeHtml(ref.start_line)}-${escapeHtml(ref.end_line || ref.start_line)}</span>` : ""}
      </div>
      ${question.question ? `<p>${escapeHtml(question.question)}</p>` : ""}
      ${question.why_now ? `<p class="choice-note">${escapeHtml(question.why_now)}</p>` : ""}
      ${question.decision_effect ? `<div class="draft-edit-preview"><strong>Effect</strong><span>${escapeHtml(question.decision_effect)}</span></div>` : ""}
      <div class="choice-actions">
        <button type="button"
          data-preview-choice
          data-section-id="${escapeAttr(ref?.section_id || "")}"
          data-start-line="${escapeAttr(ref?.start_line || "")}"
          data-end-line="${escapeAttr(ref?.end_line || ref?.start_line || "")}"
          data-choice-title="${escapeAttr(title)}"
          data-choice-body="${escapeAttr(body)}">Preview edit</button>
        <button type="button"
          data-apply-choice
          data-section-id="${escapeAttr(ref?.section_id || "")}"
          data-start-line="${escapeAttr(ref?.start_line || "")}"
          data-end-line="${escapeAttr(ref?.end_line || ref?.start_line || "")}"
          data-choice-title="${escapeAttr(title)}"
          data-choice-body="${escapeAttr(body)}">Apply as guidance</button>
      </div>
    </article>
  `;
}

function choiceDraftText(question) {
  return [
    question.question ? `Selected choice: ${question.question}` : "",
    question.decision_effect ? `Document effect: ${question.decision_effect}` : "",
    question.why_now ? `Why now: ${question.why_now}` : ""
  ].filter(Boolean).join("\n");
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
      <dt>range</dt><dd>${escapeHtml(packet.source_range)}</dd>
      <dt>targets</dt><dd>${escapeHtml((packet.target_projections || []).join(", "))}</dd>
      <dt>excluded</dt><dd>${escapeHtml((packet.excluded_context || []).join(", "))}</dd>
    </dl>
  ` : `<p>No packet found.</p>`;
}

function resultForJob(job) {
  if (!job) return null;
  return (snapshot.results || []).find(item => item.job_id === job.id) || null;
}

function renderResults(job) {
  if (!job) {
    els.resultCount.textContent = "0";
    els.resultEvidence.innerHTML = "";
    return;
  }

  const result = resultForJob(job);
  const findings = result?.findings || [];
  els.resultCount.textContent = String(findings.length);
  els.resultEvidence.innerHTML = result ? `
    <div class="finding"><strong>Summary</strong><span>${renderSourceLinkedText(result.summary || "No summary.", job)}</span></div>
    ${findings.map(finding => `
      <div class="finding">
        <strong>${escapeHtml(finding.title || finding.kind || "finding")}</strong>
        <span>${renderSourceLinkedText(finding.evidence || finding.falsifiable_test || "", job)}</span>
      </div>
    `).join("")}
  ` : `<p>No completed result yet.</p>`;
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
      renderRail();
    });
  });

  document.querySelectorAll("[data-stop-job]").forEach(button => {
    button.addEventListener("click", () => postJson("/api/actions", { type: "stop_lens", job_id: button.dataset.stopJob }));
  });

  document.querySelectorAll("[data-rerun-job]").forEach(button => {
    button.addEventListener("click", () => postJson("/api/actions", { type: "rerun_lens", job_id: button.dataset.rerunJob }));
  });

  document.querySelectorAll("[data-source-ref]").forEach(button => {
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

function referenceFromButton(button, kind = "source_reference") {
  const start = Number(button.dataset.startLine);
  const end = Number(button.dataset.endLine || button.dataset.startLine);
  return {
    kind,
    section_id: button.dataset.sectionId || selectedSectionId || "",
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

  await postJson("/api/actions", {
    type: "line_feedback",
    body,
    mode: "additive",
    section_id: anchor.section_id,
    line_number: anchor.start_line,
    source_text: button.dataset.choiceTitle || "choice packet"
  });
}

function scrollToSourceReference(anchor) {
  if (!anchor) return;
  els.sourceDrawer.open = true;
  suppressSectionObserverUntil = Date.now() + 900;
  window.requestAnimationFrame(() => {
    const line = anchor.start_line ? String(anchor.start_line) : "";
    const target =
      (line && document.querySelector(`.source-line[data-line="${CSS.escape(line)}"]`)) ||
      (anchor.section_id && document.querySelector(`.doc-section[data-section-id="${CSS.escape(anchor.section_id)}"]`));
    target?.scrollIntoView({ block: "center", behavior: "smooth" });
  });
}

function sectionForLine(line) {
  const number = Number(line);
  if (!Number.isFinite(number)) return null;
  return (snapshot.document_sections || []).find(section => {
    return number >= Number(section.start_line) && number <= Number(section.end_line);
  }) || null;
}

function sectionForJob(job) {
  if (!job) return null;
  return (snapshot.document_sections || []).find(item => item.id === job.section_id) || null;
}

function contextPacketForJob(job) {
  if (!job) return null;
  return (snapshot.context_packets || []).find(item => item.id === job.context_packet) || null;
}

function sourceRefForJob(job) {
  const section = sectionForJob(job);
  const range = parseLineRange(contextPacketForJob(job)?.source_range || "");
  return {
    kind: "source_reference",
    section_id: job?.section_id || section?.id || "",
    start_line: range.start_line || Number(section?.start_line) || null,
    end_line: range.end_line || Number(section?.end_line) || null,
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

  return refs;
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

function timestampValue(value) {
  if (!value) return 0;
  const parsed = Date.parse(value);
  return Number.isNaN(parsed) ? 0 : parsed;
}

els.startForm.addEventListener("submit", event => {
  event.preventDefault();
  selectedSectionId = null;
  selectedJobId = null;
  selectedBranchId = null;
  selectedGraphNodeId = null;
  postJson("/api/start", {
    mode: els.mode?.value || "reducer",
    source_path: els.sourcePath.value.trim(),
    targets: els.targets.value.split(",").map(item => item.trim()).filter(Boolean),
    implementation_target: els.implementationTarget?.value.trim() || "",
    section_limit: Number(els.sectionLimit.value || 3),
    max_concurrency: Number(els.maxConcurrency.value || 2),
    branch_count: Number(els.branchCount?.value || 3),
    max_depth: Number(els.maxDepth?.value || 4)
  });
});

els.mode?.addEventListener("change", () => {
  if (els.mode.value === "imaginer") {
    els.sourcePath.value = "components/implementation-imaginer/spec.md";
    els.targets.value = "implementation_plan";
  } else {
    els.sourcePath.value = "components/spec-basis-reducer/spec.md";
    els.targets.value = "code,schema,proof,runbook";
  }
});

els.pauseRun.addEventListener("click", () => postJson("/api/actions", { type: "pause" }));
els.resumeRun.addEventListener("click", () => postJson("/api/actions", { type: "resume" }));
els.requestSynthesis.addEventListener("click", () => postJson("/api/actions", { type: "request_synthesis" }));
els.closeThreadInspector.addEventListener("click", () => {
  inspectorOpen = false;
  renderRail();
});

els.closeSelectedPanel?.addEventListener("click", () => {
  selectedPanelOpen = false;
  const selectedPanel = els.decisionGraph?.closest("section");
  if (selectedPanel) selectedPanel.dataset.popover = "closed";
});

els.steerForm?.addEventListener("submit", event => {
  event.preventDefault();
  const body = els.steerBody.value.trim();
  if (!body) return;
  postJson("/api/actions", {
    type: "steer_search",
    body,
    branch_id: selectedCluster?.branch_id || null,
    subject_id: selectedCluster?.id || null
  });
  els.steerBody.value = "";
  updateSteerFormState();
});

els.queueBranch?.addEventListener("click", () => {
  const target = selectedCluster?.label || "current search state";
  const body = els.steerBody.value.trim() || `Fork a human-steered branch from ${target}.`;
  postJson("/api/actions", {
    type: "queue_imaginer_branch",
    title: `Fork: ${target}`.slice(0, 80),
    body
  });
  els.steerBody.value = "";
  updateSteerFormState();
});

els.rejectBranch?.addEventListener("click", () => {
  const branchId = selectedCluster?.branch_id;
  if (!branchId) return;
  const body = els.steerBody.value.trim() || `Reject ${selectedCluster?.label || branchId} as the next planning direction.`;
  postJson("/api/actions", {
    type: "reject_path",
    branch_id: branchId,
    body
  });
  els.steerBody.value = "";
  updateSteerFormState();
});

els.steerBody?.addEventListener("input", updateSteerFormState);

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

function applyQueryDefaults() {
  const params = new URLSearchParams(window.location.search);
  const bindings = {
    mode: els.mode,
    sourcePath: els.sourcePath,
    targets: els.targets,
    implementationTarget: els.implementationTarget,
    sectionLimit: els.sectionLimit,
    maxConcurrency: els.maxConcurrency,
    branchCount: els.branchCount,
    maxDepth: els.maxDepth
  };

  Object.entries(bindings).forEach(([key, element]) => {
    const value = params.get(key);
    if (value != null && element) element.value = value;
  });
}

function installHotkeys() {
  document.addEventListener("keydown", event => {
    if (isTypingTarget(event.target)) return;
    if (!els.frontierViewport || !els.imaginerPanel || els.imaginerPanel.hidden) return;

    const scrollStep = event.shiftKey ? 420 : 180;

    if (event.key === "ArrowLeft" || event.key === "h") {
      els.frontierViewport.scrollBy({ left: -scrollStep, behavior: "smooth" });
      event.preventDefault();
    } else if (event.key === "ArrowRight" || event.key === "l") {
      els.frontierViewport.scrollBy({ left: scrollStep, behavior: "smooth" });
      event.preventDefault();
    } else if (event.key === "ArrowUp") {
      els.frontierViewport.scrollBy({ top: -scrollStep, behavior: "smooth" });
      event.preventDefault();
    } else if (event.key === "ArrowDown") {
      els.frontierViewport.scrollBy({ top: scrollStep, behavior: "smooth" });
      event.preventDefault();
    } else if (event.key === "j" && currentFrontierGraph) {
      selectFrontierNode(nextFrontierNodeId(currentFrontierGraph, selectedGraphNodeId, 1));
      event.preventDefault();
    } else if (event.key === "k" && currentFrontierGraph) {
      selectFrontierNode(nextFrontierNodeId(currentFrontierGraph, selectedGraphNodeId, -1));
      event.preventDefault();
    } else if (event.key === "f") {
      els.frontierViewport.focus();
      event.preventDefault();
    } else if (event.key === "s") {
      if (!els.steerBody) return;
      els.steerBody.focus();
      event.preventDefault();
    } else if (event.key === "t") {
      els.sourceDrawer.open = !els.sourceDrawer.open;
      event.preventDefault();
    }
  });
}

function isTypingTarget(target) {
  return ["INPUT", "TEXTAREA", "SELECT"].includes(target?.tagName) || target?.isContentEditable;
}

function installFrontierPan() {
  const viewport = els.frontierViewport;
  if (!viewport) return;
  viewport.addEventListener("pointerdown", event => {
    if (event.button !== 0 || event.target.closest("button, input, textarea, select, summary")) return;
    panState = {
      pointerId: event.pointerId,
      x: event.clientX,
      y: event.clientY,
      left: viewport.scrollLeft,
      top: viewport.scrollTop
    };
    viewport.dataset.dragging = "true";
    viewport.setPointerCapture(event.pointerId);
  });

  viewport.addEventListener("pointermove", event => {
    if (!panState || panState.pointerId !== event.pointerId) return;
    viewport.scrollLeft = panState.left - (event.clientX - panState.x);
    viewport.scrollTop = panState.top - (event.clientY - panState.y);
  });

  viewport.addEventListener("pointerup", event => releaseFrontierPan(event.pointerId));
  viewport.addEventListener("pointercancel", event => releaseFrontierPan(event.pointerId));
}

function releaseFrontierPan(pointerId) {
  if (!panState || panState.pointerId !== pointerId) return;
  els.frontierViewport.releasePointerCapture(pointerId);
  panState = null;
  els.frontierViewport.dataset.dragging = "false";
}

applyQueryDefaults();
installHotkeys();
installFrontierPan();
connectEvents();
startPollingFallback();
getRun();
