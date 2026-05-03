You are executing Spec Gym projection `all-protocols`: All Protocols.

Projection instructions:
# All Protocols

Extract every protocol, transport, API boundary, client-server contract, and
wire-format obligation implied by the spec.

The projection should preserve explicit protocol names, source anchors, and
open questions where the protocol is implied but not specified.

Output contract:
- Format: json
- Final artifact path after merge: projections/all-protocols.json
- Type contracts: protocol

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
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "dependency",
    "title": "Implementations MUST send messages that are valid for the targeted Codex app-server v...",
    "text": "Implementations MUST send messages that are valid for the targeted Codex app-server version.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 913,
      "lineEnd": 913
    }
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
    "type": "dependency",
    "title": "Implementations MUST consult the targeted Codex app-server documentation or generated...",
    "text": "Implementations MUST consult the targeted Codex app-server documentation or generated schema instead of treating this specification as a protocol schema.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 914,
      "lineEnd": 914
    }
  },
  {
    "id": "dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro",
    "type": "dependency",
    "title": "If this specification appears to conflict with the targeted Codex app-server protocol...",
    "text": "If this specification appears to conflict with the targeted Codex app-server protocol, the Codex protocol controls protocol shape and transport behavior.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 916,
      "lineEnd": 916
    }
  },
  {
    "id": "requirement-10-1-launch-contract-transport-framing-the-protocol-transport-required-by-the-targeted-codex-app-serv",
    "type": "requirement",
    "title": "Transport/framing: the protocol transport required by the targeted Codex app-server v...",
    "text": "Transport/framing: the protocol transport required by the targeted Codex app-server version",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 928,
      "lineEnd": 928
    }
  },
  {
    "id": "claim-10-1-launch-contract-the-default-command-is-codex-app-server",
    "type": "claim",
    "title": "The default command is codex app-server.",
    "text": "The default command is `codex app-server`.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 932,
      "lineEnd": 932
    }
  },
  {
    "id": "requirement-10-1-launch-contract-approval-policy-sandbox-policy-cwd-prompt-input-and-optional-tool-declarations-a",
    "type": "requirement",
    "title": "Approval policy, sandbox policy, cwd, prompt input, and OPTIONAL tool declarations ar...",
    "text": "Approval policy, sandbox policy, cwd, prompt input, and OPTIONAL tool declarations are supplied using fields supported by the targeted Codex app-server version.",
    "normative": [
      "OPTIONAL"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 933,
      "lineEnd": 933
    }
  },
  {
    "id": "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract",
    "type": "requirement",
    "title": "Startup MUST follow the targeted Codex app-server contract.",
    "text": "Startup MUST follow the targeted Codex app-server contract.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 944,
      "lineEnd": 944
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-start-the-app-server-subprocess-in-the-per-issue-workspace",
    "type": "claim",
    "title": "Start the app-server subprocess in the per-issue workspace.",
    "text": "Start the app-server subprocess in the per-issue workspace.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 947,
      "lineEnd": 947
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0485-heading-10-agent-runner-protocol-coding-agent-integration",
    "type": "heading",
    "lineStart": 906,
    "lineEnd": 906,
    "semanticRole": "dependency",
    "generatedClaimIds": [],
    "rawMarkdown": "## 10. Agent Runner Protocol (Coding Agent Integration)"
  },
  {
    "id": "block-0490-blank-blank",
    "type": "blank",
    "lineStart": 913,
    "lineEnd": 913,
    "generatedClaimIds": [
      "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0491-list-implementations-must-send-messages-that-are-valid-for-the-targeted-codex-app-ser",
    "type": "list",
    "lineStart": 914,
    "lineEnd": 920,
    "generatedClaimIds": [
      "dependency-10-agent-runner-protocol-coding-agent-integration-implementations-must-consult-the-targeted-codex-app-server-documentation-or-gene",
      "dependency-10-agent-runner-protocol-coding-agent-integration-if-this-specification-appears-to-conflict-with-the-targeted-codex-app-server-pro",
      "dependency-10-agent-runner-protocol-coding-agent-integration-symphony-specific-requirements-in-this-section-still-control-orchestration-behav"
    ],
    "rawMarkdown": "- Implementations MUST send messages that are valid for the targeted Codex app-server version.\n- Implementations MUST consult the targeted Codex app-server documentation or generated schema\n  instead of treating this specification as a protocol schema.\n- If this specification appears to conflict with the targeted Codex app-server protocol, the Codex\n  protocol controls protocol shape and transport behavior.\n- Symphony-specific requirements in this section still control orchestration behavior, workspace\n  selection, prompt construction, continuation handling, and observability extraction."
  },
  {
    "id": "block-0493-heading-10-1-launch-contract",
    "type": "heading",
    "lineStart": 922,
    "lineEnd": 922,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.1 Launch Contract"
  },
  {
    "id": "block-0497-list-command-codex-command-invocation-bash-lc-codex-command-working-directory",
    "type": "list",
    "lineStart": 926,
    "lineEnd": 929,
    "generatedClaimIds": [
      "claim-10-1-launch-contract-invocation-bash-lc-codex-command",
      "claim-10-1-launch-contract-working-directory-workspace-path",
      "requirement-10-1-launch-contract-transport-framing-the-protocol-transport-required-by-the-targeted-codex-app-serv"
    ],
    "rawMarkdown": "- Command: `codex.command`\n- Invocation: `bash -lc <codex.command>`\n- Working directory: workspace path\n- Transport/framing: the protocol transport required by the targeted Codex app-server version"
  },
  {
    "id": "block-0500-blank-blank",
    "type": "blank",
    "lineStart": 932,
    "lineEnd": 932,
    "generatedClaimIds": [
      "claim-10-1-launch-contract-the-default-command-is-codex-app-server"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0501-list-the-default-command-is-codex-app-server-approval-policy-sandbox-policy-cwd-pr",
    "type": "list",
    "lineStart": 933,
    "lineEnd": 935,
    "generatedClaimIds": [
      "requirement-10-1-launch-contract-approval-policy-sandbox-policy-cwd-prompt-input-and-optional-tool-declarations-a"
    ],
    "rawMarkdown": "- The default command is `codex app-server`.\n- Approval policy, sandbox policy, cwd, prompt input, and OPTIONAL tool declarations are supplied\n  using fields supported by the targeted Codex app-server version."
  },
  {
    "id": "block-0507-heading-10-2-session-startup-responsibilities",
    "type": "heading",
    "lineStart": 941,
    "lineEnd": 941,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 10.2 Session Startup Responsibilities"
  },
  {
    "id": "block-0510-blank-blank",
    "type": "blank",
    "lineStart": 944,
    "lineEnd": 944,
    "generatedClaimIds": [
      "requirement-10-2-session-startup-responsibilities-startup-must-follow-the-targeted-codex-app-server-contract"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0512-blank-blank",
    "type": "blank",
    "lineStart": 947,
    "lineEnd": 947,
    "generatedClaimIds": [
      "claim-10-2-session-startup-responsibilities-start-the-app-server-subprocess-in-the-per-issue-workspace"
    ],
    "rawMarkdown": ""
  }
]
```
