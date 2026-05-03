---
id: tests-to-spec
title: Tests To Spec Draft
output: markdown
outputPath: spec-draft.md
types: [spec-draft]
inputForms: [test_suite, code_slice]
includeInAll: false
reverseOf: spec-tests
matchNodeTypes: [test, requirement, risk, claim]
keywords: [test, assert, expect, fixture, mock, should, must, invariant, regression, acceptance, failure]
---

# Tests To Spec Draft

Infer a reviewable `spec.md` draft from focused tests or test-plan slices.

The projection should describe behavior proven by tests, behavior implied by
fixtures, explicit negative cases, missing product intent, and open questions.
It must distinguish observed test behavior from inferred requirements and keep
file, line, or case anchors.
