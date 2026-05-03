---
id: spec-tests
title: Spec To Test Suite Draft
output: markdown
outputPath: tests/spec-derived-tests.md
types: [test-suite]
inputForms: [dataified_spec, claim]
trainableWith: [tests-to-spec]
matchNodeTypes: [requirement, test, risk, finding, claim]
keywords: [test, validation, verify, conformance, acceptance, invariant, failure, reject, proof, check]
---

# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.
