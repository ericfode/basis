---
id: aws-architecture
title: AWS Architecture Document
output: markdown
outputPath: architecture.md
types: [architecture-document]
inputForms: [dataified_spec, claim]
trainableWith: [architecture-to-spec]
matchNodeTypes: [component, dependency, risk, test, requirement]
keywords: [architecture, component, service, dependency, queue, storage, database, network, auth, api, worker, scheduler]
---

# AWS Architecture Document

Transform the spec into an `architecture.md` document using AWS vocabulary.

The projection should map spec components and dependencies to plausible AWS
service roles only when the source supports the mapping. Unsupported mappings
should remain questions instead of invented architecture.
