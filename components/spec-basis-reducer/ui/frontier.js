export function buildFrontierGraph(snapshot) {
  const imaginer = snapshot.imaginer || {};
  const architectureStates = imaginer.architecture_states || [];

  if (architectureStates.length) {
    return buildArchitectureStateGraph(snapshot, architectureStates);
  }

  const decisionGraph = imaginer.decision_graph || {};
  const rollups = imaginer.branch_rollups || [];
  const trace = imaginer.plan_trace || [];
  const jobs = snapshot.jobs || [];
  const results = snapshot.results || [];
  const metrics = imaginer.metrics || {};
  const decisionJobs = jobs.filter(job => job.lens_role === "decision_mining_lens");

  const decisionRecords = [
    ...(decisionGraph.candidates || []),
    ...(decisionGraph.alternatives || []),
    ...(decisionGraph.conflicts || [])
  ];

  const decisionNodes = decisionRecords.length
    ? decisionRecords.slice(0, 8).map((record, index) => decisionNode(record, index, rollups, results, decisionJobs))
    : [decisionMiningNode(jobs)];

  const impactNodes = [
    baselineImpact(metrics, jobs, results),
    ...rollups.map(rollup => branchImpact(rollup, trace, jobs, results)),
    validationImpact(results, trace, jobs),
    synthesisImpact(imaginer, jobs, results),
    steeringImpact(snapshot.steering_notes || [])
  ].filter(Boolean);

  const nodes = [...decisionNodes, ...impactNodes];
  const edges = buildEdges(decisionNodes, impactNodes);
  const columns = ["decisions", "implementation", "validation", "next"]
    .map(column => ({
      column,
      title: columnTitle(column),
      nodes: nodes.filter(node => node.column === column)
    }))
    .filter(column => column.nodes.length);

  return {
    nodes,
    edges,
    columns,
    stats: {
      nodes: nodes.length,
      frontier: nodes.filter(node => node.frontier).length,
      running: nodes.filter(node => node.status === "running").length,
      failed: nodes.filter(node => node.status === "failed").length
    }
  };
}

function buildArchitectureStateGraph(snapshot, architectureStates) {
  const jobs = snapshot.jobs || [];
  const nodes = architectureStates.map((state, index) => architectureStateNode(state, jobs, index));
  const columns = ["initial", "candidate", "reality", "synthesis"]
    .map(column => ({
      column,
      title: columnTitle(column),
      nodes: nodes.filter(node => node.column === column)
    }))
    .filter(column => column.nodes.length);

  return {
    nodes,
    edges: architectureStateEdges(nodes),
    columns,
    stats: {
      nodes: nodes.length,
      frontier: nodes.filter(node => node.frontier).length,
      running: nodes.filter(node => node.status === "running").length,
      failed: nodes.filter(node => node.status === "failed").length
    }
  };
}

export function renderFrontierGraph(graph, selectedNodeId, escapeHtml) {
  if (!graph.nodes.length) {
    return `<p class="frontier-empty">Start an Imaginer run to grow the architecture-state map.</p>`;
  }

  const selected = selectedNodeId || graph.nodes[0]?.id;
  const priority = priorityNode(graph.nodes);

  return `
    ${priority ? `
      <button
        type="button"
        class="attention-callout"
        data-graph-node="${escapeHtml(priority.id)}"
        aria-label="${escapeHtml(`Focus ${priority.label}`)}"
      >
        <span>Focus now</span>
        <strong>${escapeHtml(priority.label)}</strong>
        <em>${escapeHtml(priority.attention?.reason || priority.summary || "Inspect this state before steering the next pass.")}</em>
      </button>
    ` : ""}
    <div class="decision-impact-map">
      ${graph.columns
        .map(column => `
          <section class="idea-region" aria-label="${escapeHtml(column.title)}">
            <div class="frontier-column-title">${escapeHtml(column.title)}</div>
            ${column.nodes.map(node => renderNode(node, selected, priority?.id, escapeHtml)).join("")}
          </section>
        `)
        .join("")}
    </div>
  `;
}

function priorityNode(nodes) {
  return [...nodes].sort((left, right) => nodePriorityScore(right) - nodePriorityScore(left))[0] || null;
}

function nodePriorityScore(node) {
  const statusScore = { running: 90, queued: 70, failed: 65, frontier: 55, completed: 20, explored: 15 };
  const attentionScore = {
    reality: 45,
    pressure: 42,
    "needs-detail": 38,
    queued: 35,
    running: 34,
    synthesis: 32,
    rich: 12,
    steady: 0
  };
  const linkMetric = numberFromMetric(node.metrics, "links");
  const recordMetric = numberFromMetric(node.metrics, "records");
  const warnImpact = (node.impacts || []).filter(impact => ["warn", "bad"].includes(impact.tone)).length;

  return (statusScore[node.status] || 0) +
    (attentionScore[node.attention?.tone] || 0) +
    Math.min(18, linkMetric / 4) +
    Math.min(15, recordMetric / 3) +
    warnImpact * 8;
}

