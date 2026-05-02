import assert from "node:assert/strict";
import { test } from "node:test";
import {
  buildSpecGymState,
  renderCritique,
  renderRefinementPacket,
  renderKumuConnections,
  renderKumuElements,
  renderLean,
  renderNeo4jCypher,
  renderStructurizr,
  normalizeProjections
} from "../src/specgym.mjs";

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

test("builds a Spec Gym state from a markdown specification", () => {
  const image = buildSpecGymState(SAMPLE, "sample.md");

  assert.equal(image.schemaVersion, "specgym.claim-lattice.v0");
  assert.equal(image.stats.hasProblem, true);
  assert.equal(image.stats.hasGoals, true);
  assert.equal(image.stats.hasValidation, true);
  assert.ok(image.nodes.some((node) => node.type === "goal"));
  assert.ok(image.nodes.some((node) => node.type === "test"));
  assert.ok(image.findings.some((finding) => finding.class === "impossible"));
});

test("renders critique and lean draft", () => {
  const image = buildSpecGymState(SAMPLE, "sample.md");
  const critique = renderCritique(image);
  const lean = renderLean(image);

  assert.match(critique, /Viability Critique/);
  assert.match(critique, /Normative statements appear to conflict/);
  assert.match(lean, /inductive BadIdeaClass/);
  assert.match(lean, /def generatedStats/);
});

test("renders external tool projections and handoff packet", () => {
  const image = buildSpecGymState(SAMPLE, "sample.md");

  assert.match(renderKumuElements(image), /^Label,Type,Title,/);
  assert.match(renderKumuConnections(image), /^From,To,Type,/);
  assert.match(renderNeo4jCypher(image), /MERGE \(n:ClaimLatticeNode/);
  assert.match(renderStructurizr(image), /workspace "Spec Gym:/);
  assert.match(renderRefinementPacket(image), /## Player Procedure/);
  assert.doesNotMatch(renderRefinementPacket(image), /Kumu import|Neo4j import|Structurizr projection/);
});

test("normalizes projections explicitly", () => {
  assert.deepEqual(Array.from(normalizeProjections([])), []);
  assert.deepEqual(Array.from(normalizeProjections(["kumu,neo4j"])), ["kumu", "neo4j"]);
  assert.deepEqual(Array.from(normalizeProjections(["all"])), ["kumu", "neo4j", "structurizr", "symphony"]);
  assert.throws(() => normalizeProjections(["unknown"]), /Unknown projection/);
});
