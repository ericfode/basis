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
    "id": "dependency-a-3-problems-to-consider-each-host-needs-the-expected-shell-environment-coding-agent-executable-auth-and-",
    "type": "dependency",
    "title": "Each host needs the expected shell environment, coding-agent executable, auth, and re...",
    "text": "Each host needs the expected shell environment, coding-agent executable, auth, and repository prerequisites.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2152,
      "lineEnd": 2152
    }
  },
  {
    "id": "dependency-a-3-problems-to-consider-workspaces-are-usually-host-local-so-moving-an-issue-to-a-different-host-is-typi",
    "type": "dependency",
    "title": "Workspaces are usually host-local, so moving an issue to a different host is typicall...",
    "text": "Workspaces are usually host-local, so moving an issue to a different host is typically a cold restart unless shared storage exists.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2155,
      "lineEnd": 2155
    }
  },
  {
    "id": "requirement-a-3-problems-to-consider-implementations-should-distinguish-host-connectivity-startup-failures-from-in-wo",
    "type": "requirement",
    "title": "Implementations SHOULD distinguish host-connectivity/startup failures from in-workspa...",
    "text": "Implementations SHOULD distinguish host-connectivity/startup failures from in-workspace agent failures so the same ticket is not accidentally re-executed on multiple hosts.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2161,
      "lineEnd": 2161
    }
  },
  {
    "id": "dependency-a-3-problems-to-consider-host-health-and-saturation",
    "type": "dependency",
    "title": "Host health and saturation:",
    "text": "Host health and saturation:",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2163,
      "lineEnd": 2163
    }
  },
  {
    "id": "requirement-a-3-problems-to-consider-a-dead-or-overloaded-host-should-reduce-available-capacity-not-cause-duplicate-e",
    "type": "requirement",
    "title": "A dead or overloaded host SHOULD reduce available capacity, not cause duplicate execu...",
    "text": "A dead or overloaded host SHOULD reduce available capacity, not cause duplicate execution or an accidental fallback to local work.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2164,
      "lineEnd": 2164
    }
  },
  {
    "id": "dependency-a-3-problems-to-consider-operators-need-to-know-which-host-owns-a-run-where-its-workspace-lives-and-wheth",
    "type": "dependency",
    "title": "Operators need to know which host owns a run, where its workspace lives, and whether...",
    "text": "Operators need to know which host owns a run, where its workspace lives, and whether cleanup happened on the right machine.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2167,
      "lineEnd": 2167
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0957-heading-a-3-problems-to-consider",
    "type": "heading",
    "lineStart": 2150,
    "lineEnd": 2150,
    "semanticRole": "problem",
    "generatedClaimIds": [],
    "rawMarkdown": "### A.3 Problems to Consider"
  },
  {
    "id": "block-0959-list-remote-environment-drift-each-host-needs-the-expected-shell-environment-coding",
    "type": "list",
    "lineStart": 2152,
    "lineEnd": 2169,
    "generatedClaimIds": [
      "dependency-a-3-problems-to-consider-each-host-needs-the-expected-shell-environment-coding-agent-executable-auth-and-",
      "claim-a-3-problems-to-consider-workspace-locality",
      "dependency-a-3-problems-to-consider-workspaces-are-usually-host-local-so-moving-an-issue-to-a-different-host-is-typi",
      "claim-a-3-problems-to-consider-path-and-command-safety",
      "claim-a-3-problems-to-consider-remote-path-resolution-shell-quoting-and-workspace-boundary-checks-matter-more-o",
      "claim-a-3-problems-to-consider-startup-and-failover-semantics",
      "requirement-a-3-problems-to-consider-implementations-should-distinguish-host-connectivity-startup-failures-from-in-wo",
      "dependency-a-3-problems-to-consider-host-health-and-saturation",
      "requirement-a-3-problems-to-consider-a-dead-or-overloaded-host-should-reduce-available-capacity-not-cause-duplicate-e",
      "claim-a-3-problems-to-consider-cleanup-and-observability",
      "dependency-a-3-problems-to-consider-operators-need-to-know-which-host-owns-a-run-where-its-workspace-lives-and-wheth"
    ],
    "rawMarkdown": "- Remote environment drift:\n  - Each host needs the expected shell environment, coding-agent executable, auth, and repository\n    prerequisites.\n- Workspace locality:\n  - Workspaces are usually host-local, so moving an issue to a different host is typically a cold\n    restart unless shared storage exists.\n- Path and command safety:\n  - Remote path resolution, shell quoting, and workspace-boundary checks matter more once execution\n    crosses a machine boundary.\n- Startup and failover semantics:\n  - Implementations SHOULD distinguish host-connectivity/startup failures from in-workspace agent\n    failures so the same ticket is not accidentally re-executed on multiple hosts.\n- Host health and saturation:\n  - A dead or overloaded host SHOULD reduce available capacity, not cause duplicate execution or an\n    accidental fallback to local work.\n- Cleanup and observability:\n  - Operators need to know which host owns a run, where its workspace lives, and whether cleanup\n    happened on the right machine."
  }
]
```
