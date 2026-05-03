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
    "id": "claim-9-4-workspace-hooks-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation",
    "type": "claim",
    "title": "aftercreate failure or timeout is fatal to workspace creation.",
    "text": "`after_create` failure or timeout is fatal to workspace creation.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 880,
      "lineEnd": 880
    }
  },
  {
    "id": "claim-9-4-workspace-hooks-beforerun-failure-or-timeout-is-fatal-to-the-current-run-attempt",
    "type": "claim",
    "title": "beforerun failure or timeout is fatal to the current run attempt.",
    "text": "`before_run` failure or timeout is fatal to the current run attempt.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 881,
      "lineEnd": 881
    }
  },
  {
    "id": "claim-9-4-workspace-hooks-afterrun-failure-or-timeout-is-logged-and-ignored",
    "type": "claim",
    "title": "afterrun failure or timeout is logged and ignored.",
    "text": "`after_run` failure or timeout is logged and ignored.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 882,
      "lineEnd": 882
    }
  },
  {
    "id": "claim-9-4-workspace-hooks-beforeremove-failure-or-timeout-is-logged-and-ignored",
    "type": "claim",
    "title": "beforeremove failure or timeout is logged and ignored.",
    "text": "`before_remove` failure or timeout is logged and ignored.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 883,
      "lineEnd": 883
    }
  },
  {
    "id": "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root",
    "type": "risk",
    "title": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "text": "Invariant 2: Workspace path MUST stay inside workspace root.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 894,
      "lineEnd": 894
    }
  },
  {
    "id": "risk-9-5-safety-invariants-reject-any-path-outside-the-workspace-root",
    "type": "risk",
    "title": "Reject any path outside the workspace root.",
    "text": "Reject any path outside the workspace root.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 898,
      "lineEnd": 898
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn failure signal -> failure",
    "text": "Targeted-protocol turn failure signal -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 976,
      "lineEnd": 976
    }
  },
  {
    "id": "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
    "type": "claim",
    "title": "Targeted-protocol turn cancellation signal -> failure",
    "text": "Targeted-protocol turn cancellation signal -> failure",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 977,
      "lineEnd": 977
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0455-heading-9-4-workspace-hooks",
    "type": "heading",
    "lineStart": 861,
    "lineEnd": 861,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 9.4 Workspace Hooks"
  },
  {
    "id": "block-0466-blank-blank",
    "type": "blank",
    "lineStart": 880,
    "lineEnd": 880,
    "generatedClaimIds": [
      "claim-9-4-workspace-hooks-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0467-list-aftercreate-failure-or-timeout-is-fatal-to-workspace-creation-beforerun-failure",
    "type": "list",
    "lineStart": 881,
    "lineEnd": 884,
    "generatedClaimIds": [
      "claim-9-4-workspace-hooks-beforerun-failure-or-timeout-is-fatal-to-the-current-run-attempt",
      "claim-9-4-workspace-hooks-afterrun-failure-or-timeout-is-logged-and-ignored",
      "claim-9-4-workspace-hooks-beforeremove-failure-or-timeout-is-logged-and-ignored"
    ],
    "rawMarkdown": "- `after_create` failure or timeout is fatal to workspace creation.\n- `before_run` failure or timeout is fatal to the current run attempt.\n- `after_run` failure or timeout is logged and ignored.\n- `before_remove` failure or timeout is logged and ignored."
  },
  {
    "id": "block-0469-heading-9-5-safety-invariants",
    "type": "heading",
    "lineStart": 886,
    "lineEnd": 886,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 9.5 Safety Invariants"
  },
  {
    "id": "block-0476-blank-blank",
    "type": "blank",
    "lineStart": 894,
    "lineEnd": 894,
    "generatedClaimIds": [
      "risk-9-5-safety-invariants-invariant-2-workspace-path-must-stay-inside-workspace-root"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0479-list-normalize-both-paths-to-absolute-require-workspacepath-to-have-workspaceroot-as",
    "type": "list",
    "lineStart": 897,
    "lineEnd": 899,
    "generatedClaimIds": [
      "risk-9-5-safety-invariants-require-workspacepath-to-have-workspaceroot-as-a-prefix-directory",
      "risk-9-5-safety-invariants-reject-any-path-outside-the-workspace-root"
    ],
    "rawMarkdown": "- Normalize both paths to absolute.\n- Require `workspace_path` to have `workspace_root` as a prefix directory.\n- Reject any path outside the workspace root."
  },
  {
    "id": "block-0519-heading-10-3-streaming-turn-processing",
    "type": "heading",
    "lineStart": 969,
    "lineEnd": 969,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.3 Streaming Turn Processing"
  },
  {
    "id": "block-0525-list-targeted-protocol-turn-completion-signal-success-targeted-protocol-turn-failur",
    "type": "list",
    "lineStart": 976,
    "lineEnd": 980,
    "generatedClaimIds": [
      "claim-10-3-streaming-turn-processing-targeted-protocol-turn-failure-signal-failure",
      "claim-10-3-streaming-turn-processing-targeted-protocol-turn-cancellation-signal-failure",
      "claim-10-3-streaming-turn-processing-turn-timeout-turntimeoutms-failure",
      "claim-10-3-streaming-turn-processing-subprocess-exit-failure"
    ],
    "rawMarkdown": "- Targeted-protocol turn completion signal -> success\n- Targeted-protocol turn failure signal -> failure\n- Targeted-protocol turn cancellation signal -> failure\n- turn timeout (`turn_timeout_ms`) -> failure\n- subprocess exit -> failure"
  }
]
```
