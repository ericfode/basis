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
    "id": "risk-14-1-failure-classes-startup-handshake-failure",
    "type": "risk",
    "title": "Startup handshake failure",
    "text": "Startup handshake failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1533,
      "lineEnd": 1533
    }
  },
  {
    "id": "risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p",
    "type": "risk",
    "title": "User input requested and handled as failure by the implementation's documented policy",
    "text": "User input requested and handled as failure by the implementation's documented policy",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1536,
      "lineEnd": 1536
    }
  },
  {
    "id": "risk-14-1-failure-classes-log-sink-configuration-failure",
    "type": "risk",
    "title": "Log sink configuration failure",
    "text": "Log sink configuration failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1549,
      "lineEnd": 1549
    }
  },
  {
    "id": "risk-14-2-recovery-behavior-dispatch-validation-failures",
    "type": "risk",
    "title": "Dispatch validation failures:",
    "text": "Dispatch validation failures:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1553,
      "lineEnd": 1553
    }
  },
  {
    "id": "risk-15-1-trust-boundary-assumption-workspace-isolation-and-path-validation-are-important-baseline-controls-but-they",
    "type": "risk",
    "title": "Workspace isolation and path validation are important baseline controls, but they are...",
    "text": "Workspace isolation and path validation are important baseline controls, but they are not a substitute for whatever approval and sandbox policy an implementation chooses.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1613,
      "lineEnd": 1613
    }
  },
  {
    "id": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "type": "test",
    "title": "Core Conformance: deterministic tests REQUIRED for all conforming implementations.",
    "text": "`Core Conformance`: deterministic tests REQUIRED for all conforming implementations.",
    "normative": [
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1921,
      "lineEnd": 1921
    }
  },
  {
    "id": "test-17-test-and-validation-matrix-extension-conformance-required-only-for-optional-features-that-an-implementation",
    "type": "test",
    "title": "Extension Conformance: REQUIRED only for OPTIONAL features that an implementation cho...",
    "text": "`Extension Conformance`: REQUIRED only for OPTIONAL features that an implementation chooses to ship.",
    "normative": [
      "REQUIRED",
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1922,
      "lineEnd": 1922
    }
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear",
    "type": "claim",
    "title": "tracker.kind validation enforces currently supported kind (linear)",
    "text": "`tracker.kind` validation enforces currently supported kind (`linear`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1942,
      "lineEnd": 1942
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0775-list-3-agent-session-failures-startup-handshake-failure-turn-failed-cancelled-turn",
    "type": "list",
    "lineStart": 1533,
    "lineEnd": 1539,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-startup-handshake-failure",
      "risk-14-1-failure-classes-turn-failed-cancelled",
      "risk-14-1-failure-classes-turn-timeout",
      "risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p",
      "risk-14-1-failure-classes-subprocess-exit",
      "risk-14-1-failure-classes-stalled-session-no-activity"
    ],
    "rawMarkdown": "3. `Agent Session Failures`\n   - Startup handshake failure\n   - Turn failed/cancelled\n   - Turn timeout\n   - User input requested and handled as failure by the implementation's documented policy\n   - Subprocess exit\n   - Stalled session (no activity)"
  },
  {
    "id": "block-0779-list-5-observability-failures-snapshot-timeout-dashboard-render-errors-log-sink-con",
    "type": "list",
    "lineStart": 1547,
    "lineEnd": 1550,
    "generatedClaimIds": [
      "risk-14-1-failure-classes-snapshot-timeout",
      "risk-14-1-failure-classes-dashboard-render-errors",
      "risk-14-1-failure-classes-log-sink-configuration-failure"
    ],
    "rawMarkdown": "5. `Observability Failures`\n   - Snapshot timeout\n   - Dashboard render errors\n   - Log sink configuration failure"
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
    "id": "block-0782-blank-blank",
    "type": "blank",
    "lineStart": 1553,
    "lineEnd": 1553,
    "generatedClaimIds": [
      "risk-14-2-recovery-behavior-dispatch-validation-failures"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0809-heading-15-1-trust-boundary-assumption",
    "type": "heading",
    "lineStart": 1604,
    "lineEnd": 1604,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.1 Trust Boundary Assumption"
  },
  {
    "id": "block-0815-list-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir",
    "type": "list",
    "lineStart": 1610,
    "lineEnd": 1615,
    "generatedClaimIds": [
      "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-rely-on-auto-approved-actions-",
      "risk-15-1-trust-boundary-assumption-workspace-isolation-and-path-validation-are-important-baseline-controls-but-they"
    ],
    "rawMarkdown": "- Implementations SHOULD state clearly whether they are intended for trusted environments, more\n  restrictive environments, or both.\n- Implementations SHOULD state clearly whether they rely on auto-approved actions, operator\n  approvals, stricter sandboxing, or some combination of those controls.\n- Workspace isolation and path validation are important baseline controls, but they are not a\n  substitute for whatever approval and sandbox policy an implementation chooses."
  },
  {
    "id": "block-0879-heading-17-test-and-validation-matrix",
    "type": "heading",
    "lineStart": 1915,
    "lineEnd": 1915,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "## 17. Test and Validation Matrix"
  },
  {
    "id": "block-0884-blank-blank",
    "type": "blank",
    "lineStart": 1921,
    "lineEnd": 1921,
    "generatedClaimIds": [
      "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0885-list-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "type": "list",
    "lineStart": 1922,
    "lineEnd": 1926,
    "generatedClaimIds": [
      "test-17-test-and-validation-matrix-extension-conformance-required-only-for-optional-features-that-an-implementation",
      "test-17-test-and-validation-matrix-real-integration-profile-environment-dependent-smoke-integration-checks-recommen"
    ],
    "rawMarkdown": "- `Core Conformance`: deterministic tests REQUIRED for all conforming implementations.\n- `Extension Conformance`: REQUIRED only for OPTIONAL features that an implementation chooses to\n  ship.\n- `Real Integration Profile`: environment-dependent smoke/integration checks RECOMMENDED before\n  production use."
  },
  {
    "id": "block-0889-heading-17-1-workflow-and-config-parsing",
    "type": "heading",
    "lineStart": 1931,
    "lineEnd": 1931,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.1 Workflow and Config Parsing"
  },
  {
    "id": "block-0891-list-workflow-file-path-precedence-explicit-runtime-path-is-used-when-provided-cwd",
    "type": "list",
    "lineStart": 1933,
    "lineEnd": 1950,
    "generatedClaimIds": [
      "claim-17-1-workflow-and-config-parsing-explicit-runtime-path-is-used-when-provided",
      "claim-17-1-workflow-and-config-parsing-cwd-default-is-workflow-md-when-no-explicit-runtime-path-is-provided",
      "claim-17-1-workflow-and-config-parsing-workflow-file-changes-are-detected-and-trigger-re-read-re-apply-without-restart",
      "claim-17-1-workflow-and-config-parsing-invalid-workflow-reload-keeps-last-known-good-effective-configuration-and-emits-",
      "claim-17-1-workflow-and-config-parsing-missing-workflow-md-returns-typed-error",
      "claim-17-1-workflow-and-config-parsing-invalid-yaml-front-matter-returns-typed-error",
      "claim-17-1-workflow-and-config-parsing-front-matter-non-map-returns-typed-error",
      "requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing",
      "claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear",
      "claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection",
      "dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values",
      "claim-17-1-workflow-and-config-parsing-path-expansion-works",
      "claim-17-1-workflow-and-config-parsing-codex-command-is-preserved-as-a-shell-command-string",
      "claim-17-1-workflow-and-config-parsing-per-state-concurrency-override-map-normalizes-state-names-and-ignores-invalid-va",
      "claim-17-1-workflow-and-config-parsing-prompt-template-renders-issue-and-attempt",
      "claim-17-1-workflow-and-config-parsing-prompt-rendering-fails-on-unknown-variables-strict-mode"
    ],
    "rawMarkdown": "- Workflow file path precedence:\n  - explicit runtime path is used when provided\n  - cwd default is `WORKFLOW.md` when no explicit runtime path is provided\n- Workflow file changes are detected and trigger re-read/re-apply without restart\n- Invalid workflow reload keeps last known good effective configuration and emits an\n  operator-visible error\n- Missing `WORKFLOW.md` returns typed error\n- Invalid YAML front matter returns typed error\n- Front matter non-map returns typed error\n- Config defaults apply when OPTIONAL values are missing\n- `tracker.kind` validation enforces currently supported kind (`linear`)\n- `tracker.api_key` works (including `$VAR` indirection)\n- `$VAR` resolution works for tracker API key and path values\n- `~` path expansion works\n- `codex.command` is preserved as a shell command string\n- Per-state concurrency override map normalizes state names and ignores invalid values\n- Prompt template renders `issue` and `attempt`\n- Prompt rendering fails on unknown variables (strict mode)"
  }
]
```
