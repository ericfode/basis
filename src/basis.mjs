#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { fileURLToPath } from "node:url";
import {
  buildHistoricalSpecExperimentFromGit,
  writeHistoricalSpecArtifacts
} from "./historical-spec.mjs";

const NORMATIVE_RE = /\b(MUST(?:\s+NOT)?|REQUIRED|SHOULD(?:\s+NOT)?|RECOMMENDED|MAY|OPTIONAL)\b/g;
const VAGUE_RE = /\b(appropriate|reasonable|sufficient|enough|typically|generally|as needed|etc\.?|rich|easy|simple|robust|safe|secure|fast)\b/i;
const UNBOUNDED_RE = /\b(always|never|all|any|every|unlimited|guarantee|guaranteed|complete|fully)\b/i;
const IMPLEMENTATION_DEFINED_RE = /\bimplementation-defined\b/i;

const TYPE_LABELS = {
  spec: "Spec",
  section: "Section",
  goal: "Goal",
  non_goal: "Non-goal",
  requirement: "Requirement",
  component: "Component",
  dependency: "Dependency",
  test: "Test",
  risk: "Risk",
  claim: "Claim",
  finding: "Finding"
};

const LEGACY_PROJECTIONS = ["kumu", "neo4j", "structurizr", "symphony"];
const PROJECTION_FILES = {
  kumu: ["kumu-elements.csv", "kumu-connections.csv"],
  neo4j: ["neo4j.cypher"],
  structurizr: ["structurizr.dsl"],
  symphony: ["symphony-handoff.md"]
};
const PROJECTION_DIR = "projections";
const PROJECTION_CYCLE_DIR = "projection-cycles";
const STALE_CORE_FILES = ["graph.json", "critique.md", "SpecImage.lean", "execution-packet.md"];
const PRIMARY_COMMANDS = new Set(["play", "score", "step", "rollout", "export", "image", "mine", "train"]);
const CODE_SOURCE_EXTENSIONS = new Set([
  ".c", ".cc", ".cpp", ".cs", ".go", ".h", ".hpp", ".java", ".js", ".jsx", ".json",
  ".mjs", ".proto", ".py", ".rs", ".sh", ".swift", ".toml", ".ts", ".tsx", ".yaml", ".yml"
]);

export function buildDataifiedSpec(markdown, sourcePath = "inline.md", options = {}) {
  const normalized = markdown.replace(/\r\n/g, "\n");
  const lines = normalized.split("\n");
  const headings = parseHeadings(lines);
  const title = options.title || (headings[0]?.title ?? path.basename(sourcePath));
  const blocks = parseMarkdownBlocks(lines);
  const claimNodes = options.claimNodes ?? [];

  return {
    schemaVersion: "basis.dataified-spec.v0",
    generatedAt: new Date().toISOString(),
    source: {
      path: sourcePath,
      title,
      lineCount: lines.length,
      sha256: crypto.createHash("sha256").update(normalized).digest("hex")
    },
    reconstruction: {
      targetForm: "spec_draft",
      lossPolicy: "preserve_raw_markdown_blocks",
      unsupportedMarkdownPolicy: "opaque_raw_markdown_block",
      acceptStepRequired: true
    },
    headings: headings.map((heading, index) => ({
      id: `heading-${String(index + 1).padStart(3, "0")}-${slug(heading.title)}`,
      title: heading.title,
      level: heading.level,
      lineStart: heading.line
    })),
    blocks: blocks.map((block) => ({
      ...block,
      generatedClaimIds: claimNodes
        .filter((node) => isSourceClaimNode(node) && rangesOverlap(block, node))
        .map((node) => node.id)
    }))
  };
}

export function buildBasisState(markdown, sourcePath = "inline.md", options = {}) {
  const lines = markdown.replace(/\r\n/g, "\n").split("\n");
  const headings = parseHeadings(lines);
  const title = options.title || (headings[0]?.title ?? path.basename(sourcePath));
  const nodes = [];
  const edges = [];
  const sectionByIndex = new Map();

  const root = {
    id: "spec",
    type: "spec",
    title,
    label: title,
    source: sourcePath,
    lineStart: 1,
    lineEnd: lines.length,
    excerpt: firstNonEmpty(lines, title)
  };
  nodes.push(root);

  const stack = [{ level: 0, id: root.id }];
  headings.forEach((heading, index) => {
    const nextHeading = headings.find((candidate, candidateIndex) => candidateIndex > index && candidate.line > heading.line);
    const lineEnd = nextHeading ? nextHeading.line - 1 : lines.length;
    const id = uniqueId("section", `${String(index + 1).padStart(3, "0")}-${slug(heading.title)}`, nodes);
    const sectionNode = {
      id,
      type: "section",
      title: heading.title,
      label: heading.title,
      level: heading.level,
      lineStart: heading.line,
      lineEnd,
      excerpt: excerpt(lines, heading.line, lineEnd)
    };

    while (stack.length && stack[stack.length - 1].level >= heading.level) {
      stack.pop();
    }
    const parent = stack[stack.length - 1] ?? { id: root.id };
    nodes.push(sectionNode);
    edges.push(edge(parent.id, id, "contains", "contains"));
    stack.push({ level: heading.level, id });
    sectionByIndex.set(index, sectionNode);
  });

  const sections = Array.from(sectionByIndex.values());
  for (const section of sections) {
    const sectionLines = lines.slice(section.lineStart, section.lineEnd);
    const extracted = extractClaims(section, sectionLines, nodes);
    for (const node of extracted) {
      nodes.push(node);
      edges.push(edge(section.id, node.id, "elaborates", "elaborates"));
    }
  }

  const findings = evaluateBadIdeas(nodes, edges, lines);
  for (const finding of findings) {
    nodes.push({
      id: finding.id,
      type: "finding",
      title: finding.title,
      label: finding.title,
      class: finding.class,
      severity: finding.severity,
      excerpt: finding.detail
    });
    for (const evidenceId of finding.evidenceNodeIds) {
      edges.push(edge(finding.id, evidenceId, "pressures", "pressures"));
      edges.push(edge(evidenceId, finding.id, "evidences", "evidences"));
    }
  }

  const stats = summarize(nodes, edges, findings);
  const environment = buildEnvironmentState(stats, findings);
  return {
    schemaVersion: "basis.claim-lattice.v0",
    generatedAt: new Date().toISOString(),
    source: {
      path: sourcePath,
      title,
      lineCount: lines.length
    },
    environment,
    stats,
    nodes,
    edges,
    findings,
    glossary: buildGlossary(nodes),
    proverDraft: buildProverDraft(stats, findings)
  };
}

export const buildImageState = buildBasisState;
export const imageSpecification = buildBasisState;

function parseMarkdownBlocks(lines) {
  const blocks = [];
  let index = 0;

  const pushBlock = (type, start, end, metadata = {}) => {
    const rawLines = lines.slice(start, end + 1);
    const rawMarkdown = rawLines.join("\n");
    blocks.push({
      id: uniqueBlockId(blocks, type, rawMarkdown),
      type,
      lineStart: start + 1,
      lineEnd: end + 1,
      rawMarkdown,
      ...metadata
    });
  };

  while (index < lines.length) {
    const line = lines[index];

    if (index === 0 && line.trim() === "---") {
      let end = index + 1;
      while (end < lines.length && lines[end].trim() !== "---") end += 1;
      pushBlock("front_matter", index, Math.min(end, lines.length - 1));
      index = Math.min(end + 1, lines.length);
      continue;
    }

    const fence = /^(\s*)(`{3,}|~{3,})/.exec(line);
    if (fence) {
      const marker = fence[2][0];
      let end = index + 1;
      while (end < lines.length && !new RegExp(`^\\s*${marker}{3,}`).test(lines[end])) end += 1;
      pushBlock("fenced_code", index, Math.min(end, lines.length - 1));
      index = Math.min(end + 1, lines.length);
      continue;
    }

    const heading = /^(#{1,6})\s+(.+?)\s*$/.exec(line);
    if (heading) {
      pushBlock("heading", index, index, {
        level: heading[1].length,
        title: heading[2].replace(/`/g, ""),
        semanticRole: classifySection(heading[2])
      });
      index += 1;
      continue;
    }

    if (!line.trim()) {
      const start = index;
      while (index + 1 < lines.length && !lines[index + 1].trim()) index += 1;
      pushBlock("blank", start, index);
      index += 1;
      continue;
    }

    if (/^\s*(?:[-*]|\d+[.)])\s+/.test(line)) {
      const start = index;
      index += 1;
      while (
        index < lines.length &&
        (lines[index].trim() === "" || /^\s+(?!#{1,6}\s).+/.test(lines[index]) || /^\s*(?:[-*]|\d+[.)])\s+/.test(lines[index]))
      ) {
        if (lines[index].trim() === "" && (index + 1 >= lines.length || !/^\s/.test(lines[index + 1]))) break;
        index += 1;
      }
      pushBlock("list", start, index - 1);
      continue;
    }

    if (/^\s*>/.test(line)) {
      const start = index;
      while (index + 1 < lines.length && /^\s*>/.test(lines[index + 1])) index += 1;
      pushBlock("blockquote", start, index);
      index += 1;
      continue;
    }

    if (line.includes("|") && index + 1 < lines.length && /^\s*\|?[\s:-]+\|[\s|:-]*$/.test(lines[index + 1])) {
      const start = index;
      index += 2;
      while (index < lines.length && lines[index].includes("|")) index += 1;
      pushBlock("table", start, index - 1);
      continue;
    }

    const start = index;
    index += 1;
    while (
      index < lines.length &&
      lines[index].trim() &&
      !/^(#{1,6})\s+/.test(lines[index]) &&
      !/^\s*(?:[-*]|\d+[.)])\s+/.test(lines[index]) &&
      !/^\s*>/.test(lines[index]) &&
      !/^(\s*)(`{3,}|~{3,})/.test(lines[index])
    ) {
      index += 1;
    }
    pushBlock("paragraph", start, index - 1);
  }

  return blocks;
}

function uniqueBlockId(blocks, type, rawMarkdown) {
  const base = `block-${String(blocks.length + 1).padStart(4, "0")}-${type}-${slug(shortTitle(rawMarkdown || type))}`;
  let candidate = base;
  let suffix = 2;
  const existing = new Set(blocks.map((block) => block.id));
  while (existing.has(candidate)) {
    candidate = `${base}-${suffix}`;
    suffix += 1;
  }
  return candidate;
}

function isSourceClaimNode(node) {
  return !["spec", "section", "finding"].includes(node.type);
}

function rangesOverlap(left, right) {
  return left.lineStart <= right.lineEnd && right.lineStart <= left.lineEnd;
}

function parseHeadings(lines) {
  return lines.flatMap((line, index) => {
    const match = /^(#{1,6})\s+(.+?)\s*$/.exec(line);
    if (!match) return [];
    return [{
      level: match[1].length,
      title: match[2].replace(/`/g, ""),
      line: index + 1
    }];
  });
}