function numberFromMetric(metrics, needle) {
  const metric = (metrics || []).find(value => String(value).toLowerCase().includes(needle));
  const match = String(metric || "").match(/\d+/);
  return match ? Number(match[0]) : 0;
}

export function frontierNodeById(graph, id) {
  return graph.nodes.find(node => node.id === id) || null;
}

export function firstFrontierNodeId(graph) {
  return graph.nodes.find(node => node.kind === "architecture_state" && node.status === "completed")?.id ||
    graph.nodes.find(node => node.kind === "decision_candidate")?.id ||
    graph.nodes[0]?.id ||
    null;
}

export function nextFrontierNodeId(graph, selectedNodeId, delta) {
  const nodes = graph.nodes;
  if (!nodes.length) return null;
  const index = Math.max(0, nodes.findIndex(node => node.id === selectedNodeId));
  const next = (index + delta + nodes.length) % nodes.length;
  return nodes[next].id;
}

export function selectedClusterDetails(graph, selectedNodeId) {
  return frontierNodeById(graph, selectedNodeId) || graph.nodes[0] || null;
}

function renderNode(node, selectedNodeId, priorityNodeId, escapeHtml) {
  return `
    <button
      type="button"
      class="frontier-node"
      data-graph-node="${escapeHtml(node.id)}"
      data-kind="${escapeHtml(node.kind)}"
      data-status="${escapeHtml(node.status)}"
      data-attention="${escapeHtml(node.attention?.tone || "steady")}"
      data-frontier="${node.frontier ? "true" : "false"}"
      data-priority="${node.id === priorityNodeId ? "true" : "false"}"
      data-selected="${node.id === selectedNodeId ? "true" : "false"}"
      aria-pressed="${node.id === selectedNodeId ? "true" : "false"}"
    >
      <span class="frontier-node-kicker">
        <span class="frontier-node-eyebrow">${escapeHtml(node.eyebrow)}</span>
        ${node.attention ? `<span class="attention-pill">${escapeHtml(node.attention.label)}</span>` : ""}
      </span>
      <strong>${escapeHtml(node.label)}</strong>
      <span class="frontier-node-status">${escapeHtml(node.status)}</span>
      ${node.attention?.reason ? `
        <span class="node-attention-line">
          <span>${escapeHtml(node.attention.reason)}</span>
          <em>${escapeHtml(node.attention.action || "Inspect")}</em>
        </span>
      ` : ""}
      ${node.diagram ? renderArchitectureDiagram(node.diagram, escapeHtml, { compact: true }) : ""}
      <span class="frontier-node-summary">${escapeHtml(node.card_summary || node.summary)}</span>
      <span class="impact-strip">
        ${node.impacts.slice(0, 4).map(impact => renderImpactChip(impact, escapeHtml)).join("")}
      </span>
      <span class="cluster-metrics">
        ${node.metrics.slice(0, 4).map(metric => `<span>${escapeHtml(metric)}</span>`).join("")}
      </span>
    </button>
  `;
}

function renderImpactChip(impact, escapeHtml) {
  const opensInspector = /link|record|risk|gate|impact|blocker/i.test(impact.label);
  return `
    <span
      data-tone="${escapeHtml(impact.tone)}"
      data-action="${opensInspector ? "inspect" : "count"}"
      title="${escapeHtml(opensInspector ? `Click the card to inspect ${impact.label}.` : impact.label)}"
    >
      ${escapeHtml(impact.label)}${opensInspector ? " ->" : ""}
    </span>
  `;
}

export function renderArchitectureDiagram(diagram, escapeHtml, options = {}) {
  const compact = Boolean(options.compact);
  const allComponents = (diagram.components || []).map(normalizeArchitectureComponent);
  const components = allComponents.slice(0, 18);
  const hiddenComponentCount = Math.max(0, allComponents.length - components.length);
  const relations = (diagram.relations || []).map(normalizeRelation).slice(0, 10);
  const facets = architectureFacetNodes(diagram, 10);

  if (!components.length && !diagram.text) return "";
  if (compact) return renderCompactArchitectureDiagram(components, relations, facets, escapeHtml);

  return `
    <span class="architecture-diagram" data-compact="false" data-view="board">
      <span class="architecture-board" aria-label="Architecture state components">
        ${componentGroups(components).map(group => `
          <span
            class="architecture-group"
            data-role="${escapeHtml(group.role)}"
            data-attention="${groupNeedsAttention(group) ? "true" : "false"}"
            title="${escapeHtml(groupNeedsAttention(group) ? `${group.roleLabel} needs review` : groupTooltip(group))}"
          >
            <small>${escapeHtml(group.roleLabel)} · ${escapeHtml(group.items.length)}</small>
            ${group.items.map(component => `
              <span
                class="architecture-component"
                data-attention="${componentNeedsAttention(component) ? "true" : "false"}"
                title="${escapeHtml(componentNeedsAttention(component) ? `Review ${component.label}` : component.label)}"
              >
                <span>${escapeHtml(component.label)}</span>
                ${component.note ? `<em>${escapeHtml(component.note)}</em>` : ""}
              </span>
            `).join("")}
          </span>
        `).join("")}
        ${hiddenComponentCount ? `
          <span class="architecture-group" data-role="more">
            <small>more</small>
            <span class="architecture-component">${escapeHtml(`${hiddenComponentCount} additional surfaces`)}</span>
          </span>
        ` : ""}
      </span>
      ${relations.length ? `
        <span class="architecture-relations">
          ${relations.map(relation => `
            <span>
              <strong>${escapeHtml(relation.from)}</strong>
              <em>${escapeHtml(relation.label)}</em>
              <strong>${escapeHtml(relation.to)}</strong>
            </span>
          `).join("")}
        </span>
      ` : ""}
      ${facets.length ? `
        <span class="architecture-facets" aria-label="Architecture state impacts">
          ${facets.map(facet => `
            <span data-tone="${escapeHtml(facet.tone)}">
              <small>${escapeHtml(facet.kind)}</small>
              <strong>${escapeHtml(facet.label)}</strong>
            </span>
          `).join("")}
        </span>
      ` : ""}
      ${!compact && diagram.text ? `<span class="architecture-diagram-text">${escapeHtml(diagram.text)}</span>` : ""}
    </span>
  `;
}

