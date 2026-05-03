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
    "id": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir",
    "type": "risk",
    "title": "Implementations SHOULD state clearly whether they are intended for trusted environmen...",
    "text": "Implementations SHOULD state clearly whether they are intended for trusted environments, more restrictive environments, or both.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1609,
      "lineEnd": 1609
    }
  },
  {
    "id": "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-rely-on-auto-approved-actions-",
    "type": "risk",
    "title": "Implementations SHOULD state clearly whether they rely on auto-approved actions, oper...",
    "text": "Implementations SHOULD state clearly whether they rely on auto-approved actions, operator approvals, stricter sandboxing, or some combination of those controls.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1611,
      "lineEnd": 1611
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
    "id": "risk-15-2-filesystem-safety-requirements-workspace-path-must-remain-under-configured-workspace-root",
    "type": "risk",
    "title": "Workspace path MUST remain under configured workspace root.",
    "text": "Workspace path MUST remain under configured workspace root.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1620,
      "lineEnd": 1620
    }
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-coding-agent-cwd-must-be-the-per-issue-workspace-path-for-the-current-run",
    "type": "risk",
    "title": "Coding-agent cwd MUST be the per-issue workspace path for the current run.",
    "text": "Coding-agent cwd MUST be the per-issue workspace path for the current run.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1621,
      "lineEnd": 1621
    }
  },
  {
    "id": "risk-15-2-filesystem-safety-requirements-workspace-directory-names-must-use-sanitized-identifiers",
    "type": "risk",
    "title": "Workspace directory names MUST use sanitized identifiers.",
    "text": "Workspace directory names MUST use sanitized identifiers.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1622,
      "lineEnd": 1622
    }
  },
  {
    "id": "risk-15-4-hook-script-safety-hook-output-should-be-truncated-in-logs",
    "type": "risk",
    "title": "Hook output SHOULD be truncated in logs.",
    "text": "Hook output SHOULD be truncated in logs.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1644,
      "lineEnd": 1644
    }
  },
  {
    "id": "risk-15-5-harness-hardening-guidance-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the",
    "type": "risk",
    "title": "Implementations SHOULD explicitly evaluate their own risk profile and harden the exec...",
    "text": "Implementations SHOULD explicitly evaluate their own risk profile and harden the execution harness",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1654,
      "lineEnd": 1654
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0814-blank-blank",
    "type": "blank",
    "lineStart": 1609,
    "lineEnd": 1609,
    "generatedClaimIds": [
      "risk-15-1-trust-boundary-assumption-implementations-should-state-clearly-whether-they-are-intended-for-trusted-envir"
    ],
    "rawMarkdown": ""
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
    "id": "block-0817-heading-15-2-filesystem-safety-requirements",
    "type": "heading",
    "lineStart": 1617,
    "lineEnd": 1617,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.2 Filesystem Safety Requirements"
  },
  {
    "id": "block-0820-blank-blank",
    "type": "blank",
    "lineStart": 1620,
    "lineEnd": 1620,
    "generatedClaimIds": [
      "risk-15-2-filesystem-safety-requirements-workspace-path-must-remain-under-configured-workspace-root"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0821-list-workspace-path-must-remain-under-configured-workspace-root-coding-agent-cwd-must",
    "type": "list",
    "lineStart": 1621,
    "lineEnd": 1623,
    "generatedClaimIds": [
      "risk-15-2-filesystem-safety-requirements-coding-agent-cwd-must-be-the-per-issue-workspace-path-for-the-current-run",
      "risk-15-2-filesystem-safety-requirements-workspace-directory-names-must-use-sanitized-identifiers"
    ],
    "rawMarkdown": "- Workspace path MUST remain under configured workspace root.\n- Coding-agent cwd MUST be the per-issue workspace path for the current run.\n- Workspace directory names MUST use sanitized identifiers."
  },
  {
    "id": "block-0831-heading-15-4-hook-script-safety",
    "type": "heading",
    "lineStart": 1637,
    "lineEnd": 1637,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 15.4 Hook Script Safety"
  },
  {
    "id": "block-0837-list-hooks-are-fully-trusted-configuration-hooks-run-inside-the-workspace-directory",
    "type": "list",
    "lineStart": 1643,
    "lineEnd": 1646,
    "generatedClaimIds": [
      "risk-15-4-hook-script-safety-hooks-run-inside-the-workspace-directory",
      "risk-15-4-hook-script-safety-hook-output-should-be-truncated-in-logs",
      "risk-15-4-hook-script-safety-hook-timeouts-are-required-to-avoid-hanging-the-orchestrator"
    ],
    "rawMarkdown": "- Hooks are fully trusted configuration.\n- Hooks run inside the workspace directory.\n- Hook output SHOULD be truncated in logs.\n- Hook timeouts are REQUIRED to avoid hanging the orchestrator."
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
    "id": "block-0842-blank-blank",
    "type": "blank",
    "lineStart": 1654,
    "lineEnd": 1654,
    "generatedClaimIds": [
      "risk-15-5-harness-hardening-guidance-implementations-should-explicitly-evaluate-their-own-risk-profile-and-harden-the"
    ],
    "rawMarkdown": ""
  }
]
```
