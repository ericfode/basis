// Spec Gym Neo4j import
// Source: /Users/ericfode/src/openai-symphony/spec.md
// Load with cypher-shell or Neo4j Browser.

CREATE CONSTRAINT claim_lattice_node_id IF NOT EXISTS
FOR (n:ClaimLatticeNode)
REQUIRE n.id IS UNIQUE;

UNWIND [
  {
    "id": "spec",
    "type": "spec",
    "title": "Symphony Service Specification",
    "lineStart": 1,
    "lineEnd": 2170,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "# Symphony Service Specification",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-001-symphony-service-specification",
    "type": "section",
    "title": "Symphony Service Specification",
    "lineStart": 1,
    "lineEnd": 6,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "# Symphony Service Specification\n\nStatus: Draft v1 (language-agnostic)\n\nPurpose: Define a service that orchestrates coding agents to get project work done.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-002-normative-language",
    "type": "section",
    "title": "Normative Language",
    "lineStart": 7,
    "lineEnd": 15,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## Normative Language\n\nThe key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`, `RECOMMENDED`, `MAY`, and\n`OPTIONAL` in this document are to be interpreted as described in RFC 2119.\n\n`Implementation-defined` means the behavior is part of the implementation contract, but this\nspecification does not prescribe one universal policy. Implementations MUST document the selected\nbehavior.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-003-1-problem-statement",
    "type": "section",
    "title": "1. Problem Statement",
    "lineStart": 16,
    "lineEnd": 43,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 1. Problem Statement\n\nSymphony is a long-running automation service that continuously reads work from an issue tracker\n(Linear in this specification version), creates an isolated workspace for each issue, and runs a\ncoding agent session for that issue inside the workspace.\n\nThe service solves four operational problems:\n\n- It turns issue execution into a repeatable daemon workflow instead of manual scripts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-004-2-goals-and-non-goals",
    "type": "section",
    "title": "2. Goals and Non-Goals",
    "lineStart": 44,
    "lineEnd": 45,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 2. Goals and Non-Goals",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-005-2-1-goals",
    "type": "section",
    "title": "2.1 Goals",
    "lineStart": 46,
    "lineEnd": 57,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 2.1 Goals\n\n- Poll the issue tracker on a fixed cadence and dispatch work with bounded concurrency.\n- Maintain a single authoritative orchestrator state for dispatch, retries, and reconciliation.\n- Create deterministic per-issue workspaces and preserve them across runs.\n- Stop active runs when issue state changes make them ineligible.\n- Recover from transient failures with exponential backoff.\n- Load runtime behavior from a repository-owned `WORKFLOW.md` contract.\n- Expose operator-visible observability (at minimum structured logs).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-006-2-2-non-goals",
    "type": "section",
    "title": "2.2 Non-Goals",
    "lineStart": 58,
    "lineEnd": 68,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 2.2 Non-Goals\n\n- Rich web UI or multi-tenant control plane.\n- Prescribing a specific dashboard or terminal UI implementation.\n- General-purpose workflow engine or distributed job scheduler.\n- Built-in business logic for how to edit tickets, PRs, or comments. (That logic lives in the\n  workflow prompt and agent tooling.)\n- Mandating strong sandbox controls beyond what the coding agent and host OS provide.\n- Mandating a single default approval, sandbox, or operator-confirmation posture for all",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-007-3-system-overview",
    "type": "section",
    "title": "3. System Overview",
    "lineStart": 69,
    "lineEnd": 70,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 3. System Overview",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-008-3-1-main-components",
    "type": "section",
    "title": "3.1 Main Components",
    "lineStart": 71,
    "lineEnd": 113,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 3.1 Main Components\n\n1. `Workflow Loader`\n   - Reads `WORKFLOW.md`.\n   - Parses YAML front matter and prompt body.\n   - Returns `{config, prompt_template}`.\n\n2. `Config Layer`\n   - Exposes typed getters for workflow config values.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-009-3-2-abstraction-levels",
    "type": "section",
    "title": "3.2 Abstraction Levels",
    "lineStart": 114,
    "lineEnd": 137,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 3.2 Abstraction Levels\n\nSymphony is easiest to port when kept in these layers:\n\n1. `Policy Layer` (repo-defined)\n   - `WORKFLOW.md` prompt body.\n   - Team-specific rules for ticket handling, validation, and handoff.\n\n2. `Configuration Layer` (typed getters)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-010-3-3-external-dependencies",
    "type": "section",
    "title": "3.3 External Dependencies",
    "lineStart": 138,
    "lineEnd": 145,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 3.3 External Dependencies\n\n- Issue tracker API (Linear for `tracker.kind: linear` in this specification version).\n- Local filesystem for workspaces and logs.\n- OPTIONAL workspace population tooling (for example Git CLI, if used).\n- Coding-agent executable that supports the targeted Codex app-server mode.\n- Host environment authentication for the issue tracker and coding agent.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-011-4-core-domain-model",
    "type": "section",
    "title": "4. Core Domain Model",
    "lineStart": 146,
    "lineEnd": 147,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 4. Core Domain Model",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-012-4-1-entities",
    "type": "section",
    "title": "4.1 Entities",
    "lineStart": 148,
    "lineEnd": 149,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 4.1 Entities",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-013-4-1-1-issue",
    "type": "section",
    "title": "4.1.1 Issue",
    "lineStart": 150,
    "lineEnd": 178,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.1 Issue\n\nNormalized issue record used by orchestration, prompt rendering, and observability output.\n\nFields:\n\n- `id` (string)\n  - Stable tracker-internal ID.\n- `identifier` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-014-4-1-2-workflow-definition",
    "type": "section",
    "title": "4.1.2 Workflow Definition",
    "lineStart": 179,
    "lineEnd": 187,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.2 Workflow Definition\n\nParsed `WORKFLOW.md` payload:\n\n- `config` (map)\n  - YAML front matter root object.\n- `prompt_template` (string)\n  - Markdown body after front matter, trimmed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view",
    "type": "section",
    "title": "4.1.3 Service Config (Typed View)",
    "lineStart": 188,
    "lineEnd": 200,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.3 Service Config (Typed View)\n\nTyped runtime values derived from `WorkflowDefinition.config` plus environment resolution.\n\nExamples:\n\n- poll interval\n- workspace root\n- active and terminal issue states",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-016-4-1-4-workspace",
    "type": "section",
    "title": "4.1.4 Workspace",
    "lineStart": 201,
    "lineEnd": 210,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.4 Workspace\n\nFilesystem workspace assigned to one issue identifier.\n\nFields (logical):\n\n- `path` (absolute workspace path)\n- `workspace_key` (sanitized issue identifier)\n- `created_now` (boolean, used to gate `after_create` hook)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-017-4-1-5-run-attempt",
    "type": "section",
    "title": "4.1.5 Run Attempt",
    "lineStart": 211,
    "lineEnd": 224,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.5 Run Attempt\n\nOne execution attempt for one issue.\n\nFields (logical):\n\n- `issue_id`\n- `issue_identifier`\n- `attempt` (integer or null, `null` for first run, `>=1` for retries/continuation)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata",
    "type": "section",
    "title": "4.1.6 Live Session (Agent Session Metadata)",
    "lineStart": 225,
    "lineEnd": 246,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.6 Live Session (Agent Session Metadata)\n\nState tracked while a coding-agent subprocess is running.\n\nFields:\n\n- `session_id` (string, `<thread_id>-<turn_id>`)\n- `thread_id` (string)\n- `turn_id` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-019-4-1-7-retry-entry",
    "type": "section",
    "title": "4.1.7 Retry Entry",
    "lineStart": 247,
    "lineEnd": 259,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.7 Retry Entry\n\nScheduled retry state for an issue.\n\nFields:\n\n- `issue_id`\n- `identifier` (best-effort human ID for status surfaces/logs)\n- `attempt` (integer, 1-based for retry queue)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state",
    "type": "section",
    "title": "4.1.8 Orchestrator Runtime State",
    "lineStart": 260,
    "lineEnd": 274,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 4.1.8 Orchestrator Runtime State\n\nSingle authoritative in-memory state owned by the orchestrator.\n\nFields:\n\n- `poll_interval_ms` (current effective poll interval)\n- `max_concurrent_agents` (current effective global concurrency limit)\n- `running` (map `issue_id -> running entry`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "type": "section",
    "title": "4.2 Stable Identifiers and Normalization Rules",
    "lineStart": 275,
    "lineEnd": 288,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 4.2 Stable Identifiers and Normalization Rules\n\n- `Issue ID`\n  - Use for tracker lookups and internal map keys.\n- `Issue Identifier`\n  - Use for human-readable logs and workspace naming.\n- `Workspace Key`\n  - Derive from `issue.identifier` by replacing any character not in `[A-Za-z0-9._-]` with `_`.\n  - Use the sanitized value for the workspace directory name.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract",
    "type": "section",
    "title": "5. Workflow Specification (Repository Contract)",
    "lineStart": 289,
    "lineEnd": 290,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 5. Workflow Specification (Repository Contract)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-023-5-1-file-discovery-and-path-resolution",
    "type": "section",
    "title": "5.1 File Discovery and Path Resolution",
    "lineStart": 291,
    "lineEnd": 302,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 5.1 File Discovery and Path Resolution\n\nWorkflow file path precedence:\n\n1. Explicit application/runtime setting (set by CLI startup path).\n2. Default: `WORKFLOW.md` in the current process working directory.\n\nLoader behavior:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-024-5-2-file-format",
    "type": "section",
    "title": "5.2 File Format",
    "lineStart": 303,
    "lineEnd": 325,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 5.2 File Format\n\n`WORKFLOW.md` is a Markdown file with OPTIONAL YAML front matter.\n\nDesign note:\n\n- `WORKFLOW.md` SHOULD be self-contained enough to describe and run different workflows (prompt,\n  runtime settings, hooks, and tracker selection/config) without requiring out-of-band\n  service-specific configuration.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-025-5-3-front-matter-schema",
    "type": "section",
    "title": "5.3 Front Matter Schema",
    "lineStart": 326,
    "lineEnd": 345,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 5.3 Front Matter Schema\n\nTop-level keys:\n\n- `tracker`\n- `polling`\n- `workspace`\n- `hooks`\n- `agent`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-026-5-3-1-tracker-object",
    "type": "section",
    "title": "5.3.1 tracker (object)",
    "lineStart": 346,
    "lineEnd": 365,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.1 `tracker` (object)\n\nFields:\n\n- `kind` (string)\n  - REQUIRED for dispatch.\n  - Current supported value: `linear`\n- `endpoint` (string)\n  - Default for `tracker.kind == \"linear\"`: `https://api.linear.app/graphql`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-027-5-3-2-polling-object",
    "type": "section",
    "title": "5.3.2 polling (object)",
    "lineStart": 366,
    "lineEnd": 373,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.2 `polling` (object)\n\nFields:\n\n- `interval_ms` (integer)\n  - Default: `30000`\n  - Changes SHOULD be re-applied at runtime and affect future tick scheduling without restart.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-028-5-3-3-workspace-object",
    "type": "section",
    "title": "5.3.3 workspace (object)",
    "lineStart": 374,
    "lineEnd": 383,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.3 `workspace` (object)\n\nFields:\n\n- `root` (path string or `$VAR`)\n  - Default: `<system-temp>/symphony_workspaces`\n  - `~` is expanded.\n  - Relative paths are resolved relative to the directory containing `WORKFLOW.md`.\n  - The effective workspace root is normalized to an absolute path before use.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-029-5-3-4-hooks-object",
    "type": "section",
    "title": "5.3.4 hooks (object)",
    "lineStart": 384,
    "lineEnd": 407,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.4 `hooks` (object)\n\nFields:\n\n- `after_create` (multiline shell script string, OPTIONAL)\n  - Runs only when a workspace directory is newly created.\n  - Failure aborts workspace creation.\n- `before_run` (multiline shell script string, OPTIONAL)\n  - Runs before each agent attempt after workspace preparation and before launching the coding",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-030-5-3-5-agent-object",
    "type": "section",
    "title": "5.3.5 agent (object)",
    "lineStart": 408,
    "lineEnd": 426,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.5 `agent` (object)\n\nFields:\n\n- `max_concurrent_agents` (integer)\n  - Default: `10`\n  - Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.\n- `max_turns` (positive integer)\n  - Default: `20`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-031-5-3-6-codex-object",
    "type": "section",
    "title": "5.3.6 codex (object)",
    "lineStart": 427,
    "lineEnd": 456,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 5.3.6 `codex` (object)\n\nFields:\n\nFor Codex-owned config values such as `approval_policy`, `thread_sandbox`, and\n`turn_sandbox_policy`, supported values are defined by the targeted Codex app-server version.\nImplementors SHOULD treat them as pass-through Codex config values rather than relying on a\nhand-maintained enum in this spec. To inspect the installed Codex schema, run\n`codex app-server generate-json-schema --out <dir>` and inspect the relevant definitions referenced",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-032-5-4-prompt-template-contract",
    "type": "section",
    "title": "5.4 Prompt Template Contract",
    "lineStart": 457,
    "lineEnd": 481,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 5.4 Prompt Template Contract\n\nThe Markdown body of `WORKFLOW.md` is the per-issue prompt template.\n\nRendering requirements:\n\n- Use a strict template engine (Liquid-compatible semantics are sufficient).\n- Unknown variables MUST fail rendering.\n- Unknown filters MUST fail rendering.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface",
    "type": "section",
    "title": "5.5 Workflow Validation and Error Surface",
    "lineStart": 482,
    "lineEnd": 496,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 5.5 Workflow Validation and Error Surface\n\nError classes:\n\n- `missing_workflow_file`\n- `workflow_parse_error`\n- `workflow_front_matter_not_a_map`\n- `template_parse_error` (during prompt rendering)\n- `template_render_error` (unknown variable/filter, invalid interpolation)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-034-6-configuration-specification",
    "type": "section",
    "title": "6. Configuration Specification",
    "lineStart": 497,
    "lineEnd": 498,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 6. Configuration Specification",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline",
    "type": "section",
    "title": "6.1 Configuration Resolution Pipeline",
    "lineStart": 499,
    "lineEnd": 521,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 6.1 Configuration Resolution Pipeline\n\nConfiguration is resolved in this order:\n\n1. Select the workflow file path (explicit runtime setting, otherwise cwd default).\n2. Parse YAML front matter into a raw config map.\n3. Apply built-in defaults for missing OPTIONAL fields.\n4. Resolve `$VAR_NAME` indirection only for config values that explicitly contain `$VAR_NAME`.\n5. Coerce and validate typed values.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics",
    "type": "section",
    "title": "6.2 Dynamic Reload Semantics",
    "lineStart": 522,
    "lineEnd": 541,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 6.2 Dynamic Reload Semantics\n\nDynamic reload is REQUIRED:\n\n- The software MUST detect `WORKFLOW.md` changes.\n- On change, it MUST re-read and re-apply workflow config and prompt template without restart.\n- The software MUST attempt to adjust live behavior to the new config (for example polling\n  cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and\n  prompt content for future runs).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation",
    "type": "section",
    "title": "6.3 Dispatch Preflight Validation",
    "lineStart": 542,
    "lineEnd": 566,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 6.3 Dispatch Preflight Validation\n\nThis validation is a scheduler preflight run before attempting to dispatch new work. It validates\nthe workflow/config needed to poll and launch workers, not a full audit of all possible workflow\nbehavior.\n\nStartup validation:\n\n- Validate configuration before starting the scheduling loop.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "type": "section",
    "title": "6.4 Core Config Fields Summary (Cheat Sheet)",
    "lineStart": 567,
    "lineEnd": 597,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 6.4 Core Config Fields Summary (Cheat Sheet)\n\nThis section is intentionally redundant so a coding agent can implement the config layer quickly.\nExtension fields are documented in the extension section that defines them. Core conformance does\nnot require recognizing or validating extension fields unless that extension is implemented.\n\n- `tracker.kind`: string, REQUIRED, currently `linear`\n- `tracker.endpoint`: string, default `https://api.linear.app/graphql` when `tracker.kind=linear`\n- `tracker.api_key`: string or `$VAR`, canonical env `LINEAR_API_KEY` when `tracker.kind=linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-039-7-orchestration-state-machine",
    "type": "section",
    "title": "7. Orchestration State Machine",
    "lineStart": 598,
    "lineEnd": 602,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 7. Orchestration State Machine\n\nThe orchestrator is the only component that mutates scheduling state. All worker outcomes are\nreported back to it and converted into explicit state transitions.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states",
    "type": "section",
    "title": "7.1 Issue Orchestration States",
    "lineStart": 603,
    "lineEnd": 638,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 7.1 Issue Orchestration States\n\nThis is not the same as tracker states (`Todo`, `In Progress`, etc.). This is the service's internal\nclaim state.\n\n1. `Unclaimed`\n   - Issue is not running and has no retry scheduled.\n\n2. `Claimed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-041-7-2-run-attempt-lifecycle",
    "type": "section",
    "title": "7.2 Run Attempt Lifecycle",
    "lineStart": 639,
    "lineEnd": 656,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 7.2 Run Attempt Lifecycle\n\nA run attempt transitions through these phases:\n\n1. `PreparingWorkspace`\n2. `BuildingPrompt`\n3. `LaunchingAgentProcess`\n4. `InitializingSession`\n5. `StreamingTurn`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-042-7-3-transition-triggers",
    "type": "section",
    "title": "7.3 Transition Triggers",
    "lineStart": 657,
    "lineEnd": 687,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 7.3 Transition Triggers\n\n- `Poll Tick`\n  - Reconcile active runs.\n  - Validate config.\n  - Fetch candidate issues.\n  - Dispatch until slots are exhausted.\n\n- `Worker Exit (normal)`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules",
    "type": "section",
    "title": "7.4 Idempotency and Recovery Rules",
    "lineStart": 688,
    "lineEnd": 695,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 7.4 Idempotency and Recovery Rules\n\n- The orchestrator serializes state mutations through one authority to avoid duplicate dispatch.\n- `claimed` and `running` checks are REQUIRED before launching any worker.\n- Reconciliation runs before dispatch on every tick.\n- Restart recovery is tracker-driven and filesystem-driven (without a durable orchestrator DB).\n- Startup terminal cleanup removes stale workspaces for issues already in terminal states.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation",
    "type": "section",
    "title": "8. Polling, Scheduling, and Reconciliation",
    "lineStart": 696,
    "lineEnd": 697,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 8. Polling, Scheduling, and Reconciliation",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-045-8-1-poll-loop",
    "type": "section",
    "title": "8.1 Poll Loop",
    "lineStart": 698,
    "lineEnd": 716,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.1 Poll Loop\n\nAt startup, the service validates config, performs startup cleanup, schedules an immediate tick, and\nthen repeats every `polling.interval_ms`.\n\nThe effective poll interval SHOULD be updated when workflow config changes are re-applied.\n\nTick sequence:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules",
    "type": "section",
    "title": "8.2 Candidate Selection Rules",
    "lineStart": 717,
    "lineEnd": 735,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.2 Candidate Selection Rules\n\nAn issue is dispatch-eligible only if all are true:\n\n- It has `id`, `identifier`, `title`, and `state`.\n- Its state is in `active_states` and not in `terminal_states`.\n- It is not already in `running`.\n- It is not already in `claimed`.\n- Global concurrency slots are available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-047-8-3-concurrency-control",
    "type": "section",
    "title": "8.3 Concurrency Control",
    "lineStart": 736,
    "lineEnd": 748,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.3 Concurrency Control\n\nGlobal limit:\n\n- `available_slots = max(max_concurrent_agents - running_count, 0)`\n\nPer-state limit:\n\n- `max_concurrent_agents_by_state[state]` if present (state key normalized)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-048-8-4-retry-and-backoff",
    "type": "section",
    "title": "8.4 Retry and Backoff",
    "lineStart": 749,
    "lineEnd": 778,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.4 Retry and Backoff\n\nRetry entry creation:\n\n- Cancel any existing retry timer for the same issue.\n- Store `attempt`, `identifier`, `error`, `due_at_ms`, and new timer handle.\n\nBackoff formula:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation",
    "type": "section",
    "title": "8.5 Active Run Reconciliation",
    "lineStart": 779,
    "lineEnd": 799,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.5 Active Run Reconciliation\n\nReconciliation runs every tick and has two parts.\n\nPart A: Stall detection\n\n- For each running issue, compute `elapsed_ms` since:\n  - `last_codex_timestamp` if any event has been seen, else\n  - `started_at`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-050-8-6-startup-terminal-workspace-cleanup",
    "type": "section",
    "title": "8.6 Startup Terminal Workspace Cleanup",
    "lineStart": 800,
    "lineEnd": 809,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 8.6 Startup Terminal Workspace Cleanup\n\nWhen the service starts:\n\n1. Query tracker for issues in terminal states.\n2. For each returned issue identifier, remove the corresponding workspace directory.\n3. If the terminal-issues fetch fails, log a warning and continue startup.\n\nThis prevents stale terminal workspaces from accumulating after restarts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-051-9-workspace-management-and-safety",
    "type": "section",
    "title": "9. Workspace Management and Safety",
    "lineStart": 810,
    "lineEnd": 811,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 9. Workspace Management and Safety",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-052-9-1-workspace-layout",
    "type": "section",
    "title": "9.1 Workspace Layout",
    "lineStart": 812,
    "lineEnd": 826,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 9.1 Workspace Layout\n\nWorkspace root:\n\n- `workspace.root` (normalized absolute path)\n\nPer-issue workspace path:\n\n- `<workspace.root>/<sanitized_issue_identifier>`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-053-9-2-workspace-creation-and-reuse",
    "type": "section",
    "title": "9.2 Workspace Creation and Reuse",
    "lineStart": 827,
    "lineEnd": 845,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 9.2 Workspace Creation and Reuse\n\nInput: `issue.identifier`\n\nAlgorithm summary:\n\n1. Sanitize identifier to `workspace_key`.\n2. Compute workspace path under workspace root.\n3. Ensure the workspace path exists as a directory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined",
    "type": "section",
    "title": "9.3 OPTIONAL Workspace Population (Implementation-Defined)",
    "lineStart": 846,
    "lineEnd": 860,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 9.3 OPTIONAL Workspace Population (Implementation-Defined)\n\nThe spec does not require any built-in VCS or repository bootstrap behavior.\n\nImplementations MAY populate or synchronize the workspace using implementation-defined logic and/or\nhooks (for example `after_create` and/or `before_run`).\n\nFailure handling:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-055-9-4-workspace-hooks",
    "type": "section",
    "title": "9.4 Workspace Hooks",
    "lineStart": 861,
    "lineEnd": 885,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 9.4 Workspace Hooks\n\nSupported hooks:\n\n- `hooks.after_create`\n- `hooks.before_run`\n- `hooks.after_run`\n- `hooks.before_remove`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-056-9-5-safety-invariants",
    "type": "section",
    "title": "9.5 Safety Invariants",
    "lineStart": 886,
    "lineEnd": 905,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 9.5 Safety Invariants\n\nThis is the most important portability constraint.\n\nInvariant 1: Run the coding agent only in the per-issue workspace path.\n\n- Before launching the coding-agent subprocess, validate:\n  - `cwd == workspace_path`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "type": "section",
    "title": "10. Agent Runner Protocol (Coding Agent Integration)",
    "lineStart": 906,
    "lineEnd": 921,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 10. Agent Runner Protocol (Coding Agent Integration)\n\nThis section defines Symphony's language-neutral responsibilities when integrating a Codex\napp-server. The Codex app-server protocol for the targeted Codex version is the source of truth for\nprotocol schemas, message payloads, transport framing, and method names.\n\nProtocol source of truth:\n\n- Implementations MUST send messages that are valid for the targeted Codex app-server version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-058-10-1-launch-contract",
    "type": "section",
    "title": "10.1 Launch Contract",
    "lineStart": 922,
    "lineEnd": 940,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.1 Launch Contract\n\nSubprocess launch parameters:\n\n- Command: `codex.command`\n- Invocation: `bash -lc <codex.command>`\n- Working directory: workspace path\n- Transport/framing: the protocol transport required by the targeted Codex app-server version",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities",
    "type": "section",
    "title": "10.2 Session Startup Responsibilities",
    "lineStart": 941,
    "lineEnd": 968,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.2 Session Startup Responsibilities\n\nReference: https://developers.openai.com/codex/app-server/\n\nStartup MUST follow the targeted Codex app-server contract. Symphony additionally requires the\nclient to:\n\n- Start the app-server subprocess in the per-issue workspace.\n- Initialize the app-server session using the targeted Codex app-server protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing",
    "type": "section",
    "title": "10.3 Streaming Turn Processing",
    "lineStart": 969,
    "lineEnd": 994,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.3 Streaming Turn Processing\n\nThe client processes app-server updates according to the targeted Codex app-server protocol until\nthe active turn terminates.\n\nCompletion conditions:\n\n- Targeted-protocol turn completion signal -> success\n- Targeted-protocol turn failure signal -> failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "type": "section",
    "title": "10.4 Emitted Runtime Events (Upstream to Orchestrator)",
    "lineStart": 995,
    "lineEnd": 1020,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.4 Emitted Runtime Events (Upstream to Orchestrator)\n\nThe app-server client emits structured events to the orchestrator callback. Each event SHOULD\ninclude:\n\n- `event` (enum/string)\n- `timestamp` (UTC timestamp)\n- `codex_app_server_pid` (if available)\n- OPTIONAL `usage` map (token counts)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "type": "section",
    "title": "10.5 Approval, Tool Calls, and User Input Policy",
    "lineStart": 1021,
    "lineEnd": 1096,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.5 Approval, Tool Calls, and User Input Policy\n\nApproval, sandbox, and user-input behavior is implementation-defined.\n\nPolicy requirements:\n\n- Each implementation MUST document its chosen approval, sandbox, and operator-confirmation\n  posture.\n- Approval requests and user-input-required events MUST NOT leave a run stalled indefinitely. An",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping",
    "type": "section",
    "title": "10.6 Timeouts and Error Mapping",
    "lineStart": 1097,
    "lineEnd": 1116,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.6 Timeouts and Error Mapping\n\nTimeouts:\n\n- `codex.read_timeout_ms`: request/response timeout during startup and sync requests\n- `codex.turn_timeout_ms`: total turn stream timeout\n- `codex.stall_timeout_ms`: enforced by orchestrator based on event inactivity\n\nError mapping (RECOMMENDED normalized categories):",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-064-10-7-agent-runner-contract",
    "type": "section",
    "title": "10.7 Agent Runner Contract",
    "lineStart": 1117,
    "lineEnd": 1132,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 10.7 Agent Runner Contract\n\nThe `Agent Runner` wraps workspace + prompt + app-server client.\n\nBehavior:\n\n1. Create/reuse workspace for issue.\n2. Build prompt from workflow template.\n3. Start app-server session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "type": "section",
    "title": "11. Issue Tracker Integration Contract (Linear-Compatible)",
    "lineStart": 1133,
    "lineEnd": 1134,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 11. Issue Tracker Integration Contract (Linear-Compatible)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-066-11-1-required-operations",
    "type": "section",
    "title": "11.1 REQUIRED Operations",
    "lineStart": 1135,
    "lineEnd": 1147,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 11.1 REQUIRED Operations\n\nAn implementation MUST support these tracker adapter operations:\n\n1. `fetch_candidate_issues()`\n   - Return issues in configured active states for a configured project.\n\n2. `fetch_issues_by_states(state_names)`\n   - Used for startup terminal cleanup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-067-11-2-query-semantics-linear",
    "type": "section",
    "title": "11.2 Query Semantics (Linear)",
    "lineStart": 1148,
    "lineEnd": 1169,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 11.2 Query Semantics (Linear)\n\nLinear-specific requirements for `tracker.kind == \"linear\"`:\n\n- `tracker.kind == \"linear\"`\n- GraphQL endpoint (default `https://api.linear.app/graphql`)\n- Auth token sent in `Authorization` header\n- `tracker.project_slug` maps to Linear project `slugId`\n- Candidate issue query filters project using `project: { slugId: { eq: $projectSlug } }`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-068-11-3-normalization-rules",
    "type": "section",
    "title": "11.3 Normalization Rules",
    "lineStart": 1170,
    "lineEnd": 1180,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 11.3 Normalization Rules\n\nCandidate issue normalization SHOULD produce fields listed in Section 4.1.1.\n\nAdditional normalization details:\n\n- `labels` -> lowercase strings\n- `blocked_by` -> derived from inverse relations where relation type is `blocks`\n- `priority` -> integer only (non-integers become null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-069-11-4-error-handling-contract",
    "type": "section",
    "title": "11.4 Error Handling Contract",
    "lineStart": 1181,
    "lineEnd": 1199,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 11.4 Error Handling Contract\n\nRECOMMENDED error categories:\n\n- `unsupported_tracker_kind`\n- `missing_tracker_api_key`\n- `missing_tracker_project_slug`\n- `linear_api_request` (transport failures)\n- `linear_api_status` (non-200 HTTP)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-070-11-5-tracker-writes-important-boundary",
    "type": "section",
    "title": "11.5 Tracker Writes (Important Boundary)",
    "lineStart": 1200,
    "lineEnd": 1211,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 11.5 Tracker Writes (Important Boundary)\n\nSymphony does not require first-class tracker write APIs in the orchestrator.\n\n- Ticket mutations (state transitions, comments, PR metadata) are typically handled by the coding\n  agent using tools defined by the workflow prompt.\n- The service remains a scheduler/runner and tracker reader.\n- Workflow-specific success often means \"reached the next handoff state\" (for example\n  `Human Review`) rather than tracker terminal state `Done`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-071-12-prompt-construction-and-context-assembly",
    "type": "section",
    "title": "12. Prompt Construction and Context Assembly",
    "lineStart": 1212,
    "lineEnd": 1213,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 12. Prompt Construction and Context Assembly",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-072-12-1-inputs",
    "type": "section",
    "title": "12.1 Inputs",
    "lineStart": 1214,
    "lineEnd": 1221,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 12.1 Inputs\n\nInputs to prompt rendering:\n\n- `workflow.prompt_template`\n- normalized `issue` object\n- OPTIONAL `attempt` integer (retry/continuation metadata)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-073-12-2-rendering-rules",
    "type": "section",
    "title": "12.2 Rendering Rules",
    "lineStart": 1222,
    "lineEnd": 1228,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 12.2 Rendering Rules\n\n- Render with strict variable checking.\n- Render with strict filter checking.\n- Convert issue object keys to strings for template compatibility.\n- Preserve nested arrays/maps (labels, blockers) so templates can iterate.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-074-12-3-retry-continuation-semantics",
    "type": "section",
    "title": "12.3 Retry/Continuation Semantics",
    "lineStart": 1229,
    "lineEnd": 1237,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 12.3 Retry/Continuation Semantics\n\n`attempt` SHOULD be passed to the template because the workflow prompt can provide different\ninstructions for:\n\n- first run (`attempt` null or absent)\n- continuation run after a successful prior session\n- retry after error/timeout/stall",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-075-12-4-failure-semantics",
    "type": "section",
    "title": "12.4 Failure Semantics",
    "lineStart": 1238,
    "lineEnd": 1244,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 12.4 Failure Semantics\n\nIf prompt rendering fails:\n\n- Fail the run attempt immediately.\n- Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-076-13-logging-status-and-observability",
    "type": "section",
    "title": "13. Logging, Status, and Observability",
    "lineStart": 1245,
    "lineEnd": 1246,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 13. Logging, Status, and Observability",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-077-13-1-logging-conventions",
    "type": "section",
    "title": "13.1 Logging Conventions",
    "lineStart": 1247,
    "lineEnd": 1264,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.1 Logging Conventions\n\nREQUIRED context fields for issue-related logs:\n\n- `issue_id`\n- `issue_identifier`\n\nREQUIRED context for coding-agent session lifecycle logs:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-078-13-2-logging-outputs-and-sinks",
    "type": "section",
    "title": "13.2 Logging Outputs and Sinks",
    "lineStart": 1265,
    "lineEnd": 1275,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.2 Logging Outputs and Sinks\n\nThe spec does not prescribe where logs are written (stderr, file, remote sink, etc.).\n\nRequirements:\n\n- Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.\n- Implementations MAY write to one or more sinks.\n- If a configured log sink fails, the service SHOULD continue running when possible and emit an",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "type": "section",
    "title": "13.3 Runtime Snapshot / Monitoring Interface (OPTIONAL but RECOMMENDED)",
    "lineStart": 1276,
    "lineEnd": 1295,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.3 Runtime Snapshot / Monitoring Interface (OPTIONAL but RECOMMENDED)\n\nIf the implementation exposes a synchronous runtime snapshot (for dashboards or monitoring), it\nSHOULD return:\n\n- `running` (list of running session rows)\n- each running row SHOULD include `turn_count`\n- `retrying` (list of retry queue rows)\n- `codex_totals`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-080-13-4-optional-human-readable-status-surface",
    "type": "section",
    "title": "13.4 OPTIONAL Human-Readable Status Surface",
    "lineStart": 1296,
    "lineEnd": 1303,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.4 OPTIONAL Human-Readable Status Surface\n\nA human-readable status surface (terminal output, dashboard, etc.) is OPTIONAL and\nimplementation-defined.\n\nIf present, it SHOULD draw from orchestrator state/metrics only and MUST NOT be REQUIRED for\ncorrectness.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting",
    "type": "section",
    "title": "13.5 Session Metrics and Token Accounting",
    "lineStart": 1304,
    "lineEnd": 1334,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.5 Session Metrics and Token Accounting\n\nToken accounting rules:\n\n- Agent events can include token counts in multiple payload shapes.\n- Prefer absolute thread totals when available, such as:\n  - `thread/tokenUsage/updated` payloads\n  - `total_token_usage` within token-count wrapper events\n- Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-082-13-6-humanized-agent-event-summaries-optional",
    "type": "section",
    "title": "13.6 Humanized Agent Event Summaries (OPTIONAL)",
    "lineStart": 1335,
    "lineEnd": 1343,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.6 Humanized Agent Event Summaries (OPTIONAL)\n\nHumanized summaries of raw agent protocol events are OPTIONAL.\n\nIf implemented:\n\n- Treat them as observability-only output.\n- Do not make orchestrator logic depend on humanized strings.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension",
    "type": "section",
    "title": "13.7 OPTIONAL HTTP Server Extension",
    "lineStart": 1344,
    "lineEnd": 1372,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 13.7 OPTIONAL HTTP Server Extension\n\nThis section defines an OPTIONAL HTTP interface for observability and operational control.\n\nIf implemented:\n\n- The HTTP server is an extension and is not REQUIRED for conformance.\n- The implementation MAY serve server-rendered HTML or a client-side application for the dashboard.\n- The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQUIRED for",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-084-13-7-1-human-readable-dashboard",
    "type": "section",
    "title": "13.7.1 Human-Readable Dashboard (/)",
    "lineStart": 1373,
    "lineEnd": 1380,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 13.7.1 Human-Readable Dashboard (`/`)\n\n- Host a human-readable dashboard at `/`.\n- The returned document SHOULD depict the current state of the system (for example active sessions,\n  retry delays, token consumption, runtime totals, recent events, and health/error indicators).\n- It is up to the implementation whether this is server-generated HTML or a client-side app that\n  consumes the JSON API below.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1",
    "type": "section",
    "title": "13.7.2 JSON REST API (/api/v1/*)",
    "lineStart": 1381,
    "lineEnd": 1516,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "#### 13.7.2 JSON REST API (`/api/v1/*`)\n\nProvide a JSON REST API under `/api/v1/*` for current runtime state and operational debugging.\n\nMinimum endpoints:\n\n- `GET /api/v1/state`\n  - Returns a summary view of the current system state (running sessions, retry queue/delays,\n    aggregate token/runtime totals, latest rate limits, and any additional tracked summary fields).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-086-14-failure-model-and-recovery-strategy",
    "type": "section",
    "title": "14. Failure Model and Recovery Strategy",
    "lineStart": 1517,
    "lineEnd": 1518,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 14. Failure Model and Recovery Strategy",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-087-14-1-failure-classes",
    "type": "section",
    "title": "14.1 Failure Classes",
    "lineStart": 1519,
    "lineEnd": 1551,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 14.1 Failure Classes\n\n1. `Workflow/Config Failures`\n   - Missing `WORKFLOW.md`\n   - Invalid YAML front matter\n   - Unsupported tracker kind or missing tracker credentials/project slug\n   - Missing coding-agent executable\n\n2. `Workspace Failures`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-088-14-2-recovery-behavior",
    "type": "section",
    "title": "14.2 Recovery Behavior",
    "lineStart": 1552,
    "lineEnd": 1572,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 14.2 Recovery Behavior\n\n- Dispatch validation failures:\n  - Skip new dispatches.\n  - Keep service alive.\n  - Continue reconciliation where possible.\n\n- Worker failures:\n  - Convert to retries with exponential backoff.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart",
    "type": "section",
    "title": "14.3 Partial State Recovery (Restart)",
    "lineStart": 1573,
    "lineEnd": 1588,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 14.3 Partial State Recovery (Restart)\n\nCurrent design is intentionally in-memory for scheduler state.\nRestart recovery means the service can resume useful operation by polling tracker state and reusing\npreserved workspaces. It does not mean retry timers, running sessions, or live worker state survive\nprocess restart.\n\nAfter restart:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-090-14-4-operator-intervention-points",
    "type": "section",
    "title": "14.4 Operator Intervention Points",
    "lineStart": 1589,
    "lineEnd": 1601,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 14.4 Operator Intervention Points\n\nOperators can control behavior by:\n\n- Editing `WORKFLOW.md` (prompt and most runtime settings).\n- `WORKFLOW.md` changes are detected and re-applied automatically without restart according to\n  Section 6.2.\n- Changing issue states in the tracker:\n  - terminal state -> running session is stopped and workspace cleaned when reconciled",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-091-15-security-and-operational-safety",
    "type": "section",
    "title": "15. Security and Operational Safety",
    "lineStart": 1602,
    "lineEnd": 1603,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 15. Security and Operational Safety",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-092-15-1-trust-boundary-assumption",
    "type": "section",
    "title": "15.1 Trust Boundary Assumption",
    "lineStart": 1604,
    "lineEnd": 1616,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 15.1 Trust Boundary Assumption\n\nEach implementation defines its own trust boundary.\n\nOperational safety requirements:\n\n- Implementations SHOULD state clearly whether they are intended for trusted environments, more\n  restrictive environments, or both.\n- Implementations SHOULD state clearly whether they rely on auto-approved actions, operator",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements",
    "type": "section",
    "title": "15.2 Filesystem Safety Requirements",
    "lineStart": 1617,
    "lineEnd": 1630,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 15.2 Filesystem Safety Requirements\n\nMandatory:\n\n- Workspace path MUST remain under configured workspace root.\n- Coding-agent cwd MUST be the per-issue workspace path for the current run.\n- Workspace directory names MUST use sanitized identifiers.\n\nRECOMMENDED additional hardening for ports:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-094-15-3-secret-handling",
    "type": "section",
    "title": "15.3 Secret Handling",
    "lineStart": 1631,
    "lineEnd": 1636,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 15.3 Secret Handling\n\n- Support `$VAR` indirection in workflow config.\n- Do not log API tokens or secret env values.\n- Validate presence of secrets without printing them.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-095-15-4-hook-script-safety",
    "type": "section",
    "title": "15.4 Hook Script Safety",
    "lineStart": 1637,
    "lineEnd": 1647,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 15.4 Hook Script Safety\n\nWorkspace hooks are arbitrary shell scripts from `WORKFLOW.md`.\n\nImplications:\n\n- Hooks are fully trusted configuration.\n- Hooks run inside the workspace directory.\n- Hook output SHOULD be truncated in logs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance",
    "type": "section",
    "title": "15.5 Harness Hardening Guidance",
    "lineStart": 1648,
    "lineEnd": 1675,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 15.5 Harness Hardening Guidance\n\nRunning Codex agents against repositories, issue trackers, and other inputs that can contain\nsensitive data or externally-controlled content can be dangerous. A permissive deployment can lead\nto data leaks, destructive mutations, or full machine compromise if the agent is induced to execute\nharmful commands or use overly-powerful integrations.\n\nImplementations SHOULD explicitly evaluate their own risk profile and harden the execution harness\nwhere appropriate. This specification intentionally does not mandate a single hardening posture, but",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic",
    "type": "section",
    "title": "16. Reference Algorithms (Language-Agnostic)",
    "lineStart": 1676,
    "lineEnd": 1677,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 16. Reference Algorithms (Language-Agnostic)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-098-16-1-service-startup",
    "type": "section",
    "title": "16.1 Service Startup",
    "lineStart": 1678,
    "lineEnd": 1707,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.1 Service Startup\n\n```text\nfunction start_service():\n  configure_logging()\n  start_observability_outputs()\n  start_workflow_watch(on_change=reload_and_reapply_workflow)\n\n  state = {",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-099-16-2-poll-and-dispatch-tick",
    "type": "section",
    "title": "16.2 Poll-and-Dispatch Tick",
    "lineStart": 1708,
    "lineEnd": 1739,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.2 Poll-and-Dispatch Tick\n\n```text\non_tick(state):\n  state = reconcile_running_issues(state)\n\n  validation = validate_dispatch_config()\n  if validation is not ok:\n    log_validation_error(validation)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-100-16-3-reconcile-active-runs",
    "type": "section",
    "title": "16.3 Reconcile Active Runs",
    "lineStart": 1740,
    "lineEnd": 1765,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.3 Reconcile Active Runs\n\n```text\nfunction reconcile_running_issues(state):\n  state = reconcile_stalled_runs(state)\n\n  running_ids = keys(state.running)\n  if running_ids is empty:\n    return state",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-101-16-4-dispatch-one-issue",
    "type": "section",
    "title": "16.4 Dispatch One Issue",
    "lineStart": 1766,
    "lineEnd": 1804,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.4 Dispatch One Issue\n\n```text\nfunction dispatch_issue(issue, state, attempt):\n  worker = spawn_worker(\n    fn -> run_agent_attempt(issue, attempt, parent_orchestrator_pid) end\n  )\n\n  if worker spawn failed:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-102-16-5-worker-attempt-workspace-prompt-agent",
    "type": "section",
    "title": "16.5 Worker Attempt (Workspace + Prompt + Agent)",
    "lineStart": 1805,
    "lineEnd": 1864,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.5 Worker Attempt (Workspace + Prompt + Agent)\n\n```text\nfunction run_agent_attempt(issue, attempt, orchestrator_channel):\n  workspace = workspace_manager.create_for_issue(issue.identifier)\n  if workspace failed:\n    fail_worker(\"workspace error\")\n\n  if run_hook(\"before_run\", workspace.path) failed:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-103-16-6-worker-exit-and-retry-handling",
    "type": "section",
    "title": "16.6 Worker Exit and Retry Handling",
    "lineStart": 1865,
    "lineEnd": 1914,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 16.6 Worker Exit and Retry Handling\n\n```text\non_worker_exit(issue_id, reason, state):\n  running_entry = state.running.remove(issue_id)\n  state = add_runtime_seconds_to_totals(state, running_entry)\n\n  if reason == normal:\n    state.completed.add(issue_id)  # bookkeeping only",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-104-17-test-and-validation-matrix",
    "type": "section",
    "title": "17. Test and Validation Matrix",
    "lineStart": 1915,
    "lineEnd": 1930,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 17. Test and Validation Matrix\n\nA conforming implementation SHOULD include tests that cover the behaviors defined in this\nspecification.\n\nValidation profiles:\n\n- `Core Conformance`: deterministic tests REQUIRED for all conforming implementations.\n- `Extension Conformance`: REQUIRED only for OPTIONAL features that an implementation chooses to",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing",
    "type": "section",
    "title": "17.1 Workflow and Config Parsing",
    "lineStart": 1931,
    "lineEnd": 1951,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.1 Workflow and Config Parsing\n\n- Workflow file path precedence:\n  - explicit runtime path is used when provided\n  - cwd default is `WORKFLOW.md` when no explicit runtime path is provided\n- Workflow file changes are detected and trigger re-read/re-apply without restart\n- Invalid workflow reload keeps last known good effective configuration and emits an\n  operator-visible error\n- Missing `WORKFLOW.md` returns typed error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety",
    "type": "section",
    "title": "17.2 Workspace Manager and Safety",
    "lineStart": 1952,
    "lineEnd": 1966,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.2 Workspace Manager and Safety\n\n- Deterministic workspace path per issue identifier\n- Missing workspace directory is created\n- Existing workspace directory is reused\n- Existing non-directory path at workspace location is handled safely (replace or fail per\n  implementation policy)\n- OPTIONAL workspace population/synchronization errors are surfaced\n- `after_create` hook runs only on new workspace creation",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-107-17-3-issue-tracker-client",
    "type": "section",
    "title": "17.3 Issue Tracker Client",
    "lineStart": 1967,
    "lineEnd": 1978,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.3 Issue Tracker Client\n\n- Candidate issue fetch uses active states and project slug\n- Linear query uses the specified project filter field (`slugId`)\n- Empty `fetch_issues_by_states([])` returns empty without API call\n- Pagination preserves order across multiple pages\n- Blockers are normalized from inverse relations of type `blocks`\n- Labels are normalized to lowercase\n- Issue state refresh by ID returns minimal normalized issues",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "type": "section",
    "title": "17.4 Orchestrator Dispatch, Reconciliation, and Retry",
    "lineStart": 1979,
    "lineEnd": 1997,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.4 Orchestrator Dispatch, Reconciliation, and Retry\n\n- Dispatch sort order is priority then oldest creation time\n- `Todo` issue with non-terminal blockers is not eligible\n- `Todo` issue with terminal blockers is eligible\n- Active-state issue refresh updates running entry state\n- Non-active state stops running agent without workspace cleanup\n- Terminal state stops running agent and cleans workspace\n- Reconciliation with no running issues is a no-op",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client",
    "type": "section",
    "title": "17.5 Coding-Agent App-Server Client",
    "lineStart": 1998,
    "lineEnd": 2026,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.5 Coding-Agent App-Server Client\n\n- Launch command uses workspace cwd and invokes `bash -lc <codex.command>`\n- Session startup follows the targeted Codex app-server protocol.\n- Client identity/capability payloads are valid when the targeted Codex app-server protocol requires\n  them.\n- Policy-related startup payloads use the implementation's documented approval/sandbox settings\n- Thread and turn identities exposed by the targeted protocol are extracted and used to emit\n  `session_started`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-110-17-6-observability",
    "type": "section",
    "title": "17.6 Observability",
    "lineStart": 2027,
    "lineEnd": 2037,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.6 Observability\n\n- Validation failures are operator-visible\n- Structured logging includes issue/session context fields\n- Logging sink failures do not crash orchestration\n- Token/rate-limit aggregation remains correct across repeated agent updates\n- If a human-readable status surface is implemented, it is driven from orchestrator state and does\n  not affect correctness\n- If humanized event summaries are implemented, they cover key wrapper/agent event classes without",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle",
    "type": "section",
    "title": "17.7 CLI and Host Lifecycle",
    "lineStart": 2038,
    "lineEnd": 2046,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.7 CLI and Host Lifecycle\n\n- CLI accepts a positional workflow path argument (`path-to-WORKFLOW.md`)\n- CLI uses `./WORKFLOW.md` when no workflow path argument is provided\n- CLI errors on nonexistent explicit workflow path or missing default `./WORKFLOW.md`\n- CLI surfaces startup failure cleanly\n- CLI exits with success when application starts and shuts down normally\n- CLI exits nonzero when startup fails or the host process exits abnormally",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended",
    "type": "section",
    "title": "17.8 Real Integration Profile (RECOMMENDED)",
    "lineStart": 2047,
    "lineEnd": 2059,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 17.8 Real Integration Profile (RECOMMENDED)\n\nThese checks are RECOMMENDED for production readiness and MAY be skipped in CI when credentials,\nnetwork access, or external service permissions are unavailable.\n\n- A real tracker smoke test can be run with valid credentials supplied by `LINEAR_API_KEY` or a\n  documented local bootstrap mechanism (for example `~/.linear_api_key`).\n- Real integration tests SHOULD use isolated test identifiers/workspaces and clean up tracker\n  artifacts when practical.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done",
    "type": "section",
    "title": "18. Implementation Checklist (Definition of Done)",
    "lineStart": 2060,
    "lineEnd": 2067,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## 18. Implementation Checklist (Definition of Done)\n\nUse the same validation profiles as Section 17:\n\n- Section 18.1 = `Core Conformance`\n- Section 18.2 = `Extension Conformance`\n- Section 18.3 = `Real Integration Profile`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-114-18-1-required-for-conformance",
    "type": "section",
    "title": "18.1 REQUIRED for Conformance",
    "lineStart": 2068,
    "lineEnd": 2088,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 18.1 REQUIRED for Conformance\n\n- Workflow path selection supports explicit runtime path and cwd default\n- `WORKFLOW.md` loader with YAML front matter + prompt body split\n- Typed config layer with defaults and `$` resolution\n- Dynamic `WORKFLOW.md` watch/reload/re-apply for config and prompt\n- Polling orchestrator with single-authority mutable state\n- Issue tracker client with candidate fetch + state refresh + terminal fetch\n- Workspace manager with sanitized per-issue workspaces",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "type": "section",
    "title": "18.2 RECOMMENDED Extensions (Not REQUIRED for Conformance)",
    "lineStart": 2089,
    "lineEnd": 2101,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 18.2 RECOMMENDED Extensions (Not REQUIRED for Conformance)\n\n- HTTP server extension honors CLI `--port` over `server.port`, uses a safe default bind host, and\n  exposes the baseline endpoints/error semantics in Section 13.7 if shipped.\n- `linear_graphql` client-side tool extension exposes raw Linear GraphQL access through the\n  app-server session using configured Symphony auth.\n- TODO: Persist retry queue and session metadata across process restarts.\n- TODO: Make observability settings configurable in workflow front matter without prescribing UI\n  implementation details.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-116-18-3-operational-validation-before-production-recommended",
    "type": "section",
    "title": "18.3 Operational Validation Before Production (RECOMMENDED)",
    "lineStart": 2102,
    "lineEnd": 2108,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### 18.3 Operational Validation Before Production (RECOMMENDED)\n\n- Run the `Real Integration Profile` from Section 17.8 with valid credentials and network access.\n- Verify hook execution and workflow path resolution on the target host OS/shell environment.\n- If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default\n  bind expectations on the target environment.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional",
    "type": "section",
    "title": "Appendix A. SSH Worker Extension (OPTIONAL)",
    "lineStart": 2109,
    "lineEnd": 2120,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "## Appendix A. SSH Worker Extension (OPTIONAL)\n\nThis appendix describes a common extension profile in which Symphony keeps one central\norchestrator but executes worker runs on one or more remote hosts over SSH.\n\nExtension config:\n\n- `worker.ssh_hosts` (list of SSH host strings, OPTIONAL)\n  - When omitted, work runs locally.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-118-a-1-execution-model",
    "type": "section",
    "title": "A.1 Execution Model",
    "lineStart": 2121,
    "lineEnd": 2135,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### A.1 Execution Model\n\n- The orchestrator remains the single source of truth for polling, claims, retries, and\n  reconciliation.\n- `worker.ssh_hosts` provides the candidate SSH destinations for remote execution.\n- Each worker run is assigned to one host at a time, and that host becomes part of the run's\n  effective execution identity along with the issue workspace.\n- `workspace.root` is interpreted on the remote host, not on the orchestrator host.\n- The coding-agent app-server is launched over SSH stdio instead of as a local subprocess, so the",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-119-a-2-scheduling-notes",
    "type": "section",
    "title": "A.2 Scheduling Notes",
    "lineStart": 2136,
    "lineEnd": 2149,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### A.2 Scheduling Notes\n\n- SSH hosts MAY be treated as a pool for dispatch.\n- Implementations MAY prefer the previously used host on retries when that host is still\n  available.\n- `worker.max_concurrent_agents_per_host` is an OPTIONAL shared per-host cap across configured SSH\n  hosts.\n- When all SSH hosts are at capacity, dispatch SHOULD wait rather than silently falling back to a\n  different execution mode.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "section-120-a-3-problems-to-consider",
    "type": "section",
    "title": "A.3 Problems to Consider",
    "lineStart": 2150,
    "lineEnd": 2170,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "### A.3 Problems to Consider\n\n- Remote environment drift:\n  - Each host needs the expected shell environment, coding-agent executable, auth, and repository\n    prerequisites.\n- Workspace locality:\n  - Workspaces are usually host-local, so moving an issue to a different host is typically a cold\n    restart unless shared storage exists.\n- Path and command safety:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-normative-language-the-key-words-must-must-not-required-should-should-not-recommended-may-and",
    "type": "requirement",
    "title": "The key words MUST, MUST NOT, REQUIRED, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and",
    "lineStart": 8,
    "lineEnd": 8,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The key words `MUST`, `MUST NOT`, `REQUIRED`, `SHOULD`, `SHOULD NOT`, `RECOMMENDED`, `MAY`, and",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-normative-language-optional-in-this-document-are-to-be-interpreted-as-described-in-rfc-2119",
    "type": "requirement",
    "title": "OPTIONAL in this document are to be interpreted as described in RFC 2119.",
    "lineStart": 9,
    "lineEnd": 9,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`OPTIONAL` in this document are to be interpreted as described in RFC 2119.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-normative-language-implementations-must-document-the-selected",
    "type": "requirement",
    "title": "Implementations MUST document the selected",
    "lineStart": 12,
    "lineEnd": 12,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MUST document the selected",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-it-turns-issue-execution-into-a-repeatable-daemon-workflow-instead-of-manual-scr",
    "type": "claim",
    "title": "It turns issue execution into a repeatable daemon workflow instead of manual scripts.",
    "lineStart": 23,
    "lineEnd": 23,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It turns issue execution into a repeatable daemon workflow instead of manual scripts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-it-isolates-agent-execution-in-per-issue-workspaces-so-agent-commands-run-only-i",
    "type": "claim",
    "title": "It isolates agent execution in per-issue workspaces so agent commands run only inside...",
    "lineStart": 24,
    "lineEnd": 24,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It isolates agent execution in per-issue workspaces so agent commands run only inside per-issue workspace directories.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-it-keeps-the-workflow-policy-in-repo-workflow-md-so-teams-version-the-agent-prom",
    "type": "claim",
    "title": "It keeps the workflow policy in-repo (WORKFLOW.md) so teams version the agent prompt...",
    "lineStart": 26,
    "lineEnd": 26,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It keeps the workflow policy in-repo (`WORKFLOW.md`) so teams version the agent prompt and runtime settings with their code.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-it-provides-enough-observability-to-operate-and-debug-multiple-concurrent-agent-",
    "type": "claim",
    "title": "It provides enough observability to operate and debug multiple concurrent agent runs.",
    "lineStart": 28,
    "lineEnd": 28,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It provides enough observability to operate and debug multiple concurrent agent runs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-symphony-is-a-scheduler-runner-and-tracker-reader",
    "type": "claim",
    "title": "Symphony is a scheduler/runner and tracker reader.",
    "lineStart": 37,
    "lineEnd": 37,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Symphony is a scheduler/runner and tracker reader.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-ticket-writes-state-transitions-comments-pr-links-are-typically-performed-by-the",
    "type": "claim",
    "title": "Ticket writes (state transitions, comments, PR links) are typically performed by the...",
    "lineStart": 38,
    "lineEnd": 38,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Ticket writes (state transitions, comments, PR links) are typically performed by the coding agent using tools available in the workflow/runtime environment.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-1-problem-statement-a-successful-run-can-end-at-a-workflow-defined-handoff-state-for-example-human-r",
    "type": "claim",
    "title": "A successful run can end at a workflow-defined handoff state (for example Human Revie...",
    "lineStart": 40,
    "lineEnd": 40,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A successful run can end at a workflow-defined handoff state (for example `Human Review`), not necessarily `Done`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr",
    "type": "goal",
    "title": "Poll the issue tracker on a fixed cadence and dispatch work with bounded concurrency.",
    "lineStart": 47,
    "lineEnd": 47,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Poll the issue tracker on a fixed cadence and dispatch work with bounded concurrency.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco",
    "type": "goal",
    "title": "Maintain a single authoritative orchestrator state for dispatch, retries, and reconci...",
    "lineStart": 48,
    "lineEnd": 48,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Maintain a single authoritative orchestrator state for dispatch, retries, and reconciliation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs",
    "type": "goal",
    "title": "Create deterministic per-issue workspaces and preserve them across runs.",
    "lineStart": 49,
    "lineEnd": 49,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Create deterministic per-issue workspaces and preserve them across runs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible",
    "type": "goal",
    "title": "Stop active runs when issue state changes make them ineligible.",
    "lineStart": 50,
    "lineEnd": 50,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Stop active runs when issue state changes make them ineligible.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-recover-from-transient-failures-with-exponential-backoff",
    "type": "goal",
    "title": "Recover from transient failures with exponential backoff.",
    "lineStart": 51,
    "lineEnd": 51,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Recover from transient failures with exponential backoff.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-load-runtime-behavior-from-a-repository-owned-workflow-md-contract",
    "type": "goal",
    "title": "Load runtime behavior from a repository-owned WORKFLOW.md contract.",
    "lineStart": 52,
    "lineEnd": 52,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Load runtime behavior from a repository-owned `WORKFLOW.md` contract.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-expose-operator-visible-observability-at-minimum-structured-logs",
    "type": "goal",
    "title": "Expose operator-visible observability (at minimum structured logs).",
    "lineStart": 53,
    "lineEnd": 53,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Expose operator-visible observability (at minimum structured logs).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "goal-2-1-goals-support-tracker-filesystem-driven-restart-recovery-without-requiring-a-persisten",
    "type": "goal",
    "title": "Support tracker/filesystem-driven restart recovery without requiring a persistent dat...",
    "lineStart": 54,
    "lineEnd": 54,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Support tracker/filesystem-driven restart recovery without requiring a persistent database; exact in-memory scheduler state is not restored.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-rich-web-ui-or-multi-tenant-control-plane",
    "type": "non_goal",
    "title": "Rich web UI or multi-tenant control plane.",
    "lineStart": 59,
    "lineEnd": 59,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Rich web UI or multi-tenant control plane.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-prescribing-a-specific-dashboard-or-terminal-ui-implementation",
    "type": "non_goal",
    "title": "Prescribing a specific dashboard or terminal UI implementation.",
    "lineStart": 60,
    "lineEnd": 60,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Prescribing a specific dashboard or terminal UI implementation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-general-purpose-workflow-engine-or-distributed-job-scheduler",
    "type": "non_goal",
    "title": "General-purpose workflow engine or distributed job scheduler.",
    "lineStart": 61,
    "lineEnd": 61,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "General-purpose workflow engine or distributed job scheduler.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-built-in-business-logic-for-how-to-edit-tickets-prs-or-comments-that-logic-lives",
    "type": "non_goal",
    "title": "Built-in business logic for how to edit tickets, PRs, or comments. (That logic lives...",
    "lineStart": 62,
    "lineEnd": 62,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Built-in business logic for how to edit tickets, PRs, or comments. (That logic lives in the workflow prompt and agent tooling.)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-mandating-strong-sandbox-controls-beyond-what-the-coding-agent-and-host-os-provi",
    "type": "non_goal",
    "title": "Mandating strong sandbox controls beyond what the coding agent and host OS provide.",
    "lineStart": 64,
    "lineEnd": 64,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Mandating strong sandbox controls beyond what the coding agent and host OS provide.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "non_goal-2-2-non-goals-mandating-a-single-default-approval-sandbox-or-operator-confirmation-posture-for",
    "type": "non_goal",
    "title": "Mandating a single default approval, sandbox, or operator-confirmation posture for al...",
    "lineStart": 65,
    "lineEnd": 65,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Mandating a single default approval, sandbox, or operator-confirmation posture for all implementations.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-reads-workflow-md",
    "type": "component",
    "title": "Reads WORKFLOW.md.",
    "lineStart": 73,
    "lineEnd": 73,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reads `WORKFLOW.md`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-parses-yaml-front-matter-and-prompt-body",
    "type": "component",
    "title": "Parses YAML front matter and prompt body.",
    "lineStart": 74,
    "lineEnd": 74,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Parses YAML front matter and prompt body.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-returns-config-prompttemplate",
    "type": "component",
    "title": "Returns {config, prompttemplate}.",
    "lineStart": 75,
    "lineEnd": 75,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Returns `{config, prompt_template}`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-exposes-typed-getters-for-workflow-config-values",
    "type": "component",
    "title": "Exposes typed getters for workflow config values.",
    "lineStart": 78,
    "lineEnd": 78,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Exposes typed getters for workflow config values.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-applies-defaults-and-environment-variable-indirection",
    "type": "component",
    "title": "Applies defaults and environment variable indirection.",
    "lineStart": 79,
    "lineEnd": 79,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Applies defaults and environment variable indirection.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-performs-validation-used-by-the-orchestrator-before-dispatch",
    "type": "component",
    "title": "Performs validation used by the orchestrator before dispatch.",
    "lineStart": 80,
    "lineEnd": 80,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Performs validation used by the orchestrator before dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-fetches-candidate-issues-in-active-states",
    "type": "component",
    "title": "Fetches candidate issues in active states.",
    "lineStart": 83,
    "lineEnd": 83,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fetches candidate issues in active states.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-fetches-current-states-for-specific-issue-ids-reconciliation",
    "type": "component",
    "title": "Fetches current states for specific issue IDs (reconciliation).",
    "lineStart": 84,
    "lineEnd": 84,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fetches current states for specific issue IDs (reconciliation).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-fetches-terminal-state-issues-during-startup-cleanup",
    "type": "component",
    "title": "Fetches terminal-state issues during startup cleanup.",
    "lineStart": 85,
    "lineEnd": 85,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fetches terminal-state issues during startup cleanup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model",
    "type": "component",
    "title": "Normalizes tracker payloads into a stable issue model.",
    "lineStart": 86,
    "lineEnd": 86,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Normalizes tracker payloads into a stable issue model.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-owns-the-poll-tick",
    "type": "component",
    "title": "Owns the poll tick.",
    "lineStart": 89,
    "lineEnd": 89,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Owns the poll tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-owns-the-in-memory-runtime-state",
    "type": "component",
    "title": "Owns the in-memory runtime state.",
    "lineStart": 90,
    "lineEnd": 90,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Owns the in-memory runtime state.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-decides-which-issues-to-dispatch-retry-stop-or-release",
    "type": "component",
    "title": "Decides which issues to dispatch, retry, stop, or release.",
    "lineStart": 91,
    "lineEnd": 91,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Decides which issues to dispatch, retry, stop, or release.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-tracks-session-metrics-and-retry-queue-state",
    "type": "component",
    "title": "Tracks session metrics and retry queue state.",
    "lineStart": 92,
    "lineEnd": 92,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Tracks session metrics and retry queue state.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-maps-issue-identifiers-to-workspace-paths",
    "type": "component",
    "title": "Maps issue identifiers to workspace paths.",
    "lineStart": 95,
    "lineEnd": 95,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Maps issue identifiers to workspace paths.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-ensures-per-issue-workspace-directories-exist",
    "type": "component",
    "title": "Ensures per-issue workspace directories exist.",
    "lineStart": 96,
    "lineEnd": 96,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Ensures per-issue workspace directories exist.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-runs-workspace-lifecycle-hooks",
    "type": "component",
    "title": "Runs workspace lifecycle hooks.",
    "lineStart": 97,
    "lineEnd": 97,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runs workspace lifecycle hooks.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-cleans-workspaces-for-terminal-issues",
    "type": "component",
    "title": "Cleans workspaces for terminal issues.",
    "lineStart": 98,
    "lineEnd": 98,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Cleans workspaces for terminal issues.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-creates-workspace",
    "type": "component",
    "title": "Creates workspace.",
    "lineStart": 101,
    "lineEnd": 101,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Creates workspace.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-builds-prompt-from-issue-workflow-template",
    "type": "component",
    "title": "Builds prompt from issue + workflow template.",
    "lineStart": 102,
    "lineEnd": 102,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Builds prompt from issue + workflow template.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-launches-the-coding-agent-app-server-client",
    "type": "component",
    "title": "Launches the coding agent app-server client.",
    "lineStart": 103,
    "lineEnd": 103,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Launches the coding agent app-server client.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-streams-agent-updates-back-to-the-orchestrator",
    "type": "component",
    "title": "Streams agent updates back to the orchestrator.",
    "lineStart": 104,
    "lineEnd": 104,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Streams agent updates back to the orchestrator.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-status-surface-optional",
    "type": "component",
    "title": "Status Surface (OPTIONAL)",
    "lineStart": 106,
    "lineEnd": 106,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Status Surface` (OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-presents-human-readable-runtime-status-for-example-terminal-output-dashboard-or-",
    "type": "component",
    "title": "Presents human-readable runtime status (for example terminal output, dashboard, or ot...",
    "lineStart": 107,
    "lineEnd": 107,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Presents human-readable runtime status (for example terminal output, dashboard, or other operator-facing view).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "component-3-1-main-components-emits-structured-runtime-logs-to-one-or-more-configured-sinks",
    "type": "component",
    "title": "Emits structured runtime logs to one or more configured sinks.",
    "lineStart": 111,
    "lineEnd": 111,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Emits structured runtime logs to one or more configured sinks.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-workflow-md-prompt-body",
    "type": "claim",
    "title": "WORKFLOW.md prompt body.",
    "lineStart": 118,
    "lineEnd": 118,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`WORKFLOW.md` prompt body.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-team-specific-rules-for-ticket-handling-validation-and-handoff",
    "type": "claim",
    "title": "Team-specific rules for ticket handling, validation, and handoff.",
    "lineStart": 119,
    "lineEnd": 119,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Team-specific rules for ticket handling, validation, and handoff.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-parses-front-matter-into-typed-runtime-settings",
    "type": "claim",
    "title": "Parses front matter into typed runtime settings.",
    "lineStart": 122,
    "lineEnd": 122,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Parses front matter into typed runtime settings.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-handles-defaults-environment-tokens-and-path-normalization",
    "type": "claim",
    "title": "Handles defaults, environment tokens, and path normalization.",
    "lineStart": 123,
    "lineEnd": 123,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Handles defaults, environment tokens, and path normalization.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-polling-loop-issue-eligibility-concurrency-retries-reconciliation",
    "type": "claim",
    "title": "Polling loop, issue eligibility, concurrency, retries, reconciliation.",
    "lineStart": 126,
    "lineEnd": 126,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Polling loop, issue eligibility, concurrency, retries, reconciliation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-2-abstraction-levels-filesystem-lifecycle-workspace-preparation-coding-agent-protocol",
    "type": "dependency",
    "title": "Filesystem lifecycle, workspace preparation, coding-agent protocol.",
    "lineStart": 129,
    "lineEnd": 129,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Filesystem lifecycle, workspace preparation, coding-agent protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data",
    "type": "dependency",
    "title": "API calls and normalization for tracker data.",
    "lineStart": 132,
    "lineEnd": 132,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "API calls and normalization for tracker data.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-3-2-abstraction-levels-observability-layer-logs-optional-status-surface",
    "type": "requirement",
    "title": "Observability Layer (logs + OPTIONAL status surface)",
    "lineStart": 134,
    "lineEnd": 134,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Observability Layer` (logs + OPTIONAL status surface)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-3-2-abstraction-levels-operator-visibility-into-orchestrator-and-agent-behavior",
    "type": "claim",
    "title": "Operator visibility into orchestrator and agent behavior.",
    "lineStart": 135,
    "lineEnd": 135,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Operator visibility into orchestrator and agent behavior.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version",
    "type": "dependency",
    "title": "Issue tracker API (Linear for tracker.kind: linear in this specification version).",
    "lineStart": 139,
    "lineEnd": 139,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue tracker API (Linear for `tracker.kind: linear` in this specification version).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-3-external-dependencies-local-filesystem-for-workspaces-and-logs",
    "type": "dependency",
    "title": "Local filesystem for workspaces and logs.",
    "lineStart": 140,
    "lineEnd": 140,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Local filesystem for workspaces and logs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-3-external-dependencies-optional-workspace-population-tooling-for-example-git-cli-if-used",
    "type": "dependency",
    "title": "OPTIONAL workspace population tooling (for example Git CLI, if used).",
    "lineStart": 141,
    "lineEnd": 141,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "OPTIONAL workspace population tooling (for example Git CLI, if used).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-3-external-dependencies-coding-agent-executable-that-supports-the-targeted-codex-app-server-mode",
    "type": "dependency",
    "title": "Coding-agent executable that supports the targeted Codex app-server mode.",
    "lineStart": 142,
    "lineEnd": 142,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Coding-agent executable that supports the targeted Codex app-server mode.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-3-3-external-dependencies-host-environment-authentication-for-the-issue-tracker-and-coding-agent",
    "type": "dependency",
    "title": "Host environment authentication for the issue tracker and coding agent.",
    "lineStart": 143,
    "lineEnd": 143,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Host environment authentication for the issue tracker and coding agent.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-id-string",
    "type": "claim",
    "title": "id (string)",
    "lineStart": 155,
    "lineEnd": 155,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`id` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-stable-tracker-internal-id",
    "type": "claim",
    "title": "Stable tracker-internal ID.",
    "lineStart": 156,
    "lineEnd": 156,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Stable tracker-internal ID.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-identifier-string",
    "type": "claim",
    "title": "identifier (string)",
    "lineStart": 157,
    "lineEnd": 157,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`identifier` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-human-readable-ticket-key-example-abc-123",
    "type": "claim",
    "title": "Human-readable ticket key (example: ABC-123).",
    "lineStart": 158,
    "lineEnd": 158,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Human-readable ticket key (example: `ABC-123`).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-title-string",
    "type": "claim",
    "title": "title (string)",
    "lineStart": 159,
    "lineEnd": 159,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`title` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-description-string-or-null",
    "type": "claim",
    "title": "description (string or null)",
    "lineStart": 160,
    "lineEnd": 160,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`description` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-priority-integer-or-null",
    "type": "claim",
    "title": "priority (integer or null)",
    "lineStart": 161,
    "lineEnd": 161,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`priority` (integer or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-lower-numbers-are-higher-priority-in-dispatch-sorting",
    "type": "claim",
    "title": "Lower numbers are higher priority in dispatch sorting.",
    "lineStart": 162,
    "lineEnd": 162,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Lower numbers are higher priority in dispatch sorting.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-state-string",
    "type": "claim",
    "title": "state (string)",
    "lineStart": 163,
    "lineEnd": 163,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`state` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-current-tracker-state-name",
    "type": "claim",
    "title": "Current tracker state name.",
    "lineStart": 164,
    "lineEnd": 164,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Current tracker state name.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-branchname-string-or-null",
    "type": "claim",
    "title": "branchname (string or null)",
    "lineStart": 165,
    "lineEnd": 165,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`branch_name` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-tracker-provided-branch-metadata-if-available",
    "type": "claim",
    "title": "Tracker-provided branch metadata if available.",
    "lineStart": 166,
    "lineEnd": 166,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Tracker-provided branch metadata if available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-url-string-or-null",
    "type": "claim",
    "title": "url (string or null)",
    "lineStart": 167,
    "lineEnd": 167,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`url` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-labels-list-of-strings",
    "type": "claim",
    "title": "labels (list of strings)",
    "lineStart": 168,
    "lineEnd": 168,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`labels` (list of strings)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-normalized-to-lowercase",
    "type": "claim",
    "title": "Normalized to lowercase.",
    "lineStart": 169,
    "lineEnd": 169,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Normalized to lowercase.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-blockedby-list-of-blocker-refs",
    "type": "claim",
    "title": "blockedby (list of blocker refs)",
    "lineStart": 170,
    "lineEnd": 170,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`blocked_by` (list of blocker refs)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-each-blocker-ref-contains",
    "type": "claim",
    "title": "Each blocker ref contains:",
    "lineStart": 171,
    "lineEnd": 171,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Each blocker ref contains:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-id-string-or-null",
    "type": "claim",
    "title": "id (string or null)",
    "lineStart": 172,
    "lineEnd": 172,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`id` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-identifier-string-or-null",
    "type": "claim",
    "title": "identifier (string or null)",
    "lineStart": 173,
    "lineEnd": 173,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`identifier` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-state-string-or-null",
    "type": "claim",
    "title": "state (string or null)",
    "lineStart": 174,
    "lineEnd": 174,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`state` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-createdat-timestamp-or-null",
    "type": "claim",
    "title": "createdat (timestamp or null)",
    "lineStart": 175,
    "lineEnd": 175,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`created_at` (timestamp or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-1-issue-updatedat-timestamp-or-null",
    "type": "claim",
    "title": "updatedat (timestamp or null)",
    "lineStart": 176,
    "lineEnd": 176,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`updated_at` (timestamp or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-2-workflow-definition-config-map",
    "type": "claim",
    "title": "config (map)",
    "lineStart": 182,
    "lineEnd": 182,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`config` (map)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-2-workflow-definition-yaml-front-matter-root-object",
    "type": "claim",
    "title": "YAML front matter root object.",
    "lineStart": 183,
    "lineEnd": 183,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "YAML front matter root object.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-2-workflow-definition-prompttemplate-string",
    "type": "claim",
    "title": "prompttemplate (string)",
    "lineStart": 184,
    "lineEnd": 184,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`prompt_template` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-2-workflow-definition-markdown-body-after-front-matter-trimmed",
    "type": "claim",
    "title": "Markdown body after front matter, trimmed.",
    "lineStart": 185,
    "lineEnd": 185,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Markdown body after front matter, trimmed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-poll-interval",
    "type": "claim",
    "title": "poll interval",
    "lineStart": 193,
    "lineEnd": 193,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "poll interval",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-workspace-root",
    "type": "claim",
    "title": "workspace root",
    "lineStart": 194,
    "lineEnd": 194,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "workspace root",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-active-and-terminal-issue-states",
    "type": "claim",
    "title": "active and terminal issue states",
    "lineStart": 195,
    "lineEnd": 195,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "active and terminal issue states",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-concurrency-limits",
    "type": "claim",
    "title": "concurrency limits",
    "lineStart": 196,
    "lineEnd": 196,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "concurrency limits",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-coding-agent-executable-args-timeouts",
    "type": "claim",
    "title": "coding-agent executable/args/timeouts",
    "lineStart": 197,
    "lineEnd": 197,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "coding-agent executable/args/timeouts",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-3-service-config-typed-view-workspace-hooks",
    "type": "claim",
    "title": "workspace hooks",
    "lineStart": 198,
    "lineEnd": 198,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "workspace hooks",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-4-workspace-path-absolute-workspace-path",
    "type": "claim",
    "title": "path (absolute workspace path)",
    "lineStart": 206,
    "lineEnd": 206,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`path` (absolute workspace path)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-4-workspace-workspacekey-sanitized-issue-identifier",
    "type": "claim",
    "title": "workspacekey (sanitized issue identifier)",
    "lineStart": 207,
    "lineEnd": 207,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace_key` (sanitized issue identifier)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-4-workspace-creatednow-boolean-used-to-gate-aftercreate-hook",
    "type": "claim",
    "title": "creatednow (boolean, used to gate aftercreate hook)",
    "lineStart": 208,
    "lineEnd": 208,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`created_now` (boolean, used to gate `after_create` hook)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-issueid",
    "type": "claim",
    "title": "issueid",
    "lineStart": 216,
    "lineEnd": 216,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue_id`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-issueidentifier",
    "type": "claim",
    "title": "issueidentifier",
    "lineStart": 217,
    "lineEnd": 217,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue_identifier`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-attempt-integer-or-null-null-for-first-run-1-for-retries-continuation",
    "type": "claim",
    "title": "attempt (integer or null, null for first run, >=1 for retries/continuation)",
    "lineStart": 218,
    "lineEnd": 218,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`attempt` (integer or null, `null` for first run, `>=1` for retries/continuation)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-workspacepath",
    "type": "claim",
    "title": "workspacepath",
    "lineStart": 219,
    "lineEnd": 219,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace_path`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-startedat",
    "type": "claim",
    "title": "startedat",
    "lineStart": 220,
    "lineEnd": 220,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`started_at`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-5-run-attempt-status",
    "type": "claim",
    "title": "status",
    "lineStart": 221,
    "lineEnd": 221,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`status`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-4-1-5-run-attempt-error-optional",
    "type": "requirement",
    "title": "error (OPTIONAL)",
    "lineStart": 222,
    "lineEnd": 222,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`error` (OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-sessionid-string-threadid-turnid",
    "type": "claim",
    "title": "sessionid (string, <threadid>-<turnid>)",
    "lineStart": 230,
    "lineEnd": 230,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`session_id` (string, `<thread_id>-<turn_id>`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-threadid-string",
    "type": "claim",
    "title": "threadid (string)",
    "lineStart": 231,
    "lineEnd": 231,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`thread_id` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-turnid-string",
    "type": "claim",
    "title": "turnid (string)",
    "lineStart": 232,
    "lineEnd": 232,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_id` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-codexappserverpid-string-or-null",
    "type": "claim",
    "title": "codexappserverpid (string or null)",
    "lineStart": 233,
    "lineEnd": 233,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_app_server_pid` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastcodexevent-string-enum-or-null",
    "type": "claim",
    "title": "lastcodexevent (string/enum or null)",
    "lineStart": 234,
    "lineEnd": 234,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_codex_event` (string/enum or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastcodextimestamp-timestamp-or-null",
    "type": "claim",
    "title": "lastcodextimestamp (timestamp or null)",
    "lineStart": 235,
    "lineEnd": 235,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_codex_timestamp` (timestamp or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastcodexmessage-summarized-payload",
    "type": "claim",
    "title": "lastcodexmessage (summarized payload)",
    "lineStart": 236,
    "lineEnd": 236,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_codex_message` (summarized payload)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-codexinputtokens-integer",
    "type": "claim",
    "title": "codexinputtokens (integer)",
    "lineStart": 237,
    "lineEnd": 237,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_input_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-codexoutputtokens-integer",
    "type": "claim",
    "title": "codexoutputtokens (integer)",
    "lineStart": 238,
    "lineEnd": 238,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_output_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-codextotaltokens-integer",
    "type": "claim",
    "title": "codextotaltokens (integer)",
    "lineStart": 239,
    "lineEnd": 239,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_total_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastreportedinputtokens-integer",
    "type": "claim",
    "title": "lastreportedinputtokens (integer)",
    "lineStart": 240,
    "lineEnd": 240,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_reported_input_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastreportedoutputtokens-integer",
    "type": "claim",
    "title": "lastreportedoutputtokens (integer)",
    "lineStart": 241,
    "lineEnd": 241,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_reported_output_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-lastreportedtotaltokens-integer",
    "type": "claim",
    "title": "lastreportedtotaltokens (integer)",
    "lineStart": 242,
    "lineEnd": 242,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_reported_total_tokens` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-turncount-integer",
    "type": "claim",
    "title": "turncount (integer)",
    "lineStart": 243,
    "lineEnd": 243,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_count` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-6-live-session-agent-session-metadata-number-of-coding-agent-turns-started-within-the-current-worker-lifetime",
    "type": "claim",
    "title": "Number of coding-agent turns started within the current worker lifetime.",
    "lineStart": 244,
    "lineEnd": 244,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Number of coding-agent turns started within the current worker lifetime.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-issueid",
    "type": "claim",
    "title": "issueid",
    "lineStart": 252,
    "lineEnd": 252,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue_id`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-identifier-best-effort-human-id-for-status-surfaces-logs",
    "type": "claim",
    "title": "identifier (best-effort human ID for status surfaces/logs)",
    "lineStart": 253,
    "lineEnd": 253,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`identifier` (best-effort human ID for status surfaces/logs)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-attempt-integer-1-based-for-retry-queue",
    "type": "claim",
    "title": "attempt (integer, 1-based for retry queue)",
    "lineStart": 254,
    "lineEnd": 254,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`attempt` (integer, 1-based for retry queue)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-dueatms-monotonic-clock-timestamp",
    "type": "claim",
    "title": "dueatms (monotonic clock timestamp)",
    "lineStart": 255,
    "lineEnd": 255,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`due_at_ms` (monotonic clock timestamp)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-timerhandle-runtime-specific-timer-reference",
    "type": "claim",
    "title": "timerhandle (runtime-specific timer reference)",
    "lineStart": 256,
    "lineEnd": 256,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`timer_handle` (runtime-specific timer reference)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-7-retry-entry-error-string-or-null",
    "type": "claim",
    "title": "error (string or null)",
    "lineStart": 257,
    "lineEnd": 257,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`error` (string or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-pollintervalms-current-effective-poll-interval",
    "type": "claim",
    "title": "pollintervalms (current effective poll interval)",
    "lineStart": 265,
    "lineEnd": 265,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`poll_interval_ms` (current effective poll interval)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-maxconcurrentagents-current-effective-global-concurrency-limit",
    "type": "claim",
    "title": "maxconcurrentagents (current effective global concurrency limit)",
    "lineStart": 266,
    "lineEnd": 266,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_concurrent_agents` (current effective global concurrency limit)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-running-map-issueid-running-entry",
    "type": "claim",
    "title": "running (map issueid -> running entry)",
    "lineStart": 267,
    "lineEnd": 267,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`running` (map `issue_id -> running entry`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-claimed-set-of-issue-ids-reserved-running-retrying",
    "type": "claim",
    "title": "claimed (set of issue IDs reserved/running/retrying)",
    "lineStart": 268,
    "lineEnd": 268,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`claimed` (set of issue IDs reserved/running/retrying)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-retryattempts-map-issueid-retryentry",
    "type": "claim",
    "title": "retryattempts (map issueid -> RetryEntry)",
    "lineStart": 269,
    "lineEnd": 269,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`retry_attempts` (map `issue_id -> RetryEntry`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-completed-set-of-issue-ids-bookkeeping-only-not-dispatch-gating",
    "type": "claim",
    "title": "completed (set of issue IDs; bookkeeping only, not dispatch gating)",
    "lineStart": 270,
    "lineEnd": 270,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`completed` (set of issue IDs; bookkeeping only, not dispatch gating)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-codextotals-aggregate-tokens-runtime-seconds",
    "type": "claim",
    "title": "codextotals (aggregate tokens + runtime seconds)",
    "lineStart": 271,
    "lineEnd": 271,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_totals` (aggregate tokens + runtime seconds)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-1-8-orchestrator-runtime-state-codexratelimits-latest-rate-limit-snapshot-from-agent-events",
    "type": "claim",
    "title": "codexratelimits (latest rate-limit snapshot from agent events)",
    "lineStart": 272,
    "lineEnd": 272,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_rate_limits` (latest rate-limit snapshot from agent events)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-issue-id",
    "type": "claim",
    "title": "Issue ID",
    "lineStart": 276,
    "lineEnd": 276,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Issue ID`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-use-for-tracker-lookups-and-internal-map-keys",
    "type": "claim",
    "title": "Use for tracker lookups and internal map keys.",
    "lineStart": 277,
    "lineEnd": 277,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Use for tracker lookups and internal map keys.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-issue-identifier",
    "type": "claim",
    "title": "Issue Identifier",
    "lineStart": 278,
    "lineEnd": 278,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Issue Identifier`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-use-for-human-readable-logs-and-workspace-naming",
    "type": "claim",
    "title": "Use for human-readable logs and workspace naming.",
    "lineStart": 279,
    "lineEnd": 279,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Use for human-readable logs and workspace naming.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-workspace-key",
    "type": "claim",
    "title": "Workspace Key",
    "lineStart": 280,
    "lineEnd": 280,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Workspace Key`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-derive-from-issue-identifier-by-replacing-any-character-not-in-a-za-z0-9-with",
    "type": "claim",
    "title": "Derive from issue.identifier by replacing any character not in [A-Za-z0-9.-] with .",
    "lineStart": 281,
    "lineEnd": 281,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Derive from `issue.identifier` by replacing any character not in `[A-Za-z0-9._-]` with `_`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-use-the-sanitized-value-for-the-workspace-directory-name",
    "type": "claim",
    "title": "Use the sanitized value for the workspace directory name.",
    "lineStart": 282,
    "lineEnd": 282,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Use the sanitized value for the workspace directory name.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-normalized-issue-state",
    "type": "claim",
    "title": "Normalized Issue State",
    "lineStart": 283,
    "lineEnd": 283,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Normalized Issue State`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-compare-states-after-lowercase",
    "type": "claim",
    "title": "Compare states after lowercase.",
    "lineStart": 284,
    "lineEnd": 284,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Compare states after `lowercase`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-session-id",
    "type": "claim",
    "title": "Session ID",
    "lineStart": 285,
    "lineEnd": 285,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Session ID`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-4-2-stable-identifiers-and-normalization-rules-compose-from-coding-agent-threadid-and-turnid-as-threadid-turnid",
    "type": "claim",
    "title": "Compose from coding-agent threadid and turnid as <threadid>-<turnid>.",
    "lineStart": 286,
    "lineEnd": 286,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Compose from coding-agent `thread_id` and `turn_id` as `<thread_id>-<turn_id>`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-1-file-discovery-and-path-resolution-if-the-file-cannot-be-read-return-missingworkflowfile-error",
    "type": "claim",
    "title": "If the file cannot be read, return missingworkflowfile error.",
    "lineStart": 299,
    "lineEnd": 299,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the file cannot be read, return `missing_workflow_file` error.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-1-file-discovery-and-path-resolution-the-workflow-file-is-expected-to-be-repository-owned-and-version-controlled",
    "type": "claim",
    "title": "The workflow file is expected to be repository-owned and version-controlled.",
    "lineStart": 300,
    "lineEnd": 300,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The workflow file is expected to be repository-owned and version-controlled.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-2-file-format-workflow-md-is-a-markdown-file-with-optional-yaml-front-matter",
    "type": "requirement",
    "title": "WORKFLOW.md is a Markdown file with OPTIONAL YAML front matter.",
    "lineStart": 304,
    "lineEnd": 304,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`WORKFLOW.md` is a Markdown file with OPTIONAL YAML front matter.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "type": "requirement",
    "title": "WORKFLOW.md SHOULD be self-contained enough to describe and run different workflows (...",
    "lineStart": 308,
    "lineEnd": 308,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`WORKFLOW.md` SHOULD be self-contained enough to describe and run different workflows (prompt, runtime settings, hooks, and tracker selection/config) without requiring out-of-band service-specific configuration.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-if-file-starts-with-parse-lines-until-the-next-as-yaml-front-matter",
    "type": "claim",
    "title": "If file starts with ---, parse lines until the next --- as YAML front matter.",
    "lineStart": 314,
    "lineEnd": 314,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If file starts with `---`, parse lines until the next `---` as YAML front matter.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-remaining-lines-become-the-prompt-body",
    "type": "claim",
    "title": "Remaining lines become the prompt body.",
    "lineStart": 315,
    "lineEnd": 315,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Remaining lines become the prompt body.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-if-front-matter-is-absent-treat-the-entire-file-as-prompt-body-and-use-an-empty-",
    "type": "claim",
    "title": "If front matter is absent, treat the entire file as prompt body and use an empty conf...",
    "lineStart": 316,
    "lineEnd": 316,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If front matter is absent, treat the entire file as prompt body and use an empty config map.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-2-file-format-yaml-front-matter-must-decode-to-a-map-object-non-map-yaml-is-an-error",
    "type": "requirement",
    "title": "YAML front matter MUST decode to a map/object; non-map YAML is an error.",
    "lineStart": 317,
    "lineEnd": 317,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "YAML front matter MUST decode to a map/object; non-map YAML is an error.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-prompt-body-is-trimmed-before-use",
    "type": "claim",
    "title": "Prompt body is trimmed before use.",
    "lineStart": 318,
    "lineEnd": 318,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Prompt body is trimmed before use.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-config-front-matter-root-object-not-nested-under-a-config-key",
    "type": "claim",
    "title": "config: front matter root object (not nested under a config key).",
    "lineStart": 322,
    "lineEnd": 322,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`config`: front matter root object (not nested under a `config` key).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-2-file-format-prompttemplate-trimmed-markdown-body",
    "type": "claim",
    "title": "prompttemplate: trimmed Markdown body.",
    "lineStart": 323,
    "lineEnd": 323,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`prompt_template`: trimmed Markdown body.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-tracker",
    "type": "claim",
    "title": "tracker",
    "lineStart": 329,
    "lineEnd": 329,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-polling",
    "type": "claim",
    "title": "polling",
    "lineStart": 330,
    "lineEnd": 330,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`polling`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-workspace",
    "type": "claim",
    "title": "workspace",
    "lineStart": 331,
    "lineEnd": 331,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-hooks",
    "type": "claim",
    "title": "hooks",
    "lineStart": 332,
    "lineEnd": 332,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-agent",
    "type": "claim",
    "title": "agent",
    "lineStart": 333,
    "lineEnd": 333,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`agent`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-front-matter-schema-codex",
    "type": "claim",
    "title": "codex",
    "lineStart": 334,
    "lineEnd": 334,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-front-matter-schema-unknown-keys-should-be-ignored-for-forward-compatibility",
    "type": "requirement",
    "title": "Unknown keys SHOULD be ignored for forward compatibility.",
    "lineStart": 336,
    "lineEnd": 336,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unknown keys SHOULD be ignored for forward compatibility.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-front-matter-schema-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev",
    "type": "requirement",
    "title": "The workflow front matter is extensible. Extensions MAY define additional top-level k...",
    "lineStart": 340,
    "lineEnd": 340,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The workflow front matter is extensible. Extensions MAY define additional top-level keys without changing the core schema above.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet",
    "type": "requirement",
    "title": "Extensions SHOULD document their field schema, defaults, validation rules, and whethe...",
    "lineStart": 342,
    "lineEnd": 342,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Extensions SHOULD document their field schema, defaults, validation rules, and whether changes apply dynamically or require restart.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-kind-string",
    "type": "claim",
    "title": "kind (string)",
    "lineStart": 349,
    "lineEnd": 349,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`kind` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-1-tracker-object-required-for-dispatch",
    "type": "requirement",
    "title": "REQUIRED for dispatch.",
    "lineStart": 350,
    "lineEnd": 350,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "REQUIRED for dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-current-supported-value-linear",
    "type": "claim",
    "title": "Current supported value: linear",
    "lineStart": 351,
    "lineEnd": 351,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Current supported value: `linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-endpoint-string",
    "type": "claim",
    "title": "endpoint (string)",
    "lineStart": 352,
    "lineEnd": 352,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`endpoint` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "Default for tracker.kind == \"linear\": https://api.linear.app/graphql",
    "lineStart": 353,
    "lineEnd": 353,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default for `tracker.kind == \"linear\"`: `https://api.linear.app/graphql`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-apikey-string",
    "type": "claim",
    "title": "apikey (string)",
    "lineStart": 354,
    "lineEnd": 354,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`api_key` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-1-tracker-object-may-be-a-literal-token-or-varname",
    "type": "requirement",
    "title": "MAY be a literal token or $VARNAME.",
    "lineStart": 355,
    "lineEnd": 355,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "MAY be a literal token or `$VAR_NAME`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-canonical-environment-variable-for-tracker-kind-linear-linearapikey",
    "type": "claim",
    "title": "Canonical environment variable for tracker.kind == \"linear\": LINEARAPIKEY.",
    "lineStart": 356,
    "lineEnd": 356,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Canonical environment variable for `tracker.kind == \"linear\"`: `LINEAR_API_KEY`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-if-varname-resolves-to-an-empty-string-treat-the-key-as-missing",
    "type": "claim",
    "title": "If $VARNAME resolves to an empty string, treat the key as missing.",
    "lineStart": 357,
    "lineEnd": 357,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If `$VAR_NAME` resolves to an empty string, treat the key as missing.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-projectslug-string",
    "type": "claim",
    "title": "projectslug (string)",
    "lineStart": 358,
    "lineEnd": 358,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`project_slug` (string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-1-tracker-object-required-for-dispatch-when-tracker-kind-linear",
    "type": "requirement",
    "title": "REQUIRED for dispatch when tracker.kind == \"linear\".",
    "lineStart": 359,
    "lineEnd": 359,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "REQUIRED for dispatch when `tracker.kind == \"linear\"`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-activestates-list-of-strings",
    "type": "claim",
    "title": "activestates (list of strings)",
    "lineStart": 360,
    "lineEnd": 360,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`active_states` (list of strings)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-default-todo-in-progress",
    "type": "claim",
    "title": "Default: Todo, In Progress",
    "lineStart": 361,
    "lineEnd": 361,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `Todo`, `In Progress`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-terminalstates-list-of-strings",
    "type": "claim",
    "title": "terminalstates (list of strings)",
    "lineStart": 362,
    "lineEnd": 362,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`terminal_states` (list of strings)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-1-tracker-object-default-closed-cancelled-canceled-duplicate-done",
    "type": "claim",
    "title": "Default: Closed, Cancelled, Canceled, Duplicate, Done",
    "lineStart": 363,
    "lineEnd": 363,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `Closed`, `Cancelled`, `Canceled`, `Duplicate`, `Done`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-2-polling-object-intervalms-integer",
    "type": "claim",
    "title": "intervalms (integer)",
    "lineStart": 369,
    "lineEnd": 369,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`interval_ms` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-2-polling-object-default-30000",
    "type": "claim",
    "title": "Default: 30000",
    "lineStart": 370,
    "lineEnd": 370,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `30000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-2-polling-object-changes-should-be-re-applied-at-runtime-and-affect-future-tick-scheduling-withou",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect future tick scheduling without res...",
    "lineStart": 371,
    "lineEnd": 371,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changes SHOULD be re-applied at runtime and affect future tick scheduling without restart.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-3-workspace-object-root-path-string-or-var",
    "type": "claim",
    "title": "root (path string or $VAR)",
    "lineStart": 377,
    "lineEnd": 377,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`root` (path string or `$VAR`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-3-workspace-object-default-system-temp-symphonyworkspaces",
    "type": "claim",
    "title": "Default: <system-temp>/symphonyworkspaces",
    "lineStart": 378,
    "lineEnd": 378,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `<system-temp>/symphony_workspaces`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-3-workspace-object-is-expanded",
    "type": "claim",
    "title": "~ is expanded.",
    "lineStart": 379,
    "lineEnd": 379,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`~` is expanded.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-3-workspace-object-relative-paths-are-resolved-relative-to-the-directory-containing-workflow-md",
    "type": "claim",
    "title": "Relative paths are resolved relative to the directory containing WORKFLOW.md.",
    "lineStart": 380,
    "lineEnd": 380,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Relative paths are resolved relative to the directory containing `WORKFLOW.md`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-3-workspace-object-the-effective-workspace-root-is-normalized-to-an-absolute-path-before-use",
    "type": "claim",
    "title": "The effective workspace root is normalized to an absolute path before use.",
    "lineStart": 381,
    "lineEnd": 381,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The effective workspace root is normalized to an absolute path before use.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-aftercreate-multiline-shell-script-string-optional",
    "type": "requirement",
    "title": "aftercreate (multiline shell script string, OPTIONAL)",
    "lineStart": 387,
    "lineEnd": 387,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_create` (multiline shell script string, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-runs-only-when-a-workspace-directory-is-newly-created",
    "type": "claim",
    "title": "Runs only when a workspace directory is newly created.",
    "lineStart": 388,
    "lineEnd": 388,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runs only when a workspace directory is newly created.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-aborts-workspace-creation",
    "type": "claim",
    "title": "Failure aborts workspace creation.",
    "lineStart": 389,
    "lineEnd": 389,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Failure aborts workspace creation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-beforerun-multiline-shell-script-string-optional",
    "type": "requirement",
    "title": "beforerun (multiline shell script string, OPTIONAL)",
    "lineStart": 390,
    "lineEnd": 390,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_run` (multiline shell script string, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-runs-before-each-agent-attempt-after-workspace-preparation-and-before-launching-",
    "type": "claim",
    "title": "Runs before each agent attempt after workspace preparation and before launching the c...",
    "lineStart": 391,
    "lineEnd": 391,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runs before each agent attempt after workspace preparation and before launching the coding agent.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-aborts-the-current-attempt",
    "type": "claim",
    "title": "Failure aborts the current attempt.",
    "lineStart": 393,
    "lineEnd": 393,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Failure aborts the current attempt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-afterrun-multiline-shell-script-string-optional",
    "type": "requirement",
    "title": "afterrun (multiline shell script string, OPTIONAL)",
    "lineStart": 394,
    "lineEnd": 394,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_run` (multiline shell script string, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w",
    "type": "claim",
    "title": "Runs after each agent attempt (success, failure, timeout, or cancellation) once the w...",
    "lineStart": 395,
    "lineEnd": 395,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runs after each agent attempt (success, failure, timeout, or cancellation) once the workspace exists.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored",
    "type": "claim",
    "title": "Failure is logged but ignored.",
    "lineStart": 397,
    "lineEnd": 397,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Failure is logged but ignored.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-beforeremove-multiline-shell-script-string-optional",
    "type": "requirement",
    "title": "beforeremove (multiline shell script string, OPTIONAL)",
    "lineStart": 398,
    "lineEnd": 398,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_remove` (multiline shell script string, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-runs-before-workspace-deletion-if-the-directory-exists",
    "type": "claim",
    "title": "Runs before workspace deletion if the directory exists.",
    "lineStart": 399,
    "lineEnd": 399,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runs before workspace deletion if the directory exists.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds",
    "type": "claim",
    "title": "Failure is logged but ignored; cleanup still proceeds.",
    "lineStart": 400,
    "lineEnd": 400,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Failure is logged but ignored; cleanup still proceeds.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-timeoutms-integer-optional",
    "type": "requirement",
    "title": "timeoutms (integer, OPTIONAL)",
    "lineStart": 401,
    "lineEnd": 401,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`timeout_ms` (integer, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-default-60000",
    "type": "claim",
    "title": "Default: 60000",
    "lineStart": 402,
    "lineEnd": 402,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `60000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-applies-to-all-workspace-hooks",
    "type": "claim",
    "title": "Applies to all workspace hooks.",
    "lineStart": 403,
    "lineEnd": 403,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Applies to all workspace hooks.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation",
    "type": "claim",
    "title": "Invalid values fail configuration validation.",
    "lineStart": 404,
    "lineEnd": 404,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid values fail configuration validation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime for future hook executions.",
    "lineStart": 405,
    "lineEnd": 405,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changes SHOULD be re-applied at runtime for future hook executions.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-maxconcurrentagents-integer",
    "type": "claim",
    "title": "maxconcurrentagents (integer)",
    "lineStart": 411,
    "lineEnd": 411,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_concurrent_agents` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-default-10",
    "type": "claim",
    "title": "Default: 10",
    "lineStart": 412,
    "lineEnd": 412,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `10`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.",
    "lineStart": 413,
    "lineEnd": 413,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changes SHOULD be re-applied at runtime and affect subsequent dispatch decisions.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-maxturns-positive-integer",
    "type": "claim",
    "title": "maxturns (positive integer)",
    "lineStart": 414,
    "lineEnd": 414,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_turns` (positive integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-default-20",
    "type": "claim",
    "title": "Default: 20",
    "lineStart": 415,
    "lineEnd": 415,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `20`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-limits-the-number-of-coding-agent-turns-within-one-worker-session",
    "type": "claim",
    "title": "Limits the number of coding-agent turns within one worker session.",
    "lineStart": 416,
    "lineEnd": 416,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Limits the number of coding-agent turns within one worker session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-invalid-values-fail-configuration-validation",
    "type": "claim",
    "title": "Invalid values fail configuration validation.",
    "lineStart": 417,
    "lineEnd": 417,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid values fail configuration validation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-maxretrybackoffms-integer",
    "type": "claim",
    "title": "maxretrybackoffms (integer)",
    "lineStart": 418,
    "lineEnd": 418,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_retry_backoff_ms` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-default-300000-5-minutes",
    "type": "claim",
    "title": "Default: 300000 (5 minutes)",
    "lineStart": 419,
    "lineEnd": 419,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `300000` (5 minutes)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
    "type": "requirement",
    "title": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "lineStart": 420,
    "lineEnd": 420,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changes SHOULD be re-applied at runtime and affect future retry scheduling.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-maxconcurrentagentsbystate-map-statename-positive-integer",
    "type": "claim",
    "title": "maxconcurrentagentsbystate (map statename -> positive integer)",
    "lineStart": 421,
    "lineEnd": 421,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_concurrent_agents_by_state` (map `state_name -> positive integer`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-default-empty-map",
    "type": "claim",
    "title": "Default: empty map.",
    "lineStart": 422,
    "lineEnd": 422,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: empty map.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-state-keys-are-normalized-lowercase-for-lookup",
    "type": "claim",
    "title": "State keys are normalized (lowercase) for lookup.",
    "lineStart": 423,
    "lineEnd": 423,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "State keys are normalized (`lowercase`) for lookup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-5-agent-object-invalid-entries-non-positive-or-non-numeric-are-ignored",
    "type": "claim",
    "title": "Invalid entries (non-positive or non-numeric) are ignored.",
    "lineStart": 424,
    "lineEnd": 424,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid entries (non-positive or non-numeric) are ignored.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-6-codex-object-implementors-should-treat-them-as-pass-through-codex-config-values-rather-than-r",
    "type": "requirement",
    "title": "Implementors SHOULD treat them as pass-through Codex config values rather than relyin...",
    "lineStart": 432,
    "lineEnd": 432,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementors SHOULD treat them as pass-through Codex config values rather than relying on a",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-6-codex-object-implementations-may-validate-these",
    "type": "requirement",
    "title": "Implementations MAY validate these",
    "lineStart": 435,
    "lineEnd": 435,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY validate these",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-command-string-shell-command",
    "type": "claim",
    "title": "command (string shell command)",
    "lineStart": 438,
    "lineEnd": 438,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`command` (string shell command)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-codex-app-server",
    "type": "claim",
    "title": "Default: codex app-server",
    "lineStart": 439,
    "lineEnd": 439,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `codex app-server`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory",
    "type": "claim",
    "title": "The runtime launches this command via bash -lc in the workspace directory.",
    "lineStart": 440,
    "lineEnd": 440,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The runtime launches this command via `bash -lc` in the workspace directory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
    "type": "requirement",
    "title": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "lineStart": 441,
    "lineEnd": 441,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The launched process MUST speak a compatible app-server protocol over stdio.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value",
    "type": "claim",
    "title": "approvalpolicy (Codex AskForApproval value)",
    "lineStart": 442,
    "lineEnd": 442,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`approval_policy` (Codex `AskForApproval` value)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-implementation-defined",
    "type": "claim",
    "title": "Default: implementation-defined.",
    "lineStart": 443,
    "lineEnd": 443,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: implementation-defined.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value",
    "type": "claim",
    "title": "threadsandbox (Codex SandboxMode value)",
    "lineStart": 444,
    "lineEnd": 444,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`thread_sandbox` (Codex `SandboxMode` value)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-implementation-defined-2",
    "type": "claim",
    "title": "Default: implementation-defined.",
    "lineStart": 445,
    "lineEnd": 445,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: implementation-defined.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value",
    "type": "claim",
    "title": "turnsandboxpolicy (Codex SandboxPolicy value)",
    "lineStart": 446,
    "lineEnd": 446,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_sandbox_policy` (Codex `SandboxPolicy` value)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-implementation-defined-3",
    "type": "claim",
    "title": "Default: implementation-defined.",
    "lineStart": 447,
    "lineEnd": 447,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: implementation-defined.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-turntimeoutms-integer",
    "type": "claim",
    "title": "turntimeoutms (integer)",
    "lineStart": 448,
    "lineEnd": 448,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_timeout_ms` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-3600000-1-hour",
    "type": "claim",
    "title": "Default: 3600000 (1 hour)",
    "lineStart": 449,
    "lineEnd": 449,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `3600000` (1 hour)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-readtimeoutms-integer",
    "type": "claim",
    "title": "readtimeoutms (integer)",
    "lineStart": 450,
    "lineEnd": 450,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`read_timeout_ms` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-5000",
    "type": "claim",
    "title": "Default: 5000",
    "lineStart": 451,
    "lineEnd": 451,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `5000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-stalltimeoutms-integer",
    "type": "claim",
    "title": "stalltimeoutms (integer)",
    "lineStart": 452,
    "lineEnd": 452,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`stall_timeout_ms` (integer)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-default-300000-5-minutes",
    "type": "claim",
    "title": "Default: 300000 (5 minutes)",
    "lineStart": 453,
    "lineEnd": 453,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Default: `300000` (5 minutes)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-3-6-codex-object-if-0-stall-detection-is-disabled",
    "type": "claim",
    "title": "If <= 0, stall detection is disabled.",
    "lineStart": 454,
    "lineEnd": 454,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If `<= 0`, stall detection is disabled.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-use-a-strict-template-engine-liquid-compatible-semantics-are-sufficient",
    "type": "claim",
    "title": "Use a strict template engine (Liquid-compatible semantics are sufficient).",
    "lineStart": 462,
    "lineEnd": 462,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Use a strict template engine (Liquid-compatible semantics are sufficient).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-4-prompt-template-contract-unknown-variables-must-fail-rendering",
    "type": "requirement",
    "title": "Unknown variables MUST fail rendering.",
    "lineStart": 463,
    "lineEnd": 463,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unknown variables MUST fail rendering.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-4-prompt-template-contract-unknown-filters-must-fail-rendering",
    "type": "requirement",
    "title": "Unknown filters MUST fail rendering.",
    "lineStart": 464,
    "lineEnd": 464,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unknown filters MUST fail rendering.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-issue-object",
    "type": "claim",
    "title": "issue (object)",
    "lineStart": 468,
    "lineEnd": 468,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue` (object)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-includes-all-normalized-issue-fields-including-labels-and-blockers",
    "type": "claim",
    "title": "Includes all normalized issue fields, including labels and blockers.",
    "lineStart": 469,
    "lineEnd": 469,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Includes all normalized issue fields, including labels and blockers.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-attempt-integer-or-null",
    "type": "claim",
    "title": "attempt (integer or null)",
    "lineStart": 470,
    "lineEnd": 470,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`attempt` (integer or null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-null-absent-on-first-attempt",
    "type": "claim",
    "title": "null/absent on first attempt.",
    "lineStart": 471,
    "lineEnd": 471,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`null`/absent on first attempt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-5-4-prompt-template-contract-integer-on-retry-or-continuation-run",
    "type": "claim",
    "title": "Integer on retry or continuation run.",
    "lineStart": 472,
    "lineEnd": 472,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Integer on retry or continuation run.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-4-prompt-template-contract-if-the-workflow-prompt-body-is-empty-the-runtime-may-use-a-minimal-default-promp",
    "type": "requirement",
    "title": "If the workflow prompt body is empty, the runtime MAY use a minimal default prompt (Y...",
    "lineStart": 476,
    "lineEnd": 476,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the workflow prompt body is empty, the runtime MAY use a minimal default prompt (`You are working on an issue from Linear.`).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-5-4-prompt-template-contract-workflow-file-read-parse-failures-are-configuration-validation-errors-and-should",
    "type": "requirement",
    "title": "Workflow file read/parse failures are configuration/validation errors and SHOULD NOT...",
    "lineStart": 478,
    "lineEnd": 478,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow file read/parse failures are configuration/validation errors and SHOULD NOT silently fall back to a prompt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile",
    "type": "test",
    "title": "missingworkflowfile",
    "lineStart": 485,
    "lineEnd": 485,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`missing_workflow_file`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-workflowparseerror",
    "type": "test",
    "title": "workflowparseerror",
    "lineStart": 486,
    "lineEnd": 486,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workflow_parse_error`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap",
    "type": "test",
    "title": "workflowfrontmatternotamap",
    "lineStart": 487,
    "lineEnd": 487,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workflow_front_matter_not_a_map`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering",
    "type": "test",
    "title": "templateparseerror (during prompt rendering)",
    "lineStart": 488,
    "lineEnd": 488,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`template_parse_error` (during prompt rendering)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-templaterendererror-unknown-variable-filter-invalid-interpolation",
    "type": "test",
    "title": "templaterendererror (unknown variable/filter, invalid interpolation)",
    "lineStart": 489,
    "lineEnd": 489,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`template_render_error` (unknown variable/filter, invalid interpolation)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-workflow-file-read-yaml-errors-block-new-dispatches-until-fixed",
    "type": "test",
    "title": "Workflow file read/YAML errors block new dispatches until fixed.",
    "lineStart": 493,
    "lineEnd": 493,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow file read/YAML errors block new dispatches until fixed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-template-errors-fail-only-the-affected-run-attempt",
    "type": "test",
    "title": "Template errors fail only the affected run attempt.",
    "lineStart": 494,
    "lineEnd": 494,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Template errors fail only the affected run attempt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-1-configuration-resolution-pipeline-apply-built-in-defaults-for-missing-optional-fields",
    "type": "requirement",
    "title": "Apply built-in defaults for missing OPTIONAL fields.",
    "lineStart": 504,
    "lineEnd": 504,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Apply built-in defaults for missing OPTIONAL fields.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-1-configuration-resolution-pipeline-path-command-fields-support",
    "type": "claim",
    "title": "Path/command fields support:",
    "lineStart": 513,
    "lineEnd": 513,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Path/command fields support:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-1-configuration-resolution-pipeline-home-expansion",
    "type": "claim",
    "title": "~ home expansion",
    "lineStart": 514,
    "lineEnd": 514,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`~` home expansion",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-1-configuration-resolution-pipeline-var-expansion-for-env-backed-path-values",
    "type": "claim",
    "title": "$VAR expansion for env-backed path values",
    "lineStart": 515,
    "lineEnd": 515,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`$VAR` expansion for env-backed path values",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-6-1-configuration-resolution-pipeline-apply-expansion-only-to-values-intended-to-be-local-filesystem-paths-do-not-rewr",
    "type": "dependency",
    "title": "Apply expansion only to values intended to be local filesystem paths; do not rewrite...",
    "lineStart": 516,
    "lineEnd": 516,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Apply expansion only to values intended to be local filesystem paths; do not rewrite URIs or arbitrary shell command strings.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-1-configuration-resolution-pipeline-relative-workspace-root-values-resolve-relative-to-the-directory-containing-the-",
    "type": "claim",
    "title": "Relative workspace.root values resolve relative to the directory containing the selec...",
    "lineStart": 518,
    "lineEnd": 518,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Relative `workspace.root` values resolve relative to the directory containing the selected `WORKFLOW.md`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-dynamic-reload-is-required",
    "type": "requirement",
    "title": "Dynamic reload is REQUIRED:",
    "lineStart": 523,
    "lineEnd": 523,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dynamic reload is REQUIRED:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-the-software-must-detect-workflow-md-changes",
    "type": "requirement",
    "title": "The software MUST detect WORKFLOW.md changes.",
    "lineStart": 525,
    "lineEnd": 525,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The software MUST detect `WORKFLOW.md` changes.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
    "type": "requirement",
    "title": "On change, it MUST re-read and re-apply workflow config and prompt template without r...",
    "lineStart": 526,
    "lineEnd": 526,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "On change, it MUST re-read and re-apply workflow config and prompt template without restart.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
    "type": "requirement",
    "title": "The software MUST attempt to adjust live behavior to the new config (for example poll...",
    "lineStart": 527,
    "lineEnd": 527,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The software MUST attempt to adjust live behavior to the new config (for example polling cadence, concurrency limits, active/terminal states, codex settings, workspace paths/hooks, and prompt content for future runs).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis",
    "type": "claim",
    "title": "Reloaded config applies to future dispatch, retry scheduling, reconciliation decision...",
    "lineStart": 530,
    "lineEnd": 530,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reloaded config applies to future dispatch, retry scheduling, reconciliation decisions, hook execution, and agent launches.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical",
    "type": "requirement",
    "title": "Implementations are not REQUIRED to restart in-flight agent sessions automatically wh...",
    "lineStart": 532,
    "lineEnd": 532,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations are not REQUIRED to restart in-flight agent sessions automatically when config changes.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
    "type": "requirement",
    "title": "Extensions that manage their own listeners/resources (for example an HTTP server port...",
    "lineStart": 534,
    "lineEnd": 534,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Extensions that manage their own listeners/resources (for example an HTTP server port change) MAY require restart unless the implementation explicitly supports live rebind.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
    "type": "requirement",
    "title": "Implementations SHOULD also re-validate/reload defensively during runtime operations...",
    "lineStart": 536,
    "lineEnd": 536,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD also re-validate/reload defensively during runtime operations (for example before dispatch) in case filesystem watch events are missed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go",
    "type": "requirement",
    "title": "Invalid reloads MUST NOT crash the service; keep operating with the last known good e...",
    "lineStart": 538,
    "lineEnd": 538,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid reloads MUST NOT crash the service; keep operating with the last known good effective configuration and emit an operator-visible error.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-validate-configuration-before-starting-the-scheduling-loop",
    "type": "test",
    "title": "Validate configuration before starting the scheduling loop.",
    "lineStart": 549,
    "lineEnd": 549,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Validate configuration before starting the scheduling loop.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-if-startup-validation-fails-fail-startup-and-emit-an-operator-visible-error",
    "type": "test",
    "title": "If startup validation fails, fail startup and emit an operator-visible error.",
    "lineStart": 550,
    "lineEnd": 550,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If startup validation fails, fail startup and emit an operator-visible error.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-re-validate-before-each-dispatch-cycle",
    "type": "test",
    "title": "Re-validate before each dispatch cycle.",
    "lineStart": 554,
    "lineEnd": 554,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Re-validate before each dispatch cycle.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-if-validation-fails-skip-dispatch-for-that-tick-keep-reconciliation-active-and-e",
    "type": "test",
    "title": "If validation fails, skip dispatch for that tick, keep reconciliation active, and emi...",
    "lineStart": 555,
    "lineEnd": 555,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If validation fails, skip dispatch for that tick, keep reconciliation active, and emit an operator-visible error.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-workflow-file-can-be-loaded-and-parsed",
    "type": "test",
    "title": "Workflow file can be loaded and parsed.",
    "lineStart": 560,
    "lineEnd": 560,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow file can be loaded and parsed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-tracker-kind-is-present-and-supported",
    "type": "test",
    "title": "tracker.kind is present and supported.",
    "lineStart": 561,
    "lineEnd": 561,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.kind` is present and supported.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-tracker-apikey-is-present-after-resolution",
    "type": "test",
    "title": "tracker.apikey is present after $ resolution.",
    "lineStart": 562,
    "lineEnd": 562,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.api_key` is present after `$` resolution.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-tracker-projectslug-is-present-when-required-by-the-selected-tracker-kind",
    "type": "test",
    "title": "tracker.projectslug is present when REQUIRED by the selected tracker kind.",
    "lineStart": 563,
    "lineEnd": 563,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.project_slug` is present when REQUIRED by the selected tracker kind.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-6-3-dispatch-preflight-validation-codex-command-is-present-and-non-empty",
    "type": "test",
    "title": "codex.command is present and non-empty.",
    "lineStart": 564,
    "lineEnd": 564,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.command` is present and non-empty.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-kind-string-required-currently-linear",
    "type": "requirement",
    "title": "tracker.kind: string, REQUIRED, currently linear",
    "lineStart": 572,
    "lineEnd": 572,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.kind`: string, REQUIRED, currently `linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-6-4-core-config-fields-summary-cheat-sheet-tracker-endpoint-string-default-https-api-linear-app-graphql-when-tracker-kind-l",
    "type": "dependency",
    "title": "tracker.endpoint: string, default https://api.linear.app/graphql when tracker.kind=li...",
    "lineStart": 573,
    "lineEnd": 573,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.endpoint`: string, default `https://api.linear.app/graphql` when `tracker.kind=linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-apikey-string-or-var-canonical-env-linearapikey-when-tracker-kind-linear",
    "type": "claim",
    "title": "tracker.apikey: string or $VAR, canonical env LINEARAPIKEY when tracker.kind=linear",
    "lineStart": 574,
    "lineEnd": 574,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.api_key`: string or `$VAR`, canonical env `LINEAR_API_KEY` when `tracker.kind=linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-projectslug-string-required-when-tracker-kind-linear",
    "type": "requirement",
    "title": "tracker.projectslug: string, REQUIRED when tracker.kind=linear",
    "lineStart": 575,
    "lineEnd": 575,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.project_slug`: string, REQUIRED when `tracker.kind=linear`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-activestates-list-of-strings-default-todo-in-progress",
    "type": "claim",
    "title": "tracker.activestates: list of strings, default [\"Todo\", \"In Progress\"]",
    "lineStart": 576,
    "lineEnd": 576,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.active_states`: list of strings, default `[\"Todo\", \"In Progress\"]`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-terminalstates-list-of-strings-default-closed-cancelled-canceled",
    "type": "claim",
    "title": "tracker.terminalstates: list of strings, default [\"Closed\", \"Cancelled\", \"Canceled\",...",
    "lineStart": 577,
    "lineEnd": 577,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.terminal_states`: list of strings, default `[\"Closed\", \"Cancelled\", \"Canceled\", \"Duplicate\", \"Done\"]`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-polling-intervalms-integer-default-30000",
    "type": "claim",
    "title": "polling.intervalms: integer, default 30000",
    "lineStart": 578,
    "lineEnd": 578,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`polling.interval_ms`: integer, default `30000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-workspace-root-path-resolved-to-absolute-default-system-temp-symphonyworkspaces",
    "type": "claim",
    "title": "workspace.root: path resolved to absolute, default <system-temp>/symphonyworkspaces",
    "lineStart": 579,
    "lineEnd": 579,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace.root`: path resolved to absolute, default `<system-temp>/symphony_workspaces`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-aftercreate-shell-script-or-null",
    "type": "claim",
    "title": "hooks.aftercreate: shell script or null",
    "lineStart": 580,
    "lineEnd": 580,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.after_create`: shell script or null",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforerun-shell-script-or-null",
    "type": "claim",
    "title": "hooks.beforerun: shell script or null",
    "lineStart": 581,
    "lineEnd": 581,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.before_run`: shell script or null",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-afterrun-shell-script-or-null",
    "type": "claim",
    "title": "hooks.afterrun: shell script or null",
    "lineStart": 582,
    "lineEnd": 582,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.after_run`: shell script or null",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforeremove-shell-script-or-null",
    "type": "claim",
    "title": "hooks.beforeremove: shell script or null",
    "lineStart": 583,
    "lineEnd": 583,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.before_remove`: shell script or null",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-timeoutms-integer-default-60000",
    "type": "claim",
    "title": "hooks.timeoutms: integer, default 60000",
    "lineStart": 584,
    "lineEnd": 584,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.timeout_ms`: integer, default `60000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagents-integer-default-10",
    "type": "claim",
    "title": "agent.maxconcurrentagents: integer, default 10",
    "lineStart": 585,
    "lineEnd": 585,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`agent.max_concurrent_agents`: integer, default `10`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxturns-integer-default-20",
    "type": "claim",
    "title": "agent.maxturns: integer, default 20",
    "lineStart": 586,
    "lineEnd": 586,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`agent.max_turns`: integer, default `20`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxretrybackoffms-integer-default-300000-5m",
    "type": "claim",
    "title": "agent.maxretrybackoffms: integer, default 300000 (5m)",
    "lineStart": 587,
    "lineEnd": 587,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`agent.max_retry_backoff_ms`: integer, default `300000` (5m)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagentsbystate-map-of-positive-integers-default",
    "type": "claim",
    "title": "agent.maxconcurrentagentsbystate: map of positive integers, default {}",
    "lineStart": 588,
    "lineEnd": 588,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`agent.max_concurrent_agents_by_state`: map of positive integers, default `{}`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-command-shell-command-string-default-codex-app-server",
    "type": "claim",
    "title": "codex.command: shell command string, default codex app-server",
    "lineStart": 589,
    "lineEnd": 589,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.command`: shell command string, default `codex app-server`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-approvalpolicy-codex-askforapproval-value-default-implementation-defined",
    "type": "claim",
    "title": "codex.approvalpolicy: Codex AskForApproval value, default implementation-defined",
    "lineStart": 590,
    "lineEnd": 590,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.approval_policy`: Codex `AskForApproval` value, default implementation-defined",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-threadsandbox-codex-sandboxmode-value-default-implementation-defined",
    "type": "claim",
    "title": "codex.threadsandbox: Codex SandboxMode value, default implementation-defined",
    "lineStart": 591,
    "lineEnd": 591,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.thread_sandbox`: Codex `SandboxMode` value, default implementation-defined",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turnsandboxpolicy-codex-sandboxpolicy-value-default-implementation-defined",
    "type": "claim",
    "title": "codex.turnsandboxpolicy: Codex SandboxPolicy value, default implementation-defined",
    "lineStart": 592,
    "lineEnd": 592,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.turn_sandbox_policy`: Codex `SandboxPolicy` value, default implementation-defined",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turntimeoutms-integer-default-3600000",
    "type": "claim",
    "title": "codex.turntimeoutms: integer, default 3600000",
    "lineStart": 593,
    "lineEnd": 593,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.turn_timeout_ms`: integer, default `3600000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-readtimeoutms-integer-default-5000",
    "type": "claim",
    "title": "codex.readtimeoutms: integer, default 5000",
    "lineStart": 594,
    "lineEnd": 594,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.read_timeout_ms`: integer, default `5000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-stalltimeoutms-integer-default-300000",
    "type": "claim",
    "title": "codex.stalltimeoutms: integer, default 300000",
    "lineStart": 595,
    "lineEnd": 595,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.stall_timeout_ms`: integer, default `300000`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-issue-is-not-running-and-has-no-retry-scheduled",
    "type": "claim",
    "title": "Issue is not running and has no retry scheduled.",
    "lineStart": 608,
    "lineEnd": 608,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue is not running and has no retry scheduled.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-orchestrator-has-reserved-the-issue-to-prevent-duplicate-dispatch",
    "type": "claim",
    "title": "Orchestrator has reserved the issue to prevent duplicate dispatch.",
    "lineStart": 611,
    "lineEnd": 611,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Orchestrator has reserved the issue to prevent duplicate dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-in-practice-claimed-issues-are-either-running-or-retryqueued",
    "type": "claim",
    "title": "In practice, claimed issues are either Running or RetryQueued.",
    "lineStart": 612,
    "lineEnd": 612,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "In practice, claimed issues are either `Running` or `RetryQueued`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-worker-task-exists-and-the-issue-is-tracked-in-running-map",
    "type": "claim",
    "title": "Worker task exists and the issue is tracked in running map.",
    "lineStart": 615,
    "lineEnd": 615,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Worker task exists and the issue is tracked in `running` map.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-worker-is-not-running-but-a-retry-timer-exists-in-retryattempts",
    "type": "claim",
    "title": "Worker is not running, but a retry timer exists in retryattempts.",
    "lineStart": 618,
    "lineEnd": 618,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Worker is not running, but a retry timer exists in `retry_attempts`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-claim-removed-because-issue-is-terminal-non-active-missing-or-retry-path-complet",
    "type": "claim",
    "title": "Claim removed because issue is terminal, non-active, missing, or retry path completed...",
    "lineStart": 621,
    "lineEnd": 621,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Claim removed because issue is terminal, non-active, missing, or retry path completed without re-dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-a-successful-worker-exit-does-not-mean-the-issue-is-done-forever",
    "type": "claim",
    "title": "A successful worker exit does not mean the issue is done forever.",
    "lineStart": 626,
    "lineEnd": 626,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A successful worker exit does not mean the issue is done forever.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-",
    "type": "requirement",
    "title": "The worker MAY continue through multiple back-to-back coding-agent turns before it ex...",
    "lineStart": 627,
    "lineEnd": 627,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The worker MAY continue through multiple back-to-back coding-agent turns before it exits.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-1-issue-orchestration-states-after-each-normal-turn-completion-the-worker-re-checks-the-tracker-issue-state",
    "type": "claim",
    "title": "After each normal turn completion, the worker re-checks the tracker issue state.",
    "lineStart": 628,
    "lineEnd": 628,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "After each normal turn completion, the worker re-checks the tracker issue state.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
    "type": "requirement",
    "title": "If the issue is still in an active state, the worker SHOULD start another turn on the...",
    "lineStart": 629,
    "lineEnd": 629,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the issue is still in an active state, the worker SHOULD start another turn on the same live coding-agent thread in the same workspace, up to `agent.max_turns`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt",
    "type": "requirement",
    "title": "The first turn SHOULD use the full rendered task prompt.",
    "lineStart": 631,
    "lineEnd": 631,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The first turn SHOULD use the full rendered task prompt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread",
    "type": "requirement",
    "title": "Continuation turns SHOULD send only continuation guidance to the existing thread, not...",
    "lineStart": 632,
    "lineEnd": 632,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Continuation turns SHOULD send only continuation guidance to the existing thread, not resend the original task prompt that is already present in thread history.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua",
    "type": "test",
    "title": "Once the worker exits normally, the orchestrator still schedules a short continuation...",
    "lineStart": 634,
    "lineEnd": 634,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Once the worker exits normally, the orchestrator still schedules a short continuation retry (about 1 second) so it can re-check whether the issue remains active and needs another worker session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-poll-tick",
    "type": "claim",
    "title": "Poll Tick",
    "lineStart": 658,
    "lineEnd": 658,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Poll Tick`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-reconcile-active-runs",
    "type": "claim",
    "title": "Reconcile active runs.",
    "lineStart": 659,
    "lineEnd": 659,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reconcile active runs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-7-3-transition-triggers-validate-config",
    "type": "test",
    "title": "Validate config.",
    "lineStart": 660,
    "lineEnd": 660,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Validate config.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-fetch-candidate-issues",
    "type": "claim",
    "title": "Fetch candidate issues.",
    "lineStart": 661,
    "lineEnd": 661,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fetch candidate issues.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-dispatch-until-slots-are-exhausted",
    "type": "claim",
    "title": "Dispatch until slots are exhausted.",
    "lineStart": 662,
    "lineEnd": 662,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dispatch until slots are exhausted.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-worker-exit-normal",
    "type": "claim",
    "title": "Worker Exit (normal)",
    "lineStart": 664,
    "lineEnd": 664,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Worker Exit (normal)`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-remove-running-entry",
    "type": "claim",
    "title": "Remove running entry.",
    "lineStart": 665,
    "lineEnd": 665,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Remove running entry.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-update-aggregate-runtime-totals",
    "type": "claim",
    "title": "Update aggregate runtime totals.",
    "lineStart": 666,
    "lineEnd": 666,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Update aggregate runtime totals.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-schedule-continuation-retry-attempt-1-after-the-worker-exhausts-or-finishes-its-",
    "type": "claim",
    "title": "Schedule continuation retry (attempt 1) after the worker exhausts or finishes its in-...",
    "lineStart": 667,
    "lineEnd": 667,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Schedule continuation retry (attempt `1`) after the worker exhausts or finishes its in-process turn loop.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-worker-exit-abnormal",
    "type": "claim",
    "title": "Worker Exit (abnormal)",
    "lineStart": 670,
    "lineEnd": 670,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Worker Exit (abnormal)`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-remove-running-entry-2",
    "type": "claim",
    "title": "Remove running entry.",
    "lineStart": 671,
    "lineEnd": 671,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Remove running entry.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-update-aggregate-runtime-totals-2",
    "type": "claim",
    "title": "Update aggregate runtime totals.",
    "lineStart": 672,
    "lineEnd": 672,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Update aggregate runtime totals.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-schedule-exponential-backoff-retry",
    "type": "claim",
    "title": "Schedule exponential-backoff retry.",
    "lineStart": 673,
    "lineEnd": 673,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Schedule exponential-backoff retry.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-codex-update-event",
    "type": "claim",
    "title": "Codex Update Event",
    "lineStart": 675,
    "lineEnd": 675,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Codex Update Event`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-update-live-session-fields-token-counters-and-rate-limits",
    "type": "claim",
    "title": "Update live session fields, token counters, and rate limits.",
    "lineStart": 676,
    "lineEnd": 676,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Update live session fields, token counters, and rate limits.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-retry-timer-fired",
    "type": "claim",
    "title": "Retry Timer Fired",
    "lineStart": 678,
    "lineEnd": 678,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Retry Timer Fired`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-re-fetch-active-candidates-and-attempt-re-dispatch-or-release-claim-if-no-longer",
    "type": "claim",
    "title": "Re-fetch active candidates and attempt re-dispatch, or release claim if no longer eli...",
    "lineStart": 679,
    "lineEnd": 679,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Re-fetch active candidates and attempt re-dispatch, or release claim if no longer eligible.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-reconciliation-state-refresh",
    "type": "claim",
    "title": "Reconciliation State Refresh",
    "lineStart": 681,
    "lineEnd": 681,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Reconciliation State Refresh`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-stop-runs-whose-issue-states-are-terminal-or-no-longer-active",
    "type": "claim",
    "title": "Stop runs whose issue states are terminal or no longer active.",
    "lineStart": 682,
    "lineEnd": 682,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Stop runs whose issue states are terminal or no longer active.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-stall-timeout",
    "type": "claim",
    "title": "Stall Timeout",
    "lineStart": 684,
    "lineEnd": 684,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Stall Timeout`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-7-3-transition-triggers-kill-worker-and-schedule-retry",
    "type": "claim",
    "title": "Kill worker and schedule retry.",
    "lineStart": 685,
    "lineEnd": 685,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Kill worker and schedule retry.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-the-orchestrator-serializes-state-mutations-through-one-authority-to-avoid-dupli",
    "type": "risk",
    "title": "The orchestrator serializes state mutations through one authority to avoid duplicate...",
    "lineStart": 689,
    "lineEnd": 689,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The orchestrator serializes state mutations through one authority to avoid duplicate dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
    "type": "risk",
    "title": "claimed and running checks are REQUIRED before launching any worker.",
    "lineStart": 690,
    "lineEnd": 690,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`claimed` and `running` checks are REQUIRED before launching any worker.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-reconciliation-runs-before-dispatch-on-every-tick",
    "type": "risk",
    "title": "Reconciliation runs before dispatch on every tick.",
    "lineStart": 691,
    "lineEnd": 691,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reconciliation runs before dispatch on every tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-restart-recovery-is-tracker-driven-and-filesystem-driven-without-a-durable-orche",
    "type": "risk",
    "title": "Restart recovery is tracker-driven and filesystem-driven (without a durable orchestra...",
    "lineStart": 692,
    "lineEnd": 692,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Restart recovery is tracker-driven and filesystem-driven (without a durable orchestrator DB).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-startup-terminal-cleanup-removes-stale-workspaces-for-issues-already-in-terminal",
    "type": "risk",
    "title": "Startup terminal cleanup removes stale workspaces for issues already in terminal states.",
    "lineStart": 693,
    "lineEnd": 693,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Startup terminal cleanup removes stale workspaces for issues already in terminal states.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-8-1-poll-loop-the-effective-poll-interval-should-be-updated-when-workflow-config-changes-are-r",
    "type": "requirement",
    "title": "The effective poll interval SHOULD be updated when workflow config changes are re-app...",
    "lineStart": 702,
    "lineEnd": 702,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The effective poll interval SHOULD be updated when workflow config changes are re-applied.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-it-has-id-identifier-title-and-state",
    "type": "claim",
    "title": "It has id, identifier, title, and state.",
    "lineStart": 720,
    "lineEnd": 720,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It has `id`, `identifier`, `title`, and `state`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-its-state-is-in-activestates-and-not-in-terminalstates",
    "type": "claim",
    "title": "Its state is in activestates and not in terminalstates.",
    "lineStart": 721,
    "lineEnd": 721,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Its state is in `active_states` and not in `terminal_states`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-it-is-not-already-in-running",
    "type": "claim",
    "title": "It is not already in running.",
    "lineStart": 722,
    "lineEnd": 722,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It is not already in `running`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-it-is-not-already-in-claimed",
    "type": "claim",
    "title": "It is not already in claimed.",
    "lineStart": 723,
    "lineEnd": 723,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It is not already in `claimed`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-global-concurrency-slots-are-available",
    "type": "claim",
    "title": "Global concurrency slots are available.",
    "lineStart": 724,
    "lineEnd": 724,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Global concurrency slots are available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-per-state-concurrency-slots-are-available",
    "type": "claim",
    "title": "Per-state concurrency slots are available.",
    "lineStart": 725,
    "lineEnd": 725,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Per-state concurrency slots are available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-blocker-rule-for-todo-state-passes",
    "type": "claim",
    "title": "Blocker rule for Todo state passes:",
    "lineStart": 726,
    "lineEnd": 726,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Blocker rule for `Todo` state passes:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-2-candidate-selection-rules-if-the-issue-state-is-todo-do-not-dispatch-when-any-blocker-is-non-terminal",
    "type": "claim",
    "title": "If the issue state is Todo, do not dispatch when any blocker is non-terminal.",
    "lineStart": 727,
    "lineEnd": 727,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the issue state is `Todo`, do not dispatch when any blocker is non-terminal.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-3-concurrency-control-availableslots-max-maxconcurrentagents-runningcount-0",
    "type": "claim",
    "title": "availableslots = max(maxconcurrentagents - runningcount, 0)",
    "lineStart": 739,
    "lineEnd": 739,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`available_slots = max(max_concurrent_agents - running_count, 0)`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-3-concurrency-control-maxconcurrentagentsbystate-state-if-present-state-key-normalized",
    "type": "claim",
    "title": "maxconcurrentagentsbystate[state] if present (state key normalized)",
    "lineStart": 743,
    "lineEnd": 743,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`max_concurrent_agents_by_state[state]` if present (state key normalized)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-3-concurrency-control-otherwise-fallback-to-global-limit",
    "type": "claim",
    "title": "otherwise fallback to global limit",
    "lineStart": 744,
    "lineEnd": 744,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "otherwise fallback to global limit",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-cancel-any-existing-retry-timer-for-the-same-issue",
    "type": "claim",
    "title": "Cancel any existing retry timer for the same issue.",
    "lineStart": 752,
    "lineEnd": 752,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Cancel any existing retry timer for the same issue.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-store-attempt-identifier-error-dueatms-and-new-timer-handle",
    "type": "claim",
    "title": "Store attempt, identifier, error, dueatms, and new timer handle.",
    "lineStart": 753,
    "lineEnd": 753,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Store `attempt`, `identifier`, `error`, `due_at_ms`, and new timer handle.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-normal-continuation-retries-after-a-clean-worker-exit-use-a-short-fixed-delay-of",
    "type": "claim",
    "title": "Normal continuation retries after a clean worker exit use a short fixed delay of 1000...",
    "lineStart": 757,
    "lineEnd": 757,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Normal continuation retries after a clean worker exit use a short fixed delay of `1000` ms.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-failure-driven-retries-use-delay-min-10000-2-attempt-1-agent-maxretrybackoffms",
    "type": "claim",
    "title": "Failure-driven retries use delay = min(10000 2^(attempt - 1), agent.maxretrybackoffms).",
    "lineStart": 758,
    "lineEnd": 758,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Failure-driven retries use `delay = min(10000 * 2^(attempt - 1), agent.max_retry_backoff_ms)`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-power-is-capped-by-the-configured-max-retry-backoff-default-300000-5m",
    "type": "claim",
    "title": "Power is capped by the configured max retry backoff (default 300000 / 5m).",
    "lineStart": 759,
    "lineEnd": 759,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Power is capped by the configured max retry backoff (default `300000` / 5m).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-dispatch-if-slots-are-available",
    "type": "claim",
    "title": "Dispatch if slots are available.",
    "lineStart": 767,
    "lineEnd": 767,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dispatch if slots are available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-otherwise-requeue-with-error-no-available-orchestrator-slots",
    "type": "claim",
    "title": "Otherwise requeue with error no available orchestrator slots.",
    "lineStart": 768,
    "lineEnd": 768,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Otherwise requeue with error `no available orchestrator slots`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-terminal-state-workspace-cleanup-is-handled-by-startup-cleanup-and-active-run-re",
    "type": "claim",
    "title": "Terminal-state workspace cleanup is handled by startup cleanup and active-run reconci...",
    "lineStart": 773,
    "lineEnd": 773,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Terminal-state workspace cleanup is handled by startup cleanup and active-run reconciliation (including terminal transitions for currently running issues).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-4-retry-and-backoff-retry-handling-mainly-operates-on-active-candidates-and-releases-claims-when-the",
    "type": "claim",
    "title": "Retry handling mainly operates on active candidates and releases claims when the issu...",
    "lineStart": 775,
    "lineEnd": 775,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Retry handling mainly operates on active candidates and releases claims when the issue is absent, rather than performing terminal cleanup itself.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-for-each-running-issue-compute-elapsedms-since",
    "type": "claim",
    "title": "For each running issue, compute elapsedms since:",
    "lineStart": 784,
    "lineEnd": 784,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "For each running issue, compute `elapsed_ms` since:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-lastcodextimestamp-if-any-event-has-been-seen-else",
    "type": "claim",
    "title": "lastcodextimestamp if any event has been seen, else",
    "lineStart": 785,
    "lineEnd": 785,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`last_codex_timestamp` if any event has been seen, else",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-startedat",
    "type": "claim",
    "title": "startedat",
    "lineStart": 786,
    "lineEnd": 786,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`started_at`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-elapsedms-codex-stalltimeoutms-terminate-the-worker-and-queue-a-retry",
    "type": "claim",
    "title": "If elapsedms > codex.stalltimeoutms, terminate the worker and queue a retry.",
    "lineStart": 787,
    "lineEnd": 787,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If `elapsed_ms > codex.stall_timeout_ms`, terminate the worker and queue a retry.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-stalltimeoutms-0-skip-stall-detection-entirely",
    "type": "claim",
    "title": "If stalltimeoutms <= 0, skip stall detection entirely.",
    "lineStart": 788,
    "lineEnd": 788,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If `stall_timeout_ms <= 0`, skip stall detection entirely.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-fetch-current-issue-states-for-all-running-issue-ids",
    "type": "claim",
    "title": "Fetch current issue states for all running issue IDs.",
    "lineStart": 792,
    "lineEnd": 792,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fetch current issue states for all running issue IDs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-for-each-running-issue",
    "type": "claim",
    "title": "For each running issue:",
    "lineStart": 793,
    "lineEnd": 793,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "For each running issue:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-tracker-state-is-terminal-terminate-worker-and-clean-workspace",
    "type": "claim",
    "title": "If tracker state is terminal: terminate worker and clean workspace.",
    "lineStart": 794,
    "lineEnd": 794,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If tracker state is terminal: terminate worker and clean workspace.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-tracker-state-is-still-active-update-the-in-memory-issue-snapshot",
    "type": "claim",
    "title": "If tracker state is still active: update the in-memory issue snapshot.",
    "lineStart": 795,
    "lineEnd": 795,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If tracker state is still active: update the in-memory issue snapshot.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-tracker-state-is-neither-active-nor-terminal-terminate-worker-without-workspa",
    "type": "claim",
    "title": "If tracker state is neither active nor terminal: terminate worker without workspace c...",
    "lineStart": 796,
    "lineEnd": 796,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If tracker state is neither active nor terminal: terminate worker without workspace cleanup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-8-5-active-run-reconciliation-if-state-refresh-fails-keep-workers-running-and-try-again-on-the-next-tick",
    "type": "claim",
    "title": "If state refresh fails, keep workers running and try again on the next tick.",
    "lineStart": 797,
    "lineEnd": 797,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If state refresh fails, keep workers running and try again on the next tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-1-workspace-layout-workspace-root-normalized-absolute-path",
    "type": "claim",
    "title": "workspace.root (normalized absolute path)",
    "lineStart": 815,
    "lineEnd": 815,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace.root` (normalized absolute path)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-1-workspace-layout-workspace-root-sanitizedissueidentifier",
    "type": "claim",
    "title": "<workspace.root>/<sanitizedissueidentifier>",
    "lineStart": 819,
    "lineEnd": 819,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`<workspace.root>/<sanitized_issue_identifier>`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-1-workspace-layout-workspaces-are-reused-across-runs-for-the-same-issue",
    "type": "claim",
    "title": "Workspaces are reused across runs for the same issue.",
    "lineStart": 823,
    "lineEnd": 823,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspaces are reused across runs for the same issue.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-1-workspace-layout-successful-runs-do-not-auto-delete-workspaces",
    "type": "claim",
    "title": "Successful runs do not auto-delete workspaces.",
    "lineStart": 824,
    "lineEnd": 824,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Successful runs do not auto-delete workspaces.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-2-workspace-creation-and-reuse-this-section-does-not-assume-any-specific-repository-vcs-workflow",
    "type": "claim",
    "title": "This section does not assume any specific repository/VCS workflow.",
    "lineStart": 841,
    "lineEnd": 841,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "This section does not assume any specific repository/VCS workflow.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-2-workspace-creation-and-reuse-workspace-preparation-beyond-directory-creation-for-example-dependency-bootstrap",
    "type": "claim",
    "title": "Workspace preparation beyond directory creation (for example dependency bootstrap, ch...",
    "lineStart": 842,
    "lineEnd": 842,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace preparation beyond directory creation (for example dependency bootstrap, checkout/sync, code generation) is implementation-defined and is typically handled via hooks.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-implementations-may-populate-or-synchronize-the-workspace-using-implementation-d",
    "type": "requirement",
    "title": "Implementations MAY populate or synchronize the workspace using implementation-define...",
    "lineStart": 849,
    "lineEnd": 849,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY populate or synchronize the workspace using implementation-defined logic and/or",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-3-optional-workspace-population-implementation-defined-workspace-population-synchronization-failures-return-an-error-for-the-current-at",
    "type": "claim",
    "title": "Workspace population/synchronization failures return an error for the current attempt.",
    "lineStart": 854,
    "lineEnd": 854,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace population/synchronization failures return an error for the current attempt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-if-failure-happens-while-creating-a-brand-new-workspace-implementations-may-remo",
    "type": "requirement",
    "title": "If failure happens while creating a brand-new workspace, implementations MAY remove t...",
    "lineStart": 855,
    "lineEnd": 855,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If failure happens while creating a brand-new workspace, implementations MAY remove the partially prepared directory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-9-3-optional-workspace-population-implementation-defined-reused-workspaces-should-not-be-destructively-reset-on-population-failure-unless",
    "type": "requirement",
    "title": "Reused workspaces SHOULD NOT be destructively reset on population failure unless that...",
    "lineStart": 857,
    "lineEnd": 857,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reused workspaces SHOULD NOT be destructively reset on population failure unless that policy is explicitly chosen and documented.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-hooks-aftercreate",
    "type": "claim",
    "title": "hooks.aftercreate",
    "lineStart": 864,
    "lineEnd": 864,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.after_create`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-hooks-beforerun",
    "type": "claim",
    "title": "hooks.beforerun",
    "lineStart": 865,
    "lineEnd": 865,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.before_run`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-hooks-afterrun",
    "type": "claim",
    "title": "hooks.afterrun",
    "lineStart": 866,
    "lineEnd": 866,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.after_run`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-hooks-beforeremove",
    "type": "claim",
    "title": "hooks.beforeremove",
    "lineStart": 867,
    "lineEnd": 867,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`hooks.before_remove`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-9-4-workspace-hooks-execute-in-a-local-shell-context-appropriate-to-the-host-os-with-the-workspace-d",
    "type": "dependency",
    "title": "Execute in a local shell context appropriate to the host OS, with the workspace direc...",
    "lineStart": 871,
    "lineEnd": 871,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Execute in a local shell context appropriate to the host OS, with the workspace directory as `cwd`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-on-posix-systems-sh-lc-script-or-a-stricter-equivalent-such-as-bash-lc-script",
    "type": "claim",
    "title": "On POSIX systems, sh -lc <script> (or a stricter equivalent such as bash -lc <script>...",
    "lineStart": 873,
    "lineEnd": 873,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "On POSIX systems, `sh -lc <script>` (or a stricter equivalent such as `bash -lc <script>`) is a conforming default.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-hook-timeout-uses-hooks-timeoutms-default-60000-ms",
    "type": "claim",
    "title": "Hook timeout uses hooks.timeoutms; default: 60000 ms.",
    "lineStart": 875,
    "lineEnd": 875,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hook timeout uses `hooks.timeout_ms`; default: `60000 ms`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-log-hook-start-failures-and-timeouts",
    "type": "claim",
    "title": "Log hook start, failures, and timeouts.",
    "lineStart": 876,
    "lineEnd": 876,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Log hook start, failures, and timeouts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation",
    "type": "claim",
    "title": "aftercreate failure or timeout is fatal to workspace creation.",
    "lineStart": 880,
    "lineEnd": 880,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_create` failure or timeout is fatal to workspace creation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-beforerun-failure-or-timeout-is-fatal-to-the-current-run-attempt",
    "type": "claim",
    "title": "beforerun failure or timeout is fatal to the current run attempt.",
    "lineStart": 881,
    "lineEnd": 881,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_run` failure or timeout is fatal to the current run attempt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-afterrun-failure-or-timeout-is-logged-and-ignored",
    "type": "claim",
    "title": "afterrun failure or timeout is logged and ignored.",
    "lineStart": 882,
    "lineEnd": 882,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_run` failure or timeout is logged and ignored.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-9-4-workspace-hooks-beforeremove-failure-or-timeout-is-logged-and-ignored",
    "type": "claim",
    "title": "beforeremove failure or timeout is logged and ignored.",
    "lineStart": 883,
    "lineEnd": 883,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_remove` failure or timeout is logged and ignored.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-before-launching-the-coding-agent-subprocess-validate",
    "type": "risk",
    "title": "Before launching the coding-agent subprocess, validate:",
    "lineStart": 891,
    "lineEnd": 891,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Before launching the coding-agent subprocess, validate:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-cwd-workspacepath",
    "type": "risk",
    "title": "cwd == workspacepath",
    "lineStart": 892,
    "lineEnd": 892,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`cwd == workspace_path`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root",
    "type": "risk",
    "title": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "lineStart": 894,
    "lineEnd": 894,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-normalize-both-paths-to-absolute",
    "type": "risk",
    "title": "Normalize both paths to absolute.",
    "lineStart": 896,
    "lineEnd": 896,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Normalize both paths to absolute.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-require-workspacepath-to-have-workspaceroot-as-a-prefix-directory",
    "type": "risk",
    "title": "Require workspacepath to have workspaceroot as a prefix directory.",
    "lineStart": 897,
    "lineEnd": 897,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Require `workspace_path` to have `workspace_root` as a prefix directory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-reject-any-path-outside-the-workspace-root",
    "type": "risk",
    "title": "Reject any path outside the workspace root.",
    "lineStart": 898,
    "lineEnd": 898,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reject any path outside the workspace root.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-only-a-za-z0-9-allowed-in-workspace-directory-names",
    "type": "risk",
    "title": "Only [A-Za-z0-9.-] allowed in workspace directory names.",
    "lineStart": 902,
    "lineEnd": 902,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Only `[A-Za-z0-9._-]` allowed in workspace directory names.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-9-5-safety-invariants-replace-all-other-characters-with",
    "type": "risk",
    "title": "Replace all other characters with .",
    "lineStart": 903,
    "lineEnd": 903,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Replace all other characters with `_`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "dependency",
    "title": "Implementations MUST send messages that are valid for the targeted Codex app-server v...",
    "lineStart": 913,
    "lineEnd": 913,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MUST send messages that are valid for the targeted Codex app-server version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
    "type": "dependency",
    "title": "Implementations MUST consult the targeted Codex app-server documentation or generated...",
    "lineStart": 914,
    "lineEnd": 914,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MUST consult the targeted Codex app-server documentation or generated schema instead of treating this specification as a protocol schema.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro",
    "type": "dependency",
    "title": "If this specification appears to conflict with the targeted Codex app-server protocol...",
    "lineStart": 916,
    "lineEnd": 916,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If this specification appears to conflict with the targeted Codex app-server protocol, the Codex protocol controls protocol shape and transport behavior.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-symphony-specific-requirements-in-this-section-still-control-orchestration-behav",
    "type": "dependency",
    "title": "Symphony-specific requirements in this section still control orchestration behavior,...",
    "lineStart": 918,
    "lineEnd": 918,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Symphony-specific requirements in this section still control orchestration behavior, workspace selection, prompt construction, continuation handling, and observability extraction.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-1-launch-contract-command-codex-command",
    "type": "claim",
    "title": "Command: codex.command",
    "lineStart": 925,
    "lineEnd": 925,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Command: `codex.command`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-1-launch-contract-invocation-bash-lc-codex-command",
    "type": "claim",
    "title": "Invocation: bash -lc <codex.command>",
    "lineStart": 926,
    "lineEnd": 926,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invocation: `bash -lc <codex.command>`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-1-launch-contract-working-directory-workspace-path",
    "type": "claim",
    "title": "Working directory: workspace path",
    "lineStart": 927,
    "lineEnd": 927,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Working directory: workspace path",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-1-launch-contract-transport-framing-the-protocol-transport-required-by-the-targeted-codex-app-serv",
    "type": "requirement",
    "title": "Transport/framing: the protocol transport required by the targeted Codex app-server v...",
    "lineStart": 928,
    "lineEnd": 928,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Transport/framing: the protocol transport required by the targeted Codex app-server version",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-1-launch-contract-the-default-command-is-codex-app-server",
    "type": "claim",
    "title": "The default command is codex app-server.",
    "lineStart": 932,
    "lineEnd": 932,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The default command is `codex app-server`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-1-launch-contract-approval-policy-sandbox-policy-cwd-prompt-input-and-optional-tool-declarations-a",
    "type": "requirement",
    "title": "Approval policy, sandbox policy, cwd, prompt input, and OPTIONAL tool declarations ar...",
    "lineStart": 933,
    "lineEnd": 933,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Approval policy, sandbox policy, cwd, prompt input, and OPTIONAL tool declarations are supplied using fields supported by the targeted Codex app-server version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-1-launch-contract-recommended-additional-process-settings",
    "type": "requirement",
    "title": "RECOMMENDED additional process settings:",
    "lineStart": 936,
    "lineEnd": 936,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "RECOMMENDED additional process settings:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-1-launch-contract-max-line-size-10-mb-for-safe-buffering",
    "type": "claim",
    "title": "Max line size: 10 MB (for safe buffering)",
    "lineStart": 938,
    "lineEnd": 938,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Max line size: 10 MB (for safe buffering)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract",
    "type": "requirement",
    "title": "Startup MUST follow the targeted Codex app-server contract.",
    "lineStart": 944,
    "lineEnd": 944,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Startup MUST follow the targeted Codex app-server contract.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-start-the-app-server-subprocess-in-the-per-issue-workspace",
    "type": "claim",
    "title": "Start the app-server subprocess in the per-issue workspace.",
    "lineStart": 947,
    "lineEnd": 947,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Start the app-server subprocess in the per-issue workspace.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-initialize-the-app-server-session-using-the-targeted-codex-app-server-protocol",
    "type": "claim",
    "title": "Initialize the app-server session using the targeted Codex app-server protocol.",
    "lineStart": 948,
    "lineEnd": 948,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Initialize the app-server session using the targeted Codex app-server protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-create-or-resume-a-coding-agent-thread-according-to-the-targeted-protocol",
    "type": "claim",
    "title": "Create or resume a coding-agent thread according to the targeted protocol.",
    "lineStart": 949,
    "lineEnd": 949,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Create or resume a coding-agent thread according to the targeted protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-supply-the-absolute-per-issue-workspace-path-as-the-thread-turn-working-director",
    "type": "claim",
    "title": "Supply the absolute per-issue workspace path as the thread/turn working directory whe...",
    "lineStart": 950,
    "lineEnd": 950,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Supply the absolute per-issue workspace path as the thread/turn working directory wherever the targeted protocol accepts cwd.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-start-the-first-turn-with-the-rendered-issue-prompt",
    "type": "claim",
    "title": "Start the first turn with the rendered issue prompt.",
    "lineStart": 952,
    "lineEnd": 952,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Start the first turn with the rendered issue prompt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-start-later-in-worker-continuation-turns-on-the-same-live-thread-with-continuati",
    "type": "claim",
    "title": "Start later in-worker continuation turns on the same live thread with continuation gu...",
    "lineStart": 953,
    "lineEnd": 953,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Start later in-worker continuation turns on the same live thread with continuation guidance rather than resending the original issue prompt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-supply-the-implementation-s-documented-approval-and-sandbox-policy-using-fields-",
    "type": "claim",
    "title": "Supply the implementation's documented approval and sandbox policy using fields suppo...",
    "lineStart": 955,
    "lineEnd": 955,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Supply the implementation's documented approval and sandbox policy using fields supported by the targeted protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-include-issue-identifying-metadata-such-as-issue-identifier-issue-title-when-t",
    "type": "claim",
    "title": "Include issue-identifying metadata, such as <issue.identifier>: <issue.title>, when t...",
    "lineStart": 957,
    "lineEnd": 957,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Include issue-identifying metadata, such as `<issue.identifier>: <issue.title>`, when the targeted protocol supports turn or session titles.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-advertise-implemented-client-side-tools-using-the-targeted-protocol",
    "type": "claim",
    "title": "Advertise implemented client-side tools using the targeted protocol.",
    "lineStart": 959,
    "lineEnd": 959,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Advertise implemented client-side tools using the targeted protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser",
    "type": "claim",
    "title": "Extract threadid from the thread identity returned by the targeted Codex app-server p...",
    "lineStart": 963,
    "lineEnd": 963,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Extract `thread_id` from the thread identity returned by the targeted Codex app-server protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-extract-turnid-from-each-turn-identity-returned-by-the-targeted-codex-app-server",
    "type": "claim",
    "title": "Extract turnid from each turn identity returned by the targeted Codex app-server prot...",
    "lineStart": 964,
    "lineEnd": 964,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Extract `turn_id` from each turn identity returned by the targeted Codex app-server protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-emit-sessionid-threadid-turnid",
    "type": "claim",
    "title": "Emit sessionid = \"<threadid>-<turnid>\"",
    "lineStart": 965,
    "lineEnd": 965,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Emit `session_id = \"<thread_id>-<turn_id>\"`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-reuse-the-same-threadid-for-all-continuation-turns-inside-one-worker-run",
    "type": "claim",
    "title": "Reuse the same threadid for all continuation turns inside one worker run",
    "lineStart": 966,
    "lineEnd": 966,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reuse the same `thread_id` for all continuation turns inside one worker run",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-completion-signal-success",
    "type": "claim",
    "title": "Targeted-protocol turn completion signal -> success",
    "lineStart": 975,
    "lineEnd": 975,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Targeted-protocol turn completion signal -> success",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn failure signal -> failure",
    "lineStart": 976,
    "lineEnd": 976,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Targeted-protocol turn failure signal -> failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn cancellation signal -> failure",
    "lineStart": 977,
    "lineEnd": 977,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Targeted-protocol turn cancellation signal -> failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure",
    "type": "claim",
    "title": "turn timeout (turntimeoutms) -> failure",
    "lineStart": 978,
    "lineEnd": 978,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "turn timeout (`turn_timeout_ms`) -> failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-subprocess-exit-failure",
    "type": "claim",
    "title": "subprocess exit -> failure",
    "lineStart": 979,
    "lineEnd": 979,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "subprocess exit -> failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "requirement",
    "title": "If the worker decides to continue after a successful turn, it SHOULD start another tu...",
    "lineStart": 983,
    "lineEnd": 983,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the worker decides to continue after a successful turn, it SHOULD start another turn on the same live thread using the targeted protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an",
    "type": "requirement",
    "title": "The app-server subprocess SHOULD remain alive across those continuation turns and be...",
    "lineStart": 985,
    "lineEnd": 985,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The app-server subprocess SHOULD remain alive across those continuation turns and be stopped only when the worker run is ending.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version",
    "type": "claim",
    "title": "Follow the transport and framing rules of the targeted Codex app-server version.",
    "lineStart": 990,
    "lineEnd": 990,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Follow the transport and framing rules of the targeted Codex app-server version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-3-streaming-turn-processing-for-stdio-based-transports-keep-protocol-stream-handling-separate-from-diagnosti",
    "type": "claim",
    "title": "For stdio-based transports, keep protocol stream handling separate from diagnostic st...",
    "lineStart": 991,
    "lineEnd": 991,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "For stdio-based transports, keep protocol stream handling separate from diagnostic stderr handling unless the targeted protocol specifies otherwise.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should",
    "type": "requirement",
    "title": "Each event SHOULD",
    "lineStart": 996,
    "lineEnd": 996,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Each event SHOULD",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-event-enum-string",
    "type": "claim",
    "title": "event (enum/string)",
    "lineStart": 999,
    "lineEnd": 999,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`event` (enum/string)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-timestamp-utc-timestamp",
    "type": "claim",
    "title": "timestamp (UTC timestamp)",
    "lineStart": 1000,
    "lineEnd": 1000,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`timestamp` (UTC timestamp)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-codexappserverpid-if-available",
    "type": "claim",
    "title": "codexappserverpid (if available)",
    "lineStart": 1001,
    "lineEnd": 1001,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_app_server_pid` (if available)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-optional-usage-map-token-counts",
    "type": "requirement",
    "title": "OPTIONAL usage map (token counts)",
    "lineStart": 1002,
    "lineEnd": 1002,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "OPTIONAL `usage` map (token counts)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-payload-fields-as-needed",
    "type": "claim",
    "title": "payload fields as needed",
    "lineStart": 1003,
    "lineEnd": 1003,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "payload fields as needed",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-sessionstarted",
    "type": "claim",
    "title": "sessionstarted",
    "lineStart": 1007,
    "lineEnd": 1007,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`session_started`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-startupfailed",
    "type": "claim",
    "title": "startupfailed",
    "lineStart": 1008,
    "lineEnd": 1008,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`startup_failed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncompleted",
    "type": "claim",
    "title": "turncompleted",
    "lineStart": 1009,
    "lineEnd": 1009,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_completed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnfailed",
    "type": "claim",
    "title": "turnfailed",
    "lineStart": 1010,
    "lineEnd": 1010,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_failed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncancelled",
    "type": "claim",
    "title": "turncancelled",
    "lineStart": 1011,
    "lineEnd": 1011,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_cancelled`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnendedwitherror",
    "type": "claim",
    "title": "turnendedwitherror",
    "lineStart": 1012,
    "lineEnd": 1012,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_ended_with_error`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turninputrequired",
    "type": "claim",
    "title": "turninputrequired",
    "lineStart": 1013,
    "lineEnd": 1013,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_input_required`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-approvalautoapproved",
    "type": "claim",
    "title": "approvalautoapproved",
    "lineStart": 1014,
    "lineEnd": 1014,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`approval_auto_approved`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-unsupportedtoolcall",
    "type": "claim",
    "title": "unsupportedtoolcall",
    "lineStart": 1015,
    "lineEnd": 1015,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`unsupported_tool_call`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-notification",
    "type": "claim",
    "title": "notification",
    "lineStart": 1016,
    "lineEnd": 1016,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`notification`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-othermessage",
    "type": "claim",
    "title": "othermessage",
    "lineStart": 1017,
    "lineEnd": 1017,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`other_message`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-malformed",
    "type": "claim",
    "title": "malformed",
    "lineStart": 1018,
    "lineEnd": 1018,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`malformed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi",
    "type": "requirement",
    "title": "Each implementation MUST document its chosen approval, sandbox, and operator-confirma...",
    "lineStart": 1026,
    "lineEnd": 1026,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Each implementation MUST document its chosen approval, sandbox, and operator-confirmation posture.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-approval-requests-and-user-input-required-events-must-not-leave-a-run-stalled-in",
    "type": "requirement",
    "title": "Approval requests and user-input-required events MUST NOT leave a run stalled indefin...",
    "lineStart": 1028,
    "lineEnd": 1028,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Approval requests and user-input-required events MUST NOT leave a run stalled indefinitely. An implementation MAY either satisfy them, surface them to an operator, auto-resolve them, or fail the run according to its documented policy.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-command-execution-approvals-for-the-session",
    "type": "claim",
    "title": "Auto-approve command execution approvals for the session.",
    "lineStart": 1034,
    "lineEnd": 1034,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Auto-approve command execution approvals for the session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-file-change-approvals-for-the-session",
    "type": "claim",
    "title": "Auto-approve file-change approvals for the session.",
    "lineStart": 1035,
    "lineEnd": 1035,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Auto-approve file-change approvals for the session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-treat-user-input-required-turns-as-hard-failure",
    "type": "requirement",
    "title": "Treat user-input-required turns as hard failure.",
    "lineStart": 1036,
    "lineEnd": 1036,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Treat user-input-required turns as hard failure.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-supported-dynamic-tool-calls-that-are-explicitly-implemented-and-advertised-by-t",
    "type": "requirement",
    "title": "Supported dynamic tool calls that are explicitly implemented and advertised by the ru...",
    "lineStart": 1040,
    "lineEnd": 1040,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Supported dynamic tool calls that are explicitly implemented and advertised by the runtime SHOULD be handled according to their extension contract.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-agent-requests-a-dynamic-tool-call-that-is-not-supported-return-a-tool-fa",
    "type": "dependency",
    "title": "If the agent requests a dynamic tool call that is not supported, return a tool failur...",
    "lineStart": 1042,
    "lineEnd": 1042,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the agent requests a dynamic tool call that is not supported, return a tool failure response using the targeted protocol and continue the session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-this-prevents-the-session-from-stalling-on-unsupported-tool-execution-paths",
    "type": "dependency",
    "title": "This prevents the session from stalling on unsupported tool execution paths.",
    "lineStart": 1044,
    "lineEnd": 1044,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "This prevents the session from stalling on unsupported tool execution paths.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve",
    "type": "requirement",
    "title": "An implementation MAY expose a limited set of client-side tools to the app-server ses...",
    "lineStart": 1048,
    "lineEnd": 1048,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "An implementation MAY expose a limited set of client-side tools to the app-server session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-current-standardized-optional-tool-lineargraphql",
    "type": "dependency",
    "title": "Current standardized optional tool: lineargraphql.",
    "lineStart": 1049,
    "lineEnd": 1049,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Current standardized optional tool: `linear_graphql`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-if-implemented-supported-tools-should-be-advertised-to-the-app-server-session-du",
    "type": "requirement",
    "title": "If implemented, supported tools SHOULD be advertised to the app-server session during...",
    "lineStart": 1050,
    "lineEnd": 1050,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If implemented, supported tools SHOULD be advertised to the app-server session during startup using the protocol mechanism supported by the targeted Codex app-server version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-unsupported-tool-names-should-still-return-a-failure-result-using-the-targeted-p",
    "type": "requirement",
    "title": "Unsupported tool names SHOULD still return a failure result using the targeted protoc...",
    "lineStart": 1052,
    "lineEnd": 1052,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unsupported tool names SHOULD still return a failure result using the targeted protocol and continue the session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-purpose-execute-a-raw-graphql-query-or-mutation-against-linear-using-symphony-s-",
    "type": "claim",
    "title": "Purpose: execute a raw GraphQL query or mutation against Linear using Symphony's conf...",
    "lineStart": 1057,
    "lineEnd": 1057,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Purpose: execute a raw GraphQL query or mutation against Linear using Symphony's configured tracker auth for the current session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-availability-only-meaningful-when-tracker-kind-linear-and-valid-linear-auth-is",
    "type": "claim",
    "title": "Availability: only meaningful when tracker.kind == \"linear\" and valid Linear auth is...",
    "lineStart": 1059,
    "lineEnd": 1059,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Availability: only meaningful when `tracker.kind == \"linear\"` and valid Linear auth is configured.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-preferred-input-shape",
    "type": "claim",
    "title": "Preferred input shape:",
    "lineStart": 1060,
    "lineEnd": 1060,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Preferred input shape:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-be-a-non-empty-string",
    "type": "requirement",
    "title": "query MUST be a non-empty string.",
    "lineStart": 1071,
    "lineEnd": 1071,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`query` MUST be a non-empty string.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-contain-exactly-one-graphql-operation",
    "type": "requirement",
    "title": "query MUST contain exactly one GraphQL operation.",
    "lineStart": 1072,
    "lineEnd": 1072,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`query` MUST contain exactly one GraphQL operation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-variables-is-optional-and-when-present-must-be-a-json-object",
    "type": "requirement",
    "title": "variables is OPTIONAL and, when present, MUST be a JSON object.",
    "lineStart": 1073,
    "lineEnd": 1073,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`variables` is OPTIONAL and, when present, MUST be a JSON object.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-may-additionally-accept-a-raw-graphql-query-string-as-shorthand-",
    "type": "requirement",
    "title": "Implementations MAY additionally accept a raw GraphQL query string as shorthand input.",
    "lineStart": 1074,
    "lineEnd": 1074,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY additionally accept a raw GraphQL query string as shorthand input.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-execute-one-graphql-operation-per-tool-call",
    "type": "dependency",
    "title": "Execute one GraphQL operation per tool call.",
    "lineStart": 1075,
    "lineEnd": 1075,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Execute one GraphQL operation per tool call.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-provided-document-contains-multiple-operations-reject-the-tool-call-as-in",
    "type": "dependency",
    "title": "If the provided document contains multiple operations, reject the tool call as invali...",
    "lineStart": 1076,
    "lineEnd": 1076,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the provided document contains multiple operations, reject the tool call as invalid input.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-operationname-selection-is-intentionally-out-of-scope-for-this-extension",
    "type": "claim",
    "title": "operationName selection is intentionally out of scope for this extension.",
    "lineStart": 1077,
    "lineEnd": 1077,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`operationName` selection is intentionally out of scope for this extension.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-reuse-the-configured-linear-endpoint-and-auth-from-the-active-symphony-workflow-",
    "type": "claim",
    "title": "Reuse the configured Linear endpoint and auth from the active Symphony workflow/runti...",
    "lineStart": 1078,
    "lineEnd": 1078,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reuse the configured Linear endpoint and auth from the active Symphony workflow/runtime config; do not require the coding agent to read raw tokens from disk.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-tool-result-semantics",
    "type": "dependency",
    "title": "Tool result semantics:",
    "lineStart": 1080,
    "lineEnd": 1080,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Tool result semantics:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-transport-success-no-top-level-graphql-errors-success-true",
    "type": "claim",
    "title": "transport success + no top-level GraphQL errors -> success=true",
    "lineStart": 1081,
    "lineEnd": 1081,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "transport success + no top-level GraphQL `errors` -> `success=true`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-top-level-graphql-errors-present-success-false-but-preserve-the-graphql-response",
    "type": "claim",
    "title": "top-level GraphQL errors present -> success=false, but preserve the GraphQL response...",
    "lineStart": 1082,
    "lineEnd": 1082,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "top-level GraphQL `errors` present -> `success=false`, but preserve the GraphQL response body for debugging",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-5-approval-tool-calls-and-user-input-policy-invalid-input-missing-auth-or-transport-failure-success-false-with-an-error-payl",
    "type": "claim",
    "title": "invalid input, missing auth, or transport failure -> success=false with an error payload",
    "lineStart": 1084,
    "lineEnd": 1084,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "invalid input, missing auth, or transport failure -> `success=false` with an error payload",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-10-5-approval-tool-calls-and-user-input-policy-return-the-graphql-response-or-error-payload-as-structured-tool-output-that-the-",
    "type": "dependency",
    "title": "Return the GraphQL response or error payload as structured tool output that the model...",
    "lineStart": 1085,
    "lineEnd": 1085,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Return the GraphQL response or error payload as structured tool output that the model can inspect in-session.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-",
    "type": "requirement",
    "title": "Implementations MUST document how targeted-protocol user-input-required signals are h...",
    "lineStart": 1090,
    "lineEnd": 1090,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MUST document how targeted-protocol user-input-required signals are handled.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-a-run-must-not-stall-indefinitely-waiting-for-user-input",
    "type": "requirement",
    "title": "A run MUST NOT stall indefinitely waiting for user input.",
    "lineStart": 1091,
    "lineEnd": 1091,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A run MUST NOT stall indefinitely waiting for user input.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-a-conforming-implementation-may-fail-the-run-surface-the-request-to-an-operator-",
    "type": "requirement",
    "title": "A conforming implementation MAY fail the run, surface the request to an operator, sat...",
    "lineStart": 1092,
    "lineEnd": 1092,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A conforming implementation MAY fail the run, surface the request to an operator, satisfy it through an approved operator channel, or auto-resolve it according to its documented policy.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-5-approval-tool-calls-and-user-input-policy-the-example-high-trust-behavior-above-fails-user-input-required-turns-immediatel",
    "type": "requirement",
    "title": "The example high-trust behavior above fails user-input-required turns immediately.",
    "lineStart": 1094,
    "lineEnd": 1094,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The example high-trust behavior above fails user-input-required turns immediately.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests",
    "type": "claim",
    "title": "codex.readtimeoutms: request/response timeout during startup and sync requests",
    "lineStart": 1100,
    "lineEnd": 1100,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.read_timeout_ms`: request/response timeout during startup and sync requests",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codex-turntimeoutms-total-turn-stream-timeout",
    "type": "claim",
    "title": "codex.turntimeoutms: total turn stream timeout",
    "lineStart": 1101,
    "lineEnd": 1101,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.turn_timeout_ms`: total turn stream timeout",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codex-stalltimeoutms-enforced-by-orchestrator-based-on-event-inactivity",
    "type": "claim",
    "title": "codex.stalltimeoutms: enforced by orchestrator based on event inactivity",
    "lineStart": 1102,
    "lineEnd": 1102,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.stall_timeout_ms`: enforced by orchestrator based on event inactivity",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-10-6-timeouts-and-error-mapping-error-mapping-recommended-normalized-categories",
    "type": "requirement",
    "title": "Error mapping (RECOMMENDED normalized categories):",
    "lineStart": 1104,
    "lineEnd": 1104,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Error mapping (RECOMMENDED normalized categories):",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-codexnotfound",
    "type": "claim",
    "title": "codexnotfound",
    "lineStart": 1106,
    "lineEnd": 1106,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_not_found`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-invalidworkspacecwd",
    "type": "claim",
    "title": "invalidworkspacecwd",
    "lineStart": 1107,
    "lineEnd": 1107,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`invalid_workspace_cwd`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-responsetimeout",
    "type": "claim",
    "title": "responsetimeout",
    "lineStart": 1108,
    "lineEnd": 1108,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`response_timeout`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-turntimeout",
    "type": "claim",
    "title": "turntimeout",
    "lineStart": 1109,
    "lineEnd": 1109,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_timeout`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-portexit",
    "type": "claim",
    "title": "portexit",
    "lineStart": 1110,
    "lineEnd": 1110,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`port_exit`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-responseerror",
    "type": "claim",
    "title": "responseerror",
    "lineStart": 1111,
    "lineEnd": 1111,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`response_error`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-turnfailed",
    "type": "claim",
    "title": "turnfailed",
    "lineStart": 1112,
    "lineEnd": 1112,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_failed`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-turncancelled",
    "type": "claim",
    "title": "turncancelled",
    "lineStart": 1113,
    "lineEnd": 1113,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_cancelled`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-6-timeouts-and-error-mapping-turninputrequired",
    "type": "claim",
    "title": "turninputrequired",
    "lineStart": 1114,
    "lineEnd": 1114,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`turn_input_required`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-10-7-agent-runner-contract-workspaces-are-intentionally-preserved-after-successful-runs",
    "type": "claim",
    "title": "Workspaces are intentionally preserved after successful runs.",
    "lineStart": 1130,
    "lineEnd": 1130,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspaces are intentionally preserved after successful runs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-1-required-operations-an-implementation-must-support-these-tracker-adapter-operations",
    "type": "requirement",
    "title": "An implementation MUST support these tracker adapter operations:",
    "lineStart": 1136,
    "lineEnd": 1136,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "An implementation MUST support these tracker adapter operations:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-1-required-operations-return-issues-in-configured-active-states-for-a-configured-project",
    "type": "claim",
    "title": "Return issues in configured active states for a configured project.",
    "lineStart": 1139,
    "lineEnd": 1139,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Return issues in configured active states for a configured project.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-1-required-operations-used-for-startup-terminal-cleanup",
    "type": "claim",
    "title": "Used for startup terminal cleanup.",
    "lineStart": 1142,
    "lineEnd": 1142,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Used for startup terminal cleanup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-1-required-operations-used-for-active-run-reconciliation",
    "type": "claim",
    "title": "Used for active-run reconciliation.",
    "lineStart": 1145,
    "lineEnd": 1145,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Used for active-run reconciliation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-tracker-kind-linear",
    "type": "claim",
    "title": "tracker.kind == \"linear\"",
    "lineStart": 1151,
    "lineEnd": 1151,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.kind == \"linear\"`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "GraphQL endpoint (default https://api.linear.app/graphql)",
    "lineStart": 1152,
    "lineEnd": 1152,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "GraphQL endpoint (default `https://api.linear.app/graphql`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-auth-token-sent-in-authorization-header",
    "type": "claim",
    "title": "Auth token sent in Authorization header",
    "lineStart": 1153,
    "lineEnd": 1153,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Auth token sent in `Authorization` header",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-tracker-projectslug-maps-to-linear-project-slugid",
    "type": "claim",
    "title": "tracker.projectslug maps to Linear project slugId",
    "lineStart": 1154,
    "lineEnd": 1154,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.project_slug` maps to Linear project `slugId`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-candidate-issue-query-filters-project-using-project-slugid-eq-projectslug",
    "type": "claim",
    "title": "Candidate issue query filters project using project: { slugId: { eq: $projectSlug } }",
    "lineStart": 1155,
    "lineEnd": 1155,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Candidate issue query filters project using `project: { slugId: { eq: $projectSlug } }`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id",
    "type": "claim",
    "title": "Issue-state refresh query uses GraphQL issue IDs with variable type [ID!]",
    "lineStart": 1156,
    "lineEnd": 1156,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue-state refresh query uses GraphQL issue IDs with variable type `[ID!]`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-2-query-semantics-linear-pagination-required-for-candidate-issues",
    "type": "requirement",
    "title": "Pagination REQUIRED for candidate issues",
    "lineStart": 1157,
    "lineEnd": 1157,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Pagination REQUIRED for candidate issues",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-page-size-default-50",
    "type": "claim",
    "title": "Page size default: 50",
    "lineStart": 1158,
    "lineEnd": 1158,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Page size default: `50`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-2-query-semantics-linear-network-timeout-30000-ms",
    "type": "claim",
    "title": "Network timeout: 30000 ms",
    "lineStart": 1159,
    "lineEnd": 1159,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Network timeout: `30000 ms`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-2-query-semantics-linear-linear-graphql-schema-details-can-drift-keep-query-construction-isolated-and-tes",
    "type": "requirement",
    "title": "Linear GraphQL schema details can drift. Keep query construction isolated and test th...",
    "lineStart": 1163,
    "lineEnd": 1163,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Linear GraphQL schema details can drift. Keep query construction isolated and test the exact query fields/types REQUIRED by this specification.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp",
    "type": "requirement",
    "title": "A non-Linear implementation MAY change transport details, but the normalized outputs...",
    "lineStart": 1166,
    "lineEnd": 1166,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A non-Linear implementation MAY change transport details, but the normalized outputs MUST match the",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-3-normalization-rules-candidate-issue-normalization-should-produce-fields-listed-in-section-4-1-1",
    "type": "requirement",
    "title": "Candidate issue normalization SHOULD produce fields listed in Section 4.1.1.",
    "lineStart": 1171,
    "lineEnd": 1171,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Candidate issue normalization SHOULD produce fields listed in Section 4.1.1.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-3-normalization-rules-labels-lowercase-strings",
    "type": "claim",
    "title": "labels -> lowercase strings",
    "lineStart": 1175,
    "lineEnd": 1175,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`labels` -> lowercase strings",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-3-normalization-rules-blockedby-derived-from-inverse-relations-where-relation-type-is-blocks",
    "type": "claim",
    "title": "blockedby -> derived from inverse relations where relation type is blocks",
    "lineStart": 1176,
    "lineEnd": 1176,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`blocked_by` -> derived from inverse relations where relation type is `blocks`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-3-normalization-rules-priority-integer-only-non-integers-become-null",
    "type": "claim",
    "title": "priority -> integer only (non-integers become null)",
    "lineStart": 1177,
    "lineEnd": 1177,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`priority` -> integer only (non-integers become null)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-3-normalization-rules-createdat-and-updatedat-parse-iso-8601-timestamps",
    "type": "claim",
    "title": "createdat and updatedat -> parse ISO-8601 timestamps",
    "lineStart": 1178,
    "lineEnd": 1178,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`created_at` and `updated_at` -> parse ISO-8601 timestamps",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-11-4-error-handling-contract-recommended-error-categories",
    "type": "requirement",
    "title": "RECOMMENDED error categories:",
    "lineStart": 1182,
    "lineEnd": 1182,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "RECOMMENDED error categories:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-unsupportedtrackerkind",
    "type": "claim",
    "title": "unsupportedtrackerkind",
    "lineStart": 1184,
    "lineEnd": 1184,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`unsupported_tracker_kind`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-missingtrackerapikey",
    "type": "claim",
    "title": "missingtrackerapikey",
    "lineStart": 1185,
    "lineEnd": 1185,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`missing_tracker_api_key`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-missingtrackerprojectslug",
    "type": "claim",
    "title": "missingtrackerprojectslug",
    "lineStart": 1186,
    "lineEnd": 1186,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`missing_tracker_project_slug`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-linearapirequest-transport-failures",
    "type": "claim",
    "title": "linearapirequest (transport failures)",
    "lineStart": 1187,
    "lineEnd": 1187,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_api_request` (transport failures)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-linearapistatus-non-200-http",
    "type": "claim",
    "title": "linearapistatus (non-200 HTTP)",
    "lineStart": 1188,
    "lineEnd": 1188,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_api_status` (non-200 HTTP)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-lineargraphqlerrors",
    "type": "claim",
    "title": "lineargraphqlerrors",
    "lineStart": 1189,
    "lineEnd": 1189,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_graphql_errors`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-linearunknownpayload",
    "type": "claim",
    "title": "linearunknownpayload",
    "lineStart": 1190,
    "lineEnd": 1190,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_unknown_payload`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-linearmissingendcursor-pagination-integrity-error",
    "type": "claim",
    "title": "linearmissingendcursor (pagination integrity error)",
    "lineStart": 1191,
    "lineEnd": 1191,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_missing_end_cursor` (pagination integrity error)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick",
    "type": "claim",
    "title": "Candidate fetch failure: log and skip dispatch for this tick.",
    "lineStart": 1195,
    "lineEnd": 1195,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Candidate fetch failure: log and skip dispatch for this tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running",
    "type": "claim",
    "title": "Running-state refresh failure: log and keep active workers running.",
    "lineStart": 1196,
    "lineEnd": 1196,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Running-state refresh failure: log and keep active workers running.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup",
    "type": "claim",
    "title": "Startup terminal cleanup failure: log warning and continue startup.",
    "lineStart": 1197,
    "lineEnd": 1197,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Startup terminal cleanup failure: log warning and continue startup.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-5-tracker-writes-important-boundary-ticket-mutations-state-transitions-comments-pr-metadata-are-typically-handled-by",
    "type": "claim",
    "title": "Ticket mutations (state transitions, comments, PR metadata) are typically handled by...",
    "lineStart": 1203,
    "lineEnd": 1203,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Ticket mutations (state transitions, comments, PR metadata) are typically handled by the coding agent using tools defined by the workflow prompt.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-5-tracker-writes-important-boundary-the-service-remains-a-scheduler-runner-and-tracker-reader",
    "type": "claim",
    "title": "The service remains a scheduler/runner and tracker reader.",
    "lineStart": 1205,
    "lineEnd": 1205,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The service remains a scheduler/runner and tracker reader.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-11-5-tracker-writes-important-boundary-workflow-specific-success-often-means-reached-the-next-handoff-state-for-example",
    "type": "claim",
    "title": "Workflow-specific success often means \"reached the next handoff state\" (for example H...",
    "lineStart": 1206,
    "lineEnd": 1206,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow-specific success often means \"reached the next handoff state\" (for example `Human Review`) rather than tracker terminal state `Done`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-11-5-tracker-writes-important-boundary-if-the-lineargraphql-client-side-tool-extension-is-implemented-it-is-still-part-",
    "type": "dependency",
    "title": "If the lineargraphql client-side tool extension is implemented, it is still part of t...",
    "lineStart": 1208,
    "lineEnd": 1208,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the `linear_graphql` client-side tool extension is implemented, it is still part of the agent toolchain rather than orchestrator business logic.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-1-inputs-workflow-prompttemplate",
    "type": "claim",
    "title": "workflow.prompttemplate",
    "lineStart": 1217,
    "lineEnd": 1217,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workflow.prompt_template`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-1-inputs-normalized-issue-object",
    "type": "claim",
    "title": "normalized issue object",
    "lineStart": 1218,
    "lineEnd": 1218,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "normalized `issue` object",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-12-1-inputs-optional-attempt-integer-retry-continuation-metadata",
    "type": "requirement",
    "title": "OPTIONAL attempt integer (retry/continuation metadata)",
    "lineStart": 1219,
    "lineEnd": 1219,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "OPTIONAL `attempt` integer (retry/continuation metadata)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-2-rendering-rules-render-with-strict-variable-checking",
    "type": "claim",
    "title": "Render with strict variable checking.",
    "lineStart": 1223,
    "lineEnd": 1223,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Render with strict variable checking.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-2-rendering-rules-render-with-strict-filter-checking",
    "type": "claim",
    "title": "Render with strict filter checking.",
    "lineStart": 1224,
    "lineEnd": 1224,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Render with strict filter checking.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-2-rendering-rules-convert-issue-object-keys-to-strings-for-template-compatibility",
    "type": "claim",
    "title": "Convert issue object keys to strings for template compatibility.",
    "lineStart": 1225,
    "lineEnd": 1225,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Convert issue object keys to strings for template compatibility.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-2-rendering-rules-preserve-nested-arrays-maps-labels-blockers-so-templates-can-iterate",
    "type": "claim",
    "title": "Preserve nested arrays/maps (labels, blockers) so templates can iterate.",
    "lineStart": 1226,
    "lineEnd": 1226,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Preserve nested arrays/maps (labels, blockers) so templates can iterate.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-12-3-retry-continuation-semantics-attempt-should-be-passed-to-the-template-because-the-workflow-prompt-can-provide",
    "type": "requirement",
    "title": "attempt SHOULD be passed to the template because the workflow prompt can provide diff...",
    "lineStart": 1230,
    "lineEnd": 1230,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`attempt` SHOULD be passed to the template because the workflow prompt can provide different",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-3-retry-continuation-semantics-first-run-attempt-null-or-absent",
    "type": "claim",
    "title": "first run (attempt null or absent)",
    "lineStart": 1233,
    "lineEnd": 1233,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "first run (`attempt` null or absent)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-3-retry-continuation-semantics-continuation-run-after-a-successful-prior-session",
    "type": "claim",
    "title": "continuation run after a successful prior session",
    "lineStart": 1234,
    "lineEnd": 1234,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "continuation run after a successful prior session",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-12-3-retry-continuation-semantics-retry-after-error-timeout-stall",
    "type": "claim",
    "title": "retry after error/timeout/stall",
    "lineStart": 1235,
    "lineEnd": 1235,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "retry after error/timeout/stall",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-12-4-failure-semantics-fail-the-run-attempt-immediately",
    "type": "risk",
    "title": "Fail the run attempt immediately.",
    "lineStart": 1241,
    "lineEnd": 1241,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Fail the run attempt immediately.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh",
    "type": "risk",
    "title": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "lineStart": 1242,
    "lineEnd": 1242,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-1-logging-conventions-required-context-fields-for-issue-related-logs",
    "type": "requirement",
    "title": "REQUIRED context fields for issue-related logs:",
    "lineStart": 1248,
    "lineEnd": 1248,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "REQUIRED context fields for issue-related logs:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-issueid",
    "type": "claim",
    "title": "issueid",
    "lineStart": 1250,
    "lineEnd": 1250,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue_id`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-issueidentifier",
    "type": "claim",
    "title": "issueidentifier",
    "lineStart": 1251,
    "lineEnd": 1251,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`issue_identifier`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-1-logging-conventions-required-context-for-coding-agent-session-lifecycle-logs",
    "type": "requirement",
    "title": "REQUIRED context for coding-agent session lifecycle logs:",
    "lineStart": 1253,
    "lineEnd": 1253,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "REQUIRED context for coding-agent session lifecycle logs:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-sessionid",
    "type": "claim",
    "title": "sessionid",
    "lineStart": 1255,
    "lineEnd": 1255,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`session_id`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-use-stable-key-value-phrasing",
    "type": "claim",
    "title": "Use stable key=value phrasing.",
    "lineStart": 1259,
    "lineEnd": 1259,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Use stable `key=value` phrasing.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-include-action-outcome-completed-failed-retrying-etc",
    "type": "claim",
    "title": "Include action outcome (completed, failed, retrying, etc.).",
    "lineStart": 1260,
    "lineEnd": 1260,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Include action outcome (`completed`, `failed`, `retrying`, etc.).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-include-concise-failure-reason-when-present",
    "type": "claim",
    "title": "Include concise failure reason when present.",
    "lineStart": 1261,
    "lineEnd": 1261,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Include concise failure reason when present.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-1-logging-conventions-avoid-logging-large-raw-payloads-unless-necessary",
    "type": "claim",
    "title": "Avoid logging large raw payloads unless necessary.",
    "lineStart": 1262,
    "lineEnd": 1262,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Avoid logging large raw payloads unless necessary.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "requirement",
    "title": "Operators MUST be able to see startup/validation/dispatch failures without attaching...",
    "lineStart": 1270,
    "lineEnd": 1270,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-implementations-may-write-to-one-or-more-sinks",
    "type": "requirement",
    "title": "Implementations MAY write to one or more sinks.",
    "lineStart": 1271,
    "lineEnd": 1271,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY write to one or more sinks.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "type": "requirement",
    "title": "If a configured log sink fails, the service SHOULD continue running when possible and...",
    "lineStart": 1272,
    "lineEnd": 1272,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If a configured log sink fails, the service SHOULD continue running when possible and emit an operator-visible warning through any remaining sink.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-should-return",
    "type": "requirement",
    "title": "SHOULD return:",
    "lineStart": 1278,
    "lineEnd": 1278,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "SHOULD return:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-running-list-of-running-session-rows",
    "type": "claim",
    "title": "running (list of running session rows)",
    "lineStart": 1280,
    "lineEnd": 1280,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`running` (list of running session rows)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-each-running-row-should-include-turncount",
    "type": "requirement",
    "title": "each running row SHOULD include turncount",
    "lineStart": 1281,
    "lineEnd": 1281,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "each running row SHOULD include `turn_count`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-retrying-list-of-retry-queue-rows",
    "type": "claim",
    "title": "retrying (list of retry queue rows)",
    "lineStart": 1282,
    "lineEnd": 1282,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`retrying` (list of retry queue rows)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-codextotals",
    "type": "claim",
    "title": "codextotals",
    "lineStart": 1283,
    "lineEnd": 1283,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex_totals`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-inputtokens",
    "type": "claim",
    "title": "inputtokens",
    "lineStart": 1284,
    "lineEnd": 1284,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`input_tokens`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-outputtokens",
    "type": "claim",
    "title": "outputtokens",
    "lineStart": 1285,
    "lineEnd": 1285,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`output_tokens`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-totaltokens",
    "type": "claim",
    "title": "totaltokens",
    "lineStart": 1286,
    "lineEnd": 1286,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`total_tokens`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-secondsrunning-aggregate-runtime-seconds-as-of-snapshot-time-including-active-se",
    "type": "claim",
    "title": "secondsrunning (aggregate runtime seconds as of snapshot time, including active sessi...",
    "lineStart": 1287,
    "lineEnd": 1287,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`seconds_running` (aggregate runtime seconds as of snapshot time, including active sessions)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-ratelimits-latest-coding-agent-rate-limit-payload-if-available",
    "type": "claim",
    "title": "ratelimits (latest coding-agent rate limit payload, if available)",
    "lineStart": 1288,
    "lineEnd": 1288,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`rate_limits` (latest coding-agent rate limit payload, if available)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-recommended-snapshot-error-modes",
    "type": "requirement",
    "title": "RECOMMENDED snapshot error modes:",
    "lineStart": 1290,
    "lineEnd": 1290,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "RECOMMENDED snapshot error modes:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-timeout",
    "type": "claim",
    "title": "timeout",
    "lineStart": 1292,
    "lineEnd": 1292,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`timeout`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-unavailable",
    "type": "claim",
    "title": "unavailable",
    "lineStart": 1293,
    "lineEnd": 1293,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`unavailable`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and",
    "type": "requirement",
    "title": "A human-readable status surface (terminal output, dashboard, etc.) is OPTIONAL and",
    "lineStart": 1297,
    "lineEnd": 1297,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A human-readable status surface (terminal output, dashboard, etc.) is OPTIONAL and",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-4-optional-human-readable-status-surface-if-present-it-should-draw-from-orchestrator-state-metrics-only-and-must-not-be-r",
    "type": "requirement",
    "title": "If present, it SHOULD draw from orchestrator state/metrics only and MUST NOT be REQUI...",
    "lineStart": 1300,
    "lineEnd": 1300,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If present, it SHOULD draw from orchestrator state/metrics only and MUST NOT be REQUIRED for",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-agent-events-can-include-token-counts-in-multiple-payload-shapes",
    "type": "claim",
    "title": "Agent events can include token counts in multiple payload shapes.",
    "lineStart": 1307,
    "lineEnd": 1307,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Agent events can include token counts in multiple payload shapes.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-prefer-absolute-thread-totals-when-available-such-as",
    "type": "claim",
    "title": "Prefer absolute thread totals when available, such as:",
    "lineStart": 1308,
    "lineEnd": 1308,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Prefer absolute thread totals when available, such as:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-thread-tokenusage-updated-payloads",
    "type": "claim",
    "title": "thread/tokenUsage/updated payloads",
    "lineStart": 1309,
    "lineEnd": 1309,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`thread/tokenUsage/updated` payloads",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-totaltokenusage-within-token-count-wrapper-events",
    "type": "claim",
    "title": "totaltokenusage within token-count wrapper events",
    "lineStart": 1310,
    "lineEnd": 1310,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`total_token_usage` within token-count wrapper events",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
    "type": "dependency",
    "title": "Ignore delta-style payloads such as lasttokenusage for dashboard/API totals.",
    "lineStart": 1311,
    "lineEnd": 1311,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Ignore delta-style payloads such as `last_token_usage` for dashboard/API totals.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within",
    "type": "claim",
    "title": "Extract input/output/total token counts leniently from common field names within the...",
    "lineStart": 1312,
    "lineEnd": 1312,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Extract input/output/total token counts leniently from common field names within the selected payload.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-for-absolute-totals-track-deltas-relative-to-last-reported-totals-to-avoid-doubl",
    "type": "claim",
    "title": "For absolute totals, track deltas relative to last reported totals to avoid double-co...",
    "lineStart": 1314,
    "lineEnd": 1314,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "For absolute totals, track deltas relative to last reported totals to avoid double-counting.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin",
    "type": "claim",
    "title": "Do not treat generic usage maps as cumulative totals unless the event type defines th...",
    "lineStart": 1315,
    "lineEnd": 1315,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Do not treat generic `usage` maps as cumulative totals unless the event type defines them that way.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-accumulate-aggregate-totals-in-orchestrator-state",
    "type": "claim",
    "title": "Accumulate aggregate totals in orchestrator state.",
    "lineStart": 1317,
    "lineEnd": 1317,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Accumulate aggregate totals in orchestrator state.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-5-session-metrics-and-token-accounting-runtime-should-be-reported-as-a-live-aggregate-at-snapshot-render-time",
    "type": "requirement",
    "title": "Runtime SHOULD be reported as a live aggregate at snapshot/render time.",
    "lineStart": 1321,
    "lineEnd": 1321,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Runtime SHOULD be reported as a live aggregate at snapshot/render time.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-5-session-metrics-and-token-accounting-implementations-may-maintain-a-cumulative-counter-for-ended-sessions-and-add-act",
    "type": "requirement",
    "title": "Implementations MAY maintain a cumulative counter for ended sessions and add active-s...",
    "lineStart": 1322,
    "lineEnd": 1322,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY maintain a cumulative counter for ended sessions and add active-session elapsed time derived from `running` entries (for example `started_at`) when producing a snapshot/status view.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-add-run-duration-seconds-to-the-cumulative-ended-session-runtime-when-a-session-",
    "type": "claim",
    "title": "Add run duration seconds to the cumulative ended-session runtime when a session ends...",
    "lineStart": 1325,
    "lineEnd": 1325,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Add run duration seconds to the cumulative ended-session runtime when a session ends (normal exit or cancellation/termination).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-5-session-metrics-and-token-accounting-continuous-background-ticking-of-runtime-totals-is-not-required",
    "type": "requirement",
    "title": "Continuous background ticking of runtime totals is not REQUIRED.",
    "lineStart": 1327,
    "lineEnd": 1327,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Continuous background ticking of runtime totals is not REQUIRED.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-track-the-latest-rate-limit-payload-seen-in-any-agent-update",
    "type": "claim",
    "title": "Track the latest rate-limit payload seen in any agent update.",
    "lineStart": 1331,
    "lineEnd": 1331,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Track the latest rate-limit payload seen in any agent update.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-5-session-metrics-and-token-accounting-any-human-readable-presentation-of-rate-limit-data-is-implementation-defined",
    "type": "claim",
    "title": "Any human-readable presentation of rate-limit data is implementation-defined.",
    "lineStart": 1332,
    "lineEnd": 1332,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Any human-readable presentation of rate-limit data is implementation-defined.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional",
    "type": "requirement",
    "title": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "lineStart": 1336,
    "lineEnd": 1336,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Humanized summaries of raw agent protocol events are OPTIONAL.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-6-humanized-agent-event-summaries-optional-treat-them-as-observability-only-output",
    "type": "claim",
    "title": "Treat them as observability-only output.",
    "lineStart": 1340,
    "lineEnd": 1340,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Treat them as observability-only output.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-6-humanized-agent-event-summaries-optional-do-not-make-orchestrator-logic-depend-on-humanized-strings",
    "type": "claim",
    "title": "Do not make orchestrator logic depend on humanized strings.",
    "lineStart": 1341,
    "lineEnd": 1341,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Do not make orchestrator logic depend on humanized strings.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-this-section-defines-an-optional-http-interface-for-observability-and-operationa",
    "type": "requirement",
    "title": "This section defines an OPTIONAL HTTP interface for observability and operational con...",
    "lineStart": 1345,
    "lineEnd": 1345,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "This section defines an OPTIONAL HTTP interface for observability and operational control.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance",
    "type": "requirement",
    "title": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "lineStart": 1349,
    "lineEnd": 1349,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The HTTP server is an extension and is not REQUIRED for conformance.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-implementation-may-serve-server-rendered-html-or-a-client-side-application-f",
    "type": "requirement",
    "title": "The implementation MAY serve server-rendered HTML or a client-side application for th...",
    "lineStart": 1350,
    "lineEnd": 1350,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The implementation MAY serve server-rendered HTML or a client-side application for the dashboard.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-the-dashboard-api-must-be-observability-control-surfaces-only-and-must-not-becom",
    "type": "requirement",
    "title": "The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQ...",
    "lineStart": 1351,
    "lineEnd": 1351,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The dashboard/API MUST be observability/control surfaces only and MUST NOT become REQUIRED for orchestrator correctness.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-server-port-integer-optional",
    "type": "requirement",
    "title": "server.port (integer, OPTIONAL)",
    "lineStart": 1356,
    "lineEnd": 1356,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`server.port` (integer, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-7-optional-http-server-extension-enables-the-http-server-extension",
    "type": "claim",
    "title": "Enables the HTTP server extension.",
    "lineStart": 1357,
    "lineEnd": 1357,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Enables the HTTP server extension.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-7-optional-http-server-extension-0-requests-an-ephemeral-port-for-local-development-and-tests",
    "type": "claim",
    "title": "0 requests an ephemeral port for local development and tests.",
    "lineStart": 1358,
    "lineEnd": 1358,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`0` requests an ephemeral port for local development and tests.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-optional-http-server-extension-cli-port-overrides-server-port-when-both-are-present",
    "type": "dependency",
    "title": "CLI --port overrides server.port when both are present.",
    "lineStart": 1359,
    "lineEnd": 1359,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI `--port` overrides `server.port` when both are present.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-optional-http-server-extension-start-the-http-server-when-a-cli-port-argument-is-provided",
    "type": "dependency",
    "title": "Start the HTTP server when a CLI --port argument is provided.",
    "lineStart": 1363,
    "lineEnd": 1363,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Start the HTTP server when a CLI `--port` argument is provided.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-7-optional-http-server-extension-start-the-http-server-when-server-port-is-present-in-workflow-md-front-matter",
    "type": "claim",
    "title": "Start the HTTP server when server.port is present in WORKFLOW.md front matter.",
    "lineStart": 1364,
    "lineEnd": 1364,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Start the HTTP server when `server.port` is present in `WORKFLOW.md` front matter.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-7-optional-http-server-extension-the-server-top-level-key-is-owned-by-this-extension",
    "type": "claim",
    "title": "The server top-level key is owned by this extension.",
    "lineStart": 1365,
    "lineEnd": 1365,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The `server` top-level key is owned by this extension.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-13-7-optional-http-server-extension-positive-server-port-values-bind-that-port",
    "type": "claim",
    "title": "Positive server.port values bind that port.",
    "lineStart": 1366,
    "lineEnd": 1366,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Positive `server.port` values bind that port.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-implementations-should-bind-loopback-by-default-127-0-0-1-or-host-equivalent-unl",
    "type": "requirement",
    "title": "Implementations SHOULD bind loopback by default (127.0.0.1 or host equivalent) unless...",
    "lineStart": 1367,
    "lineEnd": 1367,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD bind loopback by default (`127.0.0.1` or host equivalent) unless explicitly configured otherwise.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-optional-http-server-extension-changes-to-http-listener-settings-for-example-server-port-do-not-need-to-hot-reb",
    "type": "requirement",
    "title": "Changes to HTTP listener settings (for example server.port) do not need to hot-rebind...",
    "lineStart": 1369,
    "lineEnd": 1369,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changes to HTTP listener settings (for example `server.port`) do not need to hot-rebind; restart-required behavior is conformant.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-1-human-readable-dashboard-host-a-human-readable-dashboard-at",
    "type": "dependency",
    "title": "Host a human-readable dashboard at /.",
    "lineStart": 1374,
    "lineEnd": 1374,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Host a human-readable dashboard at `/`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-",
    "type": "requirement",
    "title": "The returned document SHOULD depict the current state of the system (for example acti...",
    "lineStart": 1375,
    "lineEnd": 1375,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The returned document SHOULD depict the current state of the system (for example active sessions, retry delays, token consumption, runtime totals, recent events, and health/error indicators).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client",
    "type": "dependency",
    "title": "It is up to the implementation whether this is server-generated HTML or a client-side...",
    "lineStart": 1377,
    "lineEnd": 1377,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "It is up to the implementation whether this is server-generated HTML or a client-side app that consumes the JSON API below.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-state",
    "type": "dependency",
    "title": "GET /api/v1/state",
    "lineStart": 1386,
    "lineEnd": 1386,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`GET /api/v1/state`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-returns-a-summary-view-of-the-current-system-state-running-sessions-retry-queue-",
    "type": "dependency",
    "title": "Returns a summary view of the current system state (running sessions, retry queue/del...",
    "lineStart": 1387,
    "lineEnd": 1387,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Returns a summary view of the current system state (running sessions, retry queue/delays, aggregate token/runtime totals, latest rate limits, and any additional tracked summary fields).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape",
    "type": "dependency",
    "title": "Suggested response shape:",
    "lineStart": 1389,
    "lineEnd": 1389,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Suggested response shape:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-issueidentifier",
    "type": "dependency",
    "title": "GET /api/v1/<issueidentifier>",
    "lineStart": 1435,
    "lineEnd": 1435,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`GET /api/v1/<issue_identifier>`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-returns-issue-specific-runtime-debug-details-for-the-identified-issue-including-",
    "type": "dependency",
    "title": "Returns issue-specific runtime/debug details for the identified issue, including any...",
    "lineStart": 1436,
    "lineEnd": 1436,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Returns issue-specific runtime/debug details for the identified issue, including any information the implementation tracks that is useful for debugging.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2",
    "type": "dependency",
    "title": "Suggested response shape:",
    "lineStart": 1438,
    "lineEnd": 1438,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Suggested response shape:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-",
    "type": "dependency",
    "title": "If the issue is unknown to the current in-memory state, return 404 with an error resp...",
    "lineStart": 1488,
    "lineEnd": 1488,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the issue is unknown to the current in-memory state, return `404` with an error response (for example `{\\\"error\\\":{\\\"code\\\":\\\"issue_not_found\\\",\\\"message\\\":\\\"...\\\"}}`).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-post-api-v1-refresh",
    "type": "dependency",
    "title": "POST /api/v1/refresh",
    "lineStart": 1491,
    "lineEnd": 1491,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`POST /api/v1/refresh`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-queues-an-immediate-tracker-poll-reconciliation-cycle-best-effort-trigger-implem",
    "type": "dependency",
    "title": "Queues an immediate tracker poll + reconciliation cycle (best-effort trigger; impleme...",
    "lineStart": 1492,
    "lineEnd": 1492,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Queues an immediate tracker poll + reconciliation cycle (best-effort trigger; implementations MAY coalesce repeated requests).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-request-body-empty-body-or",
    "type": "dependency",
    "title": "Suggested request body: empty body or {}.",
    "lineStart": 1494,
    "lineEnd": 1494,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Suggested request body: empty body or `{}`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-202-accepted-shape",
    "type": "dependency",
    "title": "Suggested response (202 Accepted) shape:",
    "lineStart": 1495,
    "lineEnd": 1495,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Suggested response (`202 Accepted`) shape:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "dependency",
    "title": "The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging...",
    "lineStart": 1508,
    "lineEnd": 1508,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The JSON shapes above are the RECOMMENDED baseline for interoperability and debugging ergonomics.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
    "type": "dependency",
    "title": "Implementations MAY add fields, but SHOULD avoid breaking existing fields within a ve...",
    "lineStart": 1509,
    "lineEnd": 1509,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY add fields, but SHOULD avoid breaking existing fields within a version.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
    "type": "dependency",
    "title": "Endpoints SHOULD be read-only except for operational triggers like /refresh.",
    "lineStart": 1510,
    "lineEnd": 1510,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Endpoints SHOULD be read-only except for operational triggers like `/refresh`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
    "type": "dependency",
    "title": "Unsupported methods on defined routes SHOULD return 405 Method Not Allowed.",
    "lineStart": 1511,
    "lineEnd": 1511,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unsupported methods on defined routes SHOULD return `405 Method Not Allowed`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
    "type": "dependency",
    "title": "API errors SHOULD use a JSON envelope such as {\"error\":{\"code\":\"...\",\"message\":\"...\"}}.",
    "lineStart": 1512,
    "lineEnd": 1512,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "API errors SHOULD use a JSON envelope such as `{\"error\":{\"code\":\"...\",\"message\":\"...\"}}`.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup",
    "type": "dependency",
    "title": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplica...",
    "lineStart": 1513,
    "lineEnd": 1513,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the dashboard is a client-side app, it SHOULD consume this API rather than duplicating state logic.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-missing-workflow-md",
    "type": "risk",
    "title": "Missing WORKFLOW.md",
    "lineStart": 1521,
    "lineEnd": 1521,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Missing `WORKFLOW.md`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-invalid-yaml-front-matter",
    "type": "risk",
    "title": "Invalid YAML front matter",
    "lineStart": 1522,
    "lineEnd": 1522,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid YAML front matter",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-unsupported-tracker-kind-or-missing-tracker-credentials-project-slug",
    "type": "risk",
    "title": "Unsupported tracker kind or missing tracker credentials/project slug",
    "lineStart": 1523,
    "lineEnd": 1523,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unsupported tracker kind or missing tracker credentials/project slug",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-missing-coding-agent-executable",
    "type": "risk",
    "title": "Missing coding-agent executable",
    "lineStart": 1524,
    "lineEnd": 1524,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Missing coding-agent executable",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-workspace-directory-creation-failure",
    "type": "risk",
    "title": "Workspace directory creation failure",
    "lineStart": 1527,
    "lineEnd": 1527,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace directory creation failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
    "type": "risk",
    "title": "Workspace population/synchronization failure (implementation-defined; can come from h...",
    "lineStart": 1528,
    "lineEnd": 1528,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace population/synchronization failure (implementation-defined; can come from hooks)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-invalid-workspace-path-configuration",
    "type": "risk",
    "title": "Invalid workspace path configuration",
    "lineStart": 1529,
    "lineEnd": 1529,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid workspace path configuration",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-hook-timeout-failure",
    "type": "risk",
    "title": "Hook timeout/failure",
    "lineStart": 1530,
    "lineEnd": 1530,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hook timeout/failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-startup-handshake-failure",
    "type": "risk",
    "title": "Startup handshake failure",
    "lineStart": 1533,
    "lineEnd": 1533,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Startup handshake failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-turn-failed-cancelled",
    "type": "risk",
    "title": "Turn failed/cancelled",
    "lineStart": 1534,
    "lineEnd": 1534,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Turn failed/cancelled",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-turn-timeout",
    "type": "risk",
    "title": "Turn timeout",
    "lineStart": 1535,
    "lineEnd": 1535,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Turn timeout",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p",
    "type": "risk",
    "title": "User input requested and handled as failure by the implementation's documented policy",
    "lineStart": 1536,
    "lineEnd": 1536,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "User input requested and handled as failure by the implementation's documented policy",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-subprocess-exit",
    "type": "risk",
    "title": "Subprocess exit",
    "lineStart": 1537,
    "lineEnd": 1537,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Subprocess exit",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-stalled-session-no-activity",
    "type": "risk",
    "title": "Stalled session (no activity)",
    "lineStart": 1538,
    "lineEnd": 1538,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Stalled session (no activity)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-api-transport-errors",
    "type": "risk",
    "title": "API transport errors",
    "lineStart": 1541,
    "lineEnd": 1541,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "API transport errors",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-non-200-status",
    "type": "risk",
    "title": "Non-200 status",
    "lineStart": 1542,
    "lineEnd": 1542,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Non-200 status",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-graphql-errors",
    "type": "risk",
    "title": "GraphQL errors",
    "lineStart": 1543,
    "lineEnd": 1543,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "GraphQL errors",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-malformed-payloads",
    "type": "risk",
    "title": "malformed payloads",
    "lineStart": 1544,
    "lineEnd": 1544,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "malformed payloads",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-snapshot-timeout",
    "type": "risk",
    "title": "Snapshot timeout",
    "lineStart": 1547,
    "lineEnd": 1547,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Snapshot timeout",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-dashboard-render-errors",
    "type": "risk",
    "title": "Dashboard render errors",
    "lineStart": 1548,
    "lineEnd": 1548,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dashboard render errors",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-1-failure-classes-log-sink-configuration-failure",
    "type": "risk",
    "title": "Log sink configuration failure",
    "lineStart": 1549,
    "lineEnd": 1549,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Log sink configuration failure",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-dispatch-validation-failures",
    "type": "risk",
    "title": "Dispatch validation failures:",
    "lineStart": 1553,
    "lineEnd": 1553,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dispatch validation failures:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-skip-new-dispatches",
    "type": "risk",
    "title": "Skip new dispatches.",
    "lineStart": 1554,
    "lineEnd": 1554,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Skip new dispatches.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-keep-service-alive",
    "type": "risk",
    "title": "Keep service alive.",
    "lineStart": 1555,
    "lineEnd": 1555,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Keep service alive.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-continue-reconciliation-where-possible",
    "type": "risk",
    "title": "Continue reconciliation where possible.",
    "lineStart": 1556,
    "lineEnd": 1556,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Continue reconciliation where possible.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-worker-failures",
    "type": "risk",
    "title": "Worker failures:",
    "lineStart": 1558,
    "lineEnd": 1558,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Worker failures:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-convert-to-retries-with-exponential-backoff",
    "type": "risk",
    "title": "Convert to retries with exponential backoff.",
    "lineStart": 1559,
    "lineEnd": 1559,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Convert to retries with exponential backoff.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-tracker-candidate-fetch-failures",
    "type": "risk",
    "title": "Tracker candidate-fetch failures:",
    "lineStart": 1561,
    "lineEnd": 1561,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Tracker candidate-fetch failures:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-skip-this-tick",
    "type": "risk",
    "title": "Skip this tick.",
    "lineStart": 1562,
    "lineEnd": 1562,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Skip this tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-try-again-on-next-tick",
    "type": "risk",
    "title": "Try again on next tick.",
    "lineStart": 1563,
    "lineEnd": 1563,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Try again on next tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-reconciliation-state-refresh-failures",
    "type": "risk",
    "title": "Reconciliation state-refresh failures:",
    "lineStart": 1565,
    "lineEnd": 1565,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reconciliation state-refresh failures:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-keep-current-workers",
    "type": "risk",
    "title": "Keep current workers.",
    "lineStart": 1566,
    "lineEnd": 1566,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Keep current workers.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-retry-on-next-tick",
    "type": "risk",
    "title": "Retry on next tick.",
    "lineStart": 1567,
    "lineEnd": 1567,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Retry on next tick.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-dashboard-log-failures",
    "type": "risk",
    "title": "Dashboard/log failures:",
    "lineStart": 1569,
    "lineEnd": 1569,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dashboard/log failures:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-2-recovery-behavior-do-not-crash-the-orchestrator",
    "type": "risk",
    "title": "Do not crash the orchestrator.",
    "lineStart": 1570,
    "lineEnd": 1570,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Do not crash the orchestrator.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-no-retry-timers-are-restored-from-prior-process-memory",
    "type": "risk",
    "title": "No retry timers are restored from prior process memory.",
    "lineStart": 1581,
    "lineEnd": 1581,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "No retry timers are restored from prior process memory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-no-running-sessions-are-assumed-recoverable",
    "type": "risk",
    "title": "No running sessions are assumed recoverable.",
    "lineStart": 1582,
    "lineEnd": 1582,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "No running sessions are assumed recoverable.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-service-recovers-by",
    "type": "risk",
    "title": "Service recovers by:",
    "lineStart": 1583,
    "lineEnd": 1583,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Service recovers by:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-startup-terminal-workspace-cleanup",
    "type": "risk",
    "title": "startup terminal workspace cleanup",
    "lineStart": 1584,
    "lineEnd": 1584,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "startup terminal workspace cleanup",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-fresh-polling-of-active-issues",
    "type": "risk",
    "title": "fresh polling of active issues",
    "lineStart": 1585,
    "lineEnd": 1585,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "fresh polling of active issues",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-14-3-partial-state-recovery-restart-re-dispatching-eligible-work",
    "type": "risk",
    "title": "re-dispatching eligible work",
    "lineStart": 1586,
    "lineEnd": 1586,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "re-dispatching eligible work",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-editing-workflow-md-prompt-and-most-runtime-settings",
    "type": "claim",
    "title": "Editing WORKFLOW.md (prompt and most runtime settings).",
    "lineStart": 1592,
    "lineEnd": 1592,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Editing `WORKFLOW.md` (prompt and most runtime settings).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-workflow-md-changes-are-detected-and-re-applied-automatically-without-restart-ac",
    "type": "claim",
    "title": "WORKFLOW.md changes are detected and re-applied automatically without restart accordi...",
    "lineStart": 1593,
    "lineEnd": 1593,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`WORKFLOW.md` changes are detected and re-applied automatically without restart according to Section 6.2.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-changing-issue-states-in-the-tracker",
    "type": "claim",
    "title": "Changing issue states in the tracker:",
    "lineStart": 1595,
    "lineEnd": 1595,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Changing issue states in the tracker:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-terminal-state-running-session-is-stopped-and-workspace-cleaned-when-reconciled",
    "type": "claim",
    "title": "terminal state -> running session is stopped and workspace cleaned when reconciled",
    "lineStart": 1596,
    "lineEnd": 1596,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "terminal state -> running session is stopped and workspace cleaned when reconciled",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-non-active-state-running-session-is-stopped-without-cleanup",
    "type": "claim",
    "title": "non-active state -> running session is stopped without cleanup",
    "lineStart": 1597,
    "lineEnd": 1597,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "non-active state -> running session is stopped without cleanup",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-14-4-operator-intervention-points-restarting-the-service-for-process-recovery-or-deployment-not-as-the-normal-path",
    "type": "claim",
    "title": "Restarting the service for process recovery or deployment (not as the normal path for...",
    "lineStart": 1598,
    "lineEnd": 1598,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Restarting the service for process recovery or deployment (not as the normal path for applying workflow config changes).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir",
    "type": "risk",
    "title": "Implementations SHOULD state clearly whether they are intended for trusted environmen...",
    "lineStart": 1609,
    "lineEnd": 1609,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD state clearly whether they are intended for trusted environments, more restrictive environments, or both.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-rely-on-auto-approved-actions-",
    "type": "risk",
    "title": "Implementations SHOULD state clearly whether they rely on auto-approved actions, oper...",
    "lineStart": 1611,
    "lineEnd": 1611,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD state clearly whether they rely on auto-approved actions, operator approvals, stricter sandboxing, or some combination of those controls.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-1-trust-boundary-assumption-workspace-isolation-and-path-validation-are-important-baseline-controls-but-they",
    "type": "risk",
    "title": "Workspace isolation and path validation are important baseline controls, but they are...",
    "lineStart": 1613,
    "lineEnd": 1613,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace isolation and path validation are important baseline controls, but they are not a substitute for whatever approval and sandbox policy an implementation chooses.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-workspace-path-must-remain-under-configured-workspace-root",
    "type": "risk",
    "title": "Workspace path MUST remain under configured workspace root.",
    "lineStart": 1620,
    "lineEnd": 1620,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace path MUST remain under configured workspace root.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-coding-agent-cwd-must-be-the-per-issue-workspace-path-for-the-current-run",
    "type": "risk",
    "title": "Coding-agent cwd MUST be the per-issue workspace path for the current run.",
    "lineStart": 1621,
    "lineEnd": 1621,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Coding-agent cwd MUST be the per-issue workspace path for the current run.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-workspace-directory-names-must-use-sanitized-identifiers",
    "type": "risk",
    "title": "Workspace directory names MUST use sanitized identifiers.",
    "lineStart": 1622,
    "lineEnd": 1622,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace directory names MUST use sanitized identifiers.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-recommended-additional-hardening-for-ports",
    "type": "risk",
    "title": "RECOMMENDED additional hardening for ports:",
    "lineStart": 1624,
    "lineEnd": 1624,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "RECOMMENDED additional hardening for ports:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-run-under-a-dedicated-os-user",
    "type": "risk",
    "title": "Run under a dedicated OS user.",
    "lineStart": 1626,
    "lineEnd": 1626,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Run under a dedicated OS user.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-restrict-workspace-root-permissions",
    "type": "risk",
    "title": "Restrict workspace root permissions.",
    "lineStart": 1627,
    "lineEnd": 1627,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Restrict workspace root permissions.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-mount-workspace-root-on-a-dedicated-volume-if-possible",
    "type": "risk",
    "title": "Mount workspace root on a dedicated volume if possible.",
    "lineStart": 1628,
    "lineEnd": 1628,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Mount workspace root on a dedicated volume if possible.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-15-3-secret-handling-support-var-indirection-in-workflow-config",
    "type": "claim",
    "title": "Support $VAR indirection in workflow config.",
    "lineStart": 1632,
    "lineEnd": 1632,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Support `$VAR` indirection in workflow config.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
    "type": "dependency",
    "title": "Do not log API tokens or secret env values.",
    "lineStart": 1633,
    "lineEnd": 1633,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Do not log API tokens or secret env values.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them",
    "type": "test",
    "title": "Validate presence of secrets without printing them.",
    "lineStart": 1634,
    "lineEnd": 1634,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Validate presence of secrets without printing them.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-4-hook-script-safety-hooks-are-fully-trusted-configuration",
    "type": "risk",
    "title": "Hooks are fully trusted configuration.",
    "lineStart": 1642,
    "lineEnd": 1642,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hooks are fully trusted configuration.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-4-hook-script-safety-hooks-run-inside-the-workspace-directory",
    "type": "risk",
    "title": "Hooks run inside the workspace directory.",
    "lineStart": 1643,
    "lineEnd": 1643,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hooks run inside the workspace directory.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-4-hook-script-safety-hook-output-should-be-truncated-in-logs",
    "type": "risk",
    "title": "Hook output SHOULD be truncated in logs.",
    "lineStart": 1644,
    "lineEnd": 1644,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hook output SHOULD be truncated in logs.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-4-hook-script-safety-hook-timeouts-are-required-to-avoid-hanging-the-orchestrator",
    "type": "risk",
    "title": "Hook timeouts are REQUIRED to avoid hanging the orchestrator.",
    "lineStart": 1645,
    "lineEnd": 1645,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hook timeouts are REQUIRED to avoid hanging the orchestrator.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the",
    "type": "risk",
    "title": "Implementations SHOULD explicitly evaluate their own risk profile and harden the exec...",
    "lineStart": 1654,
    "lineEnd": 1654,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD explicitly evaluate their own risk profile and harden the execution harness",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-implementations-should-not-assume-that-tracker-data-repository-contents-prompt-i",
    "type": "risk",
    "title": "implementations SHOULD NOT assume that tracker data, repository contents, prompt inpu...",
    "lineStart": 1656,
    "lineEnd": 1656,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "implementations SHOULD NOT assume that tracker data, repository contents, prompt inputs, or tool",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-tightening-codex-approval-and-sandbox-settings-described-elsewhere-in-this-speci",
    "type": "risk",
    "title": "Tightening Codex approval and sandbox settings described elsewhere in this specificat...",
    "lineStart": 1661,
    "lineEnd": 1661,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Tightening Codex approval and sandbox settings described elsewhere in this specification instead of running with a maximally permissive configuration.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
    "type": "risk",
    "title": "Adding external isolation layers such as OS/container/VM sandboxing, network restrict...",
    "lineStart": 1663,
    "lineEnd": 1663,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Adding external isolation layers such as OS/container/VM sandboxing, network restrictions, or separate credentials beyond the built-in Codex policy controls.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-filtering-which-linear-issues-projects-teams-labels-or-other-tracker-sources-are",
    "type": "risk",
    "title": "Filtering which Linear issues, projects, teams, labels, or other tracker sources are...",
    "lineStart": 1665,
    "lineEnd": 1665,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Filtering which Linear issues, projects, teams, labels, or other tracker sources are eligible for dispatch so untrusted or out-of-scope tasks do not automatically reach the agent.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-narrowing-the-lineargraphql-tool-so-it-can-only-read-or-mutate-data-inside-the-i",
    "type": "risk",
    "title": "Narrowing the lineargraphql tool so it can only read or mutate data inside the intend...",
    "lineStart": 1667,
    "lineEnd": 1667,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Narrowing the `linear_graphql` tool so it can only read or mutate data inside the intended project scope, rather than exposing general workspace-wide tracker access.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d",
    "type": "risk",
    "title": "Reducing the set of client-side tools, credentials, filesystem paths, and network des...",
    "lineStart": 1669,
    "lineEnd": 1669,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reducing the set of client-side tools, credentials, filesystem paths, and network destinations available to the agent to the minimum needed for the workflow.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-the-correct-controls-are-deployment-specific-but-implementations-should-document",
    "type": "risk",
    "title": "The correct controls are deployment-specific, but implementations SHOULD document the...",
    "lineStart": 1672,
    "lineEnd": 1672,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The correct controls are deployment-specific, but implementations SHOULD document them clearly and",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-17-test-and-validation-matrix-a-conforming-implementation-should-include-tests-that-cover-the-behaviors-define",
    "type": "test",
    "title": "A conforming implementation SHOULD include tests that cover the behaviors defined in...",
    "lineStart": 1916,
    "lineEnd": 1916,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A conforming implementation SHOULD include tests that cover the behaviors defined in this",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "type": "test",
    "title": "Core Conformance: deterministic tests REQUIRED for all conforming implementations.",
    "lineStart": 1921,
    "lineEnd": 1921,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Core Conformance`: deterministic tests REQUIRED for all conforming implementations.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-17-test-and-validation-matrix-extension-conformance-required-only-for-optional-features-that-an-implementation",
    "type": "test",
    "title": "Extension Conformance: REQUIRED only for OPTIONAL features that an implementation cho...",
    "lineStart": 1922,
    "lineEnd": 1922,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Extension Conformance`: REQUIRED only for OPTIONAL features that an implementation chooses to ship.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-17-test-and-validation-matrix-real-integration-profile-environment-dependent-smoke-integration-checks-recommen",
    "type": "test",
    "title": "Real Integration Profile: environment-dependent smoke/integration checks RECOMMENDED...",
    "lineStart": 1924,
    "lineEnd": 1924,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Real Integration Profile`: environment-dependent smoke/integration checks RECOMMENDED before production use.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-workflow-file-path-precedence",
    "type": "claim",
    "title": "Workflow file path precedence:",
    "lineStart": 1932,
    "lineEnd": 1932,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow file path precedence:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-explicit-runtime-path-is-used-when-provided",
    "type": "claim",
    "title": "explicit runtime path is used when provided",
    "lineStart": 1933,
    "lineEnd": 1933,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "explicit runtime path is used when provided",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-cwd-default-is-workflow-md-when-no-explicit-runtime-path-is-provided",
    "type": "claim",
    "title": "cwd default is WORKFLOW.md when no explicit runtime path is provided",
    "lineStart": 1934,
    "lineEnd": 1934,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "cwd default is `WORKFLOW.md` when no explicit runtime path is provided",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-workflow-file-changes-are-detected-and-trigger-re-read-re-apply-without-restart",
    "type": "claim",
    "title": "Workflow file changes are detected and trigger re-read/re-apply without restart",
    "lineStart": 1935,
    "lineEnd": 1935,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow file changes are detected and trigger re-read/re-apply without restart",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-invalid-workflow-reload-keeps-last-known-good-effective-configuration-and-emits-",
    "type": "claim",
    "title": "Invalid workflow reload keeps last known good effective configuration and emits an op...",
    "lineStart": 1936,
    "lineEnd": 1936,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid workflow reload keeps last known good effective configuration and emits an operator-visible error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-missing-workflow-md-returns-typed-error",
    "type": "claim",
    "title": "Missing WORKFLOW.md returns typed error",
    "lineStart": 1938,
    "lineEnd": 1938,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Missing `WORKFLOW.md` returns typed error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-invalid-yaml-front-matter-returns-typed-error",
    "type": "claim",
    "title": "Invalid YAML front matter returns typed error",
    "lineStart": 1939,
    "lineEnd": 1939,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Invalid YAML front matter returns typed error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-front-matter-non-map-returns-typed-error",
    "type": "claim",
    "title": "Front matter non-map returns typed error",
    "lineStart": 1940,
    "lineEnd": 1940,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Front matter non-map returns typed error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing",
    "type": "requirement",
    "title": "Config defaults apply when OPTIONAL values are missing",
    "lineStart": 1941,
    "lineEnd": 1941,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Config defaults apply when OPTIONAL values are missing",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear",
    "type": "claim",
    "title": "tracker.kind validation enforces currently supported kind (linear)",
    "lineStart": 1942,
    "lineEnd": 1942,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.kind` validation enforces currently supported kind (`linear`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection",
    "type": "claim",
    "title": "tracker.apikey works (including $VAR indirection)",
    "lineStart": 1943,
    "lineEnd": 1943,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`tracker.api_key` works (including `$VAR` indirection)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values",
    "type": "dependency",
    "title": "$VAR resolution works for tracker API key and path values",
    "lineStart": 1944,
    "lineEnd": 1944,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`$VAR` resolution works for tracker API key and path values",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-path-expansion-works",
    "type": "claim",
    "title": "~ path expansion works",
    "lineStart": 1945,
    "lineEnd": 1945,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`~` path expansion works",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-codex-command-is-preserved-as-a-shell-command-string",
    "type": "claim",
    "title": "codex.command is preserved as a shell command string",
    "lineStart": 1946,
    "lineEnd": 1946,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`codex.command` is preserved as a shell command string",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-per-state-concurrency-override-map-normalizes-state-names-and-ignores-invalid-va",
    "type": "claim",
    "title": "Per-state concurrency override map normalizes state names and ignores invalid values",
    "lineStart": 1947,
    "lineEnd": 1947,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Per-state concurrency override map normalizes state names and ignores invalid values",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-prompt-template-renders-issue-and-attempt",
    "type": "claim",
    "title": "Prompt template renders issue and attempt",
    "lineStart": 1948,
    "lineEnd": 1948,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Prompt template renders `issue` and `attempt`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-1-workflow-and-config-parsing-prompt-rendering-fails-on-unknown-variables-strict-mode",
    "type": "claim",
    "title": "Prompt rendering fails on unknown variables (strict mode)",
    "lineStart": 1949,
    "lineEnd": 1949,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Prompt rendering fails on unknown variables (strict mode)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-deterministic-workspace-path-per-issue-identifier",
    "type": "risk",
    "title": "Deterministic workspace path per issue identifier",
    "lineStart": 1953,
    "lineEnd": 1953,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Deterministic workspace path per issue identifier",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-missing-workspace-directory-is-created",
    "type": "risk",
    "title": "Missing workspace directory is created",
    "lineStart": 1954,
    "lineEnd": 1954,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Missing workspace directory is created",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-existing-workspace-directory-is-reused",
    "type": "risk",
    "title": "Existing workspace directory is reused",
    "lineStart": 1955,
    "lineEnd": 1955,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Existing workspace directory is reused",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-existing-non-directory-path-at-workspace-location-is-handled-safely-replace-or-f",
    "type": "risk",
    "title": "Existing non-directory path at workspace location is handled safely (replace or fail...",
    "lineStart": 1956,
    "lineEnd": 1956,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Existing non-directory path at workspace location is handled safely (replace or fail per implementation policy)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-optional-workspace-population-synchronization-errors-are-surfaced",
    "type": "risk",
    "title": "OPTIONAL workspace population/synchronization errors are surfaced",
    "lineStart": 1958,
    "lineEnd": 1958,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "OPTIONAL workspace population/synchronization errors are surfaced",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-aftercreate-hook-runs-only-on-new-workspace-creation",
    "type": "risk",
    "title": "aftercreate hook runs only on new workspace creation",
    "lineStart": 1959,
    "lineEnd": 1959,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_create` hook runs only on new workspace creation",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-beforerun-hook-runs-before-each-attempt-and-failure-timeouts-abort-the-current-a",
    "type": "risk",
    "title": "beforerun hook runs before each attempt and failure/timeouts abort the current attempt",
    "lineStart": 1960,
    "lineEnd": 1960,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_run` hook runs before each attempt and failure/timeouts abort the current attempt",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-afterrun-hook-runs-after-each-attempt-and-failure-timeouts-are-logged-and-ignore",
    "type": "risk",
    "title": "afterrun hook runs after each attempt and failure/timeouts are logged and ignored",
    "lineStart": 1961,
    "lineEnd": 1961,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`after_run` hook runs after each attempt and failure/timeouts are logged and ignored",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-beforeremove-hook-runs-on-cleanup-and-failures-timeouts-are-ignored",
    "type": "risk",
    "title": "beforeremove hook runs on cleanup and failures/timeouts are ignored",
    "lineStart": 1962,
    "lineEnd": 1962,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`before_remove` hook runs on cleanup and failures/timeouts are ignored",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-workspace-path-sanitization-and-root-containment-invariants-are-enforced-before-",
    "type": "risk",
    "title": "Workspace path sanitization and root containment invariants are enforced before agent...",
    "lineStart": 1963,
    "lineEnd": 1963,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace path sanitization and root containment invariants are enforced before agent launch",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-agent-launch-uses-the-per-issue-workspace-path-as-cwd-and-rejects-out-of-root-pa",
    "type": "risk",
    "title": "Agent launch uses the per-issue workspace path as cwd and rejects out-of-root paths",
    "lineStart": 1964,
    "lineEnd": 1964,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Agent launch uses the per-issue workspace path as cwd and rejects out-of-root paths",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-candidate-issue-fetch-uses-active-states-and-project-slug",
    "type": "dependency",
    "title": "Candidate issue fetch uses active states and project slug",
    "lineStart": 1968,
    "lineEnd": 1968,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Candidate issue fetch uses active states and project slug",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-linear-query-uses-the-specified-project-filter-field-slugid",
    "type": "dependency",
    "title": "Linear query uses the specified project filter field (slugId)",
    "lineStart": 1969,
    "lineEnd": 1969,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Linear query uses the specified project filter field (`slugId`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-empty-fetchissuesbystates-returns-empty-without-api-call",
    "type": "dependency",
    "title": "Empty fetchissuesbystates([]) returns empty without API call",
    "lineStart": 1970,
    "lineEnd": 1970,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Empty `fetch_issues_by_states([])` returns empty without API call",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-pagination-preserves-order-across-multiple-pages",
    "type": "dependency",
    "title": "Pagination preserves order across multiple pages",
    "lineStart": 1971,
    "lineEnd": 1971,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Pagination preserves order across multiple pages",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-blockers-are-normalized-from-inverse-relations-of-type-blocks",
    "type": "dependency",
    "title": "Blockers are normalized from inverse relations of type blocks",
    "lineStart": 1972,
    "lineEnd": 1972,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Blockers are normalized from inverse relations of type `blocks`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-labels-are-normalized-to-lowercase",
    "type": "dependency",
    "title": "Labels are normalized to lowercase",
    "lineStart": 1973,
    "lineEnd": 1973,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Labels are normalized to lowercase",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-issue-state-refresh-by-id-returns-minimal-normalized-issues",
    "type": "dependency",
    "title": "Issue state refresh by ID returns minimal normalized issues",
    "lineStart": 1974,
    "lineEnd": 1974,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue state refresh by ID returns minimal normalized issues",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-issue-state-refresh-query-uses-graphql-id-typing-id-as-specified-in-section-11-2",
    "type": "dependency",
    "title": "Issue state refresh query uses GraphQL ID typing ([ID!]) as specified in Section 11.2",
    "lineStart": 1975,
    "lineEnd": 1975,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue state refresh query uses GraphQL ID typing (`[ID!]`) as specified in Section 11.2",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-3-issue-tracker-client-error-mapping-for-request-errors-non-200-graphql-errors-malformed-payloads",
    "type": "dependency",
    "title": "Error mapping for request errors, non-200, GraphQL errors, malformed payloads",
    "lineStart": 1976,
    "lineEnd": 1976,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Error mapping for request errors, non-200, GraphQL errors, malformed payloads",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-dispatch-sort-order-is-priority-then-oldest-creation-time",
    "type": "claim",
    "title": "Dispatch sort order is priority then oldest creation time",
    "lineStart": 1980,
    "lineEnd": 1980,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dispatch sort order is priority then oldest creation time",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-non-terminal-blockers-is-not-eligible",
    "type": "claim",
    "title": "Todo issue with non-terminal blockers is not eligible",
    "lineStart": 1981,
    "lineEnd": 1981,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Todo` issue with non-terminal blockers is not eligible",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-terminal-blockers-is-eligible",
    "type": "claim",
    "title": "Todo issue with terminal blockers is eligible",
    "lineStart": 1982,
    "lineEnd": 1982,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`Todo` issue with terminal blockers is eligible",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-active-state-issue-refresh-updates-running-entry-state",
    "type": "claim",
    "title": "Active-state issue refresh updates running entry state",
    "lineStart": 1983,
    "lineEnd": 1983,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Active-state issue refresh updates running entry state",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-non-active-state-stops-running-agent-without-workspace-cleanup",
    "type": "claim",
    "title": "Non-active state stops running agent without workspace cleanup",
    "lineStart": 1984,
    "lineEnd": 1984,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Non-active state stops running agent without workspace cleanup",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-terminal-state-stops-running-agent-and-cleans-workspace",
    "type": "claim",
    "title": "Terminal state stops running agent and cleans workspace",
    "lineStart": 1985,
    "lineEnd": 1985,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Terminal state stops running agent and cleans workspace",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-reconciliation-with-no-running-issues-is-a-no-op",
    "type": "claim",
    "title": "Reconciliation with no running issues is a no-op",
    "lineStart": 1986,
    "lineEnd": 1986,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reconciliation with no running issues is a no-op",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-normal-worker-exit-schedules-a-short-continuation-retry-attempt-1",
    "type": "claim",
    "title": "Normal worker exit schedules a short continuation retry (attempt 1)",
    "lineStart": 1987,
    "lineEnd": 1987,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Normal worker exit schedules a short continuation retry (attempt 1)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-abnormal-worker-exit-increments-retries-with-10s-based-exponential-backoff",
    "type": "claim",
    "title": "Abnormal worker exit increments retries with 10s-based exponential backoff",
    "lineStart": 1988,
    "lineEnd": 1988,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Abnormal worker exit increments retries with 10s-based exponential backoff",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-backoff-cap-uses-configured-agent-maxretrybackoffms",
    "type": "claim",
    "title": "Retry backoff cap uses configured agent.maxretrybackoffms",
    "lineStart": 1989,
    "lineEnd": 1989,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Retry backoff cap uses configured `agent.max_retry_backoff_ms`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-queue-entries-include-attempt-due-time-identifier-and-error",
    "type": "claim",
    "title": "Retry queue entries include attempt, due time, identifier, and error",
    "lineStart": 1990,
    "lineEnd": 1990,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Retry queue entries include attempt, due time, identifier, and error",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-stall-detection-kills-stalled-sessions-and-schedules-retry",
    "type": "claim",
    "title": "Stall detection kills stalled sessions and schedules retry",
    "lineStart": 1991,
    "lineEnd": 1991,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Stall detection kills stalled sessions and schedules retry",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-slot-exhaustion-requeues-retries-with-explicit-error-reason",
    "type": "claim",
    "title": "Slot exhaustion requeues retries with explicit error reason",
    "lineStart": 1992,
    "lineEnd": 1992,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Slot exhaustion requeues retries with explicit error reason",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-it-returns-running-rows-retry-rows-token-totals",
    "type": "dependency",
    "title": "If a snapshot API is implemented, it returns running rows, retry rows, token totals,...",
    "lineStart": 1993,
    "lineEnd": 1993,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If a snapshot API is implemented, it returns running rows, retry rows, token totals, and rate limits",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-timeout-unavailable-cases-are-surfaced",
    "type": "dependency",
    "title": "If a snapshot API is implemented, timeout/unavailable cases are surfaced",
    "lineStart": 1995,
    "lineEnd": 1995,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If a snapshot API is implemented, timeout/unavailable cases are surfaced",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command",
    "type": "dependency",
    "title": "Launch command uses workspace cwd and invokes bash -lc <codex.command>",
    "lineStart": 1999,
    "lineEnd": 1999,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Launch command uses workspace cwd and invokes `bash -lc <codex.command>`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
    "type": "dependency",
    "title": "Session startup follows the targeted Codex app-server protocol.",
    "lineStart": 2000,
    "lineEnd": 2000,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Session startup follows the targeted Codex app-server protocol.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
    "type": "dependency",
    "title": "Client identity/capability payloads are valid when the targeted Codex app-server prot...",
    "lineStart": 2001,
    "lineEnd": 2001,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Client identity/capability payloads are valid when the targeted Codex app-server protocol requires them.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san",
    "type": "dependency",
    "title": "Policy-related startup payloads use the implementation's documented approval/sandbox...",
    "lineStart": 2003,
    "lineEnd": 2003,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Policy-related startup payloads use the implementation's documented approval/sandbox settings",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
    "type": "dependency",
    "title": "Thread and turn identities exposed by the targeted protocol are extracted and used to...",
    "lineStart": 2004,
    "lineEnd": 2004,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Thread and turn identities exposed by the targeted protocol are extracted and used to emit `session_started`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
    "type": "dependency",
    "title": "Request/response read timeout is enforced",
    "lineStart": 2006,
    "lineEnd": 2006,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Request/response read timeout is enforced",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
    "type": "dependency",
    "title": "Turn timeout is enforced",
    "lineStart": 2007,
    "lineEnd": 2007,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Turn timeout is enforced",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
    "type": "dependency",
    "title": "Transport framing required by the targeted protocol is handled correctly",
    "lineStart": 2008,
    "lineEnd": 2008,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Transport framing required by the targeted protocol is handled correctly",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
    "type": "dependency",
    "title": "For stdio-based transports, diagnostic stderr handling is kept separate from the prot...",
    "lineStart": 2009,
    "lineEnd": 2009,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "For stdio-based transports, diagnostic stderr handling is kept separate from the protocol stream",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu",
    "type": "dependency",
    "title": "Command/file-change approvals are handled according to the implementation's documente...",
    "lineStart": 2010,
    "lineEnd": 2010,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Command/file-change approvals are handled according to the implementation's documented policy",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session",
    "type": "dependency",
    "title": "Unsupported dynamic tool calls are rejected without stalling the session",
    "lineStart": 2011,
    "lineEnd": 2011,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Unsupported dynamic tool calls are rejected without stalling the session",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol",
    "type": "dependency",
    "title": "User input requests are handled according to the implementation's documented policy a...",
    "lineStart": 2012,
    "lineEnd": 2012,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "User input requests are handled according to the implementation's documented policy and do not stall indefinitely",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
    "type": "dependency",
    "title": "Usage and rate-limit telemetry exposed by the targeted protocol is extracted",
    "lineStart": 2014,
    "lineEnd": 2014,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Usage and rate-limit telemetry exposed by the targeted protocol is extracted",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
    "type": "dependency",
    "title": "Approval, user-input-required, usage, and rate-limit signals are interpreted accordin...",
    "lineStart": 2015,
    "lineEnd": 2015,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Approval, user-input-required, usage, and rate-limit signals are interpreted according to the targeted protocol",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
    "type": "dependency",
    "title": "If client-side tools are implemented, session startup advertises the supported tool s...",
    "lineStart": 2017,
    "lineEnd": 2017,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If client-side tools are implemented, session startup advertises the supported tool specs using the targeted app-server protocol",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
    "type": "dependency",
    "title": "If the lineargraphql client-side tool extension is implemented:",
    "lineStart": 2019,
    "lineEnd": 2019,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the `linear_graphql` client-side tool extension is implemented:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session",
    "type": "dependency",
    "title": "the tool is advertised to the session",
    "lineStart": 2020,
    "lineEnd": 2020,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "the tool is advertised to the session",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
    "type": "dependency",
    "title": "valid query / variables inputs execute against configured Linear auth",
    "lineStart": 2021,
    "lineEnd": 2021,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "valid `query` / `variables` inputs execute against configured Linear auth",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body",
    "type": "dependency",
    "title": "top-level GraphQL errors produce success=false while preserving the GraphQL body",
    "lineStart": 2022,
    "lineEnd": 2022,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "top-level GraphQL `errors` produce `success=false` while preserving the GraphQL body",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
    "type": "dependency",
    "title": "invalid arguments, missing auth, and transport failures return structured failure pay...",
    "lineStart": 2023,
    "lineEnd": 2023,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "invalid arguments, missing auth, and transport failures return structured failure payloads",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session",
    "type": "dependency",
    "title": "unsupported tool names still fail without stalling the session",
    "lineStart": 2024,
    "lineEnd": 2024,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "unsupported tool names still fail without stalling the session",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-validation-failures-are-operator-visible",
    "type": "claim",
    "title": "Validation failures are operator-visible",
    "lineStart": 2028,
    "lineEnd": 2028,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Validation failures are operator-visible",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-structured-logging-includes-issue-session-context-fields",
    "type": "claim",
    "title": "Structured logging includes issue/session context fields",
    "lineStart": 2029,
    "lineEnd": 2029,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Structured logging includes issue/session context fields",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-logging-sink-failures-do-not-crash-orchestration",
    "type": "claim",
    "title": "Logging sink failures do not crash orchestration",
    "lineStart": 2030,
    "lineEnd": 2030,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Logging sink failures do not crash orchestration",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-token-rate-limit-aggregation-remains-correct-across-repeated-agent-updates",
    "type": "claim",
    "title": "Token/rate-limit aggregation remains correct across repeated agent updates",
    "lineStart": 2031,
    "lineEnd": 2031,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Token/rate-limit aggregation remains correct across repeated agent updates",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-if-a-human-readable-status-surface-is-implemented-it-is-driven-from-orchestrator",
    "type": "claim",
    "title": "If a human-readable status surface is implemented, it is driven from orchestrator sta...",
    "lineStart": 2032,
    "lineEnd": 2032,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If a human-readable status surface is implemented, it is driven from orchestrator state and does not affect correctness",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-17-6-observability-if-humanized-event-summaries-are-implemented-they-cover-key-wrapper-agent-event-",
    "type": "claim",
    "title": "If humanized event summaries are implemented, they cover key wrapper/agent event clas...",
    "lineStart": 2034,
    "lineEnd": 2034,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If humanized event summaries are implemented, they cover key wrapper/agent event classes without changing orchestrator behavior",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-accepts-a-positional-workflow-path-argument-path-to-workflow-md",
    "type": "dependency",
    "title": "CLI accepts a positional workflow path argument (path-to-WORKFLOW.md)",
    "lineStart": 2039,
    "lineEnd": 2039,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI accepts a positional workflow path argument (`path-to-WORKFLOW.md`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-uses-workflow-md-when-no-workflow-path-argument-is-provided",
    "type": "dependency",
    "title": "CLI uses ./WORKFLOW.md when no workflow path argument is provided",
    "lineStart": 2040,
    "lineEnd": 2040,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI uses `./WORKFLOW.md` when no workflow path argument is provided",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md",
    "type": "dependency",
    "title": "CLI errors on nonexistent explicit workflow path or missing default ./WORKFLOW.md",
    "lineStart": 2041,
    "lineEnd": 2041,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI errors on nonexistent explicit workflow path or missing default `./WORKFLOW.md`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-surfaces-startup-failure-cleanly",
    "type": "dependency",
    "title": "CLI surfaces startup failure cleanly",
    "lineStart": 2042,
    "lineEnd": 2042,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI surfaces startup failure cleanly",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-exits-with-success-when-application-starts-and-shuts-down-normally",
    "type": "dependency",
    "title": "CLI exits with success when application starts and shuts down normally",
    "lineStart": 2043,
    "lineEnd": 2043,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI exits with success when application starts and shuts down normally",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally",
    "type": "dependency",
    "title": "CLI exits nonzero when startup fails or the host process exits abnormally",
    "lineStart": 2044,
    "lineEnd": 2044,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "CLI exits nonzero when startup fails or the host process exits abnormally",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-these-checks-are-recommended-for-production-readiness-and-may-be-skipped-in-ci-w",
    "type": "dependency",
    "title": "These checks are RECOMMENDED for production readiness and MAY be skipped in CI when c...",
    "lineStart": 2048,
    "lineEnd": 2048,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "These checks are RECOMMENDED for production readiness and MAY be skipped in CI when credentials,",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap",
    "type": "dependency",
    "title": "A real tracker smoke test can be run with valid credentials supplied by LINEARAPIKEY...",
    "lineStart": 2051,
    "lineEnd": 2051,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A real tracker smoke test can be run with valid credentials supplied by `LINEAR_API_KEY` or a documented local bootstrap mechanism (for example `~/.linear_api_key`).",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-real-integration-tests-should-use-isolated-test-identifiers-workspaces-and-clean",
    "type": "dependency",
    "title": "Real integration tests SHOULD use isolated test identifiers/workspaces and clean up t...",
    "lineStart": 2053,
    "lineEnd": 2053,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Real integration tests SHOULD use isolated test identifiers/workspaces and clean up tracker artifacts when practical.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-a-skipped-real-integration-test-should-be-reported-as-skipped-not-silently-treat",
    "type": "dependency",
    "title": "A skipped real-integration test SHOULD be reported as skipped, not silently treated a...",
    "lineStart": 2055,
    "lineEnd": 2055,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A skipped real-integration test SHOULD be reported as skipped, not silently treated as passed.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-17-8-real-integration-profile-recommended-if-a-real-integration-profile-is-explicitly-enabled-in-ci-or-release-validation-",
    "type": "dependency",
    "title": "If a real-integration profile is explicitly enabled in CI or release validation, fail...",
    "lineStart": 2056,
    "lineEnd": 2056,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If a real-integration profile is explicitly enabled in CI or release validation, failures SHOULD fail that job.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-implementation-checklist-definition-of-done-section-18-1-core-conformance",
    "type": "test",
    "title": "Section 18.1 = Core Conformance",
    "lineStart": 2063,
    "lineEnd": 2063,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Section 18.1 = `Core Conformance`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-implementation-checklist-definition-of-done-section-18-2-extension-conformance",
    "type": "test",
    "title": "Section 18.2 = Extension Conformance",
    "lineStart": 2064,
    "lineEnd": 2064,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Section 18.2 = `Extension Conformance`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-implementation-checklist-definition-of-done-section-18-3-real-integration-profile",
    "type": "test",
    "title": "Section 18.3 = Real Integration Profile",
    "lineStart": 2065,
    "lineEnd": 2065,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Section 18.3 = `Real Integration Profile`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-workflow-path-selection-supports-explicit-runtime-path-and-cwd-default",
    "type": "test",
    "title": "Workflow path selection supports explicit runtime path and cwd default",
    "lineStart": 2069,
    "lineEnd": 2069,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workflow path selection supports explicit runtime path and cwd default",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-workflow-md-loader-with-yaml-front-matter-prompt-body-split",
    "type": "test",
    "title": "WORKFLOW.md loader with YAML front matter + prompt body split",
    "lineStart": 2070,
    "lineEnd": 2070,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`WORKFLOW.md` loader with YAML front matter + prompt body split",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-typed-config-layer-with-defaults-and-resolution",
    "type": "test",
    "title": "Typed config layer with defaults and $ resolution",
    "lineStart": 2071,
    "lineEnd": 2071,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Typed config layer with defaults and `$` resolution",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-dynamic-workflow-md-watch-reload-re-apply-for-config-and-prompt",
    "type": "test",
    "title": "Dynamic WORKFLOW.md watch/reload/re-apply for config and prompt",
    "lineStart": 2072,
    "lineEnd": 2072,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Dynamic `WORKFLOW.md` watch/reload/re-apply for config and prompt",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-polling-orchestrator-with-single-authority-mutable-state",
    "type": "test",
    "title": "Polling orchestrator with single-authority mutable state",
    "lineStart": 2073,
    "lineEnd": 2073,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Polling orchestrator with single-authority mutable state",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-issue-tracker-client-with-candidate-fetch-state-refresh-terminal-fetch",
    "type": "test",
    "title": "Issue tracker client with candidate fetch + state refresh + terminal fetch",
    "lineStart": 2074,
    "lineEnd": 2074,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Issue tracker client with candidate fetch + state refresh + terminal fetch",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-workspace-manager-with-sanitized-per-issue-workspaces",
    "type": "test",
    "title": "Workspace manager with sanitized per-issue workspaces",
    "lineStart": 2075,
    "lineEnd": 2075,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace manager with sanitized per-issue workspaces",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-workspace-lifecycle-hooks-aftercreate-beforerun-afterrun-beforeremove",
    "type": "test",
    "title": "Workspace lifecycle hooks (aftercreate, beforerun, afterrun, beforeremove)",
    "lineStart": 2076,
    "lineEnd": 2076,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace lifecycle hooks (`after_create`, `before_run`, `after_run`, `before_remove`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-hook-timeout-config-hooks-timeoutms-default-60000",
    "type": "test",
    "title": "Hook timeout config (hooks.timeoutms, default 60000)",
    "lineStart": 2077,
    "lineEnd": 2077,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Hook timeout config (`hooks.timeout_ms`, default `60000`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-coding-agent-app-server-subprocess-client-with-json-line-protocol",
    "type": "test",
    "title": "Coding-agent app-server subprocess client with JSON line protocol",
    "lineStart": 2078,
    "lineEnd": 2078,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Coding-agent app-server subprocess client with JSON line protocol",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-codex-launch-command-config-codex-command-default-codex-app-server",
    "type": "test",
    "title": "Codex launch command config (codex.command, default codex app-server)",
    "lineStart": 2079,
    "lineEnd": 2079,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Codex launch command config (`codex.command`, default `codex app-server`)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-strict-prompt-rendering-with-issue-and-attempt-variables",
    "type": "test",
    "title": "Strict prompt rendering with issue and attempt variables",
    "lineStart": 2080,
    "lineEnd": 2080,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Strict prompt rendering with `issue` and `attempt` variables",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-exponential-retry-queue-with-continuation-retries-after-normal-exit",
    "type": "test",
    "title": "Exponential retry queue with continuation retries after normal exit",
    "lineStart": 2081,
    "lineEnd": 2081,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Exponential retry queue with continuation retries after normal exit",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-configurable-retry-backoff-cap-agent-maxretrybackoffms-default-5m",
    "type": "test",
    "title": "Configurable retry backoff cap (agent.maxretrybackoffms, default 5m)",
    "lineStart": 2082,
    "lineEnd": 2082,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Configurable retry backoff cap (`agent.max_retry_backoff_ms`, default 5m)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-reconciliation-that-stops-runs-on-terminal-non-active-tracker-states",
    "type": "test",
    "title": "Reconciliation that stops runs on terminal/non-active tracker states",
    "lineStart": 2083,
    "lineEnd": 2083,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Reconciliation that stops runs on terminal/non-active tracker states",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-workspace-cleanup-for-terminal-issues-startup-sweep-active-transition",
    "type": "test",
    "title": "Workspace cleanup for terminal issues (startup sweep + active transition)",
    "lineStart": 2084,
    "lineEnd": 2084,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace cleanup for terminal issues (startup sweep + active transition)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-structured-logs-with-issueid-issueidentifier-and-sessionid",
    "type": "test",
    "title": "Structured logs with issueid, issueidentifier, and sessionid",
    "lineStart": 2085,
    "lineEnd": 2085,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Structured logs with `issue_id`, `issue_identifier`, and `session_id`",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-1-required-for-conformance-operator-visible-observability-structured-logs-optional-snapshot-status-surface",
    "type": "test",
    "title": "Operator-visible observability (structured logs; OPTIONAL snapshot/status surface)",
    "lineStart": 2086,
    "lineEnd": 2086,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Operator-visible observability (structured logs; OPTIONAL snapshot/status surface)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind-",
    "type": "test",
    "title": "HTTP server extension honors CLI --port over server.port, uses a safe default bind ho...",
    "lineStart": 2090,
    "lineEnd": 2090,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "HTTP server extension honors CLI `--port` over `server.port`, uses a safe default bind host, and exposes the baseline endpoints/error semantics in Section 13.7 if shipped.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-lineargraphql-client-side-tool-extension-exposes-raw-linear-graphql-access-throu",
    "type": "test",
    "title": "lineargraphql client-side tool extension exposes raw Linear GraphQL access through th...",
    "lineStart": 2092,
    "lineEnd": 2092,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`linear_graphql` client-side tool extension exposes raw Linear GraphQL access through the app-server session using configured Symphony auth.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-todo-persist-retry-queue-and-session-metadata-across-process-restarts",
    "type": "test",
    "title": "TODO: Persist retry queue and session metadata across process restarts.",
    "lineStart": 2094,
    "lineEnd": 2094,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "TODO: Persist retry queue and session metadata across process restarts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-todo-make-observability-settings-configurable-in-workflow-front-matter-without-p",
    "type": "test",
    "title": "TODO: Make observability settings configurable in workflow front matter without presc...",
    "lineStart": 2095,
    "lineEnd": 2095,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "TODO: Make observability settings configurable in workflow front matter without prescribing UI implementation details.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-first-class-tracker-write-apis-comments-state-transitions-in-the-orches",
    "type": "test",
    "title": "TODO: Add first-class tracker write APIs (comments/state transitions) in the orchestr...",
    "lineStart": 2097,
    "lineEnd": 2097,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "TODO: Add first-class tracker write APIs (comments/state transitions) in the orchestrator instead of only via agent tools.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-pluggable-issue-tracker-adapters-beyond-linear",
    "type": "test",
    "title": "TODO: Add pluggable issue tracker adapters beyond Linear.",
    "lineStart": 2099,
    "lineEnd": 2099,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "TODO: Add pluggable issue tracker adapters beyond Linear.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne",
    "type": "test",
    "title": "Run the Real Integration Profile from Section 17.8 with valid credentials and network...",
    "lineStart": 2103,
    "lineEnd": 2103,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Run the `Real Integration Profile` from Section 17.8 with valid credentials and network access.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
    "type": "test",
    "title": "Verify hook execution and workflow path resolution on the target host OS/shell enviro...",
    "lineStart": 2104,
    "lineEnd": 2104,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Verify hook execution and workflow path resolution on the target host OS/shell environment.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l",
    "type": "test",
    "title": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopb...",
    "lineStart": 2105,
    "lineEnd": 2105,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default bind expectations on the target environment.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-appendix-a-ssh-worker-extension-optional-worker-sshhosts-list-of-ssh-host-strings-optional",
    "type": "requirement",
    "title": "worker.sshhosts (list of SSH host strings, OPTIONAL)",
    "lineStart": 2115,
    "lineEnd": 2115,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`worker.ssh_hosts` (list of SSH host strings, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-appendix-a-ssh-worker-extension-optional-when-omitted-work-runs-locally",
    "type": "claim",
    "title": "When omitted, work runs locally.",
    "lineStart": 2116,
    "lineEnd": 2116,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "When omitted, work runs locally.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-appendix-a-ssh-worker-extension-optional-worker-maxconcurrentagentsperhost-positive-integer-optional",
    "type": "requirement",
    "title": "worker.maxconcurrentagentsperhost (positive integer, OPTIONAL)",
    "lineStart": 2117,
    "lineEnd": 2117,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`worker.max_concurrent_agents_per_host` (positive integer, OPTIONAL)",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-appendix-a-ssh-worker-extension-optional-shared-per-host-cap-applied-across-configured-ssh-hosts",
    "type": "dependency",
    "title": "Shared per-host cap applied across configured SSH hosts.",
    "lineStart": 2118,
    "lineEnd": 2118,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Shared per-host cap applied across configured SSH hosts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-1-execution-model-the-orchestrator-remains-the-single-source-of-truth-for-polling-claims-retries-a",
    "type": "claim",
    "title": "The orchestrator remains the single source of truth for polling, claims, retries, and...",
    "lineStart": 2122,
    "lineEnd": 2122,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The orchestrator remains the single source of truth for polling, claims, retries, and reconciliation.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-1-execution-model-worker-sshhosts-provides-the-candidate-ssh-destinations-for-remote-execution",
    "type": "claim",
    "title": "worker.sshhosts provides the candidate SSH destinations for remote execution.",
    "lineStart": 2124,
    "lineEnd": 2124,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`worker.ssh_hosts` provides the candidate SSH destinations for remote execution.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
    "type": "dependency",
    "title": "Each worker run is assigned to one host at a time, and that host becomes part of the...",
    "lineStart": 2125,
    "lineEnd": 2125,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Each worker run is assigned to one host at a time, and that host becomes part of the run's effective execution identity along with the issue workspace.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host",
    "type": "dependency",
    "title": "workspace.root is interpreted on the remote host, not on the orchestrator host.",
    "lineStart": 2127,
    "lineEnd": 2127,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`workspace.root` is interpreted on the remote host, not on the orchestrator host.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub",
    "type": "claim",
    "title": "The coding-agent app-server is launched over SSH stdio instead of as a local subproce...",
    "lineStart": 2128,
    "lineEnd": 2128,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "The coding-agent app-server is launched over SSH stdio instead of as a local subprocess, so the orchestrator still owns the session lifecycle even though commands execute remotely.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
    "type": "requirement",
    "title": "Continuation turns inside one worker lifetime SHOULD stay on the same host and worksp...",
    "lineStart": 2130,
    "lineEnd": 2130,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Continuation turns inside one worker lifetime SHOULD stay on the same host and workspace.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme",
    "type": "requirement",
    "title": "A remote host SHOULD satisfy the same basic contract as a local worker environment: r...",
    "lineStart": 2131,
    "lineEnd": 2131,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A remote host SHOULD satisfy the same basic contract as a local worker environment: reachable shell, writable workspace root, coding-agent executable, and any required auth or repository prerequisites.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-ssh-hosts-may-be-treated-as-a-pool-for-dispatch",
    "type": "requirement",
    "title": "SSH hosts MAY be treated as a pool for dispatch.",
    "lineStart": 2137,
    "lineEnd": 2137,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "SSH hosts MAY be treated as a pool for dispatch.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-implementations-may-prefer-the-previously-used-host-on-retries-when-that-host-is",
    "type": "requirement",
    "title": "Implementations MAY prefer the previously used host on retries when that host is stil...",
    "lineStart": 2138,
    "lineEnd": 2138,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY prefer the previously used host on retries when that host is still available.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-worker-maxconcurrentagentsperhost-is-an-optional-shared-per-host-cap-across-conf",
    "type": "requirement",
    "title": "worker.maxconcurrentagentsperhost is an OPTIONAL shared per-host cap across configure...",
    "lineStart": 2140,
    "lineEnd": 2140,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "`worker.max_concurrent_agents_per_host` is an OPTIONAL shared per-host cap across configured SSH hosts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal",
    "type": "requirement",
    "title": "When all SSH hosts are at capacity, dispatch SHOULD wait rather than silently falling...",
    "lineStart": 2142,
    "lineEnd": 2142,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "When all SSH hosts are at capacity, dispatch SHOULD wait rather than silently falling back to a different execution mode.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-implementations-may-fail-over-to-another-host-when-the-original-host-is-unavaila",
    "type": "requirement",
    "title": "Implementations MAY fail over to another host when the original host is unavailable b...",
    "lineStart": 2144,
    "lineEnd": 2144,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations MAY fail over to another host when the original host is unavailable before work has meaningfully started.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-2-scheduling-notes-once-a-run-has-already-produced-side-effects-a-transparent-rerun-on-another-host",
    "type": "requirement",
    "title": "Once a run has already produced side effects, a transparent rerun on another host SHO...",
    "lineStart": 2146,
    "lineEnd": 2146,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Once a run has already produced side effects, a transparent rerun on another host SHOULD be treated as a new attempt, not as invisible failover.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-remote-environment-drift",
    "type": "claim",
    "title": "Remote environment drift:",
    "lineStart": 2151,
    "lineEnd": 2151,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Remote environment drift:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-3-problems-to-consider-each-host-needs-the-expected-shell-environment-coding-agent-executable-auth-and-",
    "type": "dependency",
    "title": "Each host needs the expected shell environment, coding-agent executable, auth, and re...",
    "lineStart": 2152,
    "lineEnd": 2152,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Each host needs the expected shell environment, coding-agent executable, auth, and repository prerequisites.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-workspace-locality",
    "type": "claim",
    "title": "Workspace locality:",
    "lineStart": 2154,
    "lineEnd": 2154,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspace locality:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-3-problems-to-consider-workspaces-are-usually-host-local-so-moving-an-issue-to-a-different-host-is-typi",
    "type": "dependency",
    "title": "Workspaces are usually host-local, so moving an issue to a different host is typicall...",
    "lineStart": 2155,
    "lineEnd": 2155,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Workspaces are usually host-local, so moving an issue to a different host is typically a cold restart unless shared storage exists.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-path-and-command-safety",
    "type": "claim",
    "title": "Path and command safety:",
    "lineStart": 2157,
    "lineEnd": 2157,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Path and command safety:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-remote-path-resolution-shell-quoting-and-workspace-boundary-checks-matter-more-o",
    "type": "claim",
    "title": "Remote path resolution, shell quoting, and workspace-boundary checks matter more once...",
    "lineStart": 2158,
    "lineEnd": 2158,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Remote path resolution, shell quoting, and workspace-boundary checks matter more once execution crosses a machine boundary.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-startup-and-failover-semantics",
    "type": "claim",
    "title": "Startup and failover semantics:",
    "lineStart": 2160,
    "lineEnd": 2160,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Startup and failover semantics:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-3-problems-to-consider-implementations-should-distinguish-host-connectivity-startup-failures-from-in-wo",
    "type": "requirement",
    "title": "Implementations SHOULD distinguish host-connectivity/startup failures from in-workspa...",
    "lineStart": 2161,
    "lineEnd": 2161,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Implementations SHOULD distinguish host-connectivity/startup failures from in-workspace agent failures so the same ticket is not accidentally re-executed on multiple hosts.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-3-problems-to-consider-host-health-and-saturation",
    "type": "dependency",
    "title": "Host health and saturation:",
    "lineStart": 2163,
    "lineEnd": 2163,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Host health and saturation:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "requirement-a-3-problems-to-consider-a-dead-or-overloaded-host-should-reduce-available-capacity-not-cause-duplicate-e",
    "type": "requirement",
    "title": "A dead or overloaded host SHOULD reduce available capacity, not cause duplicate execu...",
    "lineStart": 2164,
    "lineEnd": 2164,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "A dead or overloaded host SHOULD reduce available capacity, not cause duplicate execution or an accidental fallback to local work.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "claim-a-3-problems-to-consider-cleanup-and-observability",
    "type": "claim",
    "title": "Cleanup and observability:",
    "lineStart": 2166,
    "lineEnd": 2166,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Cleanup and observability:",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "dependency-a-3-problems-to-consider-operators-need-to-know-which-host-owns-a-run-where-its-workspace-lives-and-wheth",
    "type": "dependency",
    "title": "Operators need to know which host owns a run, where its workspace lives, and whether...",
    "lineStart": 2167,
    "lineEnd": 2167,
    "severity": null,
    "badIdeaClass": null,
    "excerpt": "Operators need to know which host owns a run, where its workspace lives, and whether cleanup happened on the right machine.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "finding-impossible-unbounded",
    "type": "finding",
    "title": "Unbounded normative claims need explicit assumptions",
    "lineStart": null,
    "lineEnd": null,
    "severity": "medium",
    "badIdeaClass": "impossible",
    "excerpt": "Claims using always, never, all, every, or complete often hide impossible total guarantees over real environments.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "finding-complexity-optional-surface",
    "type": "finding",
    "title": "Optional surface is large relative to goals",
    "lineStart": null,
    "lineEnd": null,
    "severity": "low",
    "badIdeaClass": "more_complex_than_nothing",
    "excerpt": "Detected 46 optional references. Large optional surfaces can make conformance harder than the baseline problem.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "finding-misses-problem-low-overlap",
    "type": "finding",
    "title": "Problem, goals, and tests have weak lexical overlap",
    "lineStart": null,
    "lineEnd": null,
    "severity": "medium",
    "badIdeaClass": "misses_problem",
    "excerpt": "Problem-goal overlap 0.11, problem-test overlap 0.08. Low overlap is not proof of failure, but it is a good prompt to link goals and tests explicitly.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  },
  {
    "id": "finding-underspecified-vague-norms",
    "type": "finding",
    "title": "Normative claims contain vague qualifiers",
    "lineStart": null,
    "lineEnd": null,
    "severity": "medium",
    "badIdeaClass": "underspecified",
    "excerpt": "Normative language with vague qualifiers needs defaults, measurable thresholds, or a named implementation-defined policy.",
    "sourcePath": "/Users/ericfode/src/openai-symphony/spec.md"
  }
] AS row
MERGE (n:ClaimLatticeNode {id: row.id})
SET n.type = row.type,
    n.title = row.title,
    n.lineStart = row.lineStart,
    n.lineEnd = row.lineEnd,
    n.severity = row.severity,
    n.badIdeaClass = row.badIdeaClass,
    n.excerpt = row.excerpt,
    n.sourcePath = row.sourcePath;

UNWIND [
  {
    "id": "spec->section-001-symphony-service-specification:contains",
    "from": "spec",
    "to": "section-001-symphony-service-specification",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-002-normative-language:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-002-normative-language",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-003-1-problem-statement:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-003-1-problem-statement",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-004-2-goals-and-non-goals:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-004-2-goals-and-non-goals",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-004-2-goals-and-non-goals->section-005-2-1-goals:contains",
    "from": "section-004-2-goals-and-non-goals",
    "to": "section-005-2-1-goals",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-004-2-goals-and-non-goals->section-006-2-2-non-goals:contains",
    "from": "section-004-2-goals-and-non-goals",
    "to": "section-006-2-2-non-goals",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-007-3-system-overview:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-007-3-system-overview",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-007-3-system-overview->section-008-3-1-main-components:contains",
    "from": "section-007-3-system-overview",
    "to": "section-008-3-1-main-components",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-007-3-system-overview->section-009-3-2-abstraction-levels:contains",
    "from": "section-007-3-system-overview",
    "to": "section-009-3-2-abstraction-levels",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-007-3-system-overview->section-010-3-3-external-dependencies:contains",
    "from": "section-007-3-system-overview",
    "to": "section-010-3-3-external-dependencies",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-011-4-core-domain-model:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-011-4-core-domain-model",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-011-4-core-domain-model->section-012-4-1-entities:contains",
    "from": "section-011-4-core-domain-model",
    "to": "section-012-4-1-entities",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-013-4-1-1-issue:contains",
    "from": "section-012-4-1-entities",
    "to": "section-013-4-1-1-issue",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-014-4-1-2-workflow-definition:contains",
    "from": "section-012-4-1-entities",
    "to": "section-014-4-1-2-workflow-definition",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-015-4-1-3-service-config-typed-view:contains",
    "from": "section-012-4-1-entities",
    "to": "section-015-4-1-3-service-config-typed-view",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-016-4-1-4-workspace:contains",
    "from": "section-012-4-1-entities",
    "to": "section-016-4-1-4-workspace",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-017-4-1-5-run-attempt:contains",
    "from": "section-012-4-1-entities",
    "to": "section-017-4-1-5-run-attempt",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-018-4-1-6-live-session-agent-session-metadata:contains",
    "from": "section-012-4-1-entities",
    "to": "section-018-4-1-6-live-session-agent-session-metadata",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-019-4-1-7-retry-entry:contains",
    "from": "section-012-4-1-entities",
    "to": "section-019-4-1-7-retry-entry",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-012-4-1-entities->section-020-4-1-8-orchestrator-runtime-state:contains",
    "from": "section-012-4-1-entities",
    "to": "section-020-4-1-8-orchestrator-runtime-state",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-011-4-core-domain-model->section-021-4-2-stable-identifiers-and-normalization-rules:contains",
    "from": "section-011-4-core-domain-model",
    "to": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-022-5-workflow-specification-repository-contract:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-022-5-workflow-specification-repository-contract",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract->section-023-5-1-file-discovery-and-path-resolution:contains",
    "from": "section-022-5-workflow-specification-repository-contract",
    "to": "section-023-5-1-file-discovery-and-path-resolution",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract->section-024-5-2-file-format:contains",
    "from": "section-022-5-workflow-specification-repository-contract",
    "to": "section-024-5-2-file-format",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract->section-025-5-3-front-matter-schema:contains",
    "from": "section-022-5-workflow-specification-repository-contract",
    "to": "section-025-5-3-front-matter-schema",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-026-5-3-1-tracker-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-026-5-3-1-tracker-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-027-5-3-2-polling-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-027-5-3-2-polling-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-028-5-3-3-workspace-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-028-5-3-3-workspace-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-029-5-3-4-hooks-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-029-5-3-4-hooks-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-030-5-3-5-agent-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-030-5-3-5-agent-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-025-5-3-front-matter-schema->section-031-5-3-6-codex-object:contains",
    "from": "section-025-5-3-front-matter-schema",
    "to": "section-031-5-3-6-codex-object",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract->section-032-5-4-prompt-template-contract:contains",
    "from": "section-022-5-workflow-specification-repository-contract",
    "to": "section-032-5-4-prompt-template-contract",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-022-5-workflow-specification-repository-contract->section-033-5-5-workflow-validation-and-error-surface:contains",
    "from": "section-022-5-workflow-specification-repository-contract",
    "to": "section-033-5-5-workflow-validation-and-error-surface",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-034-6-configuration-specification:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-034-6-configuration-specification",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-034-6-configuration-specification->section-035-6-1-configuration-resolution-pipeline:contains",
    "from": "section-034-6-configuration-specification",
    "to": "section-035-6-1-configuration-resolution-pipeline",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-034-6-configuration-specification->section-036-6-2-dynamic-reload-semantics:contains",
    "from": "section-034-6-configuration-specification",
    "to": "section-036-6-2-dynamic-reload-semantics",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-034-6-configuration-specification->section-037-6-3-dispatch-preflight-validation:contains",
    "from": "section-034-6-configuration-specification",
    "to": "section-037-6-3-dispatch-preflight-validation",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-034-6-configuration-specification->section-038-6-4-core-config-fields-summary-cheat-sheet:contains",
    "from": "section-034-6-configuration-specification",
    "to": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-039-7-orchestration-state-machine:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-039-7-orchestration-state-machine",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-039-7-orchestration-state-machine->section-040-7-1-issue-orchestration-states:contains",
    "from": "section-039-7-orchestration-state-machine",
    "to": "section-040-7-1-issue-orchestration-states",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-039-7-orchestration-state-machine->section-041-7-2-run-attempt-lifecycle:contains",
    "from": "section-039-7-orchestration-state-machine",
    "to": "section-041-7-2-run-attempt-lifecycle",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-039-7-orchestration-state-machine->section-042-7-3-transition-triggers:contains",
    "from": "section-039-7-orchestration-state-machine",
    "to": "section-042-7-3-transition-triggers",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-039-7-orchestration-state-machine->section-043-7-4-idempotency-and-recovery-rules:contains",
    "from": "section-039-7-orchestration-state-machine",
    "to": "section-043-7-4-idempotency-and-recovery-rules",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-044-8-polling-scheduling-and-reconciliation:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-044-8-polling-scheduling-and-reconciliation",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-045-8-1-poll-loop:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-045-8-1-poll-loop",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-046-8-2-candidate-selection-rules:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-046-8-2-candidate-selection-rules",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-047-8-3-concurrency-control:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-047-8-3-concurrency-control",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-048-8-4-retry-and-backoff:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-048-8-4-retry-and-backoff",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-049-8-5-active-run-reconciliation:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-049-8-5-active-run-reconciliation",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-044-8-polling-scheduling-and-reconciliation->section-050-8-6-startup-terminal-workspace-cleanup:contains",
    "from": "section-044-8-polling-scheduling-and-reconciliation",
    "to": "section-050-8-6-startup-terminal-workspace-cleanup",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-051-9-workspace-management-and-safety:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-051-9-workspace-management-and-safety",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-051-9-workspace-management-and-safety->section-052-9-1-workspace-layout:contains",
    "from": "section-051-9-workspace-management-and-safety",
    "to": "section-052-9-1-workspace-layout",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-051-9-workspace-management-and-safety->section-053-9-2-workspace-creation-and-reuse:contains",
    "from": "section-051-9-workspace-management-and-safety",
    "to": "section-053-9-2-workspace-creation-and-reuse",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-051-9-workspace-management-and-safety->section-054-9-3-optional-workspace-population-implementation-defined:contains",
    "from": "section-051-9-workspace-management-and-safety",
    "to": "section-054-9-3-optional-workspace-population-implementation-defined",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-051-9-workspace-management-and-safety->section-055-9-4-workspace-hooks:contains",
    "from": "section-051-9-workspace-management-and-safety",
    "to": "section-055-9-4-workspace-hooks",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-051-9-workspace-management-and-safety->section-056-9-5-safety-invariants:contains",
    "from": "section-051-9-workspace-management-and-safety",
    "to": "section-056-9-5-safety-invariants",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-057-10-agent-runner-protocol-coding-agent-integration:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-058-10-1-launch-contract:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-058-10-1-launch-contract",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-059-10-2-session-startup-responsibilities:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-059-10-2-session-startup-responsibilities",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-060-10-3-streaming-turn-processing:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-060-10-3-streaming-turn-processing",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-061-10-4-emitted-runtime-events-upstream-to-orchestrator:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-062-10-5-approval-tool-calls-and-user-input-policy:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-063-10-6-timeouts-and-error-mapping:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-063-10-6-timeouts-and-error-mapping",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->section-064-10-7-agent-runner-contract:contains",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "section-064-10-7-agent-runner-contract",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-065-11-issue-tracker-integration-contract-linear-compatible:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible->section-066-11-1-required-operations:contains",
    "from": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "to": "section-066-11-1-required-operations",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible->section-067-11-2-query-semantics-linear:contains",
    "from": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "to": "section-067-11-2-query-semantics-linear",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible->section-068-11-3-normalization-rules:contains",
    "from": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "to": "section-068-11-3-normalization-rules",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible->section-069-11-4-error-handling-contract:contains",
    "from": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "to": "section-069-11-4-error-handling-contract",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-065-11-issue-tracker-integration-contract-linear-compatible->section-070-11-5-tracker-writes-important-boundary:contains",
    "from": "section-065-11-issue-tracker-integration-contract-linear-compatible",
    "to": "section-070-11-5-tracker-writes-important-boundary",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-071-12-prompt-construction-and-context-assembly:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-071-12-prompt-construction-and-context-assembly",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-071-12-prompt-construction-and-context-assembly->section-072-12-1-inputs:contains",
    "from": "section-071-12-prompt-construction-and-context-assembly",
    "to": "section-072-12-1-inputs",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-071-12-prompt-construction-and-context-assembly->section-073-12-2-rendering-rules:contains",
    "from": "section-071-12-prompt-construction-and-context-assembly",
    "to": "section-073-12-2-rendering-rules",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-071-12-prompt-construction-and-context-assembly->section-074-12-3-retry-continuation-semantics:contains",
    "from": "section-071-12-prompt-construction-and-context-assembly",
    "to": "section-074-12-3-retry-continuation-semantics",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-071-12-prompt-construction-and-context-assembly->section-075-12-4-failure-semantics:contains",
    "from": "section-071-12-prompt-construction-and-context-assembly",
    "to": "section-075-12-4-failure-semantics",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-076-13-logging-status-and-observability:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-076-13-logging-status-and-observability",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-077-13-1-logging-conventions:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-077-13-1-logging-conventions",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-078-13-2-logging-outputs-and-sinks:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-078-13-2-logging-outputs-and-sinks",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-080-13-4-optional-human-readable-status-surface:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-080-13-4-optional-human-readable-status-surface",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-081-13-5-session-metrics-and-token-accounting:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-081-13-5-session-metrics-and-token-accounting",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-082-13-6-humanized-agent-event-summaries-optional:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-082-13-6-humanized-agent-event-summaries-optional",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-076-13-logging-status-and-observability->section-083-13-7-optional-http-server-extension:contains",
    "from": "section-076-13-logging-status-and-observability",
    "to": "section-083-13-7-optional-http-server-extension",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->section-084-13-7-1-human-readable-dashboard:contains",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "section-084-13-7-1-human-readable-dashboard",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->section-085-13-7-2-json-rest-api-api-v1:contains",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "section-085-13-7-2-json-rest-api-api-v1",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-086-14-failure-model-and-recovery-strategy:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-086-14-failure-model-and-recovery-strategy",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-086-14-failure-model-and-recovery-strategy->section-087-14-1-failure-classes:contains",
    "from": "section-086-14-failure-model-and-recovery-strategy",
    "to": "section-087-14-1-failure-classes",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-086-14-failure-model-and-recovery-strategy->section-088-14-2-recovery-behavior:contains",
    "from": "section-086-14-failure-model-and-recovery-strategy",
    "to": "section-088-14-2-recovery-behavior",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-086-14-failure-model-and-recovery-strategy->section-089-14-3-partial-state-recovery-restart:contains",
    "from": "section-086-14-failure-model-and-recovery-strategy",
    "to": "section-089-14-3-partial-state-recovery-restart",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-086-14-failure-model-and-recovery-strategy->section-090-14-4-operator-intervention-points:contains",
    "from": "section-086-14-failure-model-and-recovery-strategy",
    "to": "section-090-14-4-operator-intervention-points",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-091-15-security-and-operational-safety:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-091-15-security-and-operational-safety",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-091-15-security-and-operational-safety->section-092-15-1-trust-boundary-assumption:contains",
    "from": "section-091-15-security-and-operational-safety",
    "to": "section-092-15-1-trust-boundary-assumption",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-091-15-security-and-operational-safety->section-093-15-2-filesystem-safety-requirements:contains",
    "from": "section-091-15-security-and-operational-safety",
    "to": "section-093-15-2-filesystem-safety-requirements",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-091-15-security-and-operational-safety->section-094-15-3-secret-handling:contains",
    "from": "section-091-15-security-and-operational-safety",
    "to": "section-094-15-3-secret-handling",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-091-15-security-and-operational-safety->section-095-15-4-hook-script-safety:contains",
    "from": "section-091-15-security-and-operational-safety",
    "to": "section-095-15-4-hook-script-safety",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-091-15-security-and-operational-safety->section-096-15-5-harness-hardening-guidance:contains",
    "from": "section-091-15-security-and-operational-safety",
    "to": "section-096-15-5-harness-hardening-guidance",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-097-16-reference-algorithms-language-agnostic:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-097-16-reference-algorithms-language-agnostic",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-098-16-1-service-startup:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-098-16-1-service-startup",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-099-16-2-poll-and-dispatch-tick:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-099-16-2-poll-and-dispatch-tick",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-100-16-3-reconcile-active-runs:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-100-16-3-reconcile-active-runs",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-101-16-4-dispatch-one-issue:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-101-16-4-dispatch-one-issue",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-102-16-5-worker-attempt-workspace-prompt-agent:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-102-16-5-worker-attempt-workspace-prompt-agent",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-097-16-reference-algorithms-language-agnostic->section-103-16-6-worker-exit-and-retry-handling:contains",
    "from": "section-097-16-reference-algorithms-language-agnostic",
    "to": "section-103-16-6-worker-exit-and-retry-handling",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-104-17-test-and-validation-matrix:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-104-17-test-and-validation-matrix",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-105-17-1-workflow-and-config-parsing:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-105-17-1-workflow-and-config-parsing",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-106-17-2-workspace-manager-and-safety:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-106-17-2-workspace-manager-and-safety",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-107-17-3-issue-tracker-client:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-107-17-3-issue-tracker-client",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-108-17-4-orchestrator-dispatch-reconciliation-and-retry:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-109-17-5-coding-agent-app-server-client:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-109-17-5-coding-agent-app-server-client",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-110-17-6-observability:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-110-17-6-observability",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-111-17-7-cli-and-host-lifecycle:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-111-17-7-cli-and-host-lifecycle",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->section-112-17-8-real-integration-profile-recommended:contains",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "section-112-17-8-real-integration-profile-recommended",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-113-18-implementation-checklist-definition-of-done:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-113-18-implementation-checklist-definition-of-done",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->section-114-18-1-required-for-conformance:contains",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "section-114-18-1-required-for-conformance",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->section-115-18-2-recommended-extensions-not-required-for-conformance:contains",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->section-116-18-3-operational-validation-before-production-recommended:contains",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "section-116-18-3-operational-validation-before-production-recommended",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-001-symphony-service-specification->section-117-appendix-a-ssh-worker-extension-optional:contains",
    "from": "section-001-symphony-service-specification",
    "to": "section-117-appendix-a-ssh-worker-extension-optional",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->section-118-a-1-execution-model:contains",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "section-118-a-1-execution-model",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->section-119-a-2-scheduling-notes:contains",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "section-119-a-2-scheduling-notes",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->section-120-a-3-problems-to-consider:contains",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "section-120-a-3-problems-to-consider",
    "type": "contains",
    "label": "contains"
  },
  {
    "id": "section-002-normative-language->requirement-normative-language-the-key-words-must-must-not-required-should-should-not-recommended-may-and:elaborates",
    "from": "section-002-normative-language",
    "to": "requirement-normative-language-the-key-words-must-must-not-required-should-should-not-recommended-may-and",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-002-normative-language->requirement-normative-language-optional-in-this-document-are-to-be-interpreted-as-described-in-rfc-2119:elaborates",
    "from": "section-002-normative-language",
    "to": "requirement-normative-language-optional-in-this-document-are-to-be-interpreted-as-described-in-rfc-2119",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-002-normative-language->requirement-normative-language-implementations-must-document-the-selected:elaborates",
    "from": "section-002-normative-language",
    "to": "requirement-normative-language-implementations-must-document-the-selected",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-it-turns-issue-execution-into-a-repeatable-daemon-workflow-instead-of-manual-scr:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-it-turns-issue-execution-into-a-repeatable-daemon-workflow-instead-of-manual-scr",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-it-isolates-agent-execution-in-per-issue-workspaces-so-agent-commands-run-only-i:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-it-isolates-agent-execution-in-per-issue-workspaces-so-agent-commands-run-only-i",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-it-keeps-the-workflow-policy-in-repo-workflow-md-so-teams-version-the-agent-prom:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-it-keeps-the-workflow-policy-in-repo-workflow-md-so-teams-version-the-agent-prom",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-it-provides-enough-observability-to-operate-and-debug-multiple-concurrent-agent-:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-it-provides-enough-observability-to-operate-and-debug-multiple-concurrent-agent-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-symphony-is-a-scheduler-runner-and-tracker-reader:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-symphony-is-a-scheduler-runner-and-tracker-reader",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-ticket-writes-state-transitions-comments-pr-links-are-typically-performed-by-the:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-ticket-writes-state-transitions-comments-pr-links-are-typically-performed-by-the",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-003-1-problem-statement->claim-1-problem-statement-a-successful-run-can-end-at-a-workflow-defined-handoff-state-for-example-human-r:elaborates",
    "from": "section-003-1-problem-statement",
    "to": "claim-1-problem-statement-a-successful-run-can-end-at-a-workflow-defined-handoff-state-for-example-human-r",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-recover-from-transient-failures-with-exponential-backoff:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-recover-from-transient-failures-with-exponential-backoff",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-load-runtime-behavior-from-a-repository-owned-workflow-md-contract:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-load-runtime-behavior-from-a-repository-owned-workflow-md-contract",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-expose-operator-visible-observability-at-minimum-structured-logs:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-expose-operator-visible-observability-at-minimum-structured-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-005-2-1-goals->goal-2-1-goals-support-tracker-filesystem-driven-restart-recovery-without-requiring-a-persisten:elaborates",
    "from": "section-005-2-1-goals",
    "to": "goal-2-1-goals-support-tracker-filesystem-driven-restart-recovery-without-requiring-a-persisten",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-rich-web-ui-or-multi-tenant-control-plane:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-rich-web-ui-or-multi-tenant-control-plane",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-prescribing-a-specific-dashboard-or-terminal-ui-implementation:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-prescribing-a-specific-dashboard-or-terminal-ui-implementation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-general-purpose-workflow-engine-or-distributed-job-scheduler:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-general-purpose-workflow-engine-or-distributed-job-scheduler",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-built-in-business-logic-for-how-to-edit-tickets-prs-or-comments-that-logic-lives:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-built-in-business-logic-for-how-to-edit-tickets-prs-or-comments-that-logic-lives",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-mandating-strong-sandbox-controls-beyond-what-the-coding-agent-and-host-os-provi:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-mandating-strong-sandbox-controls-beyond-what-the-coding-agent-and-host-os-provi",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-006-2-2-non-goals->non_goal-2-2-non-goals-mandating-a-single-default-approval-sandbox-or-operator-confirmation-posture-for:elaborates",
    "from": "section-006-2-2-non-goals",
    "to": "non_goal-2-2-non-goals-mandating-a-single-default-approval-sandbox-or-operator-confirmation-posture-for",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-reads-workflow-md:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-reads-workflow-md",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-parses-yaml-front-matter-and-prompt-body:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-parses-yaml-front-matter-and-prompt-body",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-returns-config-prompttemplate:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-returns-config-prompttemplate",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-exposes-typed-getters-for-workflow-config-values:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-exposes-typed-getters-for-workflow-config-values",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-applies-defaults-and-environment-variable-indirection:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-applies-defaults-and-environment-variable-indirection",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-performs-validation-used-by-the-orchestrator-before-dispatch:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-performs-validation-used-by-the-orchestrator-before-dispatch",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-fetches-candidate-issues-in-active-states:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-fetches-candidate-issues-in-active-states",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-fetches-current-states-for-specific-issue-ids-reconciliation:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-fetches-current-states-for-specific-issue-ids-reconciliation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-fetches-terminal-state-issues-during-startup-cleanup:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-fetches-terminal-state-issues-during-startup-cleanup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-normalizes-tracker-payloads-into-a-stable-issue-model",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-owns-the-poll-tick:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-owns-the-poll-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-owns-the-in-memory-runtime-state:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-owns-the-in-memory-runtime-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-decides-which-issues-to-dispatch-retry-stop-or-release:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-decides-which-issues-to-dispatch-retry-stop-or-release",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-tracks-session-metrics-and-retry-queue-state:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-tracks-session-metrics-and-retry-queue-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-maps-issue-identifiers-to-workspace-paths:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-maps-issue-identifiers-to-workspace-paths",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-ensures-per-issue-workspace-directories-exist:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-ensures-per-issue-workspace-directories-exist",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-runs-workspace-lifecycle-hooks:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-runs-workspace-lifecycle-hooks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-cleans-workspaces-for-terminal-issues:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-cleans-workspaces-for-terminal-issues",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-creates-workspace:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-creates-workspace",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-builds-prompt-from-issue-workflow-template:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-builds-prompt-from-issue-workflow-template",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-launches-the-coding-agent-app-server-client:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-launches-the-coding-agent-app-server-client",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-streams-agent-updates-back-to-the-orchestrator:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-streams-agent-updates-back-to-the-orchestrator",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-status-surface-optional:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-status-surface-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-presents-human-readable-runtime-status-for-example-terminal-output-dashboard-or-:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-presents-human-readable-runtime-status-for-example-terminal-output-dashboard-or-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-008-3-1-main-components->component-3-1-main-components-emits-structured-runtime-logs-to-one-or-more-configured-sinks:elaborates",
    "from": "section-008-3-1-main-components",
    "to": "component-3-1-main-components-emits-structured-runtime-logs-to-one-or-more-configured-sinks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-workflow-md-prompt-body:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-workflow-md-prompt-body",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-team-specific-rules-for-ticket-handling-validation-and-handoff:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-team-specific-rules-for-ticket-handling-validation-and-handoff",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-parses-front-matter-into-typed-runtime-settings:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-parses-front-matter-into-typed-runtime-settings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-handles-defaults-environment-tokens-and-path-normalization:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-handles-defaults-environment-tokens-and-path-normalization",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-polling-loop-issue-eligibility-concurrency-retries-reconciliation:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-polling-loop-issue-eligibility-concurrency-retries-reconciliation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->dependency-3-2-abstraction-levels-filesystem-lifecycle-workspace-preparation-coding-agent-protocol:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "dependency-3-2-abstraction-levels-filesystem-lifecycle-workspace-preparation-coding-agent-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "dependency-3-2-abstraction-levels-api-calls-and-normalization-for-tracker-data",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->requirement-3-2-abstraction-levels-observability-layer-logs-optional-status-surface:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "requirement-3-2-abstraction-levels-observability-layer-logs-optional-status-surface",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-009-3-2-abstraction-levels->claim-3-2-abstraction-levels-operator-visibility-into-orchestrator-and-agent-behavior:elaborates",
    "from": "section-009-3-2-abstraction-levels",
    "to": "claim-3-2-abstraction-levels-operator-visibility-into-orchestrator-and-agent-behavior",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-010-3-3-external-dependencies->dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version:elaborates",
    "from": "section-010-3-3-external-dependencies",
    "to": "dependency-3-3-external-dependencies-issue-tracker-api-linear-for-tracker-kind-linear-in-this-specification-version",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-010-3-3-external-dependencies->dependency-3-3-external-dependencies-local-filesystem-for-workspaces-and-logs:elaborates",
    "from": "section-010-3-3-external-dependencies",
    "to": "dependency-3-3-external-dependencies-local-filesystem-for-workspaces-and-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-010-3-3-external-dependencies->dependency-3-3-external-dependencies-optional-workspace-population-tooling-for-example-git-cli-if-used:elaborates",
    "from": "section-010-3-3-external-dependencies",
    "to": "dependency-3-3-external-dependencies-optional-workspace-population-tooling-for-example-git-cli-if-used",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-010-3-3-external-dependencies->dependency-3-3-external-dependencies-coding-agent-executable-that-supports-the-targeted-codex-app-server-mode:elaborates",
    "from": "section-010-3-3-external-dependencies",
    "to": "dependency-3-3-external-dependencies-coding-agent-executable-that-supports-the-targeted-codex-app-server-mode",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-010-3-3-external-dependencies->dependency-3-3-external-dependencies-host-environment-authentication-for-the-issue-tracker-and-coding-agent:elaborates",
    "from": "section-010-3-3-external-dependencies",
    "to": "dependency-3-3-external-dependencies-host-environment-authentication-for-the-issue-tracker-and-coding-agent",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-id-string:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-id-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-stable-tracker-internal-id:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-stable-tracker-internal-id",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-identifier-string:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-identifier-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-human-readable-ticket-key-example-abc-123:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-human-readable-ticket-key-example-abc-123",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-title-string:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-title-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-description-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-description-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-priority-integer-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-priority-integer-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-lower-numbers-are-higher-priority-in-dispatch-sorting:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-lower-numbers-are-higher-priority-in-dispatch-sorting",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-state-string:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-state-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-current-tracker-state-name:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-current-tracker-state-name",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-branchname-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-branchname-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-tracker-provided-branch-metadata-if-available:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-tracker-provided-branch-metadata-if-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-url-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-url-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-labels-list-of-strings:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-labels-list-of-strings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-normalized-to-lowercase:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-normalized-to-lowercase",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-blockedby-list-of-blocker-refs:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-blockedby-list-of-blocker-refs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-each-blocker-ref-contains:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-each-blocker-ref-contains",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-id-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-id-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-identifier-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-identifier-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-state-string-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-state-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-createdat-timestamp-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-createdat-timestamp-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-013-4-1-1-issue->claim-4-1-1-issue-updatedat-timestamp-or-null:elaborates",
    "from": "section-013-4-1-1-issue",
    "to": "claim-4-1-1-issue-updatedat-timestamp-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-014-4-1-2-workflow-definition->claim-4-1-2-workflow-definition-config-map:elaborates",
    "from": "section-014-4-1-2-workflow-definition",
    "to": "claim-4-1-2-workflow-definition-config-map",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-014-4-1-2-workflow-definition->claim-4-1-2-workflow-definition-yaml-front-matter-root-object:elaborates",
    "from": "section-014-4-1-2-workflow-definition",
    "to": "claim-4-1-2-workflow-definition-yaml-front-matter-root-object",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-014-4-1-2-workflow-definition->claim-4-1-2-workflow-definition-prompttemplate-string:elaborates",
    "from": "section-014-4-1-2-workflow-definition",
    "to": "claim-4-1-2-workflow-definition-prompttemplate-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-014-4-1-2-workflow-definition->claim-4-1-2-workflow-definition-markdown-body-after-front-matter-trimmed:elaborates",
    "from": "section-014-4-1-2-workflow-definition",
    "to": "claim-4-1-2-workflow-definition-markdown-body-after-front-matter-trimmed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-poll-interval:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-poll-interval",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-workspace-root:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-workspace-root",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-active-and-terminal-issue-states:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-active-and-terminal-issue-states",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-concurrency-limits:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-concurrency-limits",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-coding-agent-executable-args-timeouts:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-coding-agent-executable-args-timeouts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-015-4-1-3-service-config-typed-view->claim-4-1-3-service-config-typed-view-workspace-hooks:elaborates",
    "from": "section-015-4-1-3-service-config-typed-view",
    "to": "claim-4-1-3-service-config-typed-view-workspace-hooks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-016-4-1-4-workspace->claim-4-1-4-workspace-path-absolute-workspace-path:elaborates",
    "from": "section-016-4-1-4-workspace",
    "to": "claim-4-1-4-workspace-path-absolute-workspace-path",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-016-4-1-4-workspace->claim-4-1-4-workspace-workspacekey-sanitized-issue-identifier:elaborates",
    "from": "section-016-4-1-4-workspace",
    "to": "claim-4-1-4-workspace-workspacekey-sanitized-issue-identifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-016-4-1-4-workspace->claim-4-1-4-workspace-creatednow-boolean-used-to-gate-aftercreate-hook:elaborates",
    "from": "section-016-4-1-4-workspace",
    "to": "claim-4-1-4-workspace-creatednow-boolean-used-to-gate-aftercreate-hook",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-issueid:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-issueid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-issueidentifier:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-issueidentifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-attempt-integer-or-null-null-for-first-run-1-for-retries-continuation:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-attempt-integer-or-null-null-for-first-run-1-for-retries-continuation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-workspacepath:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-workspacepath",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-startedat:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-startedat",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->claim-4-1-5-run-attempt-status:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "claim-4-1-5-run-attempt-status",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-017-4-1-5-run-attempt->requirement-4-1-5-run-attempt-error-optional:elaborates",
    "from": "section-017-4-1-5-run-attempt",
    "to": "requirement-4-1-5-run-attempt-error-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-sessionid-string-threadid-turnid:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-sessionid-string-threadid-turnid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-threadid-string:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-threadid-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-turnid-string:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-turnid-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-codexappserverpid-string-or-null:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-codexappserverpid-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastcodexevent-string-enum-or-null:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastcodexevent-string-enum-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastcodextimestamp-timestamp-or-null:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastcodextimestamp-timestamp-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastcodexmessage-summarized-payload:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastcodexmessage-summarized-payload",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-codexinputtokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-codexinputtokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-codexoutputtokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-codexoutputtokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-codextotaltokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-codextotaltokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastreportedinputtokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastreportedinputtokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastreportedoutputtokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastreportedoutputtokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-lastreportedtotaltokens-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-lastreportedtotaltokens-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-turncount-integer:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-turncount-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-018-4-1-6-live-session-agent-session-metadata->claim-4-1-6-live-session-agent-session-metadata-number-of-coding-agent-turns-started-within-the-current-worker-lifetime:elaborates",
    "from": "section-018-4-1-6-live-session-agent-session-metadata",
    "to": "claim-4-1-6-live-session-agent-session-metadata-number-of-coding-agent-turns-started-within-the-current-worker-lifetime",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-issueid:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-issueid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-identifier-best-effort-human-id-for-status-surfaces-logs:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-identifier-best-effort-human-id-for-status-surfaces-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-attempt-integer-1-based-for-retry-queue:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-attempt-integer-1-based-for-retry-queue",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-dueatms-monotonic-clock-timestamp:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-dueatms-monotonic-clock-timestamp",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-timerhandle-runtime-specific-timer-reference:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-timerhandle-runtime-specific-timer-reference",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-019-4-1-7-retry-entry->claim-4-1-7-retry-entry-error-string-or-null:elaborates",
    "from": "section-019-4-1-7-retry-entry",
    "to": "claim-4-1-7-retry-entry-error-string-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-pollintervalms-current-effective-poll-interval:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-pollintervalms-current-effective-poll-interval",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-maxconcurrentagents-current-effective-global-concurrency-limit:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-maxconcurrentagents-current-effective-global-concurrency-limit",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-running-map-issueid-running-entry:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-running-map-issueid-running-entry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-claimed-set-of-issue-ids-reserved-running-retrying:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-claimed-set-of-issue-ids-reserved-running-retrying",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-retryattempts-map-issueid-retryentry:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-retryattempts-map-issueid-retryentry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-completed-set-of-issue-ids-bookkeeping-only-not-dispatch-gating:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-completed-set-of-issue-ids-bookkeeping-only-not-dispatch-gating",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-codextotals-aggregate-tokens-runtime-seconds:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-codextotals-aggregate-tokens-runtime-seconds",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-020-4-1-8-orchestrator-runtime-state->claim-4-1-8-orchestrator-runtime-state-codexratelimits-latest-rate-limit-snapshot-from-agent-events:elaborates",
    "from": "section-020-4-1-8-orchestrator-runtime-state",
    "to": "claim-4-1-8-orchestrator-runtime-state-codexratelimits-latest-rate-limit-snapshot-from-agent-events",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-issue-id:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-issue-id",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-use-for-tracker-lookups-and-internal-map-keys:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-use-for-tracker-lookups-and-internal-map-keys",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-issue-identifier:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-issue-identifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-use-for-human-readable-logs-and-workspace-naming:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-use-for-human-readable-logs-and-workspace-naming",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-workspace-key:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-workspace-key",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-derive-from-issue-identifier-by-replacing-any-character-not-in-a-za-z0-9-with:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-derive-from-issue-identifier-by-replacing-any-character-not-in-a-za-z0-9-with",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-use-the-sanitized-value-for-the-workspace-directory-name:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-use-the-sanitized-value-for-the-workspace-directory-name",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-normalized-issue-state:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-normalized-issue-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-compare-states-after-lowercase:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-compare-states-after-lowercase",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-session-id:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-session-id",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-021-4-2-stable-identifiers-and-normalization-rules->claim-4-2-stable-identifiers-and-normalization-rules-compose-from-coding-agent-threadid-and-turnid-as-threadid-turnid:elaborates",
    "from": "section-021-4-2-stable-identifiers-and-normalization-rules",
    "to": "claim-4-2-stable-identifiers-and-normalization-rules-compose-from-coding-agent-threadid-and-turnid-as-threadid-turnid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-023-5-1-file-discovery-and-path-resolution->claim-5-1-file-discovery-and-path-resolution-if-the-file-cannot-be-read-return-missingworkflowfile-error:elaborates",
    "from": "section-023-5-1-file-discovery-and-path-resolution",
    "to": "claim-5-1-file-discovery-and-path-resolution-if-the-file-cannot-be-read-return-missingworkflowfile-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-023-5-1-file-discovery-and-path-resolution->claim-5-1-file-discovery-and-path-resolution-the-workflow-file-is-expected-to-be-repository-owned-and-version-controlled:elaborates",
    "from": "section-023-5-1-file-discovery-and-path-resolution",
    "to": "claim-5-1-file-discovery-and-path-resolution-the-workflow-file-is-expected-to-be-repository-owned-and-version-controlled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->requirement-5-2-file-format-workflow-md-is-a-markdown-file-with-optional-yaml-front-matter:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "requirement-5-2-file-format-workflow-md-is-a-markdown-file-with-optional-yaml-front-matter",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-if-file-starts-with-parse-lines-until-the-next-as-yaml-front-matter:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-if-file-starts-with-parse-lines-until-the-next-as-yaml-front-matter",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-remaining-lines-become-the-prompt-body:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-remaining-lines-become-the-prompt-body",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-if-front-matter-is-absent-treat-the-entire-file-as-prompt-body-and-use-an-empty-:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-if-front-matter-is-absent-treat-the-entire-file-as-prompt-body-and-use-an-empty-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->requirement-5-2-file-format-yaml-front-matter-must-decode-to-a-map-object-non-map-yaml-is-an-error:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "requirement-5-2-file-format-yaml-front-matter-must-decode-to-a-map-object-non-map-yaml-is-an-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-prompt-body-is-trimmed-before-use:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-prompt-body-is-trimmed-before-use",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-config-front-matter-root-object-not-nested-under-a-config-key:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-config-front-matter-root-object-not-nested-under-a-config-key",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-024-5-2-file-format->claim-5-2-file-format-prompttemplate-trimmed-markdown-body:elaborates",
    "from": "section-024-5-2-file-format",
    "to": "claim-5-2-file-format-prompttemplate-trimmed-markdown-body",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-tracker:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-tracker",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-polling:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-polling",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-workspace:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-workspace",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-hooks:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-hooks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-agent:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-agent",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->claim-5-3-front-matter-schema-codex:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "claim-5-3-front-matter-schema-codex",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->requirement-5-3-front-matter-schema-unknown-keys-should-be-ignored-for-forward-compatibility:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "requirement-5-3-front-matter-schema-unknown-keys-should-be-ignored-for-forward-compatibility",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->requirement-5-3-front-matter-schema-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "requirement-5-3-front-matter-schema-the-workflow-front-matter-is-extensible-extensions-may-define-additional-top-lev",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-025-5-3-front-matter-schema->requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet:elaborates",
    "from": "section-025-5-3-front-matter-schema",
    "to": "requirement-5-3-front-matter-schema-extensions-should-document-their-field-schema-defaults-validation-rules-and-whet",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-kind-string:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-kind-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->requirement-5-3-1-tracker-object-required-for-dispatch:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "requirement-5-3-1-tracker-object-required-for-dispatch",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-current-supported-value-linear:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-current-supported-value-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-endpoint-string:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-endpoint-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "dependency-5-3-1-tracker-object-default-for-tracker-kind-linear-https-api-linear-app-graphql",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-apikey-string:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-apikey-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->requirement-5-3-1-tracker-object-may-be-a-literal-token-or-varname:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "requirement-5-3-1-tracker-object-may-be-a-literal-token-or-varname",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-canonical-environment-variable-for-tracker-kind-linear-linearapikey:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-canonical-environment-variable-for-tracker-kind-linear-linearapikey",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-if-varname-resolves-to-an-empty-string-treat-the-key-as-missing:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-if-varname-resolves-to-an-empty-string-treat-the-key-as-missing",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-projectslug-string:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-projectslug-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->requirement-5-3-1-tracker-object-required-for-dispatch-when-tracker-kind-linear:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "requirement-5-3-1-tracker-object-required-for-dispatch-when-tracker-kind-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-activestates-list-of-strings:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-activestates-list-of-strings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-default-todo-in-progress:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-default-todo-in-progress",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-terminalstates-list-of-strings:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-terminalstates-list-of-strings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-026-5-3-1-tracker-object->claim-5-3-1-tracker-object-default-closed-cancelled-canceled-duplicate-done:elaborates",
    "from": "section-026-5-3-1-tracker-object",
    "to": "claim-5-3-1-tracker-object-default-closed-cancelled-canceled-duplicate-done",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-027-5-3-2-polling-object->claim-5-3-2-polling-object-intervalms-integer:elaborates",
    "from": "section-027-5-3-2-polling-object",
    "to": "claim-5-3-2-polling-object-intervalms-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-027-5-3-2-polling-object->claim-5-3-2-polling-object-default-30000:elaborates",
    "from": "section-027-5-3-2-polling-object",
    "to": "claim-5-3-2-polling-object-default-30000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-027-5-3-2-polling-object->requirement-5-3-2-polling-object-changes-should-be-re-applied-at-runtime-and-affect-future-tick-scheduling-withou:elaborates",
    "from": "section-027-5-3-2-polling-object",
    "to": "requirement-5-3-2-polling-object-changes-should-be-re-applied-at-runtime-and-affect-future-tick-scheduling-withou",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-028-5-3-3-workspace-object->claim-5-3-3-workspace-object-root-path-string-or-var:elaborates",
    "from": "section-028-5-3-3-workspace-object",
    "to": "claim-5-3-3-workspace-object-root-path-string-or-var",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-028-5-3-3-workspace-object->claim-5-3-3-workspace-object-default-system-temp-symphonyworkspaces:elaborates",
    "from": "section-028-5-3-3-workspace-object",
    "to": "claim-5-3-3-workspace-object-default-system-temp-symphonyworkspaces",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-028-5-3-3-workspace-object->claim-5-3-3-workspace-object-is-expanded:elaborates",
    "from": "section-028-5-3-3-workspace-object",
    "to": "claim-5-3-3-workspace-object-is-expanded",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-028-5-3-3-workspace-object->claim-5-3-3-workspace-object-relative-paths-are-resolved-relative-to-the-directory-containing-workflow-md:elaborates",
    "from": "section-028-5-3-3-workspace-object",
    "to": "claim-5-3-3-workspace-object-relative-paths-are-resolved-relative-to-the-directory-containing-workflow-md",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-028-5-3-3-workspace-object->claim-5-3-3-workspace-object-the-effective-workspace-root-is-normalized-to-an-absolute-path-before-use:elaborates",
    "from": "section-028-5-3-3-workspace-object",
    "to": "claim-5-3-3-workspace-object-the-effective-workspace-root-is-normalized-to-an-absolute-path-before-use",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-aftercreate-multiline-shell-script-string-optional:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-aftercreate-multiline-shell-script-string-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-runs-only-when-a-workspace-directory-is-newly-created:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-runs-only-when-a-workspace-directory-is-newly-created",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-failure-aborts-workspace-creation:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-failure-aborts-workspace-creation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-beforerun-multiline-shell-script-string-optional:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-beforerun-multiline-shell-script-string-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-runs-before-each-agent-attempt-after-workspace-preparation-and-before-launching-:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-runs-before-each-agent-attempt-after-workspace-preparation-and-before-launching-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-failure-aborts-the-current-attempt:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-failure-aborts-the-current-attempt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-afterrun-multiline-shell-script-string-optional:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-afterrun-multiline-shell-script-string-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-runs-after-each-agent-attempt-success-failure-timeout-or-cancellation-once-the-w",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-failure-is-logged-but-ignored:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-beforeremove-multiline-shell-script-string-optional:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-beforeremove-multiline-shell-script-string-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-runs-before-workspace-deletion-if-the-directory-exists:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-runs-before-workspace-deletion-if-the-directory-exists",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-failure-is-logged-but-ignored-cleanup-still-proceeds",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-timeoutms-integer-optional:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-timeoutms-integer-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-default-60000:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-default-60000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-applies-to-all-workspace-hooks:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-applies-to-all-workspace-hooks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "claim-5-3-4-hooks-object-invalid-values-fail-configuration-validation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-029-5-3-4-hooks-object->requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions:elaborates",
    "from": "section-029-5-3-4-hooks-object",
    "to": "requirement-5-3-4-hooks-object-changes-should-be-re-applied-at-runtime-for-future-hook-executions",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-maxconcurrentagents-integer:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-maxconcurrentagents-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-default-10:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-default-10",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-subsequent-dispatch-decisions",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-maxturns-positive-integer:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-maxturns-positive-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-default-20:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-default-20",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-limits-the-number-of-coding-agent-turns-within-one-worker-session:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-limits-the-number-of-coding-agent-turns-within-one-worker-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-invalid-values-fail-configuration-validation:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-invalid-values-fail-configuration-validation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-maxretrybackoffms-integer:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-maxretrybackoffms-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-default-300000-5-minutes:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-default-300000-5-minutes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "requirement-5-3-5-agent-object-changes-should-be-re-applied-at-runtime-and-affect-future-retry-scheduling",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-maxconcurrentagentsbystate-map-statename-positive-integer:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-maxconcurrentagentsbystate-map-statename-positive-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-default-empty-map:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-default-empty-map",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-state-keys-are-normalized-lowercase-for-lookup:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-state-keys-are-normalized-lowercase-for-lookup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-030-5-3-5-agent-object->claim-5-3-5-agent-object-invalid-entries-non-positive-or-non-numeric-are-ignored:elaborates",
    "from": "section-030-5-3-5-agent-object",
    "to": "claim-5-3-5-agent-object-invalid-entries-non-positive-or-non-numeric-are-ignored",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->requirement-5-3-6-codex-object-implementors-should-treat-them-as-pass-through-codex-config-values-rather-than-r:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "requirement-5-3-6-codex-object-implementors-should-treat-them-as-pass-through-codex-config-values-rather-than-r",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->requirement-5-3-6-codex-object-implementations-may-validate-these:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "requirement-5-3-6-codex-object-implementations-may-validate-these",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-command-string-shell-command:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-command-string-shell-command",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-codex-app-server:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-the-runtime-launches-this-command-via-bash-lc-in-the-workspace-directory",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "requirement-5-3-6-codex-object-the-launched-process-must-speak-a-compatible-app-server-protocol-over-stdio",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-approvalpolicy-codex-askforapproval-value",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-implementation-defined:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-implementation-defined",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-threadsandbox-codex-sandboxmode-value",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-implementation-defined-2:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-implementation-defined-2",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-turnsandboxpolicy-codex-sandboxpolicy-value",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-implementation-defined-3:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-implementation-defined-3",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-turntimeoutms-integer:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-turntimeoutms-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-3600000-1-hour:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-3600000-1-hour",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-readtimeoutms-integer:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-readtimeoutms-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-5000:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-5000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-stalltimeoutms-integer:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-stalltimeoutms-integer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-default-300000-5-minutes:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-default-300000-5-minutes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-031-5-3-6-codex-object->claim-5-3-6-codex-object-if-0-stall-detection-is-disabled:elaborates",
    "from": "section-031-5-3-6-codex-object",
    "to": "claim-5-3-6-codex-object-if-0-stall-detection-is-disabled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-use-a-strict-template-engine-liquid-compatible-semantics-are-sufficient:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-use-a-strict-template-engine-liquid-compatible-semantics-are-sufficient",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->requirement-5-4-prompt-template-contract-unknown-variables-must-fail-rendering:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "requirement-5-4-prompt-template-contract-unknown-variables-must-fail-rendering",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->requirement-5-4-prompt-template-contract-unknown-filters-must-fail-rendering:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "requirement-5-4-prompt-template-contract-unknown-filters-must-fail-rendering",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-issue-object:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-issue-object",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-includes-all-normalized-issue-fields-including-labels-and-blockers:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-includes-all-normalized-issue-fields-including-labels-and-blockers",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-attempt-integer-or-null:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-attempt-integer-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-null-absent-on-first-attempt:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-null-absent-on-first-attempt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->claim-5-4-prompt-template-contract-integer-on-retry-or-continuation-run:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "claim-5-4-prompt-template-contract-integer-on-retry-or-continuation-run",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->requirement-5-4-prompt-template-contract-if-the-workflow-prompt-body-is-empty-the-runtime-may-use-a-minimal-default-promp:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "requirement-5-4-prompt-template-contract-if-the-workflow-prompt-body-is-empty-the-runtime-may-use-a-minimal-default-promp",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-032-5-4-prompt-template-contract->requirement-5-4-prompt-template-contract-workflow-file-read-parse-failures-are-configuration-validation-errors-and-should:elaborates",
    "from": "section-032-5-4-prompt-template-contract",
    "to": "requirement-5-4-prompt-template-contract-workflow-file-read-parse-failures-are-configuration-validation-errors-and-should",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-missingworkflowfile:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-workflowparseerror:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-workflowparseerror",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-templaterendererror-unknown-variable-filter-invalid-interpolation:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-templaterendererror-unknown-variable-filter-invalid-interpolation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-workflow-file-read-yaml-errors-block-new-dispatches-until-fixed:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-workflow-file-read-yaml-errors-block-new-dispatches-until-fixed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-033-5-5-workflow-validation-and-error-surface->test-5-5-workflow-validation-and-error-surface-template-errors-fail-only-the-affected-run-attempt:elaborates",
    "from": "section-033-5-5-workflow-validation-and-error-surface",
    "to": "test-5-5-workflow-validation-and-error-surface-template-errors-fail-only-the-affected-run-attempt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->requirement-6-1-configuration-resolution-pipeline-apply-built-in-defaults-for-missing-optional-fields:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "requirement-6-1-configuration-resolution-pipeline-apply-built-in-defaults-for-missing-optional-fields",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->claim-6-1-configuration-resolution-pipeline-path-command-fields-support:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "claim-6-1-configuration-resolution-pipeline-path-command-fields-support",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->claim-6-1-configuration-resolution-pipeline-home-expansion:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "claim-6-1-configuration-resolution-pipeline-home-expansion",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->claim-6-1-configuration-resolution-pipeline-var-expansion-for-env-backed-path-values:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "claim-6-1-configuration-resolution-pipeline-var-expansion-for-env-backed-path-values",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->dependency-6-1-configuration-resolution-pipeline-apply-expansion-only-to-values-intended-to-be-local-filesystem-paths-do-not-rewr:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "dependency-6-1-configuration-resolution-pipeline-apply-expansion-only-to-values-intended-to-be-local-filesystem-paths-do-not-rewr",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->claim-6-1-configuration-resolution-pipeline-relative-workspace-root-values-resolve-relative-to-the-directory-containing-the-:elaborates",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "claim-6-1-configuration-resolution-pipeline-relative-workspace-root-values-resolve-relative-to-the-directory-containing-the-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-dynamic-reload-is-required:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-dynamic-reload-is-required",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-the-software-must-detect-workflow-md-changes:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-the-software-must-detect-workflow-md-changes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-on-change-it-must-re-read-and-re-apply-workflow-config-and-prompt-template-witho",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-the-software-must-attempt-to-adjust-live-behavior-to-the-new-config-for-example-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "claim-6-2-dynamic-reload-semantics-reloaded-config-applies-to-future-dispatch-retry-scheduling-reconciliation-decis",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-implementations-are-not-required-to-restart-in-flight-agent-sessions-automatical",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-extensions-that-manage-their-own-listeners-resources-for-example-an-http-server-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-implementations-should-also-re-validate-reload-defensively-during-runtime-operat",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-036-6-2-dynamic-reload-semantics->requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go:elaborates",
    "from": "section-036-6-2-dynamic-reload-semantics",
    "to": "requirement-6-2-dynamic-reload-semantics-invalid-reloads-must-not-crash-the-service-keep-operating-with-the-last-known-go",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-validate-configuration-before-starting-the-scheduling-loop:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-validate-configuration-before-starting-the-scheduling-loop",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-if-startup-validation-fails-fail-startup-and-emit-an-operator-visible-error:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-if-startup-validation-fails-fail-startup-and-emit-an-operator-visible-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-re-validate-before-each-dispatch-cycle:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-re-validate-before-each-dispatch-cycle",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-if-validation-fails-skip-dispatch-for-that-tick-keep-reconciliation-active-and-e:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-if-validation-fails-skip-dispatch-for-that-tick-keep-reconciliation-active-and-e",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-workflow-file-can-be-loaded-and-parsed:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-workflow-file-can-be-loaded-and-parsed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-tracker-kind-is-present-and-supported:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-tracker-kind-is-present-and-supported",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-tracker-apikey-is-present-after-resolution:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-tracker-apikey-is-present-after-resolution",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-tracker-projectslug-is-present-when-required-by-the-selected-tracker-kind:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-tracker-projectslug-is-present-when-required-by-the-selected-tracker-kind",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-037-6-3-dispatch-preflight-validation->test-6-3-dispatch-preflight-validation-codex-command-is-present-and-non-empty:elaborates",
    "from": "section-037-6-3-dispatch-preflight-validation",
    "to": "test-6-3-dispatch-preflight-validation-codex-command-is-present-and-non-empty",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-kind-string-required-currently-linear:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-kind-string-required-currently-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->dependency-6-4-core-config-fields-summary-cheat-sheet-tracker-endpoint-string-default-https-api-linear-app-graphql-when-tracker-kind-l:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "dependency-6-4-core-config-fields-summary-cheat-sheet-tracker-endpoint-string-default-https-api-linear-app-graphql-when-tracker-kind-l",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-tracker-apikey-string-or-var-canonical-env-linearapikey-when-tracker-kind-linear:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-apikey-string-or-var-canonical-env-linearapikey-when-tracker-kind-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-projectslug-string-required-when-tracker-kind-linear:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "requirement-6-4-core-config-fields-summary-cheat-sheet-tracker-projectslug-string-required-when-tracker-kind-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-tracker-activestates-list-of-strings-default-todo-in-progress:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-activestates-list-of-strings-default-todo-in-progress",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-tracker-terminalstates-list-of-strings-default-closed-cancelled-canceled:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-tracker-terminalstates-list-of-strings-default-closed-cancelled-canceled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-polling-intervalms-integer-default-30000:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-polling-intervalms-integer-default-30000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-workspace-root-path-resolved-to-absolute-default-system-temp-symphonyworkspaces:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-workspace-root-path-resolved-to-absolute-default-system-temp-symphonyworkspaces",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-hooks-aftercreate-shell-script-or-null:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-aftercreate-shell-script-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforerun-shell-script-or-null:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforerun-shell-script-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-hooks-afterrun-shell-script-or-null:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-afterrun-shell-script-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforeremove-shell-script-or-null:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-beforeremove-shell-script-or-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-hooks-timeoutms-integer-default-60000:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-hooks-timeoutms-integer-default-60000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagents-integer-default-10:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagents-integer-default-10",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxturns-integer-default-20:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxturns-integer-default-20",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxretrybackoffms-integer-default-300000-5m:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxretrybackoffms-integer-default-300000-5m",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagentsbystate-map-of-positive-integers-default:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-agent-maxconcurrentagentsbystate-map-of-positive-integers-default",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-command-shell-command-string-default-codex-app-server:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-command-shell-command-string-default-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-approvalpolicy-codex-askforapproval-value-default-implementation-defined:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-approvalpolicy-codex-askforapproval-value-default-implementation-defined",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-threadsandbox-codex-sandboxmode-value-default-implementation-defined:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-threadsandbox-codex-sandboxmode-value-default-implementation-defined",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-turnsandboxpolicy-codex-sandboxpolicy-value-default-implementation-defined:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turnsandboxpolicy-codex-sandboxpolicy-value-default-implementation-defined",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-turntimeoutms-integer-default-3600000:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-turntimeoutms-integer-default-3600000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-readtimeoutms-integer-default-5000:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-readtimeoutms-integer-default-5000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-038-6-4-core-config-fields-summary-cheat-sheet->claim-6-4-core-config-fields-summary-cheat-sheet-codex-stalltimeoutms-integer-default-300000:elaborates",
    "from": "section-038-6-4-core-config-fields-summary-cheat-sheet",
    "to": "claim-6-4-core-config-fields-summary-cheat-sheet-codex-stalltimeoutms-integer-default-300000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-issue-is-not-running-and-has-no-retry-scheduled:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-issue-is-not-running-and-has-no-retry-scheduled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-orchestrator-has-reserved-the-issue-to-prevent-duplicate-dispatch:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-orchestrator-has-reserved-the-issue-to-prevent-duplicate-dispatch",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-in-practice-claimed-issues-are-either-running-or-retryqueued:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-in-practice-claimed-issues-are-either-running-or-retryqueued",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-worker-task-exists-and-the-issue-is-tracked-in-running-map:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-worker-task-exists-and-the-issue-is-tracked-in-running-map",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-worker-is-not-running-but-a-retry-timer-exists-in-retryattempts:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-worker-is-not-running-but-a-retry-timer-exists-in-retryattempts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-claim-removed-because-issue-is-terminal-non-active-missing-or-retry-path-complet:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-claim-removed-because-issue-is-terminal-non-active-missing-or-retry-path-complet",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-a-successful-worker-exit-does-not-mean-the-issue-is-done-forever:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-a-successful-worker-exit-does-not-mean-the-issue-is-done-forever",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->claim-7-1-issue-orchestration-states-after-each-normal-turn-completion-the-worker-re-checks-the-tracker-issue-state:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "claim-7-1-issue-orchestration-states-after-each-normal-turn-completion-the-worker-re-checks-the-tracker-issue-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "requirement-7-1-issue-orchestration-states-the-first-turn-should-use-the-full-rendered-task-prompt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "requirement-7-1-issue-orchestration-states-continuation-turns-should-send-only-continuation-guidance-to-the-existing-thread",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-040-7-1-issue-orchestration-states->test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua:elaborates",
    "from": "section-040-7-1-issue-orchestration-states",
    "to": "test-7-1-issue-orchestration-states-once-the-worker-exits-normally-the-orchestrator-still-schedules-a-short-continua",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-poll-tick:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-poll-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-reconcile-active-runs:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-reconcile-active-runs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->test-7-3-transition-triggers-validate-config:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "test-7-3-transition-triggers-validate-config",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-fetch-candidate-issues:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-fetch-candidate-issues",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-dispatch-until-slots-are-exhausted:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-dispatch-until-slots-are-exhausted",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-worker-exit-normal:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-worker-exit-normal",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-remove-running-entry:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-remove-running-entry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-update-aggregate-runtime-totals:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-update-aggregate-runtime-totals",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-schedule-continuation-retry-attempt-1-after-the-worker-exhausts-or-finishes-its-:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-schedule-continuation-retry-attempt-1-after-the-worker-exhausts-or-finishes-its-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-worker-exit-abnormal:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-worker-exit-abnormal",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-remove-running-entry-2:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-remove-running-entry-2",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-update-aggregate-runtime-totals-2:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-update-aggregate-runtime-totals-2",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-schedule-exponential-backoff-retry:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-schedule-exponential-backoff-retry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-codex-update-event:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-codex-update-event",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-update-live-session-fields-token-counters-and-rate-limits:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-update-live-session-fields-token-counters-and-rate-limits",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-retry-timer-fired:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-retry-timer-fired",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-re-fetch-active-candidates-and-attempt-re-dispatch-or-release-claim-if-no-longer:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-re-fetch-active-candidates-and-attempt-re-dispatch-or-release-claim-if-no-longer",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-reconciliation-state-refresh:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-reconciliation-state-refresh",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-stop-runs-whose-issue-states-are-terminal-or-no-longer-active:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-stop-runs-whose-issue-states-are-terminal-or-no-longer-active",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-stall-timeout:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-stall-timeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-042-7-3-transition-triggers->claim-7-3-transition-triggers-kill-worker-and-schedule-retry:elaborates",
    "from": "section-042-7-3-transition-triggers",
    "to": "claim-7-3-transition-triggers-kill-worker-and-schedule-retry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules->risk-7-4-idempotency-and-recovery-rules-the-orchestrator-serializes-state-mutations-through-one-authority-to-avoid-dupli:elaborates",
    "from": "section-043-7-4-idempotency-and-recovery-rules",
    "to": "risk-7-4-idempotency-and-recovery-rules-the-orchestrator-serializes-state-mutations-through-one-authority-to-avoid-dupli",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules->risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker:elaborates",
    "from": "section-043-7-4-idempotency-and-recovery-rules",
    "to": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules->risk-7-4-idempotency-and-recovery-rules-reconciliation-runs-before-dispatch-on-every-tick:elaborates",
    "from": "section-043-7-4-idempotency-and-recovery-rules",
    "to": "risk-7-4-idempotency-and-recovery-rules-reconciliation-runs-before-dispatch-on-every-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules->risk-7-4-idempotency-and-recovery-rules-restart-recovery-is-tracker-driven-and-filesystem-driven-without-a-durable-orche:elaborates",
    "from": "section-043-7-4-idempotency-and-recovery-rules",
    "to": "risk-7-4-idempotency-and-recovery-rules-restart-recovery-is-tracker-driven-and-filesystem-driven-without-a-durable-orche",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-043-7-4-idempotency-and-recovery-rules->risk-7-4-idempotency-and-recovery-rules-startup-terminal-cleanup-removes-stale-workspaces-for-issues-already-in-terminal:elaborates",
    "from": "section-043-7-4-idempotency-and-recovery-rules",
    "to": "risk-7-4-idempotency-and-recovery-rules-startup-terminal-cleanup-removes-stale-workspaces-for-issues-already-in-terminal",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-045-8-1-poll-loop->requirement-8-1-poll-loop-the-effective-poll-interval-should-be-updated-when-workflow-config-changes-are-r:elaborates",
    "from": "section-045-8-1-poll-loop",
    "to": "requirement-8-1-poll-loop-the-effective-poll-interval-should-be-updated-when-workflow-config-changes-are-r",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-it-has-id-identifier-title-and-state:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-it-has-id-identifier-title-and-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-its-state-is-in-activestates-and-not-in-terminalstates:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-its-state-is-in-activestates-and-not-in-terminalstates",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-it-is-not-already-in-running:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-it-is-not-already-in-running",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-it-is-not-already-in-claimed:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-it-is-not-already-in-claimed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-global-concurrency-slots-are-available:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-global-concurrency-slots-are-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-per-state-concurrency-slots-are-available:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-per-state-concurrency-slots-are-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-blocker-rule-for-todo-state-passes:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-blocker-rule-for-todo-state-passes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-046-8-2-candidate-selection-rules->claim-8-2-candidate-selection-rules-if-the-issue-state-is-todo-do-not-dispatch-when-any-blocker-is-non-terminal:elaborates",
    "from": "section-046-8-2-candidate-selection-rules",
    "to": "claim-8-2-candidate-selection-rules-if-the-issue-state-is-todo-do-not-dispatch-when-any-blocker-is-non-terminal",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-047-8-3-concurrency-control->claim-8-3-concurrency-control-availableslots-max-maxconcurrentagents-runningcount-0:elaborates",
    "from": "section-047-8-3-concurrency-control",
    "to": "claim-8-3-concurrency-control-availableslots-max-maxconcurrentagents-runningcount-0",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-047-8-3-concurrency-control->claim-8-3-concurrency-control-maxconcurrentagentsbystate-state-if-present-state-key-normalized:elaborates",
    "from": "section-047-8-3-concurrency-control",
    "to": "claim-8-3-concurrency-control-maxconcurrentagentsbystate-state-if-present-state-key-normalized",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-047-8-3-concurrency-control->claim-8-3-concurrency-control-otherwise-fallback-to-global-limit:elaborates",
    "from": "section-047-8-3-concurrency-control",
    "to": "claim-8-3-concurrency-control-otherwise-fallback-to-global-limit",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-cancel-any-existing-retry-timer-for-the-same-issue:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-cancel-any-existing-retry-timer-for-the-same-issue",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-store-attempt-identifier-error-dueatms-and-new-timer-handle:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-store-attempt-identifier-error-dueatms-and-new-timer-handle",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-normal-continuation-retries-after-a-clean-worker-exit-use-a-short-fixed-delay-of:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-normal-continuation-retries-after-a-clean-worker-exit-use-a-short-fixed-delay-of",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-failure-driven-retries-use-delay-min-10000-2-attempt-1-agent-maxretrybackoffms:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-failure-driven-retries-use-delay-min-10000-2-attempt-1-agent-maxretrybackoffms",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-power-is-capped-by-the-configured-max-retry-backoff-default-300000-5m:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-power-is-capped-by-the-configured-max-retry-backoff-default-300000-5m",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-dispatch-if-slots-are-available:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-dispatch-if-slots-are-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-otherwise-requeue-with-error-no-available-orchestrator-slots:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-otherwise-requeue-with-error-no-available-orchestrator-slots",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-terminal-state-workspace-cleanup-is-handled-by-startup-cleanup-and-active-run-re:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-terminal-state-workspace-cleanup-is-handled-by-startup-cleanup-and-active-run-re",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-048-8-4-retry-and-backoff->claim-8-4-retry-and-backoff-retry-handling-mainly-operates-on-active-candidates-and-releases-claims-when-the:elaborates",
    "from": "section-048-8-4-retry-and-backoff",
    "to": "claim-8-4-retry-and-backoff-retry-handling-mainly-operates-on-active-candidates-and-releases-claims-when-the",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-for-each-running-issue-compute-elapsedms-since:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-for-each-running-issue-compute-elapsedms-since",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-lastcodextimestamp-if-any-event-has-been-seen-else:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-lastcodextimestamp-if-any-event-has-been-seen-else",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-startedat:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-startedat",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-elapsedms-codex-stalltimeoutms-terminate-the-worker-and-queue-a-retry:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-elapsedms-codex-stalltimeoutms-terminate-the-worker-and-queue-a-retry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-stalltimeoutms-0-skip-stall-detection-entirely:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-stalltimeoutms-0-skip-stall-detection-entirely",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-fetch-current-issue-states-for-all-running-issue-ids:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-fetch-current-issue-states-for-all-running-issue-ids",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-for-each-running-issue:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-for-each-running-issue",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-tracker-state-is-terminal-terminate-worker-and-clean-workspace:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-tracker-state-is-terminal-terminate-worker-and-clean-workspace",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-tracker-state-is-still-active-update-the-in-memory-issue-snapshot:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-tracker-state-is-still-active-update-the-in-memory-issue-snapshot",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-tracker-state-is-neither-active-nor-terminal-terminate-worker-without-workspa:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-tracker-state-is-neither-active-nor-terminal-terminate-worker-without-workspa",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-049-8-5-active-run-reconciliation->claim-8-5-active-run-reconciliation-if-state-refresh-fails-keep-workers-running-and-try-again-on-the-next-tick:elaborates",
    "from": "section-049-8-5-active-run-reconciliation",
    "to": "claim-8-5-active-run-reconciliation-if-state-refresh-fails-keep-workers-running-and-try-again-on-the-next-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-052-9-1-workspace-layout->claim-9-1-workspace-layout-workspace-root-normalized-absolute-path:elaborates",
    "from": "section-052-9-1-workspace-layout",
    "to": "claim-9-1-workspace-layout-workspace-root-normalized-absolute-path",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-052-9-1-workspace-layout->claim-9-1-workspace-layout-workspace-root-sanitizedissueidentifier:elaborates",
    "from": "section-052-9-1-workspace-layout",
    "to": "claim-9-1-workspace-layout-workspace-root-sanitizedissueidentifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-052-9-1-workspace-layout->claim-9-1-workspace-layout-workspaces-are-reused-across-runs-for-the-same-issue:elaborates",
    "from": "section-052-9-1-workspace-layout",
    "to": "claim-9-1-workspace-layout-workspaces-are-reused-across-runs-for-the-same-issue",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-052-9-1-workspace-layout->claim-9-1-workspace-layout-successful-runs-do-not-auto-delete-workspaces:elaborates",
    "from": "section-052-9-1-workspace-layout",
    "to": "claim-9-1-workspace-layout-successful-runs-do-not-auto-delete-workspaces",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-053-9-2-workspace-creation-and-reuse->claim-9-2-workspace-creation-and-reuse-this-section-does-not-assume-any-specific-repository-vcs-workflow:elaborates",
    "from": "section-053-9-2-workspace-creation-and-reuse",
    "to": "claim-9-2-workspace-creation-and-reuse-this-section-does-not-assume-any-specific-repository-vcs-workflow",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-053-9-2-workspace-creation-and-reuse->claim-9-2-workspace-creation-and-reuse-workspace-preparation-beyond-directory-creation-for-example-dependency-bootstrap:elaborates",
    "from": "section-053-9-2-workspace-creation-and-reuse",
    "to": "claim-9-2-workspace-creation-and-reuse-workspace-preparation-beyond-directory-creation-for-example-dependency-bootstrap",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined->requirement-9-3-optional-workspace-population-implementation-defined-implementations-may-populate-or-synchronize-the-workspace-using-implementation-d:elaborates",
    "from": "section-054-9-3-optional-workspace-population-implementation-defined",
    "to": "requirement-9-3-optional-workspace-population-implementation-defined-implementations-may-populate-or-synchronize-the-workspace-using-implementation-d",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined->claim-9-3-optional-workspace-population-implementation-defined-workspace-population-synchronization-failures-return-an-error-for-the-current-at:elaborates",
    "from": "section-054-9-3-optional-workspace-population-implementation-defined",
    "to": "claim-9-3-optional-workspace-population-implementation-defined-workspace-population-synchronization-failures-return-an-error-for-the-current-at",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined->requirement-9-3-optional-workspace-population-implementation-defined-if-failure-happens-while-creating-a-brand-new-workspace-implementations-may-remo:elaborates",
    "from": "section-054-9-3-optional-workspace-population-implementation-defined",
    "to": "requirement-9-3-optional-workspace-population-implementation-defined-if-failure-happens-while-creating-a-brand-new-workspace-implementations-may-remo",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined->requirement-9-3-optional-workspace-population-implementation-defined-reused-workspaces-should-not-be-destructively-reset-on-population-failure-unless:elaborates",
    "from": "section-054-9-3-optional-workspace-population-implementation-defined",
    "to": "requirement-9-3-optional-workspace-population-implementation-defined-reused-workspaces-should-not-be-destructively-reset-on-population-failure-unless",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-hooks-aftercreate:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-hooks-aftercreate",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-hooks-beforerun:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-hooks-beforerun",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-hooks-afterrun:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-hooks-afterrun",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-hooks-beforeremove:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-hooks-beforeremove",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->dependency-9-4-workspace-hooks-execute-in-a-local-shell-context-appropriate-to-the-host-os-with-the-workspace-d:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "dependency-9-4-workspace-hooks-execute-in-a-local-shell-context-appropriate-to-the-host-os-with-the-workspace-d",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-on-posix-systems-sh-lc-script-or-a-stricter-equivalent-such-as-bash-lc-script:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-on-posix-systems-sh-lc-script-or-a-stricter-equivalent-such-as-bash-lc-script",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-hook-timeout-uses-hooks-timeoutms-default-60000-ms:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-hook-timeout-uses-hooks-timeoutms-default-60000-ms",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-log-hook-start-failures-and-timeouts:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-log-hook-start-failures-and-timeouts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-beforerun-failure-or-timeout-is-fatal-to-the-current-run-attempt:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-beforerun-failure-or-timeout-is-fatal-to-the-current-run-attempt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-afterrun-failure-or-timeout-is-logged-and-ignored:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-afterrun-failure-or-timeout-is-logged-and-ignored",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-055-9-4-workspace-hooks->claim-9-4-workspace-hooks-beforeremove-failure-or-timeout-is-logged-and-ignored:elaborates",
    "from": "section-055-9-4-workspace-hooks",
    "to": "claim-9-4-workspace-hooks-beforeremove-failure-or-timeout-is-logged-and-ignored",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-before-launching-the-coding-agent-subprocess-validate:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-before-launching-the-coding-agent-subprocess-validate",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-cwd-workspacepath:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-cwd-workspacepath",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-normalize-both-paths-to-absolute:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-normalize-both-paths-to-absolute",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-require-workspacepath-to-have-workspaceroot-as-a-prefix-directory:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-require-workspacepath-to-have-workspaceroot-as-a-prefix-directory",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-reject-any-path-outside-the-workspace-root:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-reject-any-path-outside-the-workspace-root",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-only-a-za-z0-9-allowed-in-workspace-directory-names:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-only-a-za-z0-9-allowed-in-workspace-directory-names",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-056-9-5-safety-invariants->risk-9-5-safety-invariants-replace-all-other-characters-with:elaborates",
    "from": "section-056-9-5-safety-invariants",
    "to": "risk-9-5-safety-invariants-replace-all-other-characters-with",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser:elaborates",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene:elaborates",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro:elaborates",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-057-10-agent-runner-protocol-coding-agent-integration->dependency-10-agent-runner-protocol-coding-agent-integration-symphony-specific-requirements-in-this-section-still-control-orchestration-behav:elaborates",
    "from": "section-057-10-agent-runner-protocol-coding-agent-integration",
    "to": "dependency-10-agent-runner-protocol-coding-agent-integration-symphony-specific-requirements-in-this-section-still-control-orchestration-behav",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->claim-10-1-launch-contract-command-codex-command:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "claim-10-1-launch-contract-command-codex-command",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->claim-10-1-launch-contract-invocation-bash-lc-codex-command:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "claim-10-1-launch-contract-invocation-bash-lc-codex-command",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->claim-10-1-launch-contract-working-directory-workspace-path:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "claim-10-1-launch-contract-working-directory-workspace-path",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->requirement-10-1-launch-contract-transport-framing-the-protocol-transport-required-by-the-targeted-codex-app-serv:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "requirement-10-1-launch-contract-transport-framing-the-protocol-transport-required-by-the-targeted-codex-app-serv",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->claim-10-1-launch-contract-the-default-command-is-codex-app-server:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "claim-10-1-launch-contract-the-default-command-is-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->requirement-10-1-launch-contract-approval-policy-sandbox-policy-cwd-prompt-input-and-optional-tool-declarations-a:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "requirement-10-1-launch-contract-approval-policy-sandbox-policy-cwd-prompt-input-and-optional-tool-declarations-a",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->requirement-10-1-launch-contract-recommended-additional-process-settings:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "requirement-10-1-launch-contract-recommended-additional-process-settings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-058-10-1-launch-contract->claim-10-1-launch-contract-max-line-size-10-mb-for-safe-buffering:elaborates",
    "from": "section-058-10-1-launch-contract",
    "to": "claim-10-1-launch-contract-max-line-size-10-mb-for-safe-buffering",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-start-the-app-server-subprocess-in-the-per-issue-workspace:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-start-the-app-server-subprocess-in-the-per-issue-workspace",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-initialize-the-app-server-session-using-the-targeted-codex-app-server-protocol:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-initialize-the-app-server-session-using-the-targeted-codex-app-server-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-create-or-resume-a-coding-agent-thread-according-to-the-targeted-protocol:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-create-or-resume-a-coding-agent-thread-according-to-the-targeted-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-supply-the-absolute-per-issue-workspace-path-as-the-thread-turn-working-director:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-supply-the-absolute-per-issue-workspace-path-as-the-thread-turn-working-director",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-start-the-first-turn-with-the-rendered-issue-prompt:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-start-the-first-turn-with-the-rendered-issue-prompt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-start-later-in-worker-continuation-turns-on-the-same-live-thread-with-continuati:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-start-later-in-worker-continuation-turns-on-the-same-live-thread-with-continuati",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-supply-the-implementation-s-documented-approval-and-sandbox-policy-using-fields-:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-supply-the-implementation-s-documented-approval-and-sandbox-policy-using-fields-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-include-issue-identifying-metadata-such-as-issue-identifier-issue-title-when-t:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-include-issue-identifying-metadata-such-as-issue-identifier-issue-title-when-t",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-advertise-implemented-client-side-tools-using-the-targeted-protocol:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-advertise-implemented-client-side-tools-using-the-targeted-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-extract-turnid-from-each-turn-identity-returned-by-the-targeted-codex-app-server:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-extract-turnid-from-each-turn-identity-returned-by-the-targeted-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-emit-sessionid-threadid-turnid:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-emit-sessionid-threadid-turnid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-059-10-2-session-startup-responsibilities->claim-10-2-session-startup-responsibilities-reuse-the-same-threadid-for-all-continuation-turns-inside-one-worker-run:elaborates",
    "from": "section-059-10-2-session-startup-responsibilities",
    "to": "claim-10-2-session-startup-responsibilities-reuse-the-same-threadid-for-all-continuation-turns-inside-one-worker-run",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-targeted-protocol-turn-completion-signal-success:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-completion-signal-success",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-subprocess-exit-failure:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-subprocess-exit-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-follow-the-transport-and-framing-rules-of-the-targeted-codex-app-server-version",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-060-10-3-streaming-turn-processing->claim-10-3-streaming-turn-processing-for-stdio-based-transports-keep-protocol-stream-handling-separate-from-diagnosti:elaborates",
    "from": "section-060-10-3-streaming-turn-processing",
    "to": "claim-10-3-streaming-turn-processing-for-stdio-based-transports-keep-protocol-stream-handling-separate-from-diagnosti",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-each-event-should",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-event-enum-string:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-event-enum-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-timestamp-utc-timestamp:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-timestamp-utc-timestamp",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-codexappserverpid-if-available:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-codexappserverpid-if-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-optional-usage-map-token-counts:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "requirement-10-4-emitted-runtime-events-upstream-to-orchestrator-optional-usage-map-token-counts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-payload-fields-as-needed:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-payload-fields-as-needed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-sessionstarted:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-sessionstarted",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-startupfailed:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-startupfailed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncompleted:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncompleted",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnfailed:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnfailed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncancelled:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turncancelled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnendedwitherror:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turnendedwitherror",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turninputrequired:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-turninputrequired",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-approvalautoapproved:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-approvalautoapproved",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-unsupportedtoolcall:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-unsupportedtoolcall",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-notification:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-notification",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-othermessage:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-othermessage",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->claim-10-4-emitted-runtime-events-upstream-to-orchestrator-malformed:elaborates",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "claim-10-4-emitted-runtime-events-upstream-to-orchestrator-malformed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-each-implementation-must-document-its-chosen-approval-sandbox-and-operator-confi",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-approval-requests-and-user-input-required-events-must-not-leave-a-run-stalled-in:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-approval-requests-and-user-input-required-events-must-not-leave-a-run-stalled-in",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-command-execution-approvals-for-the-session:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-command-execution-approvals-for-the-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-file-change-approvals-for-the-session:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-auto-approve-file-change-approvals-for-the-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-treat-user-input-required-turns-as-hard-failure:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-treat-user-input-required-turns-as-hard-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-supported-dynamic-tool-calls-that-are-explicitly-implemented-and-advertised-by-t:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-supported-dynamic-tool-calls-that-are-explicitly-implemented-and-advertised-by-t",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-agent-requests-a-dynamic-tool-call-that-is-not-supported-return-a-tool-fa:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-agent-requests-a-dynamic-tool-call-that-is-not-supported-return-a-tool-fa",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-this-prevents-the-session-from-stalling-on-unsupported-tool-execution-paths:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-this-prevents-the-session-from-stalling-on-unsupported-tool-execution-paths",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-an-implementation-may-expose-a-limited-set-of-client-side-tools-to-the-app-serve",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-current-standardized-optional-tool-lineargraphql:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-current-standardized-optional-tool-lineargraphql",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-if-implemented-supported-tools-should-be-advertised-to-the-app-server-session-du:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-if-implemented-supported-tools-should-be-advertised-to-the-app-server-session-du",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-unsupported-tool-names-should-still-return-a-failure-result-using-the-targeted-p:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-unsupported-tool-names-should-still-return-a-failure-result-using-the-targeted-p",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-purpose-execute-a-raw-graphql-query-or-mutation-against-linear-using-symphony-s-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-purpose-execute-a-raw-graphql-query-or-mutation-against-linear-using-symphony-s-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-availability-only-meaningful-when-tracker-kind-linear-and-valid-linear-auth-is:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-availability-only-meaningful-when-tracker-kind-linear-and-valid-linear-auth-is",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-preferred-input-shape:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-preferred-input-shape",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-be-a-non-empty-string:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-be-a-non-empty-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-contain-exactly-one-graphql-operation:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-query-must-contain-exactly-one-graphql-operation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-variables-is-optional-and-when-present-must-be-a-json-object:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-variables-is-optional-and-when-present-must-be-a-json-object",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-may-additionally-accept-a-raw-graphql-query-string-as-shorthand-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-may-additionally-accept-a-raw-graphql-query-string-as-shorthand-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-execute-one-graphql-operation-per-tool-call:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-execute-one-graphql-operation-per-tool-call",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-provided-document-contains-multiple-operations-reject-the-tool-call-as-in:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-if-the-provided-document-contains-multiple-operations-reject-the-tool-call-as-in",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-operationname-selection-is-intentionally-out-of-scope-for-this-extension:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-operationname-selection-is-intentionally-out-of-scope-for-this-extension",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-reuse-the-configured-linear-endpoint-and-auth-from-the-active-symphony-workflow-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-reuse-the-configured-linear-endpoint-and-auth-from-the-active-symphony-workflow-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-tool-result-semantics:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-tool-result-semantics",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-transport-success-no-top-level-graphql-errors-success-true:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-transport-success-no-top-level-graphql-errors-success-true",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-top-level-graphql-errors-present-success-false-but-preserve-the-graphql-response:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-top-level-graphql-errors-present-success-false-but-preserve-the-graphql-response",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->claim-10-5-approval-tool-calls-and-user-input-policy-invalid-input-missing-auth-or-transport-failure-success-false-with-an-error-payl:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "claim-10-5-approval-tool-calls-and-user-input-policy-invalid-input-missing-auth-or-transport-failure-success-false-with-an-error-payl",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->dependency-10-5-approval-tool-calls-and-user-input-policy-return-the-graphql-response-or-error-payload-as-structured-tool-output-that-the-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "dependency-10-5-approval-tool-calls-and-user-input-policy-return-the-graphql-response-or-error-payload-as-structured-tool-output-that-the-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-implementations-must-document-how-targeted-protocol-user-input-required-signals-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-a-run-must-not-stall-indefinitely-waiting-for-user-input:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-a-run-must-not-stall-indefinitely-waiting-for-user-input",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-a-conforming-implementation-may-fail-the-run-surface-the-request-to-an-operator-:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-a-conforming-implementation-may-fail-the-run-surface-the-request-to-an-operator-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-062-10-5-approval-tool-calls-and-user-input-policy->requirement-10-5-approval-tool-calls-and-user-input-policy-the-example-high-trust-behavior-above-fails-user-input-required-turns-immediatel:elaborates",
    "from": "section-062-10-5-approval-tool-calls-and-user-input-policy",
    "to": "requirement-10-5-approval-tool-calls-and-user-input-policy-the-example-high-trust-behavior-above-fails-user-input-required-turns-immediatel",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-codex-readtimeoutms-request-response-timeout-during-startup-and-sync-requests",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-codex-turntimeoutms-total-turn-stream-timeout:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-codex-turntimeoutms-total-turn-stream-timeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-codex-stalltimeoutms-enforced-by-orchestrator-based-on-event-inactivity:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-codex-stalltimeoutms-enforced-by-orchestrator-based-on-event-inactivity",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->requirement-10-6-timeouts-and-error-mapping-error-mapping-recommended-normalized-categories:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "requirement-10-6-timeouts-and-error-mapping-error-mapping-recommended-normalized-categories",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-codexnotfound:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-codexnotfound",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-invalidworkspacecwd:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-invalidworkspacecwd",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-responsetimeout:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-responsetimeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-turntimeout:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-turntimeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-portexit:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-portexit",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-responseerror:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-responseerror",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-turnfailed:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-turnfailed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-turncancelled:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-turncancelled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-063-10-6-timeouts-and-error-mapping->claim-10-6-timeouts-and-error-mapping-turninputrequired:elaborates",
    "from": "section-063-10-6-timeouts-and-error-mapping",
    "to": "claim-10-6-timeouts-and-error-mapping-turninputrequired",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-064-10-7-agent-runner-contract->claim-10-7-agent-runner-contract-workspaces-are-intentionally-preserved-after-successful-runs:elaborates",
    "from": "section-064-10-7-agent-runner-contract",
    "to": "claim-10-7-agent-runner-contract-workspaces-are-intentionally-preserved-after-successful-runs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-066-11-1-required-operations->requirement-11-1-required-operations-an-implementation-must-support-these-tracker-adapter-operations:elaborates",
    "from": "section-066-11-1-required-operations",
    "to": "requirement-11-1-required-operations-an-implementation-must-support-these-tracker-adapter-operations",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-066-11-1-required-operations->claim-11-1-required-operations-return-issues-in-configured-active-states-for-a-configured-project:elaborates",
    "from": "section-066-11-1-required-operations",
    "to": "claim-11-1-required-operations-return-issues-in-configured-active-states-for-a-configured-project",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-066-11-1-required-operations->claim-11-1-required-operations-used-for-startup-terminal-cleanup:elaborates",
    "from": "section-066-11-1-required-operations",
    "to": "claim-11-1-required-operations-used-for-startup-terminal-cleanup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-066-11-1-required-operations->claim-11-1-required-operations-used-for-active-run-reconciliation:elaborates",
    "from": "section-066-11-1-required-operations",
    "to": "claim-11-1-required-operations-used-for-active-run-reconciliation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-tracker-kind-linear:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-tracker-kind-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-auth-token-sent-in-authorization-header:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-auth-token-sent-in-authorization-header",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-tracker-projectslug-maps-to-linear-project-slugid:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-tracker-projectslug-maps-to-linear-project-slugid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-candidate-issue-query-filters-project-using-project-slugid-eq-projectslug:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-candidate-issue-query-filters-project-using-project-slugid-eq-projectslug",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->requirement-11-2-query-semantics-linear-pagination-required-for-candidate-issues:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "requirement-11-2-query-semantics-linear-pagination-required-for-candidate-issues",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-page-size-default-50:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-page-size-default-50",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->claim-11-2-query-semantics-linear-network-timeout-30000-ms:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "claim-11-2-query-semantics-linear-network-timeout-30000-ms",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->requirement-11-2-query-semantics-linear-linear-graphql-schema-details-can-drift-keep-query-construction-isolated-and-tes:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "requirement-11-2-query-semantics-linear-linear-graphql-schema-details-can-drift-keep-query-construction-isolated-and-tes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-067-11-2-query-semantics-linear->requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp:elaborates",
    "from": "section-067-11-2-query-semantics-linear",
    "to": "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-068-11-3-normalization-rules->requirement-11-3-normalization-rules-candidate-issue-normalization-should-produce-fields-listed-in-section-4-1-1:elaborates",
    "from": "section-068-11-3-normalization-rules",
    "to": "requirement-11-3-normalization-rules-candidate-issue-normalization-should-produce-fields-listed-in-section-4-1-1",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-068-11-3-normalization-rules->claim-11-3-normalization-rules-labels-lowercase-strings:elaborates",
    "from": "section-068-11-3-normalization-rules",
    "to": "claim-11-3-normalization-rules-labels-lowercase-strings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-068-11-3-normalization-rules->claim-11-3-normalization-rules-blockedby-derived-from-inverse-relations-where-relation-type-is-blocks:elaborates",
    "from": "section-068-11-3-normalization-rules",
    "to": "claim-11-3-normalization-rules-blockedby-derived-from-inverse-relations-where-relation-type-is-blocks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-068-11-3-normalization-rules->claim-11-3-normalization-rules-priority-integer-only-non-integers-become-null:elaborates",
    "from": "section-068-11-3-normalization-rules",
    "to": "claim-11-3-normalization-rules-priority-integer-only-non-integers-become-null",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-068-11-3-normalization-rules->claim-11-3-normalization-rules-createdat-and-updatedat-parse-iso-8601-timestamps:elaborates",
    "from": "section-068-11-3-normalization-rules",
    "to": "claim-11-3-normalization-rules-createdat-and-updatedat-parse-iso-8601-timestamps",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->requirement-11-4-error-handling-contract-recommended-error-categories:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "requirement-11-4-error-handling-contract-recommended-error-categories",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-unsupportedtrackerkind:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-unsupportedtrackerkind",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-missingtrackerapikey:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-missingtrackerapikey",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-missingtrackerprojectslug:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-missingtrackerprojectslug",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-linearapirequest-transport-failures:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-linearapirequest-transport-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-linearapistatus-non-200-http:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-linearapistatus-non-200-http",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-lineargraphqlerrors:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-lineargraphqlerrors",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-linearunknownpayload:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-linearunknownpayload",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-linearmissingendcursor-pagination-integrity-error:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-linearmissingendcursor-pagination-integrity-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-candidate-fetch-failure-log-and-skip-dispatch-for-this-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-running-state-refresh-failure-log-and-keep-active-workers-running",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-069-11-4-error-handling-contract->claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup:elaborates",
    "from": "section-069-11-4-error-handling-contract",
    "to": "claim-11-4-error-handling-contract-startup-terminal-cleanup-failure-log-warning-and-continue-startup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-070-11-5-tracker-writes-important-boundary->claim-11-5-tracker-writes-important-boundary-ticket-mutations-state-transitions-comments-pr-metadata-are-typically-handled-by:elaborates",
    "from": "section-070-11-5-tracker-writes-important-boundary",
    "to": "claim-11-5-tracker-writes-important-boundary-ticket-mutations-state-transitions-comments-pr-metadata-are-typically-handled-by",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-070-11-5-tracker-writes-important-boundary->claim-11-5-tracker-writes-important-boundary-the-service-remains-a-scheduler-runner-and-tracker-reader:elaborates",
    "from": "section-070-11-5-tracker-writes-important-boundary",
    "to": "claim-11-5-tracker-writes-important-boundary-the-service-remains-a-scheduler-runner-and-tracker-reader",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-070-11-5-tracker-writes-important-boundary->claim-11-5-tracker-writes-important-boundary-workflow-specific-success-often-means-reached-the-next-handoff-state-for-example:elaborates",
    "from": "section-070-11-5-tracker-writes-important-boundary",
    "to": "claim-11-5-tracker-writes-important-boundary-workflow-specific-success-often-means-reached-the-next-handoff-state-for-example",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-070-11-5-tracker-writes-important-boundary->dependency-11-5-tracker-writes-important-boundary-if-the-lineargraphql-client-side-tool-extension-is-implemented-it-is-still-part-:elaborates",
    "from": "section-070-11-5-tracker-writes-important-boundary",
    "to": "dependency-11-5-tracker-writes-important-boundary-if-the-lineargraphql-client-side-tool-extension-is-implemented-it-is-still-part-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-072-12-1-inputs->claim-12-1-inputs-workflow-prompttemplate:elaborates",
    "from": "section-072-12-1-inputs",
    "to": "claim-12-1-inputs-workflow-prompttemplate",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-072-12-1-inputs->claim-12-1-inputs-normalized-issue-object:elaborates",
    "from": "section-072-12-1-inputs",
    "to": "claim-12-1-inputs-normalized-issue-object",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-072-12-1-inputs->requirement-12-1-inputs-optional-attempt-integer-retry-continuation-metadata:elaborates",
    "from": "section-072-12-1-inputs",
    "to": "requirement-12-1-inputs-optional-attempt-integer-retry-continuation-metadata",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-073-12-2-rendering-rules->claim-12-2-rendering-rules-render-with-strict-variable-checking:elaborates",
    "from": "section-073-12-2-rendering-rules",
    "to": "claim-12-2-rendering-rules-render-with-strict-variable-checking",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-073-12-2-rendering-rules->claim-12-2-rendering-rules-render-with-strict-filter-checking:elaborates",
    "from": "section-073-12-2-rendering-rules",
    "to": "claim-12-2-rendering-rules-render-with-strict-filter-checking",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-073-12-2-rendering-rules->claim-12-2-rendering-rules-convert-issue-object-keys-to-strings-for-template-compatibility:elaborates",
    "from": "section-073-12-2-rendering-rules",
    "to": "claim-12-2-rendering-rules-convert-issue-object-keys-to-strings-for-template-compatibility",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-073-12-2-rendering-rules->claim-12-2-rendering-rules-preserve-nested-arrays-maps-labels-blockers-so-templates-can-iterate:elaborates",
    "from": "section-073-12-2-rendering-rules",
    "to": "claim-12-2-rendering-rules-preserve-nested-arrays-maps-labels-blockers-so-templates-can-iterate",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-074-12-3-retry-continuation-semantics->requirement-12-3-retry-continuation-semantics-attempt-should-be-passed-to-the-template-because-the-workflow-prompt-can-provide:elaborates",
    "from": "section-074-12-3-retry-continuation-semantics",
    "to": "requirement-12-3-retry-continuation-semantics-attempt-should-be-passed-to-the-template-because-the-workflow-prompt-can-provide",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-074-12-3-retry-continuation-semantics->claim-12-3-retry-continuation-semantics-first-run-attempt-null-or-absent:elaborates",
    "from": "section-074-12-3-retry-continuation-semantics",
    "to": "claim-12-3-retry-continuation-semantics-first-run-attempt-null-or-absent",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-074-12-3-retry-continuation-semantics->claim-12-3-retry-continuation-semantics-continuation-run-after-a-successful-prior-session:elaborates",
    "from": "section-074-12-3-retry-continuation-semantics",
    "to": "claim-12-3-retry-continuation-semantics-continuation-run-after-a-successful-prior-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-074-12-3-retry-continuation-semantics->claim-12-3-retry-continuation-semantics-retry-after-error-timeout-stall:elaborates",
    "from": "section-074-12-3-retry-continuation-semantics",
    "to": "claim-12-3-retry-continuation-semantics-retry-after-error-timeout-stall",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-075-12-4-failure-semantics->risk-12-4-failure-semantics-fail-the-run-attempt-immediately:elaborates",
    "from": "section-075-12-4-failure-semantics",
    "to": "risk-12-4-failure-semantics-fail-the-run-attempt-immediately",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-075-12-4-failure-semantics->risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh:elaborates",
    "from": "section-075-12-4-failure-semantics",
    "to": "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->requirement-13-1-logging-conventions-required-context-fields-for-issue-related-logs:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "requirement-13-1-logging-conventions-required-context-fields-for-issue-related-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-issueid:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-issueid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-issueidentifier:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-issueidentifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->requirement-13-1-logging-conventions-required-context-for-coding-agent-session-lifecycle-logs:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "requirement-13-1-logging-conventions-required-context-for-coding-agent-session-lifecycle-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-sessionid:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-sessionid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-use-stable-key-value-phrasing:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-use-stable-key-value-phrasing",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-include-action-outcome-completed-failed-retrying-etc:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-include-action-outcome-completed-failed-retrying-etc",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-include-concise-failure-reason-when-present:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-include-concise-failure-reason-when-present",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-077-13-1-logging-conventions->claim-13-1-logging-conventions-avoid-logging-large-raw-payloads-unless-necessary:elaborates",
    "from": "section-077-13-1-logging-conventions",
    "to": "claim-13-1-logging-conventions-avoid-logging-large-raw-payloads-unless-necessary",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-078-13-2-logging-outputs-and-sinks->requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac:elaborates",
    "from": "section-078-13-2-logging-outputs-and-sinks",
    "to": "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-078-13-2-logging-outputs-and-sinks->requirement-13-2-logging-outputs-and-sinks-implementations-may-write-to-one-or-more-sinks:elaborates",
    "from": "section-078-13-2-logging-outputs-and-sinks",
    "to": "requirement-13-2-logging-outputs-and-sinks-implementations-may-write-to-one-or-more-sinks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-078-13-2-logging-outputs-and-sinks->requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible:elaborates",
    "from": "section-078-13-2-logging-outputs-and-sinks",
    "to": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-should-return:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-should-return",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-running-list-of-running-session-rows:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-running-list-of-running-session-rows",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-each-running-row-should-include-turncount:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-each-running-row-should-include-turncount",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-retrying-list-of-retry-queue-rows:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-retrying-list-of-retry-queue-rows",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-codextotals:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-codextotals",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-inputtokens:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-inputtokens",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-outputtokens:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-outputtokens",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-totaltokens:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-totaltokens",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-secondsrunning-aggregate-runtime-seconds-as-of-snapshot-time-including-active-se:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-secondsrunning-aggregate-runtime-seconds-as-of-snapshot-time-including-active-se",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-ratelimits-latest-coding-agent-rate-limit-payload-if-available:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-ratelimits-latest-coding-agent-rate-limit-payload-if-available",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-recommended-snapshot-error-modes:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-recommended-snapshot-error-modes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-timeout:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-timeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-unavailable:elaborates",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-unavailable",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-080-13-4-optional-human-readable-status-surface->requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and:elaborates",
    "from": "section-080-13-4-optional-human-readable-status-surface",
    "to": "requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-080-13-4-optional-human-readable-status-surface->requirement-13-4-optional-human-readable-status-surface-if-present-it-should-draw-from-orchestrator-state-metrics-only-and-must-not-be-r:elaborates",
    "from": "section-080-13-4-optional-human-readable-status-surface",
    "to": "requirement-13-4-optional-human-readable-status-surface-if-present-it-should-draw-from-orchestrator-state-metrics-only-and-must-not-be-r",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-agent-events-can-include-token-counts-in-multiple-payload-shapes:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-agent-events-can-include-token-counts-in-multiple-payload-shapes",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-prefer-absolute-thread-totals-when-available-such-as:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-prefer-absolute-thread-totals-when-available-such-as",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-thread-tokenusage-updated-payloads:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-thread-tokenusage-updated-payloads",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-totaltokenusage-within-token-count-wrapper-events:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-totaltokenusage-within-token-count-wrapper-events",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "dependency-13-5-session-metrics-and-token-accounting-ignore-delta-style-payloads-such-as-lasttokenusage-for-dashboard-api-totals",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-extract-input-output-total-token-counts-leniently-from-common-field-names-within",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-for-absolute-totals-track-deltas-relative-to-last-reported-totals-to-avoid-doubl:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-for-absolute-totals-track-deltas-relative-to-last-reported-totals-to-avoid-doubl",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-do-not-treat-generic-usage-maps-as-cumulative-totals-unless-the-event-type-defin",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-accumulate-aggregate-totals-in-orchestrator-state:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-accumulate-aggregate-totals-in-orchestrator-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->requirement-13-5-session-metrics-and-token-accounting-runtime-should-be-reported-as-a-live-aggregate-at-snapshot-render-time:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "requirement-13-5-session-metrics-and-token-accounting-runtime-should-be-reported-as-a-live-aggregate-at-snapshot-render-time",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->requirement-13-5-session-metrics-and-token-accounting-implementations-may-maintain-a-cumulative-counter-for-ended-sessions-and-add-act:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "requirement-13-5-session-metrics-and-token-accounting-implementations-may-maintain-a-cumulative-counter-for-ended-sessions-and-add-act",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-add-run-duration-seconds-to-the-cumulative-ended-session-runtime-when-a-session-:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-add-run-duration-seconds-to-the-cumulative-ended-session-runtime-when-a-session-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->requirement-13-5-session-metrics-and-token-accounting-continuous-background-ticking-of-runtime-totals-is-not-required:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "requirement-13-5-session-metrics-and-token-accounting-continuous-background-ticking-of-runtime-totals-is-not-required",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-track-the-latest-rate-limit-payload-seen-in-any-agent-update:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-track-the-latest-rate-limit-payload-seen-in-any-agent-update",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-081-13-5-session-metrics-and-token-accounting->claim-13-5-session-metrics-and-token-accounting-any-human-readable-presentation-of-rate-limit-data-is-implementation-defined:elaborates",
    "from": "section-081-13-5-session-metrics-and-token-accounting",
    "to": "claim-13-5-session-metrics-and-token-accounting-any-human-readable-presentation-of-rate-limit-data-is-implementation-defined",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-082-13-6-humanized-agent-event-summaries-optional->requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional:elaborates",
    "from": "section-082-13-6-humanized-agent-event-summaries-optional",
    "to": "requirement-13-6-humanized-agent-event-summaries-optional-humanized-summaries-of-raw-agent-protocol-events-are-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-082-13-6-humanized-agent-event-summaries-optional->claim-13-6-humanized-agent-event-summaries-optional-treat-them-as-observability-only-output:elaborates",
    "from": "section-082-13-6-humanized-agent-event-summaries-optional",
    "to": "claim-13-6-humanized-agent-event-summaries-optional-treat-them-as-observability-only-output",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-082-13-6-humanized-agent-event-summaries-optional->claim-13-6-humanized-agent-event-summaries-optional-do-not-make-orchestrator-logic-depend-on-humanized-strings:elaborates",
    "from": "section-082-13-6-humanized-agent-event-summaries-optional",
    "to": "claim-13-6-humanized-agent-event-summaries-optional-do-not-make-orchestrator-logic-depend-on-humanized-strings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-this-section-defines-an-optional-http-interface-for-observability-and-operationa:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-this-section-defines-an-optional-http-interface-for-observability-and-operationa",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-the-http-server-is-an-extension-and-is-not-required-for-conformance",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-the-implementation-may-serve-server-rendered-html-or-a-client-side-application-f:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-the-implementation-may-serve-server-rendered-html-or-a-client-side-application-f",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-the-dashboard-api-must-be-observability-control-surfaces-only-and-must-not-becom:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-the-dashboard-api-must-be-observability-control-surfaces-only-and-must-not-becom",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-server-port-integer-optional:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-server-port-integer-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->claim-13-7-optional-http-server-extension-enables-the-http-server-extension:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "claim-13-7-optional-http-server-extension-enables-the-http-server-extension",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->claim-13-7-optional-http-server-extension-0-requests-an-ephemeral-port-for-local-development-and-tests:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "claim-13-7-optional-http-server-extension-0-requests-an-ephemeral-port-for-local-development-and-tests",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->dependency-13-7-optional-http-server-extension-cli-port-overrides-server-port-when-both-are-present:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "dependency-13-7-optional-http-server-extension-cli-port-overrides-server-port-when-both-are-present",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->dependency-13-7-optional-http-server-extension-start-the-http-server-when-a-cli-port-argument-is-provided:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "dependency-13-7-optional-http-server-extension-start-the-http-server-when-a-cli-port-argument-is-provided",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->claim-13-7-optional-http-server-extension-start-the-http-server-when-server-port-is-present-in-workflow-md-front-matter:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "claim-13-7-optional-http-server-extension-start-the-http-server-when-server-port-is-present-in-workflow-md-front-matter",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->claim-13-7-optional-http-server-extension-the-server-top-level-key-is-owned-by-this-extension:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "claim-13-7-optional-http-server-extension-the-server-top-level-key-is-owned-by-this-extension",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->claim-13-7-optional-http-server-extension-positive-server-port-values-bind-that-port:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "claim-13-7-optional-http-server-extension-positive-server-port-values-bind-that-port",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-implementations-should-bind-loopback-by-default-127-0-0-1-or-host-equivalent-unl:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-implementations-should-bind-loopback-by-default-127-0-0-1-or-host-equivalent-unl",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->requirement-13-7-optional-http-server-extension-changes-to-http-listener-settings-for-example-server-port-do-not-need-to-hot-reb:elaborates",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "requirement-13-7-optional-http-server-extension-changes-to-http-listener-settings-for-example-server-port-do-not-need-to-hot-reb",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-084-13-7-1-human-readable-dashboard->dependency-13-7-1-human-readable-dashboard-host-a-human-readable-dashboard-at:elaborates",
    "from": "section-084-13-7-1-human-readable-dashboard",
    "to": "dependency-13-7-1-human-readable-dashboard-host-a-human-readable-dashboard-at",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-084-13-7-1-human-readable-dashboard->requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-:elaborates",
    "from": "section-084-13-7-1-human-readable-dashboard",
    "to": "requirement-13-7-1-human-readable-dashboard-the-returned-document-should-depict-the-current-state-of-the-system-for-example-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-084-13-7-1-human-readable-dashboard->dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client:elaborates",
    "from": "section-084-13-7-1-human-readable-dashboard",
    "to": "dependency-13-7-1-human-readable-dashboard-it-is-up-to-the-implementation-whether-this-is-server-generated-html-or-a-client",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-get-api-v1-state:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-returns-a-summary-view-of-the-current-system-state-running-sessions-retry-queue-:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-returns-a-summary-view-of-the-current-system-state-running-sessions-retry-queue-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-get-api-v1-issueidentifier:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-get-api-v1-issueidentifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-returns-issue-specific-runtime-debug-details-for-the-identified-issue-including-:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-returns-issue-specific-runtime-debug-details-for-the-identified-issue-including-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-shape-2",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-if-the-issue-is-unknown-to-the-current-in-memory-state-return-404-with-an-error-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-post-api-v1-refresh:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-post-api-v1-refresh",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-queues-an-immediate-tracker-poll-reconciliation-cycle-best-effort-trigger-implem:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-queues-an-immediate-tracker-poll-reconciliation-cycle-best-effort-trigger-implem",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-suggested-request-body-empty-body-or:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-suggested-request-body-empty-body-or",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-suggested-response-202-accepted-shape:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-suggested-response-202-accepted-shape",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-the-json-shapes-above-are-the-recommended-baseline-for-interoperability-and-debu",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-implementations-may-add-fields-but-should-avoid-breaking-existing-fields-within-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-endpoints-should-be-read-only-except-for-operational-triggers-like-refresh",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-unsupported-methods-on-defined-routes-should-return-405-method-not-allowed",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-api-errors-should-use-a-json-envelope-such-as-error-code-message",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-085-13-7-2-json-rest-api-api-v1->dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup:elaborates",
    "from": "section-085-13-7-2-json-rest-api-api-v1",
    "to": "dependency-13-7-2-json-rest-api-api-v1-if-the-dashboard-is-a-client-side-app-it-should-consume-this-api-rather-than-dup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-missing-workflow-md:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-missing-workflow-md",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-invalid-yaml-front-matter:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-invalid-yaml-front-matter",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-unsupported-tracker-kind-or-missing-tracker-credentials-project-slug:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-unsupported-tracker-kind-or-missing-tracker-credentials-project-slug",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-missing-coding-agent-executable:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-missing-coding-agent-executable",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-workspace-directory-creation-failure:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-workspace-directory-creation-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-workspace-population-synchronization-failure-implementation-defined-can-come-fro",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-invalid-workspace-path-configuration:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-invalid-workspace-path-configuration",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-hook-timeout-failure:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-hook-timeout-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-startup-handshake-failure:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-startup-handshake-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-turn-failed-cancelled:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-turn-failed-cancelled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-turn-timeout:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-turn-timeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-user-input-requested-and-handled-as-failure-by-the-implementation-s-documented-p",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-subprocess-exit:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-subprocess-exit",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-stalled-session-no-activity:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-stalled-session-no-activity",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-api-transport-errors:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-api-transport-errors",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-non-200-status:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-non-200-status",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-graphql-errors:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-graphql-errors",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-malformed-payloads:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-malformed-payloads",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-snapshot-timeout:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-snapshot-timeout",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-dashboard-render-errors:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-dashboard-render-errors",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-087-14-1-failure-classes->risk-14-1-failure-classes-log-sink-configuration-failure:elaborates",
    "from": "section-087-14-1-failure-classes",
    "to": "risk-14-1-failure-classes-log-sink-configuration-failure",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-dispatch-validation-failures:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-dispatch-validation-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-skip-new-dispatches:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-skip-new-dispatches",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-keep-service-alive:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-keep-service-alive",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-continue-reconciliation-where-possible:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-continue-reconciliation-where-possible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-worker-failures:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-worker-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-convert-to-retries-with-exponential-backoff:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-convert-to-retries-with-exponential-backoff",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-tracker-candidate-fetch-failures:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-tracker-candidate-fetch-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-skip-this-tick:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-skip-this-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-try-again-on-next-tick:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-try-again-on-next-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-reconciliation-state-refresh-failures:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-reconciliation-state-refresh-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-keep-current-workers:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-keep-current-workers",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-retry-on-next-tick:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-retry-on-next-tick",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-dashboard-log-failures:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-dashboard-log-failures",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-088-14-2-recovery-behavior->risk-14-2-recovery-behavior-do-not-crash-the-orchestrator:elaborates",
    "from": "section-088-14-2-recovery-behavior",
    "to": "risk-14-2-recovery-behavior-do-not-crash-the-orchestrator",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-no-retry-timers-are-restored-from-prior-process-memory:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-no-retry-timers-are-restored-from-prior-process-memory",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-no-running-sessions-are-assumed-recoverable:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-no-running-sessions-are-assumed-recoverable",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-service-recovers-by:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-service-recovers-by",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-startup-terminal-workspace-cleanup:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-startup-terminal-workspace-cleanup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-fresh-polling-of-active-issues:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-fresh-polling-of-active-issues",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-089-14-3-partial-state-recovery-restart->risk-14-3-partial-state-recovery-restart-re-dispatching-eligible-work:elaborates",
    "from": "section-089-14-3-partial-state-recovery-restart",
    "to": "risk-14-3-partial-state-recovery-restart-re-dispatching-eligible-work",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-editing-workflow-md-prompt-and-most-runtime-settings:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-editing-workflow-md-prompt-and-most-runtime-settings",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-workflow-md-changes-are-detected-and-re-applied-automatically-without-restart-ac:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-workflow-md-changes-are-detected-and-re-applied-automatically-without-restart-ac",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-changing-issue-states-in-the-tracker:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-changing-issue-states-in-the-tracker",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-terminal-state-running-session-is-stopped-and-workspace-cleaned-when-reconciled:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-terminal-state-running-session-is-stopped-and-workspace-cleaned-when-reconciled",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-non-active-state-running-session-is-stopped-without-cleanup:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-non-active-state-running-session-is-stopped-without-cleanup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-090-14-4-operator-intervention-points->claim-14-4-operator-intervention-points-restarting-the-service-for-process-recovery-or-deployment-not-as-the-normal-path:elaborates",
    "from": "section-090-14-4-operator-intervention-points",
    "to": "claim-14-4-operator-intervention-points-restarting-the-service-for-process-recovery-or-deployment-not-as-the-normal-path",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-092-15-1-trust-boundary-assumption->risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir:elaborates",
    "from": "section-092-15-1-trust-boundary-assumption",
    "to": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-092-15-1-trust-boundary-assumption->risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-rely-on-auto-approved-actions-:elaborates",
    "from": "section-092-15-1-trust-boundary-assumption",
    "to": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-rely-on-auto-approved-actions-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-092-15-1-trust-boundary-assumption->risk-15-1-trust-boundary-assumption-workspace-isolation-and-path-validation-are-important-baseline-controls-but-they:elaborates",
    "from": "section-092-15-1-trust-boundary-assumption",
    "to": "risk-15-1-trust-boundary-assumption-workspace-isolation-and-path-validation-are-important-baseline-controls-but-they",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-workspace-path-must-remain-under-configured-workspace-root:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-workspace-path-must-remain-under-configured-workspace-root",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-coding-agent-cwd-must-be-the-per-issue-workspace-path-for-the-current-run:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-coding-agent-cwd-must-be-the-per-issue-workspace-path-for-the-current-run",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-workspace-directory-names-must-use-sanitized-identifiers:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-workspace-directory-names-must-use-sanitized-identifiers",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-recommended-additional-hardening-for-ports:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-recommended-additional-hardening-for-ports",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-run-under-a-dedicated-os-user:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-run-under-a-dedicated-os-user",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-restrict-workspace-root-permissions:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-restrict-workspace-root-permissions",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-093-15-2-filesystem-safety-requirements->risk-15-2-filesystem-safety-requirements-mount-workspace-root-on-a-dedicated-volume-if-possible:elaborates",
    "from": "section-093-15-2-filesystem-safety-requirements",
    "to": "risk-15-2-filesystem-safety-requirements-mount-workspace-root-on-a-dedicated-volume-if-possible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-094-15-3-secret-handling->claim-15-3-secret-handling-support-var-indirection-in-workflow-config:elaborates",
    "from": "section-094-15-3-secret-handling",
    "to": "claim-15-3-secret-handling-support-var-indirection-in-workflow-config",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-094-15-3-secret-handling->dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values:elaborates",
    "from": "section-094-15-3-secret-handling",
    "to": "dependency-15-3-secret-handling-do-not-log-api-tokens-or-secret-env-values",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-094-15-3-secret-handling->test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them:elaborates",
    "from": "section-094-15-3-secret-handling",
    "to": "test-15-3-secret-handling-validate-presence-of-secrets-without-printing-them",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-095-15-4-hook-script-safety->risk-15-4-hook-script-safety-hooks-are-fully-trusted-configuration:elaborates",
    "from": "section-095-15-4-hook-script-safety",
    "to": "risk-15-4-hook-script-safety-hooks-are-fully-trusted-configuration",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-095-15-4-hook-script-safety->risk-15-4-hook-script-safety-hooks-run-inside-the-workspace-directory:elaborates",
    "from": "section-095-15-4-hook-script-safety",
    "to": "risk-15-4-hook-script-safety-hooks-run-inside-the-workspace-directory",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-095-15-4-hook-script-safety->risk-15-4-hook-script-safety-hook-output-should-be-truncated-in-logs:elaborates",
    "from": "section-095-15-4-hook-script-safety",
    "to": "risk-15-4-hook-script-safety-hook-output-should-be-truncated-in-logs",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-095-15-4-hook-script-safety->risk-15-4-hook-script-safety-hook-timeouts-are-required-to-avoid-hanging-the-orchestrator:elaborates",
    "from": "section-095-15-4-hook-script-safety",
    "to": "risk-15-4-hook-script-safety-hook-timeouts-are-required-to-avoid-hanging-the-orchestrator",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-implementations-should-not-assume-that-tracker-data-repository-contents-prompt-i:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-implementations-should-not-assume-that-tracker-data-repository-contents-prompt-i",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-tightening-codex-approval-and-sandbox-settings-described-elsewhere-in-this-speci:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-tightening-codex-approval-and-sandbox-settings-described-elsewhere-in-this-speci",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-adding-external-isolation-layers-such-as-os-container-vm-sandboxing-network-rest",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-filtering-which-linear-issues-projects-teams-labels-or-other-tracker-sources-are:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-filtering-which-linear-issues-projects-teams-labels-or-other-tracker-sources-are",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-narrowing-the-lineargraphql-tool-so-it-can-only-read-or-mutate-data-inside-the-i:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-narrowing-the-lineargraphql-tool-so-it-can-only-read-or-mutate-data-inside-the-i",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-reducing-the-set-of-client-side-tools-credentials-filesystem-paths-and-network-d",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-096-15-5-harness-hardening-guidance->risk-15-5-harness-hardening-guidance-the-correct-controls-are-deployment-specific-but-implementations-should-document:elaborates",
    "from": "section-096-15-5-harness-hardening-guidance",
    "to": "risk-15-5-harness-hardening-guidance-the-correct-controls-are-deployment-specific-but-implementations-should-document",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->test-17-test-and-validation-matrix-a-conforming-implementation-should-include-tests-that-cover-the-behaviors-define:elaborates",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "test-17-test-and-validation-matrix-a-conforming-implementation-should-include-tests-that-cover-the-behaviors-define",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations:elaborates",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->test-17-test-and-validation-matrix-extension-conformance-required-only-for-optional-features-that-an-implementation:elaborates",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "test-17-test-and-validation-matrix-extension-conformance-required-only-for-optional-features-that-an-implementation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-104-17-test-and-validation-matrix->test-17-test-and-validation-matrix-real-integration-profile-environment-dependent-smoke-integration-checks-recommen:elaborates",
    "from": "section-104-17-test-and-validation-matrix",
    "to": "test-17-test-and-validation-matrix-real-integration-profile-environment-dependent-smoke-integration-checks-recommen",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-workflow-file-path-precedence:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-workflow-file-path-precedence",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-explicit-runtime-path-is-used-when-provided:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-explicit-runtime-path-is-used-when-provided",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-cwd-default-is-workflow-md-when-no-explicit-runtime-path-is-provided:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-cwd-default-is-workflow-md-when-no-explicit-runtime-path-is-provided",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-workflow-file-changes-are-detected-and-trigger-re-read-re-apply-without-restart:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-workflow-file-changes-are-detected-and-trigger-re-read-re-apply-without-restart",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-invalid-workflow-reload-keeps-last-known-good-effective-configuration-and-emits-:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-invalid-workflow-reload-keeps-last-known-good-effective-configuration-and-emits-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-missing-workflow-md-returns-typed-error:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-missing-workflow-md-returns-typed-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-invalid-yaml-front-matter-returns-typed-error:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-invalid-yaml-front-matter-returns-typed-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-front-matter-non-map-returns-typed-error:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-front-matter-non-map-returns-typed-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "requirement-17-1-workflow-and-config-parsing-config-defaults-apply-when-optional-values-are-missing",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-tracker-kind-validation-enforces-currently-supported-kind-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-tracker-apikey-works-including-var-indirection",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "dependency-17-1-workflow-and-config-parsing-var-resolution-works-for-tracker-api-key-and-path-values",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-path-expansion-works:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-path-expansion-works",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-codex-command-is-preserved-as-a-shell-command-string:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-codex-command-is-preserved-as-a-shell-command-string",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-per-state-concurrency-override-map-normalizes-state-names-and-ignores-invalid-va:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-per-state-concurrency-override-map-normalizes-state-names-and-ignores-invalid-va",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-prompt-template-renders-issue-and-attempt:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-prompt-template-renders-issue-and-attempt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-105-17-1-workflow-and-config-parsing->claim-17-1-workflow-and-config-parsing-prompt-rendering-fails-on-unknown-variables-strict-mode:elaborates",
    "from": "section-105-17-1-workflow-and-config-parsing",
    "to": "claim-17-1-workflow-and-config-parsing-prompt-rendering-fails-on-unknown-variables-strict-mode",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-deterministic-workspace-path-per-issue-identifier:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-deterministic-workspace-path-per-issue-identifier",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-missing-workspace-directory-is-created:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-missing-workspace-directory-is-created",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-existing-workspace-directory-is-reused:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-existing-workspace-directory-is-reused",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-existing-non-directory-path-at-workspace-location-is-handled-safely-replace-or-f:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-existing-non-directory-path-at-workspace-location-is-handled-safely-replace-or-f",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-optional-workspace-population-synchronization-errors-are-surfaced:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-optional-workspace-population-synchronization-errors-are-surfaced",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-aftercreate-hook-runs-only-on-new-workspace-creation:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-aftercreate-hook-runs-only-on-new-workspace-creation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-beforerun-hook-runs-before-each-attempt-and-failure-timeouts-abort-the-current-a:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-beforerun-hook-runs-before-each-attempt-and-failure-timeouts-abort-the-current-a",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-afterrun-hook-runs-after-each-attempt-and-failure-timeouts-are-logged-and-ignore:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-afterrun-hook-runs-after-each-attempt-and-failure-timeouts-are-logged-and-ignore",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-beforeremove-hook-runs-on-cleanup-and-failures-timeouts-are-ignored:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-beforeremove-hook-runs-on-cleanup-and-failures-timeouts-are-ignored",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-workspace-path-sanitization-and-root-containment-invariants-are-enforced-before-:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-workspace-path-sanitization-and-root-containment-invariants-are-enforced-before-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-106-17-2-workspace-manager-and-safety->risk-17-2-workspace-manager-and-safety-agent-launch-uses-the-per-issue-workspace-path-as-cwd-and-rejects-out-of-root-pa:elaborates",
    "from": "section-106-17-2-workspace-manager-and-safety",
    "to": "risk-17-2-workspace-manager-and-safety-agent-launch-uses-the-per-issue-workspace-path-as-cwd-and-rejects-out-of-root-pa",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-candidate-issue-fetch-uses-active-states-and-project-slug:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-candidate-issue-fetch-uses-active-states-and-project-slug",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-linear-query-uses-the-specified-project-filter-field-slugid:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-linear-query-uses-the-specified-project-filter-field-slugid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-empty-fetchissuesbystates-returns-empty-without-api-call:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-empty-fetchissuesbystates-returns-empty-without-api-call",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-pagination-preserves-order-across-multiple-pages:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-pagination-preserves-order-across-multiple-pages",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-blockers-are-normalized-from-inverse-relations-of-type-blocks:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-blockers-are-normalized-from-inverse-relations-of-type-blocks",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-labels-are-normalized-to-lowercase:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-labels-are-normalized-to-lowercase",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-issue-state-refresh-by-id-returns-minimal-normalized-issues:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-issue-state-refresh-by-id-returns-minimal-normalized-issues",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-issue-state-refresh-query-uses-graphql-id-typing-id-as-specified-in-section-11-2:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-issue-state-refresh-query-uses-graphql-id-typing-id-as-specified-in-section-11-2",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-107-17-3-issue-tracker-client->dependency-17-3-issue-tracker-client-error-mapping-for-request-errors-non-200-graphql-errors-malformed-payloads:elaborates",
    "from": "section-107-17-3-issue-tracker-client",
    "to": "dependency-17-3-issue-tracker-client-error-mapping-for-request-errors-non-200-graphql-errors-malformed-payloads",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-dispatch-sort-order-is-priority-then-oldest-creation-time:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-dispatch-sort-order-is-priority-then-oldest-creation-time",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-non-terminal-blockers-is-not-eligible:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-non-terminal-blockers-is-not-eligible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-terminal-blockers-is-eligible:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-todo-issue-with-terminal-blockers-is-eligible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-active-state-issue-refresh-updates-running-entry-state:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-active-state-issue-refresh-updates-running-entry-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-non-active-state-stops-running-agent-without-workspace-cleanup:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-non-active-state-stops-running-agent-without-workspace-cleanup",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-terminal-state-stops-running-agent-and-cleans-workspace:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-terminal-state-stops-running-agent-and-cleans-workspace",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-reconciliation-with-no-running-issues-is-a-no-op:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-reconciliation-with-no-running-issues-is-a-no-op",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-normal-worker-exit-schedules-a-short-continuation-retry-attempt-1:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-normal-worker-exit-schedules-a-short-continuation-retry-attempt-1",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-abnormal-worker-exit-increments-retries-with-10s-based-exponential-backoff:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-abnormal-worker-exit-increments-retries-with-10s-based-exponential-backoff",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-backoff-cap-uses-configured-agent-maxretrybackoffms:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-backoff-cap-uses-configured-agent-maxretrybackoffms",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-queue-entries-include-attempt-due-time-identifier-and-error:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-retry-queue-entries-include-attempt-due-time-identifier-and-error",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-stall-detection-kills-stalled-sessions-and-schedules-retry:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-stall-detection-kills-stalled-sessions-and-schedules-retry",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->claim-17-4-orchestrator-dispatch-reconciliation-and-retry-slot-exhaustion-requeues-retries-with-explicit-error-reason:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "claim-17-4-orchestrator-dispatch-reconciliation-and-retry-slot-exhaustion-requeues-retries-with-explicit-error-reason",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-it-returns-running-rows-retry-rows-token-totals:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-it-returns-running-rows-retry-rows-token-totals",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry->dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-timeout-unavailable-cases-are-surfaced:elaborates",
    "from": "section-108-17-4-orchestrator-dispatch-reconciliation-and-retry",
    "to": "dependency-17-4-orchestrator-dispatch-reconciliation-and-retry-if-a-snapshot-api-is-implemented-timeout-unavailable-cases-are-surfaced",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-launch-command-uses-workspace-cwd-and-invokes-bash-lc-codex-command",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-session-startup-follows-the-targeted-codex-app-server-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-client-identity-capability-payloads-are-valid-when-the-targeted-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-policy-related-startup-payloads-use-the-implementation-s-documented-approval-san",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-thread-and-turn-identities-exposed-by-the-targeted-protocol-are-extracted-and-us",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-request-response-read-timeout-is-enforced",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-turn-timeout-is-enforced",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-transport-framing-required-by-the-targeted-protocol-is-handled-correctly",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-for-stdio-based-transports-diagnostic-stderr-handling-is-kept-separate-from-the-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-command-file-change-approvals-are-handled-according-to-the-implementation-s-docu",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-unsupported-dynamic-tool-calls-are-rejected-without-stalling-the-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-user-input-requests-are-handled-according-to-the-implementation-s-documented-pol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-usage-and-rate-limit-telemetry-exposed-by-the-targeted-protocol-is-extracted",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-approval-user-input-required-usage-and-rate-limit-signals-are-interpreted-accord",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-if-client-side-tools-are-implemented-session-startup-advertises-the-supported-to",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-if-the-lineargraphql-client-side-tool-extension-is-implemented",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-the-tool-is-advertised-to-the-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-valid-query-variables-inputs-execute-against-configured-linear-auth",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-top-level-graphql-errors-produce-success-false-while-preserving-the-graphql-body",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-invalid-arguments-missing-auth-and-transport-failures-return-structured-failure-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-109-17-5-coding-agent-app-server-client->dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session:elaborates",
    "from": "section-109-17-5-coding-agent-app-server-client",
    "to": "dependency-17-5-coding-agent-app-server-client-unsupported-tool-names-still-fail-without-stalling-the-session",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-validation-failures-are-operator-visible:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-validation-failures-are-operator-visible",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-structured-logging-includes-issue-session-context-fields:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-structured-logging-includes-issue-session-context-fields",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-logging-sink-failures-do-not-crash-orchestration:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-logging-sink-failures-do-not-crash-orchestration",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-token-rate-limit-aggregation-remains-correct-across-repeated-agent-updates:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-token-rate-limit-aggregation-remains-correct-across-repeated-agent-updates",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-if-a-human-readable-status-surface-is-implemented-it-is-driven-from-orchestrator:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-if-a-human-readable-status-surface-is-implemented-it-is-driven-from-orchestrator",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-110-17-6-observability->claim-17-6-observability-if-humanized-event-summaries-are-implemented-they-cover-key-wrapper-agent-event-:elaborates",
    "from": "section-110-17-6-observability",
    "to": "claim-17-6-observability-if-humanized-event-summaries-are-implemented-they-cover-key-wrapper-agent-event-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-accepts-a-positional-workflow-path-argument-path-to-workflow-md:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-accepts-a-positional-workflow-path-argument-path-to-workflow-md",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-uses-workflow-md-when-no-workflow-path-argument-is-provided:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-uses-workflow-md-when-no-workflow-path-argument-is-provided",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-errors-on-nonexistent-explicit-workflow-path-or-missing-default-workflow-md",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-surfaces-startup-failure-cleanly:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-surfaces-startup-failure-cleanly",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-exits-with-success-when-application-starts-and-shuts-down-normally:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-exits-with-success-when-application-starts-and-shuts-down-normally",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-111-17-7-cli-and-host-lifecycle->dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally:elaborates",
    "from": "section-111-17-7-cli-and-host-lifecycle",
    "to": "dependency-17-7-cli-and-host-lifecycle-cli-exits-nonzero-when-startup-fails-or-the-host-process-exits-abnormally",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended->dependency-17-8-real-integration-profile-recommended-these-checks-are-recommended-for-production-readiness-and-may-be-skipped-in-ci-w:elaborates",
    "from": "section-112-17-8-real-integration-profile-recommended",
    "to": "dependency-17-8-real-integration-profile-recommended-these-checks-are-recommended-for-production-readiness-and-may-be-skipped-in-ci-w",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended->dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap:elaborates",
    "from": "section-112-17-8-real-integration-profile-recommended",
    "to": "dependency-17-8-real-integration-profile-recommended-a-real-tracker-smoke-test-can-be-run-with-valid-credentials-supplied-by-linearap",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended->dependency-17-8-real-integration-profile-recommended-real-integration-tests-should-use-isolated-test-identifiers-workspaces-and-clean:elaborates",
    "from": "section-112-17-8-real-integration-profile-recommended",
    "to": "dependency-17-8-real-integration-profile-recommended-real-integration-tests-should-use-isolated-test-identifiers-workspaces-and-clean",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended->dependency-17-8-real-integration-profile-recommended-a-skipped-real-integration-test-should-be-reported-as-skipped-not-silently-treat:elaborates",
    "from": "section-112-17-8-real-integration-profile-recommended",
    "to": "dependency-17-8-real-integration-profile-recommended-a-skipped-real-integration-test-should-be-reported-as-skipped-not-silently-treat",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-112-17-8-real-integration-profile-recommended->dependency-17-8-real-integration-profile-recommended-if-a-real-integration-profile-is-explicitly-enabled-in-ci-or-release-validation-:elaborates",
    "from": "section-112-17-8-real-integration-profile-recommended",
    "to": "dependency-17-8-real-integration-profile-recommended-if-a-real-integration-profile-is-explicitly-enabled-in-ci-or-release-validation-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->test-18-implementation-checklist-definition-of-done-section-18-1-core-conformance:elaborates",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "test-18-implementation-checklist-definition-of-done-section-18-1-core-conformance",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->test-18-implementation-checklist-definition-of-done-section-18-2-extension-conformance:elaborates",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "test-18-implementation-checklist-definition-of-done-section-18-2-extension-conformance",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-113-18-implementation-checklist-definition-of-done->test-18-implementation-checklist-definition-of-done-section-18-3-real-integration-profile:elaborates",
    "from": "section-113-18-implementation-checklist-definition-of-done",
    "to": "test-18-implementation-checklist-definition-of-done-section-18-3-real-integration-profile",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-workflow-path-selection-supports-explicit-runtime-path-and-cwd-default:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-workflow-path-selection-supports-explicit-runtime-path-and-cwd-default",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-workflow-md-loader-with-yaml-front-matter-prompt-body-split:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-workflow-md-loader-with-yaml-front-matter-prompt-body-split",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-typed-config-layer-with-defaults-and-resolution:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-typed-config-layer-with-defaults-and-resolution",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-dynamic-workflow-md-watch-reload-re-apply-for-config-and-prompt:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-dynamic-workflow-md-watch-reload-re-apply-for-config-and-prompt",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-polling-orchestrator-with-single-authority-mutable-state:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-polling-orchestrator-with-single-authority-mutable-state",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-issue-tracker-client-with-candidate-fetch-state-refresh-terminal-fetch:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-issue-tracker-client-with-candidate-fetch-state-refresh-terminal-fetch",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-workspace-manager-with-sanitized-per-issue-workspaces:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-workspace-manager-with-sanitized-per-issue-workspaces",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-workspace-lifecycle-hooks-aftercreate-beforerun-afterrun-beforeremove:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-workspace-lifecycle-hooks-aftercreate-beforerun-afterrun-beforeremove",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-hook-timeout-config-hooks-timeoutms-default-60000:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-hook-timeout-config-hooks-timeoutms-default-60000",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-coding-agent-app-server-subprocess-client-with-json-line-protocol:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-coding-agent-app-server-subprocess-client-with-json-line-protocol",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-codex-launch-command-config-codex-command-default-codex-app-server:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-codex-launch-command-config-codex-command-default-codex-app-server",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-strict-prompt-rendering-with-issue-and-attempt-variables:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-strict-prompt-rendering-with-issue-and-attempt-variables",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-exponential-retry-queue-with-continuation-retries-after-normal-exit:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-exponential-retry-queue-with-continuation-retries-after-normal-exit",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-configurable-retry-backoff-cap-agent-maxretrybackoffms-default-5m:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-configurable-retry-backoff-cap-agent-maxretrybackoffms-default-5m",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-reconciliation-that-stops-runs-on-terminal-non-active-tracker-states:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-reconciliation-that-stops-runs-on-terminal-non-active-tracker-states",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-workspace-cleanup-for-terminal-issues-startup-sweep-active-transition:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-workspace-cleanup-for-terminal-issues-startup-sweep-active-transition",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-structured-logs-with-issueid-issueidentifier-and-sessionid:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-structured-logs-with-issueid-issueidentifier-and-sessionid",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-114-18-1-required-for-conformance->test-18-1-required-for-conformance-operator-visible-observability-structured-logs-optional-snapshot-status-surface:elaborates",
    "from": "section-114-18-1-required-for-conformance",
    "to": "test-18-1-required-for-conformance-operator-visible-observability-structured-logs-optional-snapshot-status-surface",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind-:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-http-server-extension-honors-cli-port-over-server-port-uses-a-safe-default-bind-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-lineargraphql-client-side-tool-extension-exposes-raw-linear-graphql-access-throu:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-lineargraphql-client-side-tool-extension-exposes-raw-linear-graphql-access-throu",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-todo-persist-retry-queue-and-session-metadata-across-process-restarts:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-todo-persist-retry-queue-and-session-metadata-across-process-restarts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-todo-make-observability-settings-configurable-in-workflow-front-matter-without-p:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-todo-make-observability-settings-configurable-in-workflow-front-matter-without-p",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-todo-add-first-class-tracker-write-apis-comments-state-transitions-in-the-orches:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-first-class-tracker-write-apis-comments-state-transitions-in-the-orches",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-115-18-2-recommended-extensions-not-required-for-conformance->test-18-2-recommended-extensions-not-required-for-conformance-todo-add-pluggable-issue-tracker-adapters-beyond-linear:elaborates",
    "from": "section-115-18-2-recommended-extensions-not-required-for-conformance",
    "to": "test-18-2-recommended-extensions-not-required-for-conformance-todo-add-pluggable-issue-tracker-adapters-beyond-linear",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-116-18-3-operational-validation-before-production-recommended->test-18-3-operational-validation-before-production-recommended-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne:elaborates",
    "from": "section-116-18-3-operational-validation-before-production-recommended",
    "to": "test-18-3-operational-validation-before-production-recommended-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-116-18-3-operational-validation-before-production-recommended->test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e:elaborates",
    "from": "section-116-18-3-operational-validation-before-production-recommended",
    "to": "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-116-18-3-operational-validation-before-production-recommended->test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l:elaborates",
    "from": "section-116-18-3-operational-validation-before-production-recommended",
    "to": "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->requirement-appendix-a-ssh-worker-extension-optional-worker-sshhosts-list-of-ssh-host-strings-optional:elaborates",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "requirement-appendix-a-ssh-worker-extension-optional-worker-sshhosts-list-of-ssh-host-strings-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->claim-appendix-a-ssh-worker-extension-optional-when-omitted-work-runs-locally:elaborates",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "claim-appendix-a-ssh-worker-extension-optional-when-omitted-work-runs-locally",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->requirement-appendix-a-ssh-worker-extension-optional-worker-maxconcurrentagentsperhost-positive-integer-optional:elaborates",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "requirement-appendix-a-ssh-worker-extension-optional-worker-maxconcurrentagentsperhost-positive-integer-optional",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-117-appendix-a-ssh-worker-extension-optional->dependency-appendix-a-ssh-worker-extension-optional-shared-per-host-cap-applied-across-configured-ssh-hosts:elaborates",
    "from": "section-117-appendix-a-ssh-worker-extension-optional",
    "to": "dependency-appendix-a-ssh-worker-extension-optional-shared-per-host-cap-applied-across-configured-ssh-hosts",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->claim-a-1-execution-model-the-orchestrator-remains-the-single-source-of-truth-for-polling-claims-retries-a:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "claim-a-1-execution-model-the-orchestrator-remains-the-single-source-of-truth-for-polling-claims-retries-a",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->claim-a-1-execution-model-worker-sshhosts-provides-the-candidate-ssh-destinations-for-remote-execution:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "claim-a-1-execution-model-worker-sshhosts-provides-the-candidate-ssh-destinations-for-remote-execution",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-118-a-1-execution-model->requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme:elaborates",
    "from": "section-118-a-1-execution-model",
    "to": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-ssh-hosts-may-be-treated-as-a-pool-for-dispatch:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-ssh-hosts-may-be-treated-as-a-pool-for-dispatch",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-implementations-may-prefer-the-previously-used-host-on-retries-when-that-host-is:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-implementations-may-prefer-the-previously-used-host-on-retries-when-that-host-is",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-worker-maxconcurrentagentsperhost-is-an-optional-shared-per-host-cap-across-conf:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-worker-maxconcurrentagentsperhost-is-an-optional-shared-per-host-cap-across-conf",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-implementations-may-fail-over-to-another-host-when-the-original-host-is-unavaila:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-implementations-may-fail-over-to-another-host-when-the-original-host-is-unavaila",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-119-a-2-scheduling-notes->requirement-a-2-scheduling-notes-once-a-run-has-already-produced-side-effects-a-transparent-rerun-on-another-host:elaborates",
    "from": "section-119-a-2-scheduling-notes",
    "to": "requirement-a-2-scheduling-notes-once-a-run-has-already-produced-side-effects-a-transparent-rerun-on-another-host",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-remote-environment-drift:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-remote-environment-drift",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->dependency-a-3-problems-to-consider-each-host-needs-the-expected-shell-environment-coding-agent-executable-auth-and-:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "dependency-a-3-problems-to-consider-each-host-needs-the-expected-shell-environment-coding-agent-executable-auth-and-",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-workspace-locality:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-workspace-locality",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->dependency-a-3-problems-to-consider-workspaces-are-usually-host-local-so-moving-an-issue-to-a-different-host-is-typi:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "dependency-a-3-problems-to-consider-workspaces-are-usually-host-local-so-moving-an-issue-to-a-different-host-is-typi",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-path-and-command-safety:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-path-and-command-safety",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-remote-path-resolution-shell-quoting-and-workspace-boundary-checks-matter-more-o:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-remote-path-resolution-shell-quoting-and-workspace-boundary-checks-matter-more-o",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-startup-and-failover-semantics:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-startup-and-failover-semantics",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->requirement-a-3-problems-to-consider-implementations-should-distinguish-host-connectivity-startup-failures-from-in-wo:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "requirement-a-3-problems-to-consider-implementations-should-distinguish-host-connectivity-startup-failures-from-in-wo",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->dependency-a-3-problems-to-consider-host-health-and-saturation:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "dependency-a-3-problems-to-consider-host-health-and-saturation",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->requirement-a-3-problems-to-consider-a-dead-or-overloaded-host-should-reduce-available-capacity-not-cause-duplicate-e:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "requirement-a-3-problems-to-consider-a-dead-or-overloaded-host-should-reduce-available-capacity-not-cause-duplicate-e",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->claim-a-3-problems-to-consider-cleanup-and-observability:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "claim-a-3-problems-to-consider-cleanup-and-observability",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "section-120-a-3-problems-to-consider->dependency-a-3-problems-to-consider-operators-need-to-know-which-host-owns-a-run-where-its-workspace-lives-and-wheth:elaborates",
    "from": "section-120-a-3-problems-to-consider",
    "to": "dependency-a-3-problems-to-consider-operators-need-to-know-which-host-owns-a-run-where-its-workspace-lives-and-wheth",
    "type": "elaborates",
    "label": "elaborates"
  },
  {
    "id": "finding-impossible-unbounded->risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker:pressures",
    "from": "finding-impossible-unbounded",
    "to": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker->finding-impossible-unbounded:evidences",
    "from": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
    "to": "finding-impossible-unbounded",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-impossible-unbounded->requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible:pressures",
    "from": "finding-impossible-unbounded",
    "to": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible->finding-impossible-unbounded:evidences",
    "from": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "to": "finding-impossible-unbounded",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-impossible-unbounded->test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations:pressures",
    "from": "finding-impossible-unbounded",
    "to": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations->finding-impossible-unbounded:evidences",
    "from": "test-17-test-and-validation-matrix-core-conformance-deterministic-tests-required-for-all-conforming-implementations",
    "to": "finding-impossible-unbounded",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-impossible-unbounded->requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme:pressures",
    "from": "finding-impossible-unbounded",
    "to": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme->finding-impossible-unbounded:evidences",
    "from": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme",
    "to": "finding-impossible-unbounded",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-impossible-unbounded->requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal:pressures",
    "from": "finding-impossible-unbounded",
    "to": "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal->finding-impossible-unbounded:evidences",
    "from": "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal",
    "to": "finding-impossible-unbounded",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-002-normative-language:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-002-normative-language",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-002-normative-language->finding-complexity-optional-surface:evidences",
    "from": "section-002-normative-language",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-010-3-3-external-dependencies:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-010-3-3-external-dependencies",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-010-3-3-external-dependencies->finding-complexity-optional-surface:evidences",
    "from": "section-010-3-3-external-dependencies",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-024-5-2-file-format:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-024-5-2-file-format",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-024-5-2-file-format->finding-complexity-optional-surface:evidences",
    "from": "section-024-5-2-file-format",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-029-5-3-4-hooks-object:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-029-5-3-4-hooks-object",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-029-5-3-4-hooks-object->finding-complexity-optional-surface:evidences",
    "from": "section-029-5-3-4-hooks-object",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-035-6-1-configuration-resolution-pipeline:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-035-6-1-configuration-resolution-pipeline",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-035-6-1-configuration-resolution-pipeline->finding-complexity-optional-surface:evidences",
    "from": "section-035-6-1-configuration-resolution-pipeline",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-054-9-3-optional-workspace-population-implementation-defined:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-054-9-3-optional-workspace-population-implementation-defined",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-054-9-3-optional-workspace-population-implementation-defined->finding-complexity-optional-surface:evidences",
    "from": "section-054-9-3-optional-workspace-population-implementation-defined",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-061-10-4-emitted-runtime-events-upstream-to-orchestrator:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator->finding-complexity-optional-surface:evidences",
    "from": "section-061-10-4-emitted-runtime-events-upstream-to-orchestrator",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-072-12-1-inputs:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-072-12-1-inputs",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-072-12-1-inputs->finding-complexity-optional-surface:evidences",
    "from": "section-072-12-1-inputs",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended->finding-complexity-optional-surface:evidences",
    "from": "section-079-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-080-13-4-optional-human-readable-status-surface:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-080-13-4-optional-human-readable-status-surface",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-080-13-4-optional-human-readable-status-surface->finding-complexity-optional-surface:evidences",
    "from": "section-080-13-4-optional-human-readable-status-surface",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-082-13-6-humanized-agent-event-summaries-optional:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-082-13-6-humanized-agent-event-summaries-optional",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-082-13-6-humanized-agent-event-summaries-optional->finding-complexity-optional-surface:evidences",
    "from": "section-082-13-6-humanized-agent-event-summaries-optional",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-complexity-optional-surface->section-083-13-7-optional-http-server-extension:pressures",
    "from": "finding-complexity-optional-surface",
    "to": "section-083-13-7-optional-http-server-extension",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-083-13-7-optional-http-server-extension->finding-complexity-optional-surface:evidences",
    "from": "section-083-13-7-optional-http-server-extension",
    "to": "finding-complexity-optional-surface",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->section-003-1-problem-statement:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "section-003-1-problem-statement",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "section-003-1-problem-statement->finding-misses-problem-low-overlap:evidences",
    "from": "section-003-1-problem-statement",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr->finding-misses-problem-low-overlap:evidences",
    "from": "goal-2-1-goals-poll-the-issue-tracker-on-a-fixed-cadence-and-dispatch-work-with-bounded-concurr",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco->finding-misses-problem-low-overlap:evidences",
    "from": "goal-2-1-goals-maintain-a-single-authoritative-orchestrator-state-for-dispatch-retries-and-reco",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs->finding-misses-problem-low-overlap:evidences",
    "from": "goal-2-1-goals-create-deterministic-per-issue-workspaces-and-preserve-them-across-runs",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible->finding-misses-problem-low-overlap:evidences",
    "from": "goal-2-1-goals-stop-active-runs-when-issue-state-changes-make-them-ineligible",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->test-5-5-workflow-validation-and-error-surface-missingworkflowfile:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile->finding-misses-problem-low-overlap:evidences",
    "from": "test-5-5-workflow-validation-and-error-surface-missingworkflowfile",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->test-5-5-workflow-validation-and-error-surface-workflowparseerror:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "test-5-5-workflow-validation-and-error-surface-workflowparseerror",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-workflowparseerror->finding-misses-problem-low-overlap:evidences",
    "from": "test-5-5-workflow-validation-and-error-surface-workflowparseerror",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap->finding-misses-problem-low-overlap:evidences",
    "from": "test-5-5-workflow-validation-and-error-surface-workflowfrontmatternotamap",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-misses-problem-low-overlap->test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering:pressures",
    "from": "finding-misses-problem-low-overlap",
    "to": "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering->finding-misses-problem-low-overlap:evidences",
    "from": "test-5-5-workflow-validation-and-error-surface-templateparseerror-during-prompt-rendering",
    "to": "finding-misses-problem-low-overlap",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-underspecified-vague-norms->requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl:pressures",
    "from": "finding-underspecified-vague-norms",
    "to": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl->finding-underspecified-vague-norms:evidences",
    "from": "requirement-5-2-file-format-workflow-md-should-be-self-contained-enough-to-describe-and-run-different-workfl",
    "to": "finding-underspecified-vague-norms",
    "type": "evidences",
    "label": "evidences"
  },
  {
    "id": "finding-underspecified-vague-norms->requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and:pressures",
    "from": "finding-underspecified-vague-norms",
    "to": "requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and",
    "type": "pressures",
    "label": "pressures"
  },
  {
    "id": "requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and->finding-underspecified-vague-norms:evidences",
    "from": "requirement-13-4-optional-human-readable-status-surface-a-human-readable-status-surface-terminal-output-dashboard-etc-is-optional-and",
    "to": "finding-underspecified-vague-norms",
    "type": "evidences",
    "label": "evidences"
  }
] AS row
MATCH (from:ClaimLatticeNode {id: row.from})
MATCH (to:ClaimLatticeNode {id: row.to})
MERGE (from)-[r:SPEC_EDGE {id: row.id}]->(to)
SET r.type = row.type,
    r.label = row.label;