function renderCompactArchitectureDiagram(components, relations, facets, escapeHtml) {
  const groups = componentGroups(components);
  const flow = compactFlowComponents(components, relations).slice(0, 7);

  return `
    <span class="architecture-diagram" data-compact="true" data-view="system-strip">
      <span class="architecture-role-strip" aria-label="Architecture surface groups">
        ${groups.map(group => `
          <span
            class="architecture-role-segment"
            data-role="${escapeHtml(group.role)}"
            style="--weight:${Math.min(6, Math.max(1, group.items.length))}"
            title="${escapeHtml(groupTooltip(group))}"
            aria-label="${escapeHtml(groupTooltip(group))}"
          >
            <strong aria-hidden="true"></strong>
            <em>${escapeHtml(group.items.length)}</em>
          </span>
        `).join("")}
      </span>
      ${flow.length ? `
        <span class="architecture-flowline" aria-label="Representative architecture flow">
          ${flow.map((component, index) => `
            <span
              class="architecture-flow-node"
              data-role="${escapeHtml(component.role)}"
              title="${escapeHtml(component.label)}"
              aria-label="${escapeHtml(component.label)}"
            ></span>
            ${index < flow.length - 1 ? `<span class="architecture-flow-edge"></span>` : ""}
          `).join("")}
        </span>
      ` : ""}
      <span class="architecture-summaryline">
        ${escapeHtml(surfaceSummary(components, relations, facets))}
      </span>
    </span>
  `;
}

function architectureStateNode(state, jobs, index) {
  const sourceRole = state.source_lens_role || "imaginer_result";
  const components = state.diagram?.components || [];
  const relations = state.diagram?.relations || [];
  const impacts = [...(state.diagram?.impacts || []), ...(state.diagram?.validation_gates || [])];
  const title = architectureStateTitle(state, sourceRole, index, components);
  const detailNodes = architectureStateDetails(state);

  return {
    id: `architecture-${state.id || index}`,
    column: architectureColumn(sourceRole),
    kind: "architecture_state",
    status: state.status || "waiting",
    label: title,
    eyebrow: architectureEyebrow(sourceRole),
    summary: state.summary || "Architecture state projection is still being generated.",
    card_summary: sentenceClamp(state.summary || state.authority_boundary || "Projected architecture state.", 18),
    metrics: [
      `${components.length} components`,
      `${relations.length} links`,
      state.depth ? `depth ${state.depth}` : "",
      state.source_lens_role ? state.source_lens_role.replace("_lens", "") : ""
    ].filter(Boolean),
    impacts: [
      impactBadge(components.length, "components", "info"),
      impactBadge(relations.length, "links", "neutral"),
      impactBadge((state.records || []).length, "records", "neutral")
    ],
    layers: [
      { label: "components", count: components.length },
      { label: "links", count: relations.length },
      { label: "impacts", count: impacts.length },
      { label: "records", count: (state.records || []).length }
    ],
    details: detailNodes,
    branch_id: state.branch_id,
    job_ids: [state.job_id, state.source_job_id].filter(Boolean),
    depth: state.depth || 0,
    diagram: {
      text: state.diagram?.text,
      components,
      relations,
      impacts,
      validation_gates: state.diagram?.validation_gates || [],
      facets: detailNodes.slice(0, 8).map(detail => ({
        kind: detail.kind || detail.status || "record",
        label: detail.title || detail.body || "state detail",
        tone: detailTone(detail)
      }))
    },
    frontier: ["queued", "running"].includes(state.status),
    attention: architectureAttention(state, sourceRole, components, relations, detailNodes)
  };
}

function architectureColumn(sourceRole) {
  if (sourceRole === "ordinary_plan_baseline_lens" || sourceRole === "decision_mining_lens") return "initial";
  if (sourceRole === "reality_lens") return "reality";
  if (sourceRole === "imaginer_synthesis_lens") return "synthesis";
  return "candidate";
}

