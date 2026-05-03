You are executing Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Output contract:
- Format: markdown
- Final artifact path after merge: projections/implementation-questions.md
- Type contracts: implementation-question

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
    "id": "risk-15-5-harness-hardening-guidance-implementations-should-not-assume-that-tracker-data-repository-contents-prompt-i",
    "type": "risk",
    "title": "implementations SHOULD NOT assume that tracker data, repository contents, prompt inpu...",
    "text": "implementations SHOULD NOT assume that tracker data, repository contents, prompt inputs, or tool",
    "normative": [
      "SHOULD NOT"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1656,
      "lineEnd": 1656
    }
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-the-correct-controls-are-deployment-specific-but-implementations-should-document",
    "type": "risk",
    "title": "The correct controls are deployment-specific, but implementations SHOULD document the...",
    "text": "The correct controls are deployment-specific, but implementations SHOULD document them clearly and",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1672,
      "lineEnd": 1672
    }
  },
  {
    "id": "test-17-test-and-validation-matrix-a-conforming-implementation-should-include-tests-that-cover-the-behaviors-define",
    "type": "test",
    "title": "A conforming implementation SHOULD include tests that cover the behaviors defined in...",
    "text": "A conforming implementation SHOULD include tests that cover the behaviors defined in this",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1916,
      "lineEnd": 1916
    }
  },
  {
    "id": "requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing",
    "type": "requirement",
    "title": "Config defaults apply when OPTIONAL values are missing",
    "text": "Config defaults apply when OPTIONAL values are missing",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1941,
      "lineEnd": 1941
    }
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-missing-workspace-directory-is-created",
    "type": "risk",
    "title": "Missing workspace directory is created",
    "text": "Missing workspace directory is created",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1954,
      "lineEnd": 1954
    }
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
    "type": "dependency",
    "title": "invalid arguments, missing auth, and transport failures return structured failure pay...",
    "text": "invalid arguments, missing auth, and transport failures return structured failure payloads",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2023,
      "lineEnd": 2023
    }
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md",
    "type": "dependency",
    "title": "CLI errors on nonexistent explicit workflow path or missing default ./WORKFLOW.md",
    "text": "CLI errors on nonexistent explicit workflow path or missing default `./WORKFLOW.md`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2041,
      "lineEnd": 2041
    }
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-real-integration-tests-should-use-isolated-test-identifiers-workspaces-and-clean",
    "type": "dependency",
    "title": "Real integration tests SHOULD use isolated test identifiers/workspaces and clean up t...",
    "text": "Real integration tests SHOULD use isolated test identifiers/workspaces and clean up tracker artifacts when practical.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2053,
      "lineEnd": 2053
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0843-paragraph-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the",
    "type": "paragraph",
    "lineStart": 1655,
    "lineEnd": 1658,
    "generatedClaimIds": [
      "risk-15-5-harness-hardening-guidance-implementations-should-not-assume-that-tracker-data-repository-contents-prompt-i"
    ],
    "rawMarkdown": "Implementations SHOULD explicitly evaluate their own risk profile and harden the execution harness\nwhere appropriate. This specification intentionally does not mandate a single hardening posture, but\nimplementations SHOULD NOT assume that tracker data, repository contents, prompt inputs, or tool\narguments are fully trustworthy just because they originate inside a normal workflow."
  },
  {
    "id": "block-0848-blank-blank",
    "type": "blank",
    "lineStart": 1672,
    "lineEnd": 1672,
    "generatedClaimIds": [
      "risk-15-5-harness-hardening-guidance-the-correct-controls-are-deployment-specific-but-implementations-should-document"
    ],
    "rawMarkdown": ""
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
    "id": "block-0880-blank-blank",
    "type": "blank",
    "lineStart": 1916,
    "lineEnd": 1916,
    "generatedClaimIds": [
      "test-17-test-and-validation-matrix-a-conforming-implementation-should-include-tests-that-cover-the-behaviors-define"
    ],
    "rawMarkdown": ""
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
  },
  {
    "id": "block-0893-heading-17-2-workspace-manager-and-safety",
    "type": "heading",
    "lineStart": 1952,
    "lineEnd": 1952,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.2 Workspace Manager and Safety"
  },
  {
    "id": "block-0895-list-deterministic-workspace-path-per-issue-identifier-missing-workspace-directory-is",
    "type": "list",
    "lineStart": 1954,
    "lineEnd": 1965,
    "generatedClaimIds": [
      "risk-17-2-workspace-manager-and-safety-missing-workspace-directory-is-created",
      "risk-17-2-workspace-manager-and-safety-existing-workspace-directory-is-reused",
      "risk-17-2-workspace-manager-and-safety-existing-non-directory-path-at-workspace-location-is-handled-safely-replace-or-f",
      "risk-17-2-workspace-manager-and-safety-optional-workspace-population-synchronization-errors-are-surfaced",
      "risk-17-2-workspace-manager-and-safety-aftercreate-hook-runs-only-on-new-workspace-creation",
      "risk-17-2-workspace-manager-and-safety-beforerun-hook-runs-before-each-attempt-and-failure-timeouts-abort-the-current-a",
      "risk-17-2-workspace-manager-and-safety-afterrun-hook-runs-after-each-attempt-and-failure-timeouts-are-logged-and-ignore",
      "risk-17-2-workspace-manager-and-safety-beforeremove-hook-runs-on-cleanup-and-failures-timeouts-are-ignored",
      "risk-17-2-workspace-manager-and-safety-workspace-path-sanitization-and-root-containment-invariants-are-enforced-before-",
      "risk-17-2-workspace-manager-and-safety-agent-launch-uses-the-per-issue-workspace-path-as-cwd-and-rejects-out-of-root-pa"
    ],
    "rawMarkdown": "- Deterministic workspace path per issue identifier\n- Missing workspace directory is created\n- Existing workspace directory is reused\n- Existing non-directory path at workspace location is handled safely (replace or fail per\n  implementation policy)\n- OPTIONAL workspace population/synchronization errors are surfaced\n- `after_create` hook runs only on new workspace creation\n- `before_run` hook runs before each attempt and failure/timeouts abort the current attempt\n- `after_run` hook runs after each attempt and failure/timeouts are logged and ignored\n- `before_remove` hook runs on cleanup and failures/timeouts are ignored\n- Workspace path sanitization and root containment invariants are enforced before agent launch\n- Agent launch uses the per-issue workspace path as cwd and rejects out-of-root paths"
  },
  {
    "id": "block-0905-heading-17-5-coding-agent-app-server-client",
    "type": "heading",
    "lineStart": 1998,
    "lineEnd": 1998,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.5 Coding-Agent App-Server Client"
  },
  {
    "id": "block-0907-list-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command-session-st",
    "type": "list",
    "lineStart": 2000,
    "lineEnd": 2025,
    "generatedClaimIds": [
      "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
      "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
      "dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san",
      "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
      "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
      "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
      "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
      "dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu",
      "dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session",
      "dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol",
      "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
      "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
      "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
      "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
      "dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session",
      "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
      "dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body",
      "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
      "dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session"
    ],
    "rawMarkdown": "- Launch command uses workspace cwd and invokes `bash -lc <codex.command>`\n- Session startup follows the targeted Codex app-server protocol.\n- Client identity/capability payloads are valid when the targeted Codex app-server protocol requires\n  them.\n- Policy-related startup payloads use the implementation's documented approval/sandbox settings\n- Thread and turn identities exposed by the targeted protocol are extracted and used to emit\n  `session_started`\n- Request/response read timeout is enforced\n- Turn timeout is enforced\n- Transport framing required by the targeted protocol is handled correctly\n- For stdio-based transports, diagnostic stderr handling is kept separate from the protocol stream\n- Command/file-change approvals are handled according to the implementation's documented policy\n- Unsupported dynamic tool calls are rejected without stalling the session\n- User input requests are handled according to the implementation's documented policy and do not\n  stall indefinitely\n- Usage and rate-limit telemetry exposed by the targeted protocol is extracted\n- Approval, user-input-required, usage, and rate-limit signals are interpreted according to the\n  targeted protocol\n- If client-side tools are implemented, session startup advertises the supported tool specs\n  using the targeted app-server protocol\n- If the `linear_graphql` client-side tool extension is implemented:\n  - the tool is advertised to the session\n  - valid `query` / `variables` inputs execute against configured Linear auth\n  - top-level GraphQL `errors` produce `success=false` while preserving the GraphQL body\n  - invalid arguments, missing auth, and transport failures return structured failure payloads\n  - unsupported tool names still fail without stalling the session"
  },
  {
    "id": "block-0913-heading-17-7-cli-and-host-lifecycle",
    "type": "heading",
    "lineStart": 2038,
    "lineEnd": 2038,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.7 CLI and Host Lifecycle"
  },
  {
    "id": "block-0915-list-cli-accepts-a-positional-workflow-path-argument-path-to-workflow-md-cli-uses",
    "type": "list",
    "lineStart": 2040,
    "lineEnd": 2045,
    "generatedClaimIds": [
      "dependency-17-7-cli-and-host-lifecycle-cli-uses-workflow-md-when-no-workflow-path-argument-is-provided",
      "dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md",
      "dependency-17-7-cli-and-host-lifecycle-cli-surfaces-startup-failure-cleanly",
      "dependency-17-7-cli-and-host-lifecycle-cli-exits-with-success-when-application-starts-and-shuts-down-normally",
      "dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally"
    ],
    "rawMarkdown": "- CLI accepts a positional workflow path argument (`path-to-WORKFLOW.md`)\n- CLI uses `./WORKFLOW.md` when no workflow path argument is provided\n- CLI errors on nonexistent explicit workflow path or missing default `./WORKFLOW.md`\n- CLI surfaces startup failure cleanly\n- CLI exits with success when application starts and shuts down normally\n- CLI exits nonzero when startup fails or the host process exits abnormally"
  },
  {
    "id": "block-0917-heading-17-8-real-integration-profile-recommended",
    "type": "heading",
    "lineStart": 2047,
    "lineEnd": 2047,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.8 Real Integration Profile (RECOMMENDED)"
  },
  {
    "id": "block-0921-list-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap",
    "type": "list",
    "lineStart": 2052,
    "lineEnd": 2058,
    "generatedClaimIds": [
      "dependency-17-8-real-integration-profile-recommended-real-integration-tests-should-use-isolated-test-identifiers-workspaces-and-clean",
      "dependency-17-8-real-integration-profile-recommended-a-skipped-real-integration-test-should-be-reported-as-skipped-not-silently-treat",
      "dependency-17-8-real-integration-profile-recommended-if-a-real-integration-profile-is-explicitly-enabled-in-ci-or-release-validation-"
    ],
    "rawMarkdown": "- A real tracker smoke test can be run with valid credentials supplied by `LINEAR_API_KEY` or a\n  documented local bootstrap mechanism (for example `~/.linear_api_key`).\n- Real integration tests SHOULD use isolated test identifiers/workspaces and clean up tracker\n  artifacts when practical.\n- A skipped real-integration test SHOULD be reported as skipped, not silently treated as passed.\n- If a real-integration profile is explicitly enabled in CI or release validation, failures SHOULD\n  fail that job."
  }
]
```
