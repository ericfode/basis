---
id: all-protocols
title: All Protocols
output: json
outputPath: projections/all-protocols.json
types: [protocol]
inputForms: [dataified_spec, claim]
matchNodeTypes: [claim, requirement, component, dependency, test]
keywords: [protocol, api, transport, grpc, http, websocket, socket, tcp, udp, protobuf, json, client, server]
---

# All Protocols

Extract every protocol, transport, API boundary, client-server contract, and
wire-format obligation implied by the spec.

The projection should preserve explicit protocol names, source anchors, and
open questions where the protocol is implied but not specified.