function architectureEyebrow(sourceRole) {
  if (sourceRole === "ordinary_plan_baseline_lens") return "baseline state";
  if (sourceRole === "decision_mining_lens") return "decision-mined state";
  if (sourceRole === "engineer_lens") return "candidate state";
  if (sourceRole === "reality_lens") return "reality-checked state";
  if (sourceRole === "imaginer_synthesis_lens") return "synthesized state";
  return "architecture state";
}

function architectureTitle(sourceRole, state, index) {
  if (sourceRole === "ordinary_plan_baseline_lens") return "Baseline Proposal Runtime";
  if (sourceRole === "decision_mining_lens") return "Decision-Mined Planning Surface";
  if (sourceRole === "imaginer_synthesis_lens") return "Synthesized Implementation Core";
  if (state.branch_title) return branchArchitectureName(state.branch_title);
  return `Architecture State ${index + 1}`;
}

function architectureStateTitle(state, sourceRole, index, components) {
  const raw = state.title || "";
  if (raw && !looksLikeFallbackStateName(raw) && state.title_source !== "pending_lens") return raw;
  if (["queued", "running"].includes(state.status || "")) return "Architecture lens naming state";
  return architectureTitle(sourceRole, state, index, components);
}

function looksLikeFallbackStateName(value) {
  const title = String(value || "").trim();
  return !title ||
    /^state after\b/i.test(title) ||
    /^architecture state\b/i.test(title) ||
    /^engineer state\b/i.test(title) ||
    /^reality-checked state\b/i.test(title) ||
    /\bd\d+\s+state$/i.test(title);
}

function branchArchitectureName(branchTitle) {
  const title = String(branchTitle || "").toLowerCase();
  if (title.includes("app-server")) return "App-Server Search Context";
  if (title.includes("conservative") || title.includes("otp")) return "Conservative OTP Validation Core";
  if (title.includes("wiki") || title.includes("artifact")) return "Projection-Only Artifact Wiki";
  if (title.includes("packet")) return "Validated Plan Packet Core";
  return `${String(branchTitle || "Candidate").replace(/\bfirst\b/i, "").trim()} Architecture Surface`;
}

function architectureStateDetails(state) {
  const records = (state.records || []).map(recordDetail);
  const impacts = (state.diagram?.impacts || []).map(item => ({
    title: item,
    kind: "state_impact",
    body: state.authority_boundary || "",
    status: "projection"
  }));
  const gates = (state.diagram?.validation_gates || []).map(item => ({
    title: item,
    kind: "validation_gate",
    body: "Gate carried by architecture-state projection.",
    status: "gate"
  }));

  return [...records, ...impacts, ...gates].slice(0, 12);
}

function componentGroups(components) {
  const grouped = new Map();

  components.forEach(component => {
    if (!grouped.has(component.role)) {
      grouped.set(component.role, {
        role: component.role,
        roleLabel: component.roleLabel,
        items: []
      });
    }
    grouped.get(component.role).items.push(component);
  });

  return [...grouped.values()].sort((left, right) => {
    const leftIndex = roleOrder().indexOf(left.role);
    const rightIndex = roleOrder().indexOf(right.role);
    return normalizeRoleOrder(leftIndex) - normalizeRoleOrder(rightIndex) ||
      right.items.length - left.items.length ||
      left.role.localeCompare(right.role);
  });
}

function groupNeedsAttention(group) {
  return ["evidence", "gate", "risk"].includes(group.role) ||
    group.items.some(componentNeedsAttention);
}

function componentNeedsAttention(component) {
  const text = `${component.role} ${component.label} ${component.note || ""}`.toLowerCase();
  return ["evidence", "gate", "risk"].includes(component.role) ||
    text.includes("acceptance") ||
    text.includes("blocker") ||
    text.includes("risk") ||
    text.includes("validation");
}

function roleOrder() {
  return ["source", "state", "packet", "worker", "adapter", "projection", "evidence", "gate", "risk", "core", "ui", "model", "more"];
}

function normalizeRoleOrder(index) {
  return index === -1 ? 100 : index;
}

function groupTooltip(group) {
  return `${group.roleLabel}: ${group.items.map(component => component.label).join(", ")}`;
}

function compactFlowComponents(components, relations) {
  const byLabel = new Map(components.map(component => [component.label, component]));
  const labels = [];

  relations.forEach(relation => {
    [relation.from, relation.to].forEach(label => {
      if (label && !labels.includes(label)) labels.push(label);
    });
  });

  const flow = labels
    .map(label => byLabel.get(label) || normalizeArchitectureComponent(label))
    .filter(Boolean);

  return flow.length ? flow : components;
}

function surfaceSummary(components, relations, facets) {
  const groups = componentGroups(components);
  const leading = groups
    .slice(0, 3)
    .map(group => `${group.items.length} ${group.roleLabel}`)
    .join(" · ");

  return [
    leading || `${components.length} surfaces`,
    `${relations.length} links`,
    facets.length ? `${facets.length} review flags` : ""
  ].filter(Boolean).join(" · ");
}

function normalizeArchitectureComponent(component) {
  const label = componentLabel(component);
  const note = typeof component === "object" && component
    ? component.note || component.surface || component.owner || component.responsibility || ""
    : "";
  const role = normalizeComponentRole(
    typeof component === "object" && component ? component.role || component.kind || component.type : "",
    label
  );

  return {
    label,
    note,
    role,
    roleLabel: componentRoleLabel(role)
  };
}

