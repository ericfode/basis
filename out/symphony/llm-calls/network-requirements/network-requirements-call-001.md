You are executing Spec Gym projection `network-requirements`: Network Requirements.

Projection instructions:
# Network Requirements

Extract all requirements, dependencies, risks, and validation surfaces related
to networking.

The projection should include source-backed requirements first, then inferred
network obligations and missing validation questions.

Output contract:
- Format: json
- Final artifact path after merge: projections/network-requirements.json
- Type contracts: requirement

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
    "id": "dependency-3-2-abstraction-levels-filesystem-lifecycle-workspace-preparation-coding-agent-protocol",
    "type": "dependency",
    "title": "Filesystem lifecycle, workspace preparation, coding-agent protocol.",
    "text": "Filesystem lifecycle, workspace preparation, coding-agent protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 129,
      "lineEnd": 129
    }
  },
  {
    "id": "dependency-3-3-external-dependencies-coding-agent-executable-that-supports-the-targeted-codex-app-server-mode",
    "type": "dependency",
    "title": "Coding-agent executable that supports the targeted Codex app-server mode.",
    "text": "Coding-agent executable that supports the targeted Codex app-server mode.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 142,
      "lineEnd": 142
    }
  },
  {
    "id": "dependency-3-3-external-dependencies-host-environment-authentication-for-the-issue-tracker-and-coding-agent",
    "type": "dependency",
    "title": "Host environment authentication for the issue tracker and coding agent.",
    "text": "Host environment authentication for the issue tracker and coding agent.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 143,
      "lineEnd": 143
    }
  },
  {
    "id": "requirement-5-3-4-hooks-object-timeoutms-integer-optional",
    "type": "requirement",
    "title": "timeoutms (integer, OPTIONAL)",
    "text": "`timeout_ms` (integer, OPTIONAL)",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 401,
      "lineEnd": 401
    }
  },
  {
    "id": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "text": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 420,
      "lineEnd": 420
    }
  },
  {
    "id": "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
    "type": "requirement",
    "title": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "text": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 441,
      "lineEnd": 441
    }
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
    "type": "requirement",
    "title": "Extensions that manage their own listeners/resources (for example an HTTP server port...",
    "text": "Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY require restart unless the implementation explicitly supports live rebind.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 534,
      "lineEnd": 534
    }
  },
  {
    "id": "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua",
    "type": "test",
    "title": "Once the worker exits normally, the orchestrator still schedules a short continuation...",
    "text": "Once the worker exits normally, the orchestrator still schedules a short continuation retry (about 1 second) so it can re-check whether the issue remains active and needs another worker session.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 634,
      "lineEnd": 634
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0057-heading-3-2-abstraction-levels",
    "type": "heading",
    "lineStart": 114,
    "lineEnd": 114,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Abstraction Levels"
  },
  {
    "id": "block-0067-list-4-execution-layer-workspace-agent-subprocess-filesystem-lifecycle-workspace-p",
    "type": "list",
    "lineStart": 129,
    "lineEnd": 130,
    "generatedClaimIds": [
      "dependency-3-2-abstraction-levels-filesystem-lifecycle-workspace-preparation-coding-agent-protocol"
    ],
    "rawMarkdown": "4. `Execution Layer` (workspace + agent subprocess)\n   - Filesystem lifecycle, workspace preparation, coding-agent protocol."
  },
  {
    "id": "block-0073-heading-3-3-external-dependencies",
    "type": "heading",
    "lineStart": 138,
    "lineEnd": 138,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 External Dependencies"
  },
  {
    "id": "block-0075-list-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version",
    "type": "list",
    "lineStart": 140,
    "lineEnd": 144,
    "generatedClaimIds": [
      "dependency-3-3-external-dependencies-local-filesystem-for-workspaces-and-logs",
      "dependency-3-3-external-dependencies-optional-workspace-population-tooling-for-example-git-cli-if-used",
      "dependency-3-3-external-dependencies-coding-agent-executable-that-supports-the-targeted-codex-app-server-mode",
      "dependency-3-3-external-dependencies-host-environment-authentication-for-the-issue-tracker-and-coding-agent"
    ],
    "rawMarkdown": "- Issue tracker API (Linear for `tracker.kind: linear` in this specification version).\n- Local filesystem for workspaces and logs.\n- OPTIONAL workspace population tooling (for example Git CLI, if used).\n- Coding-agent executable that supports the targeted Codex app-server mode.\n- Host environment authentication for the issue tracker and coding agent."
  },
  {
    "id": "block-0205-heading-5-3-4-hooks-object",
    "type": "heading",
    "lineStart": 384,
    "lineEnd": 384,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.4 `hooks` (object)"
  },
  {
    "id": "block-0209-list-aftercreate-multiline-shell-script-string-optional-runs-only-when-a-workspace",
    "type": "list",
    "lineStart": 388,
    "lineEnd": 406,
    "generatedClaimIds": [
      "claim-5-3-4-hooks-object-runs-only-when-a-workspace-directory-is-newly-created",
      "claim-5-3-4-hooks-object-failure-aborts-workspace-creation",
      "requirement-5-3-4-hooks-object-beforerun-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-before-each-agent-attempt-after-workspace-preparation-and-before-launching-",
      "claim-5-3-4-hooks-object-failure-aborts-the-current-attempt",
      "requirement-5-3-4-hooks-object-afterrun-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w",
      "claim-5-3-4-hooks-object-failure-is-logged-but-ignored",
      "requirement-5-3-4-hooks-object-beforeremove-multiline-shell-script-string-optional",
      "claim-5-3-4-hooks-object-runs-before-workspace-deletion-if-the-directory-exists",
      "claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds",
      "requirement-5-3-4-hooks-object-timeoutms-integer-optional",
      "claim-5-3-4-hooks-object-default-60000",
      "claim-5-3-4-hooks-object-applies-to-all-workspace-hooks",
      "claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation",
      "requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions"
    ],
    "rawMarkdown": "- `after_create` (multiline shell script string, OPTIONAL)\n  - Runs only when a workspace directory is newly created.\n  - Failure aborts workspace creation.\n- `before_run` (multiline shell script string, OPTIONAL)\n  - Runs before each agent attempt after workspace preparation and before launching the coding\n    agent.\n  - Failure aborts the current attempt.\n- `after_run` (multiline shell script string, OPTIONAL)\n  - Runs after each agent attempt (success, failure, timeout, or cancellation) once the workspace\n    exists.\n  - Failure is logged but ignored.\n- `before_remove` (multiline shell script string, OPTIONAL)\n  - Runs before workspace deletion if the directory exists.\n  - Failure is logged but ignored; cleanup still proceeds.\n- `timeout_ms` (integer, OPTIONAL)\n  - Default: `60000`\n  - Applies to all workspace hooks.\n  - Invalid values fail configuration validation.\n  - Changes SHOULD be re-applied at runtime for future hook executions."
  },
  {
    "id": "block-0211-heading-5-3-5-agent-object",
    "type": "heading",
    "lineStart": 408,
    "lineEnd": 408,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.5 `agent` (object)"
  },
  {
    "id": "block-0215-list-maxconcurrentagents-integer-default-10-changes-should-be-re-applied-at-runti",
    "type": "list",
    "lineStart": 412,
    "lineEnd": 425,
    "generatedClaimIds": [
      "claim-5-3-5-agent-object-default-10",
      "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions",
      "claim-5-3-5-agent-object-maxturns-positive-integer",
      "claim-5-3-5-agent-object-default-20",
      "claim-5-3-5-agent-object-limits-the-number-of-coding-agent-turns-within-one-worker-session",
      "claim-5-3-5-agent-object-invalid-values-fail-configuration-validation",
      "claim-5-3-5-agent-object-maxretrybackoffms-integer",
      "claim-5-3-5-agent-object-default-300000-5-minutes",
      "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
      "claim-5-3-5-agent-object-maxconcurrentagentsbystate-map-statename-positive-integer",
      "claim-5-3-5-agent-object-default-empty-map",
      "claim-5-3-5-agent-object-state-keys-are-normalized-lowercase-for-lookup",
      "claim-5-3-5-agent-object-invalid-entries-non-positive-or-non-numeric-are-ignored"
    ],
    "rawMarkdown": "- `max_concurrent_agents` (integer)\n  - Default: `10`\n  - Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.\n- `max_turns` (positive integer)\n  - Default: `20`\n  - Limits the number of coding-agent turns within one worker session.\n  - Invalid values fail configuration validation.\n- `max_retry_backoff_ms` (integer)\n  - Default: `300000` (5 minutes)\n  - Changes SHOULD be re-applied at runtime and affect future retry scheduling.\n- `max_concurrent_agents_by_state` (map `state_name -> positive integer`)\n  - Default: empty map.\n  - State keys are normalized (`lowercase`) for lookup.\n  - Invalid entries (non-positive or non-numeric) are ignored."
  },
  {
    "id": "block-0217-heading-5-3-6-codex-object",
    "type": "heading",
    "lineStart": 427,
    "lineEnd": 427,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "#### 5.3.6 `codex` (object)"
  },
  {
    "id": "block-0223-list-command-string-shell-command-default-codex-app-server-the-runtime-launches-t",
    "type": "list",
    "lineStart": 439,
    "lineEnd": 455,
    "generatedClaimIds": [
      "claim-5-3-6-codex-object-default-codex-app-server",
      "claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory",
      "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
      "claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value",
      "claim-5-3-6-codex-object-default-implementation-defined",
      "claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value",
      "claim-5-3-6-codex-object-default-implementation-defined-2",
      "claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value",
      "claim-5-3-6-codex-object-default-implementation-defined-3",
      "claim-5-3-6-codex-object-turntimeoutms-integer",
      "claim-5-3-6-codex-object-default-3600000-1-hour",
      "claim-5-3-6-codex-object-readtimeoutms-integer",
      "claim-5-3-6-codex-object-default-5000",
      "claim-5-3-6-codex-object-stalltimeoutms-integer",
      "claim-5-3-6-codex-object-default-300000-5-minutes",
      "claim-5-3-6-codex-object-if-0-stall-detection-is-disabled"
    ],
    "rawMarkdown": "- `command` (string shell command)\n  - Default: `codex app-server`\n  - The runtime launches this command via `bash -lc` in the workspace directory.\n  - The launched process MUST speak a compatible app-server protocol over stdio.\n- `approval_policy` (Codex `AskForApproval` value)\n  - Default: implementation-defined.\n- `thread_sandbox` (Codex `SandboxMode` value)\n  - Default: implementation-defined.\n- `turn_sandbox_policy` (Codex `SandboxPolicy` value)\n  - Default: implementation-defined.\n- `turn_timeout_ms` (integer)\n  - Default: `3600000` (1 hour)\n- `read_timeout_ms` (integer)\n  - Default: `5000`\n- `stall_timeout_ms` (integer)\n  - Default: `300000` (5 minutes)\n  - If `<= 0`, stall detection is disabled."
  },
  {
    "id": "block-0265-heading-6-2-dynamic-reload-semantics",
    "type": "heading",
    "lineStart": 522,
    "lineEnd": 522,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 6.2 Dynamic Reload Semantics"
  },
  {
    "id": "block-0269-list-the-software-must-detect-workflow-md-changes-on-change-it-must-re-read-and-re-a",
    "type": "list",
    "lineStart": 526,
    "lineEnd": 540,
    "generatedClaimIds": [
      "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
      "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
      "claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis",
      "requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical",
      "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
      "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
      "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go"
    ],
    "rawMarkdown": "- The software MUST detect `WORKFLOW.md` changes.\n- On change, it MUST re-read and re-apply workflow config and prompt template without restart.\n- The software MUST attempt to adjust live behavior to the new config (for example polling\n  cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and\n  prompt content for future runs).\n- Reloaded config applies to future dispatch, retry scheduling, reconciliation decisions, hook\n  execution, and agent launches.\n- Implementations are not REQUIRED to restart in-flight agent sessions automatically when config\n  changes.\n- Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY\n  require restart unless the implementation explicitly supports live rebind.\n- Implementations SHOULD also re-validate/reload defensively during runtime operations (for example\n  before dispatch) in case filesystem watch events are missed.\n- Invalid reloads MUST NOT crash the service; keep operating with the last known good effective\n  configuration and emit an operator-visible error."
  },
  {
    "id": "block-0297-heading-7-1-issue-orchestration-states",
    "type": "heading",
    "lineStart": 603,
    "lineEnd": 603,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 7.1 Issue Orchestration States"
  },
  {
    "id": "block-0313-list-a-successful-worker-exit-does-not-mean-the-issue-is-done-forever-the-worker-may",
    "type": "list",
    "lineStart": 627,
    "lineEnd": 637,
    "generatedClaimIds": [
      "requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-",
      "claim-7-1-issue-orchestration-states-after-each-normal-turn-completion-the-worker-re-checks-the-tracker-issue-state",
      "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
      "requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt",
      "requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread",
      "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua"
    ],
    "rawMarkdown": "- A successful worker exit does not mean the issue is done forever.\n- The worker MAY continue through multiple back-to-back coding-agent turns before it exits.\n- After each normal turn completion, the worker re-checks the tracker issue state.\n- If the issue is still in an active state, the worker SHOULD start another turn on the same live\n  coding-agent thread in the same workspace, up to `agent.max_turns`.\n- The first turn SHOULD use the full rendered task prompt.\n- Continuation turns SHOULD send only continuation guidance to the existing thread, not resend the\n  original task prompt that is already present in thread history.\n- Once the worker exits normally, the orchestrator still schedules a short continuation retry\n  (about 1 second) so it can re-check whether the issue remains active and needs another worker\n  session."
  }
]
```
