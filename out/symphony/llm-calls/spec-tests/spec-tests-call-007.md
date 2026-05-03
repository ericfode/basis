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
    "id": "risk-17-2-workspace-manager-and-safety-beforerun-hook-runs-before-each-attempt-and-failure-timeouts-abort-the-current-a",
    "type": "risk",
    "title": "beforerun hook runs before each attempt and failure/timeouts abort the current attempt",
    "text": "`before_run` hook runs before each attempt and failure/timeouts abort the current attempt",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1960,
      "lineEnd": 1960
    }
  },
  {
    "id": "risk-17-2-workspace-manager-and-safety-afterrun-hook-runs-after-each-attempt-and-failure-timeouts-are-logged-and-ignore",
    "type": "risk",
    "title": "afterrun hook runs after each attempt and failure/timeouts are logged and ignored",
    "text": "`after_run` hook runs after each attempt and failure/timeouts are logged and ignored",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1961,
      "lineEnd": 1961
    }
  },
  {
    "id": "claim-17-6-observability-validation-failures-are-operator-visible",
    "type": "claim",
    "title": "Validation failures are operator-visible",
    "text": "Validation failures are operator-visible",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2028,
      "lineEnd": 2028
    }
  },
  {
    "id": "test-18-implementation-checklist-definition-of-done-section-18-1-core-conformance",
    "type": "test",
    "title": "Section 18.1 = Core Conformance",
    "text": "Section 18.1 = `Core Conformance`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2063,
      "lineEnd": 2063
    }
  },
  {
    "id": "test-18-implementation-checklist-definition-of-done-section-18-2-extension-conformance",
    "type": "test",
    "title": "Section 18.2 = Extension Conformance",
    "text": "Section 18.2 = `Extension Conformance`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2064,
      "lineEnd": 2064
    }
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
    "type": "test",
    "title": "Verify hook execution and workflow path resolution on the target host OS/shell enviro...",
    "text": "Verify hook execution and workflow path resolution on the target host OS/shell environment.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2104,
      "lineEnd": 2104
    }
  },
  {
    "id": "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l",
    "type": "test",
    "title": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopb...",
    "text": "If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default bind expectations on the target environment.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2105,
      "lineEnd": 2105
    }
  },
  {
    "id": "finding-complexity-optional-surface",
    "type": "finding",
    "title": "Optional surface is large relative to goals",
    "text": "Detected 46 optional references. Large optional surfaces can make conformance harder than the baseline problem.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md"
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0909-heading-17-6-observability",
    "type": "heading",
    "lineStart": 2027,
    "lineEnd": 2027,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 17.6 Observability"
  },
  {
    "id": "block-0910-blank-blank",
    "type": "blank",
    "lineStart": 2028,
    "lineEnd": 2028,
    "generatedClaimIds": [
      "claim-17-6-observability-validation-failures-are-operator-visible"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0923-heading-18-implementation-checklist-definition-of-done",
    "type": "heading",
    "lineStart": 2060,
    "lineEnd": 2060,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "## 18. Implementation Checklist (Definition of Done)"
  },
  {
    "id": "block-0926-blank-blank",
    "type": "blank",
    "lineStart": 2063,
    "lineEnd": 2063,
    "generatedClaimIds": [
      "test-18-implementation-checklist-definition-of-done-section-18-1-core-conformance"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0927-list-section-18-1-core-conformance-section-18-2-extension-conformance-section-18",
    "type": "list",
    "lineStart": 2064,
    "lineEnd": 2066,
    "generatedClaimIds": [
      "test-18-implementation-checklist-definition-of-done-section-18-2-extension-conformance",
      "test-18-implementation-checklist-definition-of-done-section-18-3-real-integration-profile"
    ],
    "rawMarkdown": "- Section 18.1 = `Core Conformance`\n- Section 18.2 = `Extension Conformance`\n- Section 18.3 = `Real Integration Profile`"
  },
  {
    "id": "block-0937-heading-18-3-operational-validation-before-production-recommended",
    "type": "heading",
    "lineStart": 2102,
    "lineEnd": 2102,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "### 18.3 Operational Validation Before Production (RECOMMENDED)"
  },
  {
    "id": "block-0939-list-run-the-real-integration-profile-from-section-17-8-with-valid-credentials-and-ne",
    "type": "list",
    "lineStart": 2104,
    "lineEnd": 2107,
    "generatedClaimIds": [
      "test-18-3-operational-validation-before-production-recommended-verify-hook-execution-and-workflow-path-resolution-on-the-target-host-os-shell-e",
      "test-18-3-operational-validation-before-production-recommended-if-the-optional-http-server-is-shipped-verify-the-configured-port-behavior-and-l"
    ],
    "rawMarkdown": "- Run the `Real Integration Profile` from Section 17.8 with valid credentials and network access.\n- Verify hook execution and workflow path resolution on the target host OS/shell environment.\n- If the OPTIONAL HTTP server is shipped, verify the configured port behavior and loopback/default\n  bind expectations on the target environment."
  }
]
```
