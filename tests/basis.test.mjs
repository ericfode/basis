import assert from "node:assert/strict";
import { test } from "node:test";
import {
  buildDataifiedSpec,
  buildBasisState,
  renderCritique,
  renderRefinementPacket,
  renderKumuConnections,
  renderKumuElements,
  renderLean,
  renderNeo4jCypher,
  renderProjection,
  renderStructurizr,
  buildProjectionCycleTrainingPlan,
  loadProjectionSpecs,
  normalizeProjections
} from "../src/basis.mjs";
import {
  optimizeHistoricalSpecPrompt,
  pickHistoricalSamples
} from "../src/historical-spec.mjs";

const SAMPLE = `# Sample Spec

## Problem

The current process hides contradictions until prototype time.

## Goals

- The tool MUST extract claims.
- The tool MUST NOT extract claims.
- The tool SHOULD expose an explorable claim lattice.

## Components

- Parser.
- Claim lattice.

## Validation

- A generated graph MUST contain one goal.
`;

test("builds a Basis state from a markdown specification", () => {
  const image = buildBasisState(SAMPLE, "sample.md");

  assert.equal(image.schemaVersion, "basis.claim-lattice.v0");
  assert.equal(image.stats.hasProblem, true);
  assert.equal(image.stats.hasGoals, true);
  assert.equal(image.stats.hasValidation, true);
  assert.ok(image.nodes.some((node) => node.type === "goal"));
  assert.ok(image.nodes.some((node) => node.type === "test"));
  assert.ok(image.findings.some((finding) => finding.class === "impossible"));
});

test("builds a dataified spec that preserves raw markdown blocks", () => {
  const dataified = buildDataifiedSpec(SAMPLE, "sample.md");

  assert.equal(dataified.schemaVersion, "basis.dataified-spec.v0");
  assert.equal(dataified.source.sha256.length, 64);
  assert.ok(dataified.blocks.some((block) => block.type === "heading" && block.rawMarkdown === "# Sample Spec"));
  assert.ok(dataified.blocks.some((block) => block.type === "list" && block.rawMarkdown.includes("MUST extract claims")));
  assert.equal(dataified.reconstruction.acceptStepRequired, true);
});

test("renders critique and lean draft", () => {
  const image = buildBasisState(SAMPLE, "sample.md");
  const critique = renderCritique(image);
  const lean = renderLean(image);

  assert.match(critique, /Viability Critique/);
  assert.match(critique, /Normative statements appear to conflict/);
  assert.match(lean, /inductive BadIdeaClass/);
  assert.match(lean, /def generatedStats/);
});