function extractClaims(section, sectionLines, existingNodes) {
  const nodes = [];
  const sectionContext = classifySection(section.title);
  let bulletBuffer = [];

  const flushBullet = () => {
    if (!bulletBuffer.length) return;
    const first = bulletBuffer[0];
    const text = bulletBuffer.map((item) => item.text).join(" ").replace(/\s+/g, " ").trim();
    if (text.length < 3) {
      bulletBuffer = [];
      return;
    }
    const nodeType = classifyClaim(sectionContext, text);
    nodes.push(claimNode(nodeType, section, first.line, text, existingNodes.concat(nodes)));
    bulletBuffer = [];
  };

  for (let offset = 0; offset < sectionLines.length; offset += 1) {
    const absoluteLine = section.lineStart + offset;
    const line = sectionLines[offset];
    const bullet = /^\s*[-*]\s+(.+?)\s*$/.exec(line);
    const continuation = /^\s{2,}(.+?)\s*$/.exec(line);
    if (bullet) {
      flushBullet();
      bulletBuffer.push({ line: absoluteLine, text: bullet[1] });
    } else if (continuation && bulletBuffer.length && !/^#{1,6}\s/.test(line)) {
      bulletBuffer.push({ line: absoluteLine, text: continuation[1] });
    } else {
      flushBullet();
      for (const sentence of normativeSentences(line)) {
        const nodeType = classifyClaim(sectionContext, sentence);
        nodes.push(claimNode(nodeType, section, absoluteLine, sentence, existingNodes.concat(nodes)));
      }
    }
  }
  flushBullet();
  return nodes;
}

function classifySection(title) {
  const lower = title.toLowerCase();
  if (/\bgoal|non-goal|non goal\b/.test(lower)) return lower.includes("non") ? "non_goal" : "goal";
  if (/\bcomponent|overview|layer|architecture\b/.test(lower)) return "component";
  if (/\bdependency|integration|external|client|api\b/.test(lower)) return "dependency";
  if (/\btest|validation|conformance|definition of done|checklist\b/.test(lower)) return "test";
  if (/\brisk|failure|safety|security|recovery|trust|hardening\b/.test(lower)) return "risk";
  if (/\bproblem|purpose\b/.test(lower)) return "problem";
  return "claim";
}

function classifyClaim(sectionContext, text) {
  const lower = text.toLowerCase();
  if (sectionContext === "goal") return "goal";
  if (sectionContext === "non_goal") return "non_goal";
  if (sectionContext === "component") return "component";
  if (sectionContext === "dependency") return "dependency";
  if (sectionContext === "test") return "test";
  if (sectionContext === "risk") return "risk";
  if (NORMATIVE_RE.test(text)) {
    NORMATIVE_RE.lastIndex = 0;
    return "requirement";
  }
  NORMATIVE_RE.lastIndex = 0;
  if (/\bmust\b|\bshould\b|\brequired\b/.test(lower)) return "requirement";
  if (/\bexternal\b|\bapi\b|\bfilesystem\b|\bhost\b|\bcli\b|\btool\b/.test(lower)) return "dependency";
  if (/\bvalidate\b|\btest\b|\bcheck\b|\bconformance\b/.test(lower)) return "test";
  return "claim";
}