function componentLabel(component) {
  if (typeof component === "string") return component;
  return component?.name || component?.title || component?.module || component?.id || "component";
}

function normalizeComponentRole(rawRole, label) {
  const role = String(rawRole || "").toLowerCase().replaceAll("_", "-");
  if (["source", "core", "state", "worker", "adapter", "projection", "packet", "gate", "risk", "evidence", "ui", "model"].includes(role)) {
    return role;
  }
  return inferComponentRole(label);
}

function inferComponentRole(label) {
  const text = String(label || "").toLowerCase();
  if (text.includes("spec") || text.includes("source")) return "source";
  if (text.includes("packet") || text.includes("context")) return "packet";
  if (text.includes("provider") || text.includes("adapter") || text.includes("app-server") || text.includes("codex")) return "adapter";
  if (text.includes("projection") || text.includes("view") || text.includes("diagram") || text.includes("map") || text.includes("ui")) return "projection";
  if (text.includes("gate") || text.includes("test") || text.includes("validator") || text.includes("validation")) return "gate";
  if (text.includes("risk") || text.includes("blocker") || text.includes("reality") || text.includes("evidence")) return "evidence";
  if (text.includes("server") || text.includes("supervisor") || text.includes("worker") || text.includes("lens")) return "worker";
  if (text.includes("basis.") || text.includes("state") || text.includes("record") || text.includes("event")) return "state";
  return "core";
}

function componentRoleLabel(role) {
  const labels = {
    source: "source",
    core: "core",
    state: "state",
    worker: "worker",
    adapter: "adapter",
    projection: "projection",
    packet: "packet",
    gate: "gate",
    risk: "risk",
    evidence: "evidence",
    ui: "ui",
    model: "model",
    more: "more"
  };
  return labels[role] || "part";
}

function normalizeRelation(relation) {
  if (typeof relation === "string") {
    return { from: "state", label: "has", to: relation };
  }

  return {
    from: relation?.from || relation?.source || "state",
    label: relation?.label || relation?.kind || "feeds",
    to: relation?.to || relation?.target || "state"
  };
}

function architectureFacetNodes(diagram, limit) {
  const candidates = [
    ...(diagram.facets || []),
    ...(diagram.impacts || []).map(label => ({ kind: "impact", label, tone: "warn" })),
    ...(diagram.validation_gates || []).map(label => ({ kind: "gate", label, tone: "good" }))
  ];
  const seen = new Set();

  return candidates
    .map(facet => ({
      kind: String(facet.kind || facet.status || "record").replaceAll("_", " "),
      label: String(facet.label || facet.title || facet.body || "state detail"),
      tone: facet.tone || detailTone(facet)
    }))
    .filter(facet => {
      const key = `${facet.kind}:${facet.label}`;
      if (seen.has(key)) return false;
      seen.add(key);
      return true;
    })
    .slice(0, limit);
}

function detailTone(detail) {
  const text = `${detail.kind || ""} ${detail.status || ""} ${detail.title || ""}`.toLowerCase();
  if (text.includes("risk") || text.includes("blocker") || text.includes("gap") || text.includes("reject")) return "warn";
  if (text.includes("gate") || text.includes("validation") || text.includes("test")) return "good";
  if (text.includes("impact") || text.includes("decision")) return "info";
  return "neutral";
}

function architectureAttention(state, sourceRole, components, relations, details) {
  if (state.status === "running") {
    return {
      tone: "running",
      label: "active lens",
      reason: "A model turn is still changing this state.",
      action: "Watch"
    };
  }
  if (state.status === "queued") {
    return {
      tone: "queued",
      label: "inspect next",
      reason: "This is the next unexplored state that can redirect the search.",
      action: "Inspect"
    };
  }
  if (!relations.length && sourceRole !== "decision_mining_lens") {
    return {
      tone: "needs-detail",
      label: "needs links",
      reason: "The state has components but no visible causal links.",
      action: "Open links"
    };
  }
  if (sourceRole === "reality_lens") {
    return {
      tone: "reality",
      label: "review evidence",
      reason: "Reality found evidence, gates, or blockers that can change the plan.",
      action: "Review"
    };
  }
  if (sourceRole === "imaginer_synthesis_lens") {
    return {
      tone: "synthesis",
      label: "plan candidate",
      reason: "This state can become the implementation plan.",
      action: "Compare"
    };
  }
  if (details.some(detail => detailTone(detail) === "warn")) {
    return {
      tone: "pressure",
      label: "risk visible",
      reason: "A risk or blocker is attached to this state.",
      action: "Inspect"
    };
  }
  if (components.length >= 8) {
    return {
      tone: "rich",
      label: "stateful",
      reason: "Large state surface; inspect only if it is on your path.",
      action: "Inspect"
    };
  }
  return {
    tone: "steady",
    label: "state node",
    reason: "",
    action: "Inspect"
  };
}