test("renders external tool projections and handoff packet", () => {
  const image = buildBasisState(SAMPLE, "sample.md");

  assert.match(renderKumuElements(image), /^Label,Type,Title,/);
  assert.match(renderKumuConnections(image), /^From,To,Type,/);
  assert.match(renderNeo4jCypher(image), /MERGE \(n:ClaimLatticeNode/);
  assert.match(renderStructurizr(image), /workspace "Basis:/);
  assert.match(renderRefinementPacket(image), /## Player Procedure/);
  assert.doesNotMatch(renderRefinementPacket(image), /Kumu import|Neo4j import|Structurizr projection/);
});

test("loads markdown projection specs and renders a projection", () => {
  const image = buildBasisState(SAMPLE, "sample.md");
  const dataified = buildDataifiedSpec(SAMPLE, "sample.md", { claimNodes: image.nodes });
  const specs = loadProjectionSpecs(process.cwd());
  const projection = specs.get("network-requirements");

  assert.ok(projection);
  assert.equal(projection.output, "json");
  const plan = JSON.parse(renderProjection(projection, image, dataified));
  assert.equal(plan.schemaVersion, "basis.llm-projection-plan.v0");
  assert.equal(plan.projection.id, "network-requirements");
  assert.equal(plan.execution.contentGeneration, "llm_only");
  assert.ok(plan.calls.length > 0);
});

test("normalizes projections explicitly", () => {
  const specs = loadProjectionSpecs(process.cwd());

  assert.deepEqual(Array.from(normalizeProjections([])), []);
  assert.deepEqual(Array.from(normalizeProjections(["kumu,neo4j"], specs)), ["kumu", "neo4j"]);
  assert.deepEqual(Array.from(normalizeProjections(["network_requirements"], specs)), ["network-requirements"]);
  assert.ok(Array.from(normalizeProjections(["all"], specs)).includes("network-requirements"));
  assert.ok(Array.from(normalizeProjections(["all"], specs)).includes("spec-tests"));
  assert.ok(!Array.from(normalizeProjections(["all"], specs)).includes("architecture-to-spec"));
  assert.ok(!Array.from(normalizeProjections(["all"], specs)).includes("tests-to-spec"));
  assert.ok(!Array.from(normalizeProjections(["all"], specs)).includes("code-to-spec"));
  assert.ok(Array.from(normalizeProjections(["architecture-to-spec"], specs)).includes("architecture-to-spec"));
  assert.ok(Array.from(normalizeProjections(["tests-to-spec"], specs)).includes("tests-to-spec"));
  assert.ok(Array.from(normalizeProjections(["code-to-spec"], specs)).includes("code-to-spec"));
  assert.throws(() => normalizeProjections(["unknown"], specs), /Unknown projection/);
});

test("builds a trainable projection cycle plan", () => {
  const image = buildBasisState(SAMPLE, "sample.md");
  const dataified = buildDataifiedSpec(SAMPLE, "sample.md", { claimNodes: image.nodes });
  const specs = loadProjectionSpecs(process.cwd());
  const plan = buildProjectionCycleTrainingPlan(
    specs.get("aws-architecture"),
    specs.get("architecture-to-spec"),
    image,
    dataified,
    { iterations: 2 }
  );

  assert.equal(plan.schemaVersion, "basis.projection-cycle-training-plan.v0");
  assert.equal(plan.cycleId, "aws-architecture__architecture-to-spec");
  assert.equal(plan.rounds.length, 2);
  assert.equal(plan.forward.outputPath, "architecture.md");
  assert.equal(plan.reverse.outputPath, "spec-draft.md");
  assert.match(plan.rounds[0].reverse.callPath, /architecture-to-spec-call-001\.json$/);
  assert.match(plan.rounds[0].judge.promptPath, /judge\.md$/);
  assert.equal(plan.acceptance.deterministicOutputRequired, false);
});

test("picks historical samples with the root and target preserved", () => {
  const commits = ["c0", "c1", "c2", "c3", "c4", "c5"];

  assert.deepEqual(pickHistoricalSamples(commits, 3), ["c0", "c3", "c5"]);
  assert.deepEqual(pickHistoricalSamples(commits, 8), commits);
});

test("optimizes a historical spec prompt toward root-stable essence", () => {
  const snapshots = [
    {
      commit: "root",
      short: "root",
      date: "2009-03-22 00:00:00 +0000",
      timestamp: 1237680000,
      subject: "first commit",
      features: [
        feature("networked_command_server", "Networked command server", 10),
        feature("in_memory_primary_dataset", "In-memory primary dataset", 10)
      ]
    },
    {
      commit: "middle",
      short: "middle",
      date: "2013-01-01 00:00:00 +0000",
      timestamp: 1356998400,
      subject: "middle",
      features: [
        feature("networked_command_server", "Networked command server", 10),
        feature("in_memory_primary_dataset", "In-memory primary dataset", 10),
        feature("cluster_mode", "Cluster mode", 5)
      ]
    },
    {
      commit: "head",
      short: "head",
      date: "2026-01-01 00:00:00 +0000",
      timestamp: 1767225600,
      subject: "head",
      features: [
        feature("networked_command_server", "Networked command server", 10),
        feature("in_memory_primary_dataset", "In-memory primary dataset", 10),
        feature("cluster_mode", "Cluster mode", 5)
      ]
    }
  ];

  const loop = optimizeHistoricalSpecPrompt(snapshots, { iterations: 2 });

  assert.ok(loop.best.candidate.selectedFeatureIds.includes("networked_command_server"));
  assert.ok(loop.best.candidate.selectedFeatureIds.includes("in_memory_primary_dataset"));
  assert.equal(loop.best.judgement.firstInvalid, null);
  assert.ok(!loop.best.candidate.selectedFeatureIds.includes("cluster_mode"));
});

function feature(id, title, essenceWeight) {
  return {
    id,
    title,
    category: id === "cluster_mode" ? "extension" : "core",
    essenceWeight,
    claim: `${title} claim.`,
    evidence: {
      paths: [`${id}.c`],
      textSignals: []
    }
  };
}
