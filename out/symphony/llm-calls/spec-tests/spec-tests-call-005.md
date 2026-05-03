You are executing Spec Gym projection `spec-tests`: Spec To Test Suite Draft.

Projection instructions:
# Spec To Test Suite Draft

Transform source-backed spec claims into a draft test plan or executable-test
outline.

The projection should prefer acceptance tests, negative tests, invariants, and
regression checks grounded in requirements, risks, and findings. It must keep
untestable requirements as questions instead of inventing passing tests.

Output contract:
- Format: markdown
- Final artifact path after merge: tests/spec-derived-tests.md
- Type contracts: test-suite

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
    "id": "claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup",
    "type": "claim",
    "title": "Startup terminal cleanup failure: log warning and continue startup.",
    "text": "Startup terminal cleanup failure: log warning and continue startup.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1197,
      "lineEnd": 1197
    }
  },
  {
    "id": "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh",
    "type": "risk",
    "title": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "text": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1242,
      "lineEnd": 1242
    }
  },
  {
    "id": "claim-13-1-logging-conventions-include-concise-failure-reason-when-present",
    "type": "claim",
    "title": "Include concise failure reason when present.",
    "text": "Include concise failure reason when present.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1261,
      "lineEnd": 1261
    }
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "requirement",
    "title": "Operators MUST be able to see startup/validation/dispatch failures without attaching...",
    "text": "Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1270,
      "lineEnd": 1270
    }
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance",
    "type": "requirement",
    "title": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "text": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "normative": [
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1349,
      "lineEnd": 1349
    }
  },
  {
    "id": "risk-14-1-failure-classes-workspace-directory-creation-failure",
    "type": "risk",
    "title": "Workspace directory creation failure",
    "text": "Workspace directory creation failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1527,
      "lineEnd": 1527
    }
  },
  {
    "id": "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
    "type": "risk",
    "title": "Workspace population/synchronization failure (implementation-defined; can come from h...",
    "text": "Workspace population/synchronization failure (implementation-defined; can come from hooks)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1528,
      "lineEnd": 1528
    }
  },
  {
    "id": "risk-14-1-failure-classes-hook-timeout-failure",
    "type": "risk",
    "title": "Hook timeout/failure",
    "text": "Hook timeout/failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1530,
      "lineEnd": 1530
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0629-heading-11-4-error-handling-contract",
    "type": "heading",
    "lineStart": 1181,
    "lineEnd": 1181,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.4 Error Handling Contract"
  },
  {
    "id": "block-0637-list-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick-running-state-refre",
    "type": "list",
    "lineStart": 1196,
    "lineEnd": 1198,
    "generatedClaimIds": [
      "claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running",
      "claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup"
    ],
    "rawMarkdown": "- Candidate fetch failure: log and skip dispatch for this tick.\n- Running-state refresh failure: log and keep active workers running.\n- Startup terminal cleanup failure: log warning and continue startup."
  },
  {
    "id": "block-0663-heading-12-4-failure-semantics",
    "type": "heading",
    "lineStart": 1238,
    "lineEnd": 1238,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 12.4 Failure Semantics"
  },
  {
    "id": "block-0667-list-fail-the-run-attempt-immediately-let-the-orchestrator-treat-it-like-any-other-wo",
    "type": "list",
    "lineStart": 1242,
    "lineEnd": 1243,
    "generatedClaimIds": [
      "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh"
    ],
    "rawMarkdown": "- Fail the run attempt immediately.\n- Let the orchestrator treat it like any other worker failure and decide retry behavior."
  },
  {
    "id": "block-0671-heading-13-1-logging-conventions",
    "type": "heading",
    "lineStart": 1247,
    "lineEnd": 1247,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.1 Logging Conventions"
  },
  {
    "id": "block-0683-list-use-stable-key-value-phrasing-include-action-outcome-completed-failed-retryin",
    "type": "list",
    "lineStart": 1260,
    "lineEnd": 1263,
    "generatedClaimIds": [
      "claim-13-1-logging-conventions-include-action-outcome-completed-failed-retrying-etc",
      "claim-13-1-logging-conventions-include-concise-failure-reason-when-present",
      "claim-13-1-logging-conventions-avoid-logging-large-raw-payloads-unless-necessary"
    ],
    "rawMarkdown": "- Use stable `key=value` phrasing.\n- Include action outcome (`completed`, `failed`, `retrying`, etc.).\n- Include concise failure reason when present.\n- Avoid logging large raw payloads unless necessary."
  },
  {
    "id": "block-0685-heading-13-2-logging-outputs-and-sinks",
    "type": "heading",
    "lineStart": 1265,
    "lineEnd": 1265,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.2 Logging Outputs and Sinks"
  },
  {
    "id": "block-0690-blank-blank",
    "type": "blank",
    "lineStart": 1270,
    "lineEnd": 1270,
    "generatedClaimIds": [
      "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0731-heading-13-7-optional-http-server-extension",
    "type": "heading",
    "lineStart": 1344,
    "lineEnd": 1344,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.7 OPTIONAL HTTP Server Extension"
  },
  {
    "id": "block-0736-blank-blank",
    "type": "blank",
    "lineStart": 1349,
    "lineEnd": 1349,
    "generatedClaimIds": [
      "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance"
    ],
    "rawMarkdown": ""
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
    "id": "block-0773-list-2-workspace-failures-workspace-directory-creation-failure-workspace-population-s",
    "type": "list",
    "lineStart": 1527,
    "lineEnd": 1531,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-workspace-directory-creation-failure",
      "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
      "risk-14-1-failure-classes-invalid-workspace-path-configuration",
      "risk-14-1-failure-classes-hook-timeout-failure"
    ],
    "rawMarkdown": "2. `Workspace Failures`\n   - Workspace directory creation failure\n   - Workspace population/synchronization failure (implementation-defined; can come from hooks)\n   - Invalid workspace path configuration\n   - Hook timeout/failure"
  }
]
```