function normativeSentences(line) {
  if (!line.trim() || /^#{1,6}\s/.test(line) || /^\s*[-*]\s+/.test(line)) return [];
  if (!NORMATIVE_RE.test(line)) {
    NORMATIVE_RE.lastIndex = 0;
    return [];
  }
  NORMATIVE_RE.lastIndex = 0;
  return line
    .split(/(?<=[.!?])\s+/)
    .map((sentence) => sentence.trim())
    .filter((sentence) => NORMATIVE_RE.test(sentence))
    .map((sentence) => {
      NORMATIVE_RE.lastIndex = 0;
      return sentence;
    });
}

function claimNode(type, section, lineStart, text, nodes) {
  const title = shortTitle(text);
  return {
    id: uniqueId(type, `${slug(section.title)}-${slug(title)}`, nodes),
    type,
    title,
    label: title,
    sectionId: section.id,
    lineStart,
    lineEnd: lineStart,
    normative: normativeKeywords(text),
    excerpt: text
  };
}

function evaluateBadIdeas(nodes, edges, lines) {
  const findings = [];
  const byType = groupBy(nodes, (node) => node.type);
  const requirements = byType.requirement ?? [];
  const normativeClaims = nodes.filter((node) => (node.normative ?? []).length > 0);
  const goals = byType.goal ?? [];
  const tests = byType.test ?? [];
  const components = byType.component ?? [];
  const dependencies = byType.dependency ?? [];
  const risks = byType.risk ?? [];
  const problemSections = nodes.filter((node) => node.type === "section" && /\bproblem|purpose\b/i.test(node.title));

  const contradictions = detectContradictions(normativeClaims);
  contradictions.forEach((pair, index) => {
    findings.push(finding(
      `finding-impossible-${index + 1}`,
      "impossible",
      "high",
      "Normative statements appear to conflict",
      `Both sides normalize to "${pair.normalized}". This should be split by mode or resolved before implementation.`,
      [pair.must.id, pair.mustNot.id]
    ));
  });

  const unbounded = normativeClaims.filter((node) => UNBOUNDED_RE.test(node.excerpt)).slice(0, 6);
  if (unbounded.length) {
    findings.push(finding(
      "finding-impossible-unbounded",
      "impossible",
      "medium",
      "Unbounded normative claims need explicit assumptions",
      "Claims using always, never, all, every, or complete often hide impossible total guarantees over real environments.",
      unbounded.map((node) => node.id)
    ));
  }

  if (!problemSections.length || !goals.length || !tests.length) {
    const evidence = [problemSections[0], goals[0], tests[0]].filter(Boolean).map((node) => node.id);
    findings.push(finding(
      "finding-useless-missing-core-surface",
      "useless",
      "high",
      "Spec lacks one of problem, goals, or validation",
      `Detected problem sections: ${problemSections.length}; goals: ${goals.length}; tests: ${tests.length}. A spec can look complete while remaining useless without all three.`,
      evidence
    ));
  }

  const componentPressure = components.length + dependencies.length;
  const valueSurface = goals.length + tests.length;
  if (componentPressure > 0 && valueSurface > 0 && componentPressure > valueSurface * 2.5) {
    findings.push(finding(
      "finding-complexity-component-pressure",
      "more_complex_than_nothing",
      "medium",
      "Component and dependency count outruns value surface",
      `Detected ${componentPressure} component/dependency nodes against ${valueSurface} goal/test nodes. This may be justified, but the graph should show which components buy which outcomes.`,
      components.concat(dependencies).slice(0, 12).map((node) => node.id)
    ));
  }

  const optionalCount = nodes.filter((node) => /\bOPTIONAL\b|\boptional\b/i.test(node.excerpt ?? "")).length;
  if (optionalCount > Math.max(8, goals.length)) {
    findings.push(finding(
      "finding-complexity-optional-surface",
      "more_complex_than_nothing",
      "low",
      "Optional surface is large relative to goals",
      `Detected ${optionalCount} optional references. Large optional surfaces can make conformance harder than the baseline problem.`,
      nodes.filter((node) => /\bOPTIONAL\b|\boptional\b/i.test(node.excerpt ?? "")).slice(0, 12).map((node) => node.id)
    ));
  }

  const problemText = problemSections.map((node) => node.excerpt).join(" ");
  const goalText = goals.map((node) => node.excerpt).join(" ");
  const testText = tests.map((node) => node.excerpt).join(" ");
  const problemGoalOverlap = tokenOverlap(problemText, goalText);
  const problemTestOverlap = tokenOverlap(problemText, testText);
  if (problemSections.length && goals.length && tests.length && (problemGoalOverlap < 0.12 || problemTestOverlap < 0.08)) {
    findings.push(finding(
      "finding-misses-problem-low-overlap",
      "misses_problem",
      "medium",
      "Problem, goals, and tests have weak lexical overlap",
      `Problem-goal overlap ${problemGoalOverlap.toFixed(2)}, problem-test overlap ${problemTestOverlap.toFixed(2)}. Low overlap is not proof of failure, but it is a good prompt to link goals and tests explicitly.`,
      [problemSections[0].id].concat(goals.slice(0, 4).map((node) => node.id), tests.slice(0, 4).map((node) => node.id))
    ));
  }

  const vagueRequirements = normativeClaims.filter((node) => VAGUE_RE.test(node.excerpt)).slice(0, 10);
  if (vagueRequirements.length) {
    findings.push(finding(
      "finding-underspecified-vague-norms",
      "underspecified",
      "medium",
      "Normative claims contain vague qualifiers",
      "Normative language with vague qualifiers needs defaults, measurable thresholds, or a named implementation-defined policy.",
      vagueRequirements.map((node) => node.id)
    ));
  }

  const implementationDefined = nodes.filter((node) => IMPLEMENTATION_DEFINED_RE.test(node.excerpt ?? ""));
  const docsObligation = nodes.some((node) => {
    const normalized = String(node.excerpt ?? "").replace(/\s+/g, " ");
    return /implementation-defined.{0,260}document|document.{0,260}implementation-defined/i.test(normalized);
  });
  if (implementationDefined.length && !docsObligation) {
    findings.push(finding(
      "finding-underspecified-implementation-defined",
      "underspecified",
      "high",
      "Implementation-defined behavior lacks a visible documentation obligation",
      "Implementation-defined choices are acceptable only when the implementation contract records the selected behavior.",
      implementationDefined.slice(0, 10).map((node) => node.id)
    ));
  }

  if (!risks.length && lines.some((line) => /\bsecret|sandbox|approval|safety|security|failure|retry\b/i.test(line))) {
    findings.push(finding(
      "finding-underspecified-risk-surface",
      "underspecified",
      "low",
      "Risk vocabulary appears without extracted risk nodes",
      "The parser saw risk vocabulary, but the graph did not classify any risk claims. The source likely needs explicit risk sections or sharper bullets.",
      []
    ));
  }

  return findings;
}

function detectContradictions(requirements) {
  const must = new Map();
  const mustNot = new Map();
  for (const req of requirements) {
    const text = normalizeNormative(req.excerpt);
    if (!text) continue;
    if (/\bMUST\s+NOT\b/i.test(req.excerpt)) {
      mustNot.set(text, req);
    } else if (/\bMUST\b/i.test(req.excerpt)) {
      must.set(text, req);
    }
  }
  return Array.from(must.keys())
    .filter((key) => mustNot.has(key))
    .map((key) => ({ normalized: key, must: must.get(key), mustNot: mustNot.get(key) }));
}

function normalizeNormative(text) {
  return text
    .toLowerCase()
    .replace(/\bmust\s+not\b/g, "")
    .replace(/\bmust\b/g, "")
    .replace(/\bshould\s+not\b/g, "")
    .replace(/\bshould\b/g, "")
    .replace(/\brequired\b/g, "")
    .replace(/\brecommended\b/g, "")
    .replace(/\bmay\b/g, "")
    .replace(/\boptional\b/g, "")
    .replace(/[`*_.,:;()[\]{}]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

function finding(id, badIdeaClass, severity, title, detail, evidenceNodeIds) {
  return {
    id,
    class: badIdeaClass,
    severity,
    title,
    detail,
    evidenceNodeIds: Array.from(new Set(evidenceNodeIds.filter(Boolean)))
  };
}

function summarize(nodes, edges, findings) {
  const byType = groupBy(nodes, (node) => node.type);
  const byFindingClass = groupBy(findings, (finding) => finding.class);
  return {
    nodeCount: nodes.length,
    edgeCount: edges.length,
    nodeTypes: Object.fromEntries(Object.entries(byType).map(([key, value]) => [key, value.length])),
    findingCount: findings.length,
    findingClasses: Object.fromEntries(Object.entries(byFindingClass).map(([key, value]) => [key, value.length])),
    hasProblem: nodes.some((node) => node.type === "section" && /\bproblem|purpose\b/i.test(node.title)),
    hasGoals: (byType.goal ?? []).length > 0,
    hasValidation: (byType.test ?? []).length > 0,
    hasProverTarget: true
  };
}

function buildEnvironmentState(stats, findings) {
  const highFindings = findings.filter((finding) => finding.severity === "high").length;
  const mediumFindings = findings.filter((finding) => finding.severity === "medium").length;
  const coreSurfaceScore = [stats.hasProblem, stats.hasGoals, stats.hasValidation]
    .filter(Boolean).length / 3;
  const penalty = Math.min(0.7, highFindings * 0.25 + mediumFindings * 0.1);
  return {
    kind: "collaborative-spec-verifiability-environment",
    model: "claim-lattice",
    actors: ["human", "agent", "prover", "test_runner", "adapter", "policy"],
    observation: [
      "source_spec",
      "source_anchors",
      "claim_lattice",
      "obligation_graph",
      "viability_critique",
      "verification_surfaces",
      "adapter_outputs"
    ],
    actions: [
      "split_claim",
      "merge_claims",
      "strengthen_claim",
      "weaken_claim",
      "add_evidence",
      "add_negative_test",
      "add_proof_obligation",
      "mark_non_goal",
      "reject_idea",
      "request_narrower_experiment"
    ],
    rewardSignals: [
      "verifiability_delta",
      "traceability_delta",
      "falsifiability_delta",
      "contradiction_reduction",
      "ambiguity_reduction",
      "obligations_discharged",
      "negative_tests_rejected",
      "invalid_idea_rejected"
    ],
    doneStates: ["implementation_ready", "rejected", "unresolved_with_missing_evidence"],
    safetyInvariant: "A player must not improve score by deleting source evidence or weakening the stated problem without recording that tradeoff.",
    score: Number(Math.max(0, Math.min(1, coreSurfaceScore - penalty)).toFixed(2))
  };
}

function buildGlossary(nodes) {
  const terms = new Map();
  for (const node of nodes) {
    const text = `${node.title ?? ""} ${node.excerpt ?? ""}`;
    for (const match of text.matchAll(/`([^`]+)`/g)) {
      const term = match[1].trim();
      if (!term || term.length > 80) continue;
      const entry = terms.get(term) ?? { term, nodeIds: [] };
      entry.nodeIds.push(node.id);
      terms.set(term, entry);
    }
  }
  return Array.from(terms.values())
    .map((entry) => ({ ...entry, nodeIds: Array.from(new Set(entry.nodeIds)).slice(0, 20) }))
    .sort((a, b) => a.term.localeCompare(b.term));
}

function buildProverDraft(stats, findings) {
  return {
    language: "lean4",
    module: "ClaimLattice",
    obligations: [
      "CoreSurfacePresent",
      "NoHighSeverityImpossibleFinding",
      "EveryGoalHasValidationLink",
      "EveryImplementationDefinedChoiceHasDocumentedPolicy",
      "ComponentPressureIsJustifiedByGoals"
    ],
    generatedFacts: {
      nodeCount: stats.nodeCount,
      edgeCount: stats.edgeCount,
      findingCount: findings.length,
      highSeverityFindings: findings.filter((finding) => finding.severity === "high").length
    }
  };
}

function renderCritique(image) {
  const lines = [];
  lines.push(`# Viability Critique: ${image.source.title}`);
  lines.push("");
  lines.push(`Source: \`${image.source.path}\``);
  lines.push(`Generated: ${image.generatedAt}`);
  lines.push("");
  lines.push("## Claim Lattice Summary");
  lines.push("");
  lines.push(`- Nodes: ${image.stats.nodeCount}`);
  lines.push(`- Edges: ${image.stats.edgeCount}`);
  lines.push(`- Findings: ${image.stats.findingCount}`);
  lines.push(`- Problem surface: ${image.stats.hasProblem ? "yes" : "no"}`);
  lines.push(`- Goal surface: ${image.stats.hasGoals ? "yes" : "no"}`);
  lines.push(`- Validation surface: ${image.stats.hasValidation ? "yes" : "no"}`);
  lines.push("");
  lines.push("## Findings");
  lines.push("");
  if (!image.findings.length) {
    lines.push("No findings produced by the current heuristic evaluators.");
  }
  for (const finding of image.findings) {
    lines.push(`### ${finding.title}`);
    lines.push("");
    lines.push(`- Class: \`${finding.class}\``);
    lines.push(`- Severity: \`${finding.severity}\``);
    lines.push(`- Detail: ${finding.detail}`);
    if (finding.evidenceNodeIds.length) {
      lines.push(`- Evidence nodes: ${finding.evidenceNodeIds.map((id) => `\`${id}\``).join(", ")}`);
    }
    lines.push("");
  }
  lines.push("## Next Formalization Moves");
  lines.push("");
  for (const obligation of image.proverDraft.obligations) {
    lines.push(`- ${obligation}`);
  }
  lines.push("");
  return lines.join("\n");
}

function renderLean(image) {
  const highFindings = image.findings.filter((finding) => finding.severity === "high").length;
  const classes = Array.from(new Set(image.findings.map((finding) => finding.class)));
  const classComments = classes.length ? classes.map((klass) => `-- detected: ${klass}`).join("\n") : "-- no detected bad-idea classes";
  return `import Std

namespace ClaimLattice

inductive BadIdeaClass where
  | impossible
  | useless
  | moreComplexThanNothing
  | missesProblem
  | underspecified
  | unfalsifiable
  deriving Repr, DecidableEq

inductive Severity where
  | low
  | medium
  | high
  deriving Repr, DecidableEq, Ord

structure ImageStats where
  nodeCount : Nat
  edgeCount : Nat
  findingCount : Nat
  highSeverityFindingCount : Nat
  hasProblem : Bool
  hasGoals : Bool
  hasValidation : Bool
  deriving Repr

def generatedStats : ImageStats := {
  nodeCount := ${image.stats.nodeCount},
  edgeCount := ${image.stats.edgeCount},
  findingCount := ${image.findings.length},
  highSeverityFindingCount := ${highFindings},
  hasProblem := ${image.stats.hasProblem},
  hasGoals := ${image.stats.hasGoals},
  hasValidation := ${image.stats.hasValidation}
}

def coreSurfacePresent (stats : ImageStats) : Prop :=
  stats.hasProblem = true ∧ stats.hasGoals = true ∧ stats.hasValidation = true

def rejectsHighImpossibleFindings (stats : ImageStats) : Prop :=
  stats.highSeverityFindingCount = 0

def readyForPrototype (stats : ImageStats) : Prop :=
  coreSurfacePresent stats ∧ rejectsHighImpossibleFindings stats

theorem missing_core_surface_blocks_ready
    (stats : ImageStats)
    (h : stats.hasProblem = false ∨ stats.hasGoals = false ∨ stats.hasValidation = false) :
    ¬ readyForPrototype stats := by
  intro ready
  rcases ready with ⟨core, _⟩
  rcases core with ⟨problem, goals, validation⟩
  rcases h with hProblem | hGoals | hValidation
  · simp [hProblem] at problem
  · simp [hGoals] at goals
  · simp [hValidation] at validation

-- Generated from ${escapeLeanComment(image.source.path)}
${classComments}

end ClaimLattice
`;
}

function renderKumuElements(image) {
  const rows = [
    ["Label", "Type", "Title", "Source", "Line Start", "Line End", "Severity", "Class", "Excerpt"]
  ];
  for (const node of image.nodes) {
    rows.push([
      node.id,
      node.type,
      node.title ?? node.label ?? node.id,
      image.source.path,
      node.lineStart ?? "",
      node.lineEnd ?? "",
      node.severity ?? "",
      node.class ?? "",
      node.excerpt ?? ""
    ]);
  }
  return csv(rows);
}

function renderKumuConnections(image) {
  const rows = [["From", "To", "Type", "Label", "Id"]];
  for (const edge of image.edges) {
    rows.push([edge.from, edge.to, edge.type, edge.label ?? edge.type, edge.id]);
  }
  return csv(rows);
}

function renderNeo4jCypher(image) {
  const nodes = image.nodes.map((node) => ({
    id: node.id,
    type: node.type,
    title: node.title ?? node.label ?? node.id,
    lineStart: node.lineStart ?? null,
    lineEnd: node.lineEnd ?? null,
    severity: node.severity ?? null,
    badIdeaClass: node.class ?? null,
    excerpt: node.excerpt ?? null,
    sourcePath: image.source.path
  }));
  const edges = image.edges.map((edge) => ({
    id: edge.id,
    from: edge.from,
    to: edge.to,
    type: edge.type,
    label: edge.label ?? edge.type
  }));

  return [
    "// Basis Neo4j import",
    `// Source: ${image.source.path}`,
    "// Load with cypher-shell or Neo4j Browser.",
    "",
    "CREATE CONSTRAINT claim_lattice_node_id IF NOT EXISTS",
    "FOR (n:ClaimLatticeNode)",
    "REQUIRE n.id IS UNIQUE;",
    "",
    `UNWIND ${JSON.stringify(nodes, null, 2)} AS row`,
    "MERGE (n:ClaimLatticeNode {id: row.id})",
    "SET n.type = row.type,",
    "    n.title = row.title,",
    "    n.lineStart = row.lineStart,",
    "    n.lineEnd = row.lineEnd,",
    "    n.severity = row.severity,",
    "    n.badIdeaClass = row.badIdeaClass,",
    "    n.excerpt = row.excerpt,",
    "    n.sourcePath = row.sourcePath;",
    "",
    `UNWIND ${JSON.stringify(edges, null, 2)} AS row`,
    "MATCH (from:ClaimLatticeNode {id: row.from})",
    "MATCH (to:ClaimLatticeNode {id: row.to})",
    "MERGE (from)-[r:SPEC_EDGE {id: row.id}]->(to)",
    "SET r.type = row.type,",
    "    r.label = row.label;",
    ""
  ].join("\n");
}

function renderStructurizr(image) {
  const components = image.nodes
    .filter((node) => node.type === "component")
    .slice(0, 40);
  const title = image.source.title.replace(/^#\s*/, "");
  const systemIdentifier = "specSystem";
  const componentLines = components.map((node, index) => {
    const identifier = `c${index + 1}`;
    const name = dslQuote(shortTitle(node.title ?? node.id));
    const description = dslQuote(`${node.type} · ${node.id}`);
    return `      ${identifier} = container "${name}" "${description}" "Claim lattice node"`;
  });

  return `workspace "Basis: ${dslQuote(title)}" "Architecture projection generated from a prose claim lattice." {
  model {
    reviewer = person "Spec reviewer" "Explores bad-idea pressure and implementation topology."

    ${systemIdentifier} = softwareSystem "${dslQuote(title)}" "System shape inferred from the claim lattice." {
${componentLines.length ? componentLines.join("\n") : "      placeholder = container \"No component nodes detected\" \"The claim lattice did not extract component nodes.\" \"Claim lattice node\""}
    }

    reviewer -> ${systemIdentifier} "reviews and elaborates"
  }

  views {
    systemContext ${systemIdentifier} "SystemContext" {
      include *
      autoLayout
    }

    container ${systemIdentifier} "Containers" {
      include *
      autoLayout
    }

    theme default
  }
}
`;
}

function renderRefinementPacket(image) {
  const orderedFindings = image.findings
    .slice()
    .sort((left, right) => severityRank(right.severity) - severityRank(left.severity));
  const findingLines = orderedFindings.map((finding) => {
    const evidence = finding.evidenceNodeIds.slice(0, 6).map((id) => `\`${id}\``).join(", ");
    return `- ${finding.severity.toUpperCase()} \`${finding.class}\`: ${finding.title}${evidence ? ` (${evidence})` : ""}`;
  });

  return `# Refinement Packet: ${image.source.title}

## Objective

Resolve the highest-value viability finding before prototype work proceeds.

## Input Artifacts

- Source spec: \`${image.source.path}\`
- Dataified spec: \`dataified-spec.json\`
- Canonical graph: \`claim-lattice.json\`
- Critique: \`viability-critique.md\`
- Lean mock model: \`ClaimLattice.lean\`
- Optional projections: generated only when requested.
- Environment score: \`${image.environment.score}\`

## Current Findings

${findingLines.length ? findingLines.join("\n") : "No current findings."}

## Player Procedure

1. Load \`viability-critique.md\`, \`dataified-spec.json\`, and \`claim-lattice.json\`.
2. Pick exactly one finding, preferring high severity over broad cleanup.
3. Trace its evidence nodes back to source lines.
4. Patch the source specification, add a recorded design decision, or reject the idea with evidence.
5. Regenerate the Basis state.
6. Run the verification gates.
7. Report the changed source lines, regenerated artifacts, and remaining highest finding.

## Verification Gates

\`\`\`sh
npm test
npm run play:symphony
lean out/symphony/ClaimLattice.lean
\`\`\`

## Acceptance

- The selected finding is resolved or explicitly reclassified with evidence.
- Regenerated artifacts include source anchors and enough provenance to review differences.
- The Lean mock model still type-checks.
- No new high-severity finding is introduced.
`;
}

function edge(from, to, type, label) {
  return { id: `${from}->${to}:${type}`, from, to, type, label };
}

function csv(rows) {
  return `${rows.map((row) => row.map(csvCell).join(",")).join("\n")}\n`;
}

function csvCell(value) {
  const stringValue = String(value ?? "");
  if (!/[",\n\r]/.test(stringValue)) return stringValue;
  return `"${stringValue.replaceAll('"', '""')}"`;
}

function dslQuote(value) {
  return String(value ?? "").replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, " ").slice(0, 180);
}

function severityRank(severity) {
  return { high: 3, medium: 2, low: 1 }[severity] ?? 0;
}

function groupBy(items, keyFn) {
  return items.reduce((groups, item) => {
    const key = keyFn(item);
    if (!groups[key]) groups[key] = [];
    groups[key].push(item);
    return groups;
  }, {});
}

function tokenOverlap(left, right) {
  const leftTokens = semanticTokens(left);
  const rightTokens = semanticTokens(right);
  if (!leftTokens.size || !rightTokens.size) return 0;
  const shared = Array.from(leftTokens).filter((token) => rightTokens.has(token)).length;
  return shared / Math.max(leftTokens.size, rightTokens.size);
}

function semanticTokens(text) {
  const stop = new Set([
    "the", "and", "for", "that", "with", "from", "this", "into", "must", "should",
    "may", "not", "are", "can", "one", "each", "used", "when", "where", "will",
    "shall", "have", "has", "its", "their", "inside", "outside", "before", "after"
  ]);
  return new Set(
    String(text)
      .toLowerCase()
      .replace(/[^a-z0-9_ -]/g, " ")
      .split(/\s+/)
      .filter((token) => token.length > 3 && !stop.has(token))
  );
}

function normativeKeywords(text) {
  const matches = Array.from(String(text).matchAll(NORMATIVE_RE)).map((match) => match[1].toUpperCase());
  NORMATIVE_RE.lastIndex = 0;
  return Array.from(new Set(matches));
}

function shortTitle(text) {
  const cleaned = text.replace(/[`*_]/g, "").replace(/\s+/g, " ").trim();
  if (cleaned.length <= 88) return cleaned;
  return `${cleaned.slice(0, 85).trim()}...`;
}

function slug(input) {
  return String(input)
    .toLowerCase()
    .replace(/`/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .slice(0, 80) || "item";
}

function uniqueId(prefix, seed, nodes) {
  const existing = new Set(nodes.map((node) => node.id));
  let base = `${prefix}-${seed}`.replace(/-+/g, "-");
  let candidate = base;
  let index = 2;
  while (existing.has(candidate)) {
    candidate = `${base}-${index}`;
    index += 1;
  }
  return candidate;
}

function excerpt(lines, start, end) {
  return lines
    .slice(start - 1, Math.min(end, start + 8))
    .join("\n")
    .trim()
    .slice(0, 1200);
}

function firstNonEmpty(lines, fallback) {
  return lines.find((line) => line.trim()) ?? fallback;
}

function escapeLeanComment(text) {
  return String(text).replace(/\n/g, " ").replace(/-\//g, "- /");
}

function parseArgs(argv) {
  const [command, input, ...rest] = argv;
  const options = {
    command,
    input,
    outDir: "out/basis",
    title: undefined,
    projections: [],
    action: undefined,
    actor: "human",
    claim: undefined,
    policy: undefined,
    branch: undefined,
    since: undefined,
    forwardProjection: undefined,
    reverseProjection: undefined,
    samples: 12,
    iterations: 4
  };
  for (let index = 0; index < rest.length; index += 1) {
    const arg = rest[index];
    if (arg === "--out") {
      options.outDir = rest[index + 1];
      index += 1;
    } else if (arg === "--title") {
      options.title = rest[index + 1];
      index += 1;
    } else if (arg === "--projection" || arg === "--derive") {
      options.projections.push(rest[index + 1]);
      index += 1;
    } else if (arg === "--all-projections") {
      options.projections.push("all");
    } else if (arg === "--action") {
      options.action = rest[index + 1];
      index += 1;
    } else if (arg === "--actor") {
      options.actor = rest[index + 1];
      index += 1;
    } else if (arg === "--claim") {
      options.claim = rest[index + 1];
      index += 1;
    } else if (arg === "--policy") {
      options.policy = rest[index + 1];
      index += 1;
    } else if (arg === "--forward") {
      options.forwardProjection = rest[index + 1];
      index += 1;
    } else if (arg === "--reverse") {
      options.reverseProjection = rest[index + 1];
      index += 1;
    } else if (arg === "--branch") {
      options.branch = rest[index + 1];
      index += 1;
    } else if (arg === "--since" || arg === "--from-root") {
      options.since = rest[index + 1];
      index += 1;
    } else if (arg === "--samples") {
      options.samples = Number(rest[index + 1]);
      index += 1;
    } else if (arg === "--iterations") {
      options.iterations = Number(rest[index + 1]);
      index += 1;
    } else {
      throw new Error(`Unknown argument: ${arg}`);
    }
  }
  return options;
}

function parseProjectionMarkdown(markdown, filePath) {
  const match = /^---\n([\s\S]*?)\n---\n?([\s\S]*)$/m.exec(markdown);
  if (!match) {
    throw new Error(`Projection file lacks front matter: ${filePath}`);
  }
  const metadata = {};
  for (const rawLine of match[1].split("\n")) {
    const line = rawLine.trim();
    if (!line || line.startsWith("#")) continue;
    const field = /^([A-Za-z0-9_-]+):\s*(.*?)\s*$/.exec(line);
    if (!field) continue;
    metadata[field[1]] = parseFrontMatterValue(field[2]);
  }
  if (!metadata.id) {
    throw new Error(`Projection file lacks id: ${filePath}`);
  }
  return {
    ...metadata,
    description: match[2].trim(),
    path: filePath
  };
}

function parseFrontMatterValue(value) {
  if (/^\[.*\]$/.test(value)) {
    const inner = value.slice(1, -1).trim();
    if (!inner) return [];
    return inner.split(",").map((item) => item.trim().replace(/^["']|["']$/g, "")).filter(Boolean);
  }
  if (value === "true") return true;
  if (value === "false") return false;
  return value.replace(/^["']|["']$/g, "");
}

function loadProjectionSpecs(rootDir = process.cwd()) {
  const projectionDir = path.join(rootDir, PROJECTION_DIR);
  if (!fs.existsSync(projectionDir)) return new Map();
  const specs = new Map();
  for (const file of fs.readdirSync(projectionDir).filter((item) => item.endsWith(".md")).sort()) {
    const filePath = path.join(projectionDir, file);
    const spec = parseProjectionMarkdown(fs.readFileSync(filePath, "utf8"), filePath);
    specs.set(spec.id, spec);
  }
  return specs;
}

function normalizeProjectionId(id) {
  return String(id).trim().toLowerCase().replace(/_/g, "-");
}

function projectionIncludedInAll(spec) {
  return spec.includeInAll !== false;
}

function normalizeProjections(projections, projectionSpecs = loadProjectionSpecs()) {
  const selected = new Set();
  const dynamicProjectionIds = Array.from(projectionSpecs.keys());
  const allDynamicProjectionIds = Array.from(projectionSpecs.entries())
    .filter(([, spec]) => projectionIncludedInAll(spec))
    .map(([id]) => id);
  const known = LEGACY_PROJECTIONS.concat(dynamicProjectionIds);
  const allKnown = LEGACY_PROJECTIONS.concat(allDynamicProjectionIds);
  for (const projection of projections) {
    if (!projection) continue;
    for (const item of String(projection).split(",")) {
      const normalized = normalizeProjectionId(item);
      if (!normalized) continue;
      if (normalized === "all") {
        allKnown.forEach((name) => selected.add(name));
      } else if (known.includes(normalized)) {
        selected.add(normalized);
      } else {
        throw new Error(`Unknown projection: ${normalized}. Known projections: ${known.join(", ")}, all`);
      }
    }
  }
  return selected;
}

function removeStaleProjectionFiles(outDir, projections, projectionSpecs = new Map()) {
  for (const [projection, files] of Object.entries(PROJECTION_FILES)) {
    if (projections.has(projection)) continue;
    for (const file of files) {
      const target = path.join(outDir, file);
      if (fs.existsSync(target)) fs.rmSync(target);
    }
  }
  for (const [projection, spec] of projectionSpecs.entries()) {
    if (projections.has(projection)) continue;
    const target = path.join(outDir, spec.outputPath);
    if (fs.existsSync(target)) fs.rmSync(target);
    const callDir = path.join(outDir, "llm-calls", projection);
    if (fs.existsSync(callDir)) fs.rmSync(callDir, { recursive: true, force: true });
  }
  if (!Array.from(projections).some((projection) => projectionSpecs.has(projection))) {
    const runPath = path.join(outDir, "llm-projection-run.json");
    if (fs.existsSync(runPath)) fs.rmSync(runPath);
  }
}

function removeStaleCoreFiles(outDir) {
  for (const file of STALE_CORE_FILES) {
    const target = path.join(outDir, file);
    if (fs.existsSync(target)) fs.rmSync(target);
  }
}

function writeCoreArtifacts(outDir, image, dataifiedSpec) {
  fs.writeFileSync(path.join(outDir, "dataified-spec.json"), `${JSON.stringify(dataifiedSpec, null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, "claim-lattice.json"), `${JSON.stringify(image, null, 2)}\n`);
  fs.writeFileSync(path.join(outDir, "viability-critique.md"), renderCritique(image));
  fs.writeFileSync(path.join(outDir, "ClaimLattice.lean"), renderLean(image));
  fs.writeFileSync(path.join(outDir, "refinement-packet.md"), renderRefinementPacket(image));
}

function buildCodeSourcePack(rootDir) {
  const files = [];
  collectCodeFiles(rootDir, rootDir, files);
  return {
    schemaVersion: "basis.code-source-pack.v0",
    source: {
      path: rootDir,
      fileCount: files.length
    },
    files: files.slice(0, 160).map((file) => {
      const text = fs.readFileSync(file.absolutePath, "utf8");
      const lines = text.replace(/\r\n/g, "\n").split("\n");
      return {
        path: file.relativePath,
        language: languageForPath(file.relativePath),
        lineCount: lines.length,
        excerptLineStart: 1,
        excerptLineEnd: Math.min(lines.length, 120),
        excerpt: lines.slice(0, 120).join("\n")
      };
    })
  };
}

function collectCodeFiles(rootDir, currentDir, files) {
  for (const entry of fs.readdirSync(currentDir, { withFileTypes: true })) {
    if (entry.name.startsWith(".") || ["node_modules", "out", "target", "dist", "build"].includes(entry.name)) continue;
    const absolutePath = path.join(currentDir, entry.name);
    if (entry.isDirectory()) {
      collectCodeFiles(rootDir, absolutePath, files);
      continue;
    }
    if (!entry.isFile()) continue;
    if (!CODE_SOURCE_EXTENSIONS.has(path.extname(entry.name).toLowerCase())) continue;
    const stats = fs.statSync(absolutePath);
    if (stats.size > 256_000) continue;
    files.push({
      absolutePath,
      relativePath: path.relative(rootDir, absolutePath)
    });
  }
}

function languageForPath(filePath) {
  const extension = path.extname(filePath).replace(".", "");
  if (extension === "mjs") return "js";
  return extension || "text";
}

function renderCodeSourceMarkdown(pack) {
  const lines = [
    "# Code Source Pack",
    "",
    `Source: \`${pack.source.path}\``,
    `Files: ${pack.source.fileCount}`,
    "",
    "This generated source pack is input for LLM-only code-to-spec projection calls.",
    ""
  ];
  for (const file of pack.files) {
    lines.push(`## ${file.path}`);
    lines.push("");
    lines.push(`Lines: ${file.excerptLineStart}-${file.excerptLineEnd} of ${file.lineCount}`);
    lines.push("");
    lines.push(`\`\`\`${file.language}`);
    lines.push(file.excerpt);
    lines.push("```");
    lines.push("");
  }
  return lines.join("\n");
}

function renderProjection(spec, image, dataifiedSpec) {
  return `${JSON.stringify(buildProjectionPlan(spec, image, dataifiedSpec), null, 2)}\n`;
}

function buildProjectionPlan(spec, image, dataifiedSpec) {
  const nodes = selectProjectionNodes(spec, image);
  const slices = buildProjectionSlices(spec, image, dataifiedSpec, nodes);
  return {
    schemaVersion: "basis.llm-projection-plan.v0",
    projection: {
      id: spec.id,
      title: spec.title,
      output: spec.output,
      outputPath: spec.outputPath,
      types: spec.types ?? [],
      description: spec.description
    },
    source: image.source,
    inputForms: spec.inputForms ?? [],
    selection: {
      matchNodeTypes: spec.matchNodeTypes ?? [],
      keywords: spec.keywords ?? [],
      nodeCount: nodes.length
    },
    execution: {
      runner: "codex_app_server",
      localRole: "focus_and_call_packet_generation_only",
      contentGeneration: "llm_only",
      sliceCount: slices.length,
      mergeRequired: true,
      determinismTraining: "repeat projection calls, validate against type contracts, and record drift"
    },
    calls: slices.map((slice, index) => projectionCall(spec, image, dataifiedSpec, slice, index + 1)),
    dataifiedSpec: {
      schemaVersion: dataifiedSpec.schemaVersion,
      sourceHash: dataifiedSpec.source.sha256,
      blockCount: dataifiedSpec.blocks.length
    },
    unresolvedFindings: image.findings.map((finding) => ({
      id: finding.id,
      class: finding.class,
      severity: finding.severity,
      title: finding.title,
      evidenceNodeIds: finding.evidenceNodeIds
    }))
  };
}

function buildProjectionSlices(spec, image, dataifiedSpec, nodes) {
  const selectedNodes = nodes.length
    ? nodes
    : image.nodes.filter((node) => !["spec", "finding"].includes(node.type)).slice(0, 80);
  const chunkSize = Number(spec.chunkSize ?? 8);
  const chunks = [];
  for (let index = 0; index < selectedNodes.length; index += chunkSize) {
    chunks.push(selectedNodes.slice(index, index + chunkSize));
  }
  if (!chunks.length) chunks.push([]);
  return chunks.map((chunk, index) => {
    const blocks = blocksForNodes(dataifiedSpec, chunk);
    return {
      id: `${spec.id}-slice-${String(index + 1).padStart(3, "0")}`,
      nodeIds: chunk.map((node) => node.id),
      nodes: chunk.map((node) => projectionNode(node, image.source.path)),
      blocks
    };
  });
}

function blocksForNodes(dataifiedSpec, nodes) {
  if (!nodes.length) return dataifiedSpec.blocks.slice(0, 20).map(projectionBlock);
  const selected = new Map();
  for (const node of nodes) {
    for (const block of dataifiedSpec.blocks) {
      if (rangesOverlap(block, node)) selected.set(block.id, block);
    }
    const heading = nearestHeadingBlock(dataifiedSpec.blocks, node.lineStart);
    if (heading) selected.set(heading.id, heading);
  }
  return Array.from(selected.values())
    .sort((left, right) => left.lineStart - right.lineStart)
    .map(projectionBlock);
}

function nearestHeadingBlock(blocks, line) {
  return blocks
    .filter((block) => block.type === "heading" && block.lineStart <= line)
    .sort((left, right) => right.lineStart - left.lineStart)[0];
}

function projectionBlock(block) {
  return {
    id: block.id,
    type: block.type,
    lineStart: block.lineStart,
    lineEnd: block.lineEnd,
    semanticRole: block.semanticRole,
    generatedClaimIds: block.generatedClaimIds ?? [],
    rawMarkdown: block.rawMarkdown
  };
}

function projectionCall(spec, image, dataifiedSpec, slice, callNumber) {
  return {
    id: `${spec.id}-call-${String(callNumber).padStart(3, "0")}`,
    projectionId: spec.id,
    sliceId: slice.id,
    runner: "codex_app_server",
    source: {
      path: image.source.path,
      title: image.source.title,
      hash: dataifiedSpec.source.sha256
    },
    expectedOutput: {
      format: spec.output,
      finalPath: spec.outputPath,
      types: spec.types ?? []
    },
    sourceNodeIds: slice.nodeIds,
    blockIds: slice.blocks.map((block) => block.id),
    prompt: projectionPrompt(spec, slice)
  };
}

function projectionPrompt(spec, slice) {
  return [
    `You are executing Basis projection \`${spec.id}\`: ${spec.title}.`,
    "",
    "Projection instructions:",
    spec.description,
    "",
    "Output contract:",
    `- Format: ${spec.output}`,
    `- Final artifact path after merge: ${spec.outputPath}`,
    `- Type contracts: ${(spec.types ?? []).join(", ") || "none declared"}`,
    "",
    "Rules:",
    "- Use only the source slice below.",
    "- Preserve source anchors for every emitted item.",
    "- Mark inferred items explicitly.",
    "- Do not fill missing facts with invented certainty.",
    "- Return only the partial projection payload for this slice.",
    "",
    "Source nodes:",
    "```json",
    JSON.stringify(slice.nodes, null, 2),
    "```",
    "",
    "Source Markdown blocks:",
    "```json",
    JSON.stringify(slice.blocks, null, 2),
    "```"
  ].join("\n");
}

function selectProjectionNodes(spec, image) {
  const nodeTypes = new Set(spec.matchNodeTypes ?? []);
  const keywords = (spec.keywords ?? []).map((keyword) => String(keyword).toLowerCase());
  return image.nodes
    .filter((node) => node.type !== "spec" && node.type !== "section")
    .filter((node) => !nodeTypes.size || nodeTypes.has(node.type))
    .filter((node) => {
      if (!keywords.length) return true;
      const haystack = `${node.title ?? ""} ${node.excerpt ?? ""}`.toLowerCase();
      return keywords.some((keyword) => keywordMatches(haystack, keyword));
    });
}

function keywordMatches(haystack, keyword) {
  const escaped = String(keyword).replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  return new RegExp(`(^|[^a-z0-9])${escaped}([^a-z0-9]|$)`, "i").test(haystack);
}

function projectionNode(node, sourcePath) {
  return {
    id: node.id,
    type: node.type,
    title: node.title,
    text: node.excerpt ?? "",
    normative: node.normative ?? [],
    source: {
      path: sourcePath,
      lineStart: node.lineStart,
      lineEnd: node.lineEnd
    }
  };
}

function writeProjectionArtifacts(outDir, projections, projectionSpecs, image, dataifiedSpec) {
  const run = {
    schemaVersion: "basis.llm-projection-run.v0",
    source: image.source,
    sourceHash: dataifiedSpec.source.sha256,
    selectedProjectionIds: Array.from(projections).filter((projection) => projectionSpecs.has(projection)),
    plans: []
  };
  for (const projection of projections) {
    const spec = projectionSpecs.get(projection);
    if (!spec) continue;
    const staleFinalOutput = path.join(outDir, spec.outputPath);
    if (fs.existsSync(staleFinalOutput)) fs.rmSync(staleFinalOutput, { recursive: true, force: true });
    const plan = buildProjectionPlan(spec, image, dataifiedSpec);
    run.plans.push({
      projectionId: spec.id,
      callCount: plan.calls.length,
      planPath: path.join("llm-calls", spec.id, "projection-plan.json"),
      mergePromptPath: path.join("llm-calls", spec.id, "merge.md"),
      finalOutputPath: spec.outputPath
    });
    writeProjectionPlanFiles(outDir, spec, plan);
  }
  if (run.plans.length) {
    fs.writeFileSync(path.join(outDir, "llm-projection-run.json"), `${JSON.stringify(run, null, 2)}\n`);
  }
}

function writeProjectionPlanFiles(outDir, spec, plan) {
  const dir = path.join(outDir, "llm-calls", spec.id);
  fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(path.join(dir, "projection-plan.json"), `${JSON.stringify(plan, null, 2)}\n`);
  plan.calls.forEach((call) => {
    fs.writeFileSync(path.join(dir, `${call.id}.json`), `${JSON.stringify(call, null, 2)}\n`);
    fs.writeFileSync(path.join(dir, `${call.id}.md`), `${call.prompt}\n`);
  });
  fs.writeFileSync(path.join(dir, "merge.md"), `${projectionMergePrompt(spec, plan)}\n`);
}

function projectionMergePrompt(spec, plan) {
  return [
    `You are merging partial LLM outputs for Basis projection \`${spec.id}\`: ${spec.title}.`,
    "",
    "Projection instructions:",
    spec.description,
    "",
    "Final output contract:",
    `- Format: ${spec.output}`,
    `- Path: ${spec.outputPath}`,
    `- Types: ${(spec.types ?? []).join(", ") || "none declared"}`,
    "",
    "Merge rules:",
    "- Preserve source anchors.",
    "- Deduplicate by source anchor and semantic identity.",
    "- Keep uncertainty explicit.",
    "- Report conflicts instead of hiding them.",
    "- Return only the final projection artifact content.",
    "",
    "Expected partial call files:",
    ...plan.calls.map((call) => `- ${call.id}.json / ${call.id}.md`)
  ].join("\n");
}

function requireProjectionSpec(id, projectionSpecs, flagName) {
  const normalized = normalizeProjectionId(id ?? "");
  if (!normalized) {
    throw new Error(`Missing ${flagName} projection`);
  }
  const spec = projectionSpecs.get(normalized);
  if (!spec) {
    throw new Error(`Unknown ${flagName} projection: ${normalized}`);
  }
  return spec;
}

function projectionCycleId(forwardSpec, reverseSpec) {
  return `${forwardSpec.id}__${reverseSpec.id}`;
}

function buildProjectionCycleTrainingPlan(forwardSpec, reverseSpec, image, dataifiedSpec, options = {}) {
  const iterations = Math.max(1, Number(options.iterations ?? 1));
  const cycleId = projectionCycleId(forwardSpec, reverseSpec);
  const rounds = [];
  for (let index = 0; index < iterations; index += 1) {
    const roundId = `round-${String(index + 1).padStart(3, "0")}`;
    const roundRoot = path.join(PROJECTION_CYCLE_DIR, cycleId, roundId);
    rounds.push({
      id: roundId,
      forward: {
        projectionId: forwardSpec.id,
        planPath: path.join(roundRoot, "forward", "llm-calls", forwardSpec.id, "projection-plan.json"),
        mergePromptPath: path.join(roundRoot, "forward", "llm-calls", forwardSpec.id, "merge.md"),
        intermediateArtifactPath: forwardSpec.outputPath
      },
      reverse: {
        projectionId: reverseSpec.id,
        callPath: path.join(roundRoot, "reverse", `${reverseSpec.id}-call-001.json`),
        promptPath: path.join(roundRoot, "reverse", `${reverseSpec.id}-call-001.md`),
        sourceArtifactPath: forwardSpec.outputPath,
        returnedSpecDraftPath: reverseSpec.outputPath
      },
      judge: {
        callPath: path.join(roundRoot, "judge-call.json"),
        promptPath: path.join(roundRoot, "judge.md"),
        driftReportPath: path.join(roundRoot, "drift-report.json")
      },
      gates: [
        `node src/basis.mjs play ${reverseSpec.outputPath} --out ${path.join(roundRoot, "roundtrip")}`,
        "npm test"
      ]
    });
  }
  return {
    schemaVersion: "basis.projection-cycle-training-plan.v0",
    cycleId,
    objective: "train_bidirectional_projection_consistency",
    source: image.source,
    sourceHash: dataifiedSpec.source.sha256,
    iterations,
    forward: projectionCycleEndpoint(forwardSpec),
    reverse: projectionCycleEndpoint(reverseSpec),
    rounds,
    acceptance: {
      deterministicOutputRequired: false,
      compare: [
        "original dataified-spec.json against returned draft dataified-spec.json",
        "original claim-lattice.json against returned draft claim-lattice.json",
        "source anchors preserved, renamed, retired, lost, or invented",
        "intermediate artifact assumptions and open questions carried back into the draft",
        "findings disappeared only with an explicit correction record"
      ],
      rejectOn: [
        "missing required source anchors",
        "unsupported certainty introduced by either direction",
        "intermediate artifact content ignored by reverse projection",
        "round-trip drift report absent"
      ]
    }
  };
}

function projectionCycleEndpoint(spec) {
  return {
    projectionId: spec.id,
    title: spec.title,
    inputForms: spec.inputForms ?? [],
    output: spec.output,
    outputPath: spec.outputPath,
    types: spec.types ?? [],
    explicitOnly: spec.includeInAll === false
  };
}

function writeProjectionCycleTrainingArtifacts(outDir, forwardSpec, reverseSpec, image, dataifiedSpec, options = {}) {
  const plan = buildProjectionCycleTrainingPlan(forwardSpec, reverseSpec, image, dataifiedSpec, options);
  const cycleRoot = path.join(outDir, PROJECTION_CYCLE_DIR, plan.cycleId);
  if (fs.existsSync(cycleRoot)) fs.rmSync(cycleRoot, { recursive: true, force: true });
  fs.writeFileSync(path.join(outDir, "projection-cycle-training-plan.json"), `${JSON.stringify(plan, null, 2)}\n`);
  for (const round of plan.rounds) {
    const roundDir = path.join(cycleRoot, round.id);
    fs.mkdirSync(roundDir, { recursive: true });

    const forwardPlan = buildProjectionPlan(forwardSpec, image, dataifiedSpec);
    writeProjectionPlanFiles(path.join(roundDir, "forward"), forwardSpec, forwardPlan);

    const reverseCall = projectionCycleReverseCall(forwardSpec, reverseSpec, image, dataifiedSpec, round);
    const reverseDir = path.join(roundDir, "reverse");
    fs.mkdirSync(reverseDir, { recursive: true });
    fs.writeFileSync(path.join(reverseDir, `${reverseSpec.id}-call-001.json`), `${JSON.stringify(reverseCall, null, 2)}\n`);
    fs.writeFileSync(path.join(reverseDir, `${reverseSpec.id}-call-001.md`), `${reverseCall.prompt}\n`);

    const judgeCall = projectionCycleJudgeCall(plan, forwardSpec, reverseSpec, round);
    fs.writeFileSync(path.join(roundDir, "judge-call.json"), `${JSON.stringify(judgeCall, null, 2)}\n`);
    fs.writeFileSync(path.join(roundDir, "judge.md"), `${judgeCall.prompt}\n`);
  }
  return plan;
}

function projectionCycleReverseCall(forwardSpec, reverseSpec, image, dataifiedSpec, round) {
  const prompt = projectionCycleReversePrompt(forwardSpec, reverseSpec, round);
  return {
    schemaVersion: "basis.llm-projection-call.v0",
    id: `${reverseSpec.id}-call-001`,
    projectionId: reverseSpec.id,
    roundId: round.id,
    runner: "codex_app_server",
    sourceArtifact: {
      path: forwardSpec.outputPath,
      producedByProjectionId: forwardSpec.id,
      producedByRoundId: round.id
    },
    originalSourceReference: {
      path: image.source.path,
      title: image.source.title,
      hash: dataifiedSpec.source.sha256,
      contentAvailableToReverseCall: false
    },
    expectedOutput: {
      format: reverseSpec.output,
      finalPath: reverseSpec.outputPath,
      types: reverseSpec.types ?? []
    },
    prompt
  };
}

function projectionCycleReversePrompt(forwardSpec, reverseSpec, round) {
  return [
    `You are executing reverse Basis projection \`${reverseSpec.id}\`: ${reverseSpec.title}.`,
    "",
    `Training round: ${round.id}`,
    "",
    "Source artifact contract:",
    `- Read the intermediate artifact produced by \`${forwardSpec.id}\`.`,
    `- Intermediate artifact path: ${forwardSpec.outputPath}`,
    "- Use only that intermediate artifact content for reconstruction.",
    "- Do not use the original spec content; the judge handles comparison later.",
    "",
    "Reverse projection instructions:",
    reverseSpec.description,
    "",
    "Output contract:",
    `- Format: ${reverseSpec.output}`,
    `- Final artifact path after merge: ${reverseSpec.outputPath}`,
    `- Type contracts: ${(reverseSpec.types ?? []).join(", ") || "none declared"}`,
    "",
    "Rules:",
    "- Preserve source anchors from the intermediate artifact when present.",
    "- Mark inferred product intent explicitly.",
    "- Carry assumptions and open questions forward instead of collapsing them into certainty.",
    "- Return only the reverse projection artifact content."
  ].join("\n");
}

function projectionCycleJudgeCall(plan, forwardSpec, reverseSpec, round) {
  const prompt = [
    `You are judging Basis projection cycle \`${plan.cycleId}\` for ${round.id}.`,
    "",
    "Inputs the runner must attach:",
    "- original dataified-spec.json",
    "- original claim-lattice.json",
    `- intermediate artifact from \`${forwardSpec.id}\`: ${forwardSpec.outputPath}`,
    `- returned spec draft from \`${reverseSpec.id}\`: ${reverseSpec.outputPath}`,
    "- regenerated dataified-spec.json from the returned spec draft",
    "- regenerated claim-lattice.json from the returned spec draft",
    "",
    "Judge task:",
    "- Compare semantic coverage, not byte equality.",
    "- Identify source anchors preserved, renamed, retired, lost, or invented.",
    "- Identify claims lost, claims invented, and claims weakened.",
    "- Identify assumptions or open questions that disappeared.",
    "- Identify test or architecture facts that came back as unsupported spec certainty.",
    "- Decide whether this round should be accepted for training data.",
    "",
    "Return JSON only with fields:",
    "`cycleId`, `roundId`, `acceptedForTraining`, `coverageScore`, `driftScore`, `lostAnchors`, `inventedClaims`, `weakenedClaims`, `collapsedUncertainty`, `notes`."
  ].join("\n");
  return {
    schemaVersion: "basis.llm-cycle-judge-call.v0",
    id: `${plan.cycleId}-${round.id}-judge`,
    cycleId: plan.cycleId,
    roundId: round.id,
    runner: "codex_app_server",
    outputPath: round.judge.driftReportPath,
    prompt
  };
}

async function main(argv) {
  const args = parseArgs(argv);
  if (!PRIMARY_COMMANDS.has(args.command) || !args.input) {
    process.stderr.write("Usage: node src/basis.mjs <play|score|step|rollout|export|mine|train> <spec.md|repo> [--out out/basis] [--title Title]\n");
    process.exitCode = 2;
    return;
  }

  const inputPath = path.resolve(args.input);
  const outDir = path.resolve(args.outDir);

  if (args.command === "mine") {
    const experiment = buildHistoricalSpecExperimentFromGit(inputPath, {
      branch: args.branch,
      since: args.since,
      samples: args.samples,
      iterations: args.iterations
    });
    fs.mkdirSync(outDir, { recursive: true });
    removeStaleCoreFiles(outDir);
    writeHistoricalSpecArtifacts(outDir, experiment);
    const minedSpecPath = path.join(outDir, "mined-spec.md");
    const image = buildBasisState(experiment.bestSpec.markdown, minedSpecPath, { title: args.title });
    const dataifiedSpec = buildDataifiedSpec(experiment.bestSpec.markdown, minedSpecPath, { title: args.title, claimNodes: image.nodes });
    writeCoreArtifacts(outDir, image, dataifiedSpec);
    process.stdout.write(`Basis mine artifacts written to ${outDir}\n`);
    process.stdout.write(`repo=${experiment.source.repo}\n`);
    process.stdout.write(`root=${experiment.source.root} target=${experiment.source.target}\n`);
    process.stdout.write(`samples=${experiment.source.selectedSampleCount} firstParentCommits=${experiment.source.totalFirstParentCommits}\n`);
    process.stdout.write(`bestPrompt=${experiment.bestSpec.promptId} reward=${experiment.bestSpec.reward}\n`);
    process.stdout.write(`nodes=${image.stats.nodeCount} edges=${image.stats.edgeCount} findings=${image.stats.findingCount}\n`);
    return;
  }

  const inputStats = fs.statSync(inputPath);
  const codeSourcePack = inputStats.isDirectory() ? buildCodeSourcePack(inputPath) : null;
  const markdown = codeSourcePack ? renderCodeSourceMarkdown(codeSourcePack) : fs.readFileSync(inputPath, "utf8");
  const image = buildBasisState(markdown, inputPath, { title: args.title });
  const dataifiedSpec = buildDataifiedSpec(markdown, inputPath, { title: args.title, claimNodes: image.nodes });
  const projectionSpecs = loadProjectionSpecs(process.cwd());
  fs.mkdirSync(outDir, { recursive: true });
  removeStaleCoreFiles(outDir);
  writeCoreArtifacts(outDir, image, dataifiedSpec);
  if (codeSourcePack) {
    fs.writeFileSync(path.join(outDir, "code-source-pack.json"), `${JSON.stringify(codeSourcePack, null, 2)}\n`);
  }

  if (args.command === "train") {
    const forwardSpec = requireProjectionSpec(args.forwardProjection, projectionSpecs, "--forward");
    const reverseSpec = requireProjectionSpec(args.reverseProjection, projectionSpecs, "--reverse");
    removeStaleProjectionFiles(outDir, new Set(), projectionSpecs);
    const cyclePlan = writeProjectionCycleTrainingArtifacts(outDir, forwardSpec, reverseSpec, image, dataifiedSpec, {
      iterations: args.iterations
    });
    process.stdout.write(`Basis train cycle written to ${outDir}\n`);
    process.stdout.write(`cycle=${cyclePlan.cycleId}\n`);
    process.stdout.write(`rounds=${cyclePlan.rounds.length}\n`);
    process.stdout.write(`nodes=${image.stats.nodeCount} edges=${image.stats.edgeCount} findings=${image.stats.findingCount}\n`);
    process.stdout.write(`score=${image.environment.score}\n`);
    return;
  }

  const projections = normalizeProjections(args.projections, projectionSpecs);
  removeStaleProjectionFiles(outDir, projections, projectionSpecs);
  writeProjectionArtifacts(outDir, projections, projectionSpecs, image, dataifiedSpec);

  if (projections.has("kumu")) {
    fs.writeFileSync(path.join(outDir, "kumu-elements.csv"), renderKumuElements(image));
    fs.writeFileSync(path.join(outDir, "kumu-connections.csv"), renderKumuConnections(image));
  }
  if (projections.has("neo4j")) {
    fs.writeFileSync(path.join(outDir, "neo4j.cypher"), renderNeo4jCypher(image));
  }
  if (projections.has("structurizr")) {
    fs.writeFileSync(path.join(outDir, "structurizr.dsl"), renderStructurizr(image));
  }
  if (projections.has("symphony")) {
    fs.writeFileSync(path.join(outDir, "symphony-handoff.md"), renderRefinementPacket(image));
  }

  const command = args.command === "image" ? "play" : args.command;
  process.stdout.write(`Basis ${command} state written to ${outDir}\n`);
  process.stdout.write(`nodes=${image.stats.nodeCount} edges=${image.stats.edgeCount} findings=${image.stats.findingCount}\n`);
  process.stdout.write(`score=${image.environment.score}\n`);
  if (command === "step") {
    process.stdout.write(`actor=${args.actor} action=${args.action ?? "unspecified"} claim=${args.claim ?? "unspecified"}\n`);
  }
  if (command === "rollout" && args.policy) {
    process.stdout.write(`policy=${args.policy}\n`);
  }
  if (projections.size) {
    process.stdout.write(`projections=${Array.from(projections).join(",")}\n`);
  }
}

const invokedPath = process.argv[1] ? path.resolve(process.argv[1]) : "";
if (invokedPath === fileURLToPath(import.meta.url)) {
  main(process.argv.slice(2)).catch((error) => {
    process.stderr.write(`${error.stack ?? error.message}\n`);
    process.exitCode = 1;
  });
}

export {
  renderCritique,
  renderRefinementPacket,
  renderRefinementPacket as renderExecutionPacket,
  renderKumuConnections,
  renderKumuElements,
  renderLean,
  renderNeo4jCypher,
  renderStructurizr,
  loadProjectionSpecs,
  renderProjection,
  buildProjectionCycleTrainingPlan,
  normalizeProjections
};
