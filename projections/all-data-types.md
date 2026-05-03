---
id: all-data-types
title: All Data Types
output: json
outputPath: projections/all-data-types.json
types: [data-type]
inputForms: [dataified_spec, claim]
matchNodeTypes: [claim, requirement, component, dependency]
keywords: [data, type, schema, field, message, model, json, proto, protobuf, struct, enum]
---

# All Data Types

Extract every data type, field, schema, enum, message, model, and structured
payload implied by the spec.

The projection should preserve source anchors and distinguish explicit source
text from inferred type candidates.
