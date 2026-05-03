You are executing Spec Gym projection `aws-architecture`: AWS Architecture Document.

Projection instructions:
# AWS Architecture Document

Transform the spec into an `architecture.md` document using AWS vocabulary.

The projection should map spec components and dependencies to plausible AWS
service roles only when the source supports the mapping. Unsupported mappings
should remain questions instead of invented architecture.

Output contract:
- Format: markdown
- Final artifact path after merge: architecture.md
- Type contracts: architecture-document

Rules:
- Use only the source slice below.
- Preserve source anchors for every emitted item.
- Mark inferred items explicitly.
- Do not fill missing facts with invented certainty.
- Return only the partial projection payload for this slice.

Source nodes:
```json
[
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
    "type": "dependency",
    "title": "API errors SHOULD use a JSON envelope such as {\"error\":{\"code\":\"...\",\"message\":\"...\"}}.",
    "text": "API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1512,
      "lineEnd": 1512
    }
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup",
    "type": "dependency",
    "title": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplica...",
    "text": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state logic.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1513,
      "lineEnd": 1513
    }
  },
  {
    "id": "risk-14-1-failure-classes-api-transport-errors",
    "type": "risk",
    "title": "API transport errors",
    "text": "API transport errors",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1541,
      "lineEnd": 1541
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-keep-service-alive",
    "type": "risk",
    "title": "Keep service alive.",
    "text": "Keep service alive.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1555,
      "lineEnd": 1555
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-worker-failures",
    "type": "risk",
    "title": "Worker failures:",
    "text": "Worker failures:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1558,
      "lineEnd": 1558
    }
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-service-recovers-by",
    "type": "risk",
    "title": "Service recovers by:",
    "text": "Service recovers by:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1583,
      "lineEnd": 1583
    }
  },
  {
    "id": "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
    "type": "dependency",
    "title": "Do not log API tokens or secret env values.",
    "text": "Do not log API tokens or secret env values.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1633,
      "lineEnd": 1633
    }
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
    "type": "risk",
    "title": "Adding external isolation layers such as OS/container/VM sandboxing, network restrict...",
    "text": "Adding external isolation layers such as OS/container/VM sandboxing, network restrictions, or separate credentials beyond the built-in Codex policy controls.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1663,
      "lineEnd": 1663
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0751-heading-13-7-2-json-rest-api-api-v1",
    "type": "heading",
    "lineStart": 1381,
    "lineEnd": 1381,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 13.7.2 JSON REST API (`/api/v1/*`)"
  },
  {
    "id": "block-0765-list-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "list",
    "lineStart": 1509,
    "lineEnd": 1515,
    "generatedClaimIds": [
      "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
      "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
      "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
      "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
      "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup"
    ],
    "rawMarkdown": "- The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging ergonomics.\n- Implementations MAY add fields, but SHOULD avoid breaking existing fields within a version.\n- Endpoints SHOULD be read-only except for operational triggers like `/refresh`.\n- Unsupported methods on defined routes SHOULD return `405 Method Not Allowed`.\n- API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.\n- If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state\n  logic."
  },
  {
    "id": "block-0769-heading-14-1-failure-classes",
    "type": "heading",
    "lineStart": 1519,
    "lineEnd": 1519,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.1 Failure Classes"
  },
  {
    "id": "block-0777-list-4-tracker-failures-api-transport-errors-non-200-status-graphql-errors-malfor",
    "type": "list",
    "lineStart": 1541,
    "lineEnd": 1545,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-api-transport-errors",
      "risk-14-1-failure-classes-non-200-status",
      "risk-14-1-failure-classes-graphql-errors",
      "risk-14-1-failure-classes-malformed-payloads"
    ],
    "rawMarkdown": "4. `Tracker Failures`\n   - API transport errors\n   - Non-200 status\n   - GraphQL errors\n   - malformed payloads"
  },
  {
    "id": "block-0781-heading-14-2-recovery-behavior",
    "type": "heading",
    "lineStart": 1552,
    "lineEnd": 1552,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.2 Recovery Behavior"
  },
  {
    "id": "block-0783-list-dispatch-validation-failures-skip-new-dispatches-keep-service-alive-contin",
    "type": "list",
    "lineStart": 1554,
    "lineEnd": 1557,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-skip-new-dispatches",
      "risk-14-2-recovery-behavior-keep-service-alive",
      "risk-14-2-recovery-behavior-continue-reconciliation-where-possible"
    ],
    "rawMarkdown": "- Dispatch validation failures:\n  - Skip new dispatches.\n  - Keep service alive.\n  - Continue reconciliation where possible."
  },
  {
    "id": "block-0784-blank-blank",
    "type": "blank",
    "lineStart": 1558,
    "lineEnd": 1558,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-worker-failures"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0793-heading-14-3-partial-state-recovery-restart",
    "type": "heading",
    "lineStart": 1573,
    "lineEnd": 1573,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 14.3 Partial State Recovery (Restart)"
  },
  {
    "id": "block-0799-list-no-retry-timers-are-restored-from-prior-process-memory-no-running-sessions-are-a",
    "type": "list",
    "lineStart": 1582,
    "lineEnd": 1587,
    "generatedClaimIds": [
      "risk-14-3-partial-state-recovery-restart-no-running-sessions-are-assumed-recoverable",
      "risk-14-3-partial-state-recovery-restart-service-recovers-by",
      "risk-14-3-partial-state-recovery-restart-startup-terminal-workspace-cleanup",
      "risk-14-3-partial-state-recovery-restart-fresh-polling-of-active-issues",
      "risk-14-3-partial-state-recovery-restart-re-dispatching-eligible-work"
    ],
    "rawMarkdown": "- No retry timers are restored from prior process memory.\n- No running sessions are assumed recoverable.\n- Service recovers by:\n  - startup terminal workspace cleanup\n  - fresh polling of active issues\n  - re-dispatching eligible work"
  },
  {
    "id": "block-0827-heading-15-3-secret-handling",
    "type": "heading",
    "lineStart": 1631,
    "lineEnd": 1631,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.3 Secret Handling"
  },
  {
    "id": "block-0829-list-support-var-indirection-in-workflow-config-do-not-log-api-tokens-or-secret-env",
    "type": "list",
    "lineStart": 1633,
    "lineEnd": 1635,
    "generatedClaimIds": [
      "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
      "test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them"
    ],
    "rawMarkdown": "- Support `$VAR` indirection in workflow config.\n- Do not log API tokens or secret env values.\n- Validate presence of secrets without printing them."
  },
  {
    "id": "block-0839-heading-15-5-harness-hardening-guidance",
    "type": "heading",
    "lineStart": 1648,
    "lineEnd": 1648,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.5 Harness Hardening Guidance"
  },
  {
    "id": "block-0847-list-tightening-codex-approval-and-sandbox-settings-described-elsewhere-in-this-speci",
    "type": "list",
    "lineStart": 1662,
    "lineEnd": 1671,
    "generatedClaimIds": [
      "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
      "risk-15-5-harness-hardening-guidance-filtering-which-linear-issues-projects-teams-labels-or-other-tracker-sources-are",
      "risk-15-5-harness-hardening-guidance-narrowing-the-lineargraphql-tool-so-it-can-only-read-or-mutate-data-inside-the-i",
      "risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d"
    ],
    "rawMarkdown": "- Tightening Codex approval and sandbox settings described elsewhere in this specification instead\n  of running with a maximally permissive configuration.\n- Adding external isolation layers such as OS/container/VM sandboxing, network restrictions, or\n  separate credentials beyond the built-in Codex policy controls.\n- Filtering which Linear issues, projects, teams, labels, or other tracker sources are eligible for\n  dispatch so untrusted or out-of-scope tasks do not automatically reach the agent.\n- Narrowing the `linear_graphql` tool so it can only read or mutate data inside the\n  intended project scope, rather than exposing general workspace-wide tracker access.\n- Reducing the set of client-side tools, credentials, filesystem paths, and network destinations\n  available to the agent to the minimum needed for the workflow."
  }
]
```