function architectureStateEdges(nodes) {
  return nodes
    .filter(node => node.branch_id)
    .sort((a, b) => (a.branch_id || "").localeCompare(b.branch_id || "") || (a.depth || 0) - (b.depth || 0))
    .map((node, index, ordered) => {
      const previous = ordered
        .slice(0, index)
        .reverse()
        .find(candidate => candidate.branch_id === node.branch_id);
      return previous ? { from: previous.id, to: node.id } : null;
    })
    .filter(Boolean);
}

function decisionNode(record, index, rollups, results, decisionJobs) {
  const kind = record.kind || "decision_candidate";
  const title = record.title || labelForKind(kind);
  const body = record.body || record.evidence || "";
  const pathImpacts = matchingRollups(title, body, rollups);
  const detail = recordDetail(record);

  return {
    id: `decision-${index}-${slug(title)}`,
    column: "decisions",
    kind,
    status: record.status || "proposed",
    label: title,
    eyebrow: kind.replaceAll("_", " "),
    summary: body || "Decision candidate awaiting impact evidence.",
    card_summary: sentenceClamp(body || "Decision candidate awaiting impact evidence.", 22),
    metrics: [
      `${pathImpacts.length || rollups.length} path impacts`,
      `${countValidationRecords(results, title, body)} validation links`
    ],
    impacts: [
      impactBadge(pathImpacts.length || rollups.length, "paths", "info"),
      impactBadge(countBlockers(pathImpacts), "blockers", "warn"),
      impactBadge(countReality(pathImpacts), "reality", "warn")
    ],
    layers: [
      { label: "path impacts", count: pathImpacts.length || rollups.length },
      { label: "validation links", count: countValidationRecords(results, title, body) },
      { label: "decision records", count: 1 }
    ],
    details: [detail, ...pathImpacts.map(rollupImpactDetail)].slice(0, 8),
    job_ids: decisionJobs.map(job => job.id),
    frontier: record.status !== "accepted"
  };
}

function decisionMiningNode(jobs) {
  const decisionJobs = jobs.filter(job => job.lens_role === "decision_mining_lens");

  return {
    id: "decision-mining",
    column: "decisions",
    kind: "decision_candidate",
    status: aggregateStatus(decisionJobs),
    label: "Mine Decision Space",
    eyebrow: "decision discovery",
    summary: "Decision candidates have not landed yet. Mining should produce choices, alternatives, conflicts, and missing acceptance records.",
    card_summary: "Mining choices, alternatives, conflicts, missing acceptance records, and branch seeds.",
    metrics: [`${decisionJobs.length} jobs`],
    impacts: [impactBadge(threadCount(decisionJobs), "threads", "info")],
    layers: [{ label: "threads", count: threadCount(decisionJobs) }],
    details: [],
    job_ids: decisionJobs.map(job => job.id),
    frontier: true
  };
}

function baselineImpact(metrics, jobs, results) {
  const baselineJobs = jobs.filter(job => job.lens_role === "ordinary_plan_baseline_lens");
  const baselineResults = resultsForJobs(results, baselineJobs);
  const records = baselineResults.flatMap(result => result.proposed_records || []);

  if (!baselineJobs.length && !records.length) return null;

  return {
    id: "impact-baseline",
    column: "implementation",
    kind: "impact_baseline",
    status: aggregateStatus(baselineJobs),
    label: "Baseline Delta",
    eyebrow: "ordinary plan pressure",
    summary:
      firstSummary(baselineResults) ||
      "The shallow plan that recursive decision search must improve.",
    card_summary: "Ordinary shallow plan pressure. Recursive search should beat this with stronger boundaries, gates, and rejected paths.",
    metrics: [`delta ${metrics.baseline_delta || 0}`, `${records.length} records`],
    impacts: [
      impactBadge(metrics.baseline_delta || 0, "delta", "info"),
      impactBadge(records.length, "records", "neutral")
    ],
    layers: [
      { label: "baseline records", count: records.length },
      { label: "findings", count: baselineResults.flatMap(result => result.findings || []).length }
    ],
    details: records.map(recordDetail),
    job_ids: baselineJobs.map(job => job.id),
    frontier: baselineJobs.some(job => ["queued", "running"].includes(job.status))
  };
}

function branchImpact(rollup, trace, jobs, results) {
  const branchJobs = jobs.filter(job => job.branch_id === rollup.branch_id);
  const branchTrace = trace.filter(node => node.branch_id === rollup.branch_id);
  const branchResults = resultsForJobs(results, branchJobs);
  const records = branchResults.flatMap(result => result.proposed_records || []);
  const status = branchStatus(rollup, branchJobs);

  return {
    id: `impact-${rollup.branch_id}`,
    column: "implementation",
    kind: "impact_path",
    status,
    label: rollup.title || rollup.branch_id,
    eyebrow: "path impact",
    summary:
      latestSummary(branchTrace) ||
      firstSummary(branchResults) ||
      "Implementation path impact of the current decision set.",
    card_summary: pathImpactSummary(rollup, records),
    metrics: [
      `${rollup.completed || 0} done`,
      `depth ${rollup.max_depth || 0}`,
      `${rollup.reality_checks || 0} reality checks`,
      `${rollup.records || records.length || 0} records`
    ],
    impacts: [
      impactBadge(rollup.blockers?.length || 0, "blockers", "warn"),
      impactBadge(rollup.reality_checks || 0, "reality", "warn"),
      impactBadge(rollup.records || records.length || 0, "records", "neutral")
    ],
    layers: [
      { label: "blockers", count: rollup.blockers?.length || 0 },
      { label: "records", count: rollup.records || records.length || 0 },
      { label: "reality", count: rollup.reality_checks || 0 },
      { label: "threads", count: threadCount(branchJobs) }
    ],
    details: [...records.map(recordDetail), ...(rollup.blockers || []).map(blockerDetail)].slice(0, 18),
    branch_id: rollup.branch_id,
    job_ids: branchJobs.map(job => job.id),
    frontier: ["queued", "running", "frontier"].includes(status)
  };
}

