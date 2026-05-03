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
    "id": "requirement-7-1-issue-orchestration-states-the-worker-may-continue-through-multiple-back-to-back-coding-agent-turns-before-",
    "type": "requirement",
    "title": "The worker MAY continue through multiple back-to-back coding-agent turns before it ex...",
    "text": "The worker MAY continue through multiple back-to-back coding-agent turns before it exits.",
    "normative": [
      "MAY"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 627,
      "lineEnd": 627
    }
  },
  {
    "id": "requirement-7-1-issue-orchestration-states-if-the-issue-is-still-in-an-active-state-the-worker-should-start-another-turn-on",
    "type": "requirement",
    "title": "If the issue is still in an active state, the worker SHOULD start another turn on the...",
    "text": "If the issue is still in an active state, the worker SHOULD start another turn on the same live coding-agent thread in the same workspace, up to `agent.max_turns`.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 629,
      "lineEnd": 629
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
  },
  {
    "id": "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
    "type": "risk",
    "title": "claimed and running checks are REQUIRED before launching any worker.",
    "text": "`claimed` and `running` checks are REQUIRED before launching any worker.",
    "normative": [
      "REQUIRED"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 690,
      "lineEnd": 690
    }
  },
  {
    "id": "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "requirement",
    "title": "If the worker decides to continue after a successful turn, it SHOULD start another tu...",
    "text": "If the worker decides to continue after a successful turn, it SHOULD start another turn on the same live thread using the targeted protocol.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 983,
      "lineEnd": 983
    }
  },
  {
    "id": "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an",
    "type": "requirement",
    "title": "The app-server subprocess SHOULD remain alive across those continuation turns and be...",
    "text": "The app-server subprocess SHOULD remain alive across those continuation turns and be stopped only when the worker run is ending.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 985,
      "lineEnd": 985
    }
  },
  {
    "id": "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "dependency",
    "title": "GraphQL endpoint (default https://api.linear.app/graphql)",
    "text": "GraphQL endpoint (default `https://api.linear.app/graphql`)",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1152,
      "lineEnd": 1152
    }
  },
  {
    "id": "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh",
    "type": "risk",
    "title": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "text": "Let the orchestrator treat it like any other worker failure and decide retry behavior.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1242,
      "lineEnd": 1242
    }
  }
]
```

Source Markdown blocks:
```json
[
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
  },
  {
    "id": "block-0339-heading-7-4-idempotency-and-recovery-rules",
    "type": "heading",
    "lineStart": 688,
    "lineEnd": 688,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 7.4 Idempotency and Recovery Rules"
  },
  {
    "id": "block-0341-list-the-orchestrator-serializes-state-mutations-through-one-authority-to-avoid-dupli",
    "type": "list",
    "lineStart": 690,
    "lineEnd": 694,
    "generatedClaimIds": [
      "risk-7-4-idempotency-and-recovery-rules-claimed-and-running-checks-are-required-before-launching-any-worker",
      "risk-7-4-idempotency-and-recovery-rules-reconciliation-runs-before-dispatch-on-every-tick",
      "risk-7-4-idempotency-and-recovery-rules-restart-recovery-is-tracker-driven-and-filesystem-driven-without-a-durable-orche",
      "risk-7-4-idempotency-and-recovery-rules-startup-terminal-cleanup-removes-stale-workspaces-for-issues-already-in-terminal"
    ],
    "rawMarkdown": "- The orchestrator serializes state mutations through one authority to avoid duplicate dispatch.\n- `claimed` and `running` checks are REQUIRED before launching any worker.\n- Reconciliation runs before dispatch on every tick.\n- Restart recovery is tracker-driven and filesystem-driven (without a durable orchestrator DB).\n- Startup terminal cleanup removes stale workspaces for issues already in terminal states."
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
    "id": "block-0528-blank-blank",
    "type": "blank",
    "lineStart": 983,
    "lineEnd": 983,
    "generatedClaimIds": [
      "requirement-10-3-streaming-turn-processing-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0529-list-if-the-worker-decides-to-continue-after-a-successful-turn-it-should-start-anothe",
    "type": "list",
    "lineStart": 984,
    "lineEnd": 987,
    "generatedClaimIds": [
      "requirement-10-3-streaming-turn-processing-the-app-server-subprocess-should-remain-alive-across-those-continuation-turns-an"
    ],
    "rawMarkdown": "- If the worker decides to continue after a successful turn, it SHOULD start another turn on the same\n  live thread using the targeted protocol.\n- The app-server subprocess SHOULD remain alive across those continuation turns and be stopped only\n  when the worker run is ending."
  },
  {
    "id": "block-0609-heading-11-2-query-semantics-linear",
    "type": "heading",
    "lineStart": 1148,
    "lineEnd": 1148,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.2 Query Semantics (Linear)"
  },
  {
    "id": "block-0613-list-tracker-kind-linear-graphql-endpoint-default-https-api-linear-app-graphql",
    "type": "list",
    "lineStart": 1152,
    "lineEnd": 1160,
    "generatedClaimIds": [
      "dependency-11-2-query-semantics-linear-graphql-endpoint-default-https-api-linear-app-graphql",
      "claim-11-2-query-semantics-linear-auth-token-sent-in-authorization-header",
      "claim-11-2-query-semantics-linear-tracker-projectslug-maps-to-linear-project-slugid",
      "claim-11-2-query-semantics-linear-candidate-issue-query-filters-project-using-project-slugid-eq-projectslug",
      "claim-11-2-query-semantics-linear-issue-state-refresh-query-uses-graphql-issue-ids-with-variable-type-id",
      "requirement-11-2-query-semantics-linear-pagination-required-for-candidate-issues",
      "claim-11-2-query-semantics-linear-page-size-default-50",
      "claim-11-2-query-semantics-linear-network-timeout-30000-ms"
    ],
    "rawMarkdown": "- `tracker.kind == \"linear\"`\n- GraphQL endpoint (default `https://api.linear.app/graphql`)\n- Auth token sent in `Authorization` header\n- `tracker.project_slug` maps to Linear project `slugId`\n- Candidate issue query filters project using `project: { slugId: { eq: $projectSlug } }`\n- Issue-state refresh query uses GraphQL issue IDs with variable type `[ID!]`\n- Pagination REQUIRED for candidate issues\n- Page size default: `50`\n- Network timeout: `30000 ms`"
  },
  {
    "id": "block-0663-heading-12-4-failure-semantics",
    "type": "heading",
    "lineStart": 1238,
    "lineEnd": 1238,
    "semanticRole": "risk",
    "generatedClaimIds": [],
    "rawMarkdown": "### 12.4 Failure Semantics"
  },
  {
    "id": "block-0667-list-fail-the-run-attempt-immediately-let-the-orchestrator-treat-it-like-any-other-wo",
    "type": "list",
    "lineStart": 1242,
    "lineEnd": 1243,
    "generatedClaimIds": [
      "risk-12-4-failure-semantics-let-the-orchestrator-treat-it-like-any-other-worker-failure-and-decide-retry-beh"
    ],
    "rawMarkdown": "- Fail the run attempt immediately.\n- Let the orchestrator treat it like any other worker failure and decide retry behavior."
  }
]
```
