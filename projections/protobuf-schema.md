---
id: protobuf-schema
title: Protobuf Schema
output: proto
outputPath: spec.proto
types: [protobuf-schema, data-type, protocol]
inputForms: [dataified_spec, claim]
matchNodeTypes: [claim, requirement, component, dependency]
keywords: [proto, protobuf, message, enum, schema, field, type, api, request, response, event]
---

# Protobuf Schema

Derive a `.proto` schema from explicit data, protocol, request, response, and
event claims in the spec.

The projection should keep uncertain message or field names as comments or
questions rather than silently committing to an invented interface.
