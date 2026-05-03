---
id: network-requirements
title: Network Requirements
output: json
outputPath: projections/network-requirements.json
types: [requirement]
inputForms: [claim]
matchNodeTypes: [requirement, dependency, risk, test]
keywords: [network, protocol, transport, socket, server, client, timeout, retry, backoff, port, host, tls, auth, grpc, http, websocket]
---

# Network Requirements

Extract all requirements, dependencies, risks, and validation surfaces related
to networking.

The projection should include source-backed requirements first, then inferred
network obligations and missing validation questions.