function validationImpact(results, trace, jobs) {
  const records = results.flatMap(result => result.proposed_records || []);
  const findings = results.flatMap(result => result.findings || []);
  const validationRecords = records.filter(record => hasKind(record, ["validation", "risk", "blocker", "constraint", "rejected"]));
  const validationFindings = findings.filter(finding => hasKind(finding, ["validation", "risk", "blocker", "constraint", "rejected"]));
  const count = validationRecords.length + validationFindings.length;
  const realityCount = trace.filter(node => node.role === "reality_lens").length;
  const realityJobs = jobs.filter(job => job.lens_role === "reality_lens");

  if (count === 0 && realityCount === 0) return null;

  return {
    id: "impact-validation",
    column: "validation",
    kind: "impact_validation",
    status: count > 0 ? "active" : "waiting",
    label: "Reality Impact",
    eyebrow: "validation pressure",
    summary: "Where decisions collide with risks, blockers, gates, rejected paths, and stabilized constraints.",
    card_summary: "Risks, blockers, rejected paths, gates, and constraints discovered by Reality checks.",
    metrics: [`${count} checks`, `${realityCount} reality turns`],
    impacts: [
      impactBadge(countKind(validationRecords, "risk") + countKind(validationFindings, "risk"), "risks", "warn"),
      impactBadge(countKind(validationRecords, "rejected") + countKind(validationFindings, "rejected"), "rejected", "bad"),
      impactBadge(countKind(validationRecords, "constraint") + countKind(validationFindings, "constraint"), "constraints", "info")
    ],
    layers: [
      { label: "risks", count: countKind(validationRecords, "risk") + countKind(validationFindings, "risk") },
      { label: "gates", count: countKind(validationRecords, "validation") + countKind(validationFindings, "validation") },
      { label: "rejected", count: countKind(validationRecords, "rejected") + countKind(validationFindings, "rejected") },
      { label: "constraints", count: countKind(validationRecords, "constraint") + countKind(validationFindings, "constraint") }
    ],
    details: [...validationRecords.map(recordDetail), ...validationFindings.map(recordDetail)].slice(0, 20),
    job_ids: realityJobs.map(job => job.id),
    frontier: false
  };
}

function synthesisImpact(imaginer, jobs, results) {
  const synthesisJobs = jobs.filter(job => job.lens_role === "imaginer_synthesis_lens");
  const synthesisResults = resultsForJobs(results, synthesisJobs);
  const synthesis = imaginer.synthesis;

  if (!synthesisJobs.length && !synthesis) return null;

  const records = synthesisResults.flatMap(result => result.proposed_records || []);
  const findings = synthesisResults.flatMap(result => result.findings || []);

  return {
    id: "impact-synthesis",
    column: "next",
    kind: "impact_synthesis",
    status: aggregateStatus(synthesisJobs) || "ready",
    label: "Plan Impact",
    eyebrow: "synthesis",
    summary: synthesis?.summary || firstSummary(synthesisResults) || "Decision impacts collapsed into a proposal-only implementation plan.",
    card_summary: "Synthesis pressure from explored choices into a proposal-only implementation plan.",
    metrics: [`${records.length} records`, `${findings.length} findings`],
    impacts: [
      impactBadge(records.length, "plan records", "info"),
      impactBadge(findings.length, "findings", "neutral")
    ],
    layers: [
      { label: "records", count: records.length },
      { label: "findings", count: findings.length },
      { label: "threads", count: threadCount(synthesisJobs) }
    ],
    details: records.map(recordDetail),
    job_ids: synthesisJobs.map(job => job.id),
    frontier: synthesisJobs.some(job => ["queued", "running"].includes(job.status))
  };
}

function steeringImpact(notes) {
  return {
    id: "impact-steering",
    column: "next",
    kind: "impact_steering",
    status: notes.length ? "active" : "ready",
    label: "Next Steering",
    eyebrow: "fork or redirect",
    summary: "Choose a decision or path, then steer, fork, or reject that target.",
    card_summary: "Human steering mutates the selected decision or path, then queues the next branch or redirect.",
    metrics: [`${notes.length} notes`],
    impacts: [impactBadge(notes.length, "steers", "info")],
    layers: [{ label: "notes", count: notes.length }],
    details: notes.map(note => ({
      title: note.body,
      kind: "steering_note",
      body: note.branch_id ? `Branch: ${note.branch_id}` : "Run-level steering",
      status: "proposal pressure"
    })),
    job_ids: [],
    frontier: true
  };
}

