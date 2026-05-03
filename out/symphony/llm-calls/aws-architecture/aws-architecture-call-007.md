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
    "id": "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme",
    "type": "requirement",
    "title": "A remote host SHOULD satisfy the same basic contract as a local worker environment: r...",
    "text": "A remote host SHOULD satisfy the same basic contract as a local worker environment: reachable shell, writable workspace root, coding-agent executable, and any required auth or repository prerequisites.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2131,
      "lineEnd": 2131
    }
  },
  {
    "id": "requirement-a-2-scheduling-notes-worker-maxconcurrentagentsperhost-is-an-optional-shared-per-host-cap-across-conf",
    "type": "requirement",
    "title": "worker.maxconcurrentagentsperhost is an OPTIONAL shared per-host cap across configure...",
    "text": "`worker.max_concurrent_agents_per_host` is an OPTIONAL shared per-host cap across configured SSH hosts.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2140,
      "lineEnd": 2140
    }
  },
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
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0949-heading-a-1-execution-model",
    "type": "heading",
    "lineStart": 2121,
    "lineEnd": 2121,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### A.1 Execution Model"
  },
  {
    "id": "block-0951-list-the-orchestrator-remains-the-single-source-of-truth-for-polling-claims-retries-a",
    "type": "list",
    "lineStart": 2123,
    "lineEnd": 2134,
    "generatedClaimIds": [
      "claim-a-1-execution-model-worker-sshhosts-provides-the-candidate-ssh-destinations-for-remote-execution",
      "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
      "dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host",
      "claim-a-1-execution-model-the-coding-agent-app-server-is-launched-over-ssh-stdio-instead-of-as-a-local-sub",
      "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
      "requirement-a-1-execution-model-a-remote-host-should-satisfy-the-same-basic-contract-as-a-local-worker-environme"
    ],
    "rawMarkdown": "- The orchestrator remains the single source of truth for polling, claims, retries, and\n  reconciliation.\n- `worker.ssh_hosts` provides the candidate SSH destinations for remote execution.\n- Each worker run is assigned to one host at a time, and that host becomes part of the run's\n  effective execution identity along with the issue workspace.\n- `workspace.root` is interpreted on the remote host, not on the orchestrator host.\n- The coding-agent app-server is launched over SSH stdio instead of as a local subprocess, so the\n  orchestrator still owns the session lifecycle even though commands execute remotely.\n- Continuation turns inside one worker lifetime SHOULD stay on the same host and workspace.\n- A remote host SHOULD satisfy the same basic contract as a local worker environment: reachable\n  shell, writable workspace root, coding-agent executable, and any required auth or repository\n  prerequisites."
  },
  {
    "id": "block-0953-heading-a-2-scheduling-notes",
    "type": "heading",
    "lineStart": 2136,
    "lineEnd": 2136,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### A.2 Scheduling Notes"
  },
  {
    "id": "block-0955-list-ssh-hosts-may-be-treated-as-a-pool-for-dispatch-implementations-may-prefer-the-p",
    "type": "list",
    "lineStart": 2138,
    "lineEnd": 2148,
    "generatedClaimIds": [
      "requirement-a-2-scheduling-notes-implementations-may-prefer-the-previously-used-host-on-retries-when-that-host-is",
      "requirement-a-2-scheduling-notes-worker-maxconcurrentagentsperhost-is-an-optional-shared-per-host-cap-across-conf",
      "requirement-a-2-scheduling-notes-when-all-ssh-hosts-are-at-capacity-dispatch-should-wait-rather-than-silently-fal",
      "requirement-a-2-scheduling-notes-implementations-may-fail-over-to-another-host-when-the-original-host-is-unavaila",
      "requirement-a-2-scheduling-notes-once-a-run-has-already-produced-side-effects-a-transparent-rerun-on-another-host"
    ],
    "rawMarkdown": "- SSH hosts MAY be treated as a pool for dispatch.\n- Implementations MAY prefer the previously used host on retries when that host is still\n  available.\n- `worker.max_concurrent_agents_per_host` is an OPTIONAL shared per-host cap across configured SSH\n  hosts.\n- When all SSH hosts are at capacity, dispatch SHOULD wait rather than silently falling back to a\n  different execution mode.\n- Implementations MAY fail over to another host when the original host is unavailable before work\n  has meaningfully started.\n- Once a run has already produced side effects, a transparent rerun on another host SHOULD be\n  treated as a new attempt, not as invisible failover."
  },
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
