---
id: architecture-to-spec
title: Architecture Document To Spec Draft
output: markdown
outputPath: spec-draft.md
types: [spec-draft]
inputForms: [architecture_document, markdown]
includeInAll: false
reverseOf: aws-architecture
matchNodeTypes: [component, dependency, requirement, risk, test, claim]
keywords: [architecture, component, service, dependency, aws, network, queue, storage, database, api, worker, scheduler]
---

# Architecture Document To Spec Draft

Infer a reviewable `spec.md` draft from an architecture document.

The projection should preserve architecture sections, source anchors, open
questions, assumptions, and unsupported mappings. It should reconstruct
problem, goals, requirements, components, dependencies, validation, risks, and
open questions only when they are supported by the architecture source. It must
mark inferred product intent explicitly.
