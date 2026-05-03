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
    "id": "dependency-a-1-execution-model-each-worker-run-is-assigned-to-one-host-at-a-time-and-that-host-becomes-part-of-",
    "type": "dependency",
    "title": "Each worker run is assigned to one host at a time, and that host becomes part of the...",
    "text": "Each worker run is assigned to one host at a time, and that host becomes part of the run's effective execution identity along with the issue workspace.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2125,
      "lineEnd": 2125
    }
  },
  {
    "id": "dependency-a-1-execution-model-workspace-root-is-interpreted-on-the-remote-host-not-on-the-orchestrator-host",
    "type": "dependency",
    "title": "workspace.root is interpreted on the remote host, not on the orchestrator host.",
    "text": "`workspace.root` is interpreted on the remote host, not on the orchestrator host.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2127,
      "lineEnd": 2127
    }
  },
  {
    "id": "requirement-a-1-execution-model-continuation-turns-inside-one-worker-lifetime-should-stay-on-the-same-host-and-w",
    "type": "requirement",
    "title": "Continuation turns inside one worker lifetime SHOULD stay on the same host and worksp...",
    "text": "Continuation turns inside one worker lifetime SHOULD stay on the same host and workspace.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2130,
      "lineEnd": 2130
    }
  },
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
    "id": "requirement-a-2-scheduling-notes-implementations-may-prefer-the-previously-used-host-on-retries-when-that-host-is",
    "type": "requirement",
    "title": "Implementations MAY prefer the previously used host on retries when that host is stil...",
    "text": "Implementations MAY prefer the previously used host on retries when that host is still available.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2138,
      "lineEnd": 2138
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
    "id": "requirement-a-2-scheduling-notes-implementations-may-fail-over-to-another-host-when-the-original-host-is-unavaila",
    "type": "requirement",
    "title": "Implementations MAY fail over to another host when the original host is unavailable b...",
    "text": "Implementations MAY fail over to another host when the original host is unavailable before work has meaningfully started.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2144,
      "lineEnd": 2144
    }
  },
  {
    "id": "requirement-a-2-scheduling-notes-once-a-run-has-already-produced-side-effects-a-transparent-rerun-on-another-host",
    "type": "requirement",
    "title": "Once a run has already produced side effects, a transparent rerun on another host SHO...",
    "text": "Once a run has already produced side effects, a transparent rerun on another host SHOULD be treated as a new attempt, not as invisible failover.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 2146,
      "lineEnd": 2146
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
  }
]
```