function buildEdges(decisions, impacts) {
  return decisions.flatMap(decision =>
    impacts.map(impact => ({ from: decision.id, to: impact.id }))
  );
}

function matchingRollups(title, body, rollups) {
  const haystack = `${title} ${body}`.toLowerCase();
  const matches = rollups.filter(rollup => haystack.includes(String(rollup.title || "").toLowerCase()));
  return matches.length ? matches : rollups;
}

function rollupImpactDetail(rollup) {
  return {
    title: rollup.title || rollup.branch_id,
    kind: "path_impact",
    body: `${rollup.records || 0} records, ${rollup.reality_checks || 0} reality checks, ${rollup.blockers?.length || 0} blockers.`,
    status: rollup.failed ? "risk" : "impact"
  };
}

function aggregateStatus(jobs) {
  if (!jobs.length) return "waiting";
  if (jobs.some(job => job.status === "running")) return "running";
  if (jobs.some(job => job.status === "queued")) return "queued";
  if (jobs.some(job => job.status === "failed")) return "failed";
  if (jobs.some(job => job.status === "completed")) return "completed";
  return jobs[0]?.status || "waiting";
}

function branchStatus(rollup, jobs) {
  if ((rollup.running || 0) > 0 || jobs.some(job => job.status === "running")) return "running";
  if ((rollup.queued || 0) > 0 || jobs.some(job => job.status === "queued")) return "queued";
  if ((rollup.failed || 0) > 0 && (rollup.completed || 0) === 0) return "failed";
  if ((rollup.completed || 0) > 0) return "explored";
  return "frontier";
}

function resultsForJobs(results, jobs) {
  const jobIds = new Set(jobs.map(job => job.id));
  return results.filter(result => jobIds.has(result.job_id));
}

function threadCount(jobs) {
  return jobs.filter(job => job.codex_thread_id).length;
}

function firstSummary(results) {
  return results.find(result => result.summary)?.summary || "";
}

function latestSummary(trace) {
  return trace
    .slice()
    .reverse()
    .find(node => node.summary)?.summary || "";
}

function recordDetail(record) {
  return {
    title: record.title || record.kind || "record",
    kind: record.kind || "record",
    body: record.body || record.evidence || record.falsifiable_test || "",
    status: record.status || record.evidence_kind || record.severity || "proposal"
  };
}

function blockerDetail(blocker) {
  return {
    title: blocker.title || blocker.kind || "blocker",
    kind: blocker.kind || "blocker",
    body: blocker.body || blocker.evidence || blocker.falsifiable_test || String(blocker),
    status: blocker.severity || "blocker"
  };
}

function hasKind(record, needles) {
  const kind = String(record.kind || "").toLowerCase();
  const title = String(record.title || "").toLowerCase();
  return needles.some(needle => kind.includes(needle) || title.includes(needle));
}

function countKind(records, needle) {
  return records.filter(record => hasKind(record, [needle])).length;
}

function countBlockers(rollups) {
  return rollups.reduce((sum, rollup) => sum + (rollup.blockers?.length || 0), 0);
}

function countReality(rollups) {
  return rollups.reduce((sum, rollup) => sum + (rollup.reality_checks || 0), 0);
}

function countValidationRecords(results, title, body) {
  const text = `${title} ${body}`.toLowerCase();
  return results
    .flatMap(result => [...(result.findings || []), ...(result.proposed_records || [])])
    .filter(record => {
      const recordText = `${record.title || ""} ${record.body || ""} ${record.evidence || ""}`.toLowerCase();
      return text
        .split(/\s+/)
        .filter(word => word.length > 7)
        .some(word => recordText.includes(word));
    }).length;
}

function impactBadge(count, label, tone) {
  return { label: `${count} ${label}`, tone };
}

function pathImpactSummary(rollup, records) {
  const blockers = rollup.blockers?.length || 0;
  const checks = rollup.reality_checks || 0;
  const recordCount = rollup.records || records.length || 0;
  return `${recordCount} records, ${checks} reality checks, ${blockers} blockers. Depth ${rollup.max_depth || 0} path pressure.`;
}

function sentenceClamp(value, wordLimit) {
  const words = String(value || "").trim().split(/\s+/).filter(Boolean);
  if (words.length <= wordLimit) return words.join(" ");
  return `${words.slice(0, wordLimit).join(" ")}...`;
}

function labelForKind(kind) {
  return String(kind).replaceAll("_", " ");
}

function columnTitle(column) {
  if (column === "initial") return "Initial States";
  if (column === "candidate") return "Candidate States";
  if (column === "reality") return "Reality States";
  if (column === "synthesis") return "Synthesis State";
  if (column === "decisions") return "Decision Space";
  if (column === "implementation") return "Implementation Impact";
  if (column === "validation") return "Reality Impact";
  if (column === "next") return "Next Move";
  return column;
}

function slug(value) {
  return String(value)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 42);
}
