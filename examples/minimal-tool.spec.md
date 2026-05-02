# Spec Gym Mini Example

Status: Draft.

## Problem

Teams write long specifications, then discover contradictions only after a
prototype exists.

## Goals

- The tool MUST extract addressable claims from Markdown.
- The tool SHOULD expose the claim lattice as an inspectable graph projection.
- The tool MUST emit a prover-facing mock model.

## Non-Goals

- The tool MUST NOT implement the final target system.
- The tool does not replace human review.

## Components

- Parser.
- Claim lattice.
- Bad-idea evaluator.
- Prover emitter.

## Validation

- A generated claim lattice MUST contain at least one goal node.
- A generated viability critique MUST list findings with evidence.
