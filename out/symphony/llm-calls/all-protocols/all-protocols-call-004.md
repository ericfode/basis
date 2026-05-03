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
    "id": "claim-10-2-session-startup-responsibilities-initialize-the-app-server-session-using-the-targeted-codex-app-server-protocol",
    "type": "claim",
    "title": "Initialize the app-server session using the targeted Codex app-server protocol.",
    "text": "Initialize the app-server session using the targeted Codex app-server protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 948,
      "lineEnd": 948
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-create-or-resume-a-coding-agent-thread-according-to-the-targeted-protocol",
    "type": "claim",
    "title": "Create or resume a coding-agent thread according to the targeted protocol.",
    "text": "Create or resume a coding-agent thread according to the targeted protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 949,
      "lineEnd": 949
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-supply-the-absolute-per-issue-workspace-path-as-the-thread-turn-working-director",
    "type": "claim",
    "title": "Supply the absolute per-issue workspace path as the thread/turn working directory whe...",
    "text": "Supply the absolute per-issue workspace path as the thread/turn working directory wherever the targeted protocol accepts cwd.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 950,
      "lineEnd": 950
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-supply-the-implementation-s-documented-approval-and-sandbox-policy-using-fields-",
    "type": "claim",
    "title": "Supply the implementation's documented approval and sandbox policy using fields suppo...",
    "text": "Supply the implementation's documented approval and sandbox policy using fields supported by the targeted protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 955,
      "lineEnd": 955
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-include-issue-identifying-metadata-such-as-issue-identifier-issue-title-when-t",
    "type": "claim",
    "title": "Include issue-identifying metadata, such as <issue.identifier>: <issue.title>, when t...",
    "text": "Include issue-identifying metadata, such as `<issue.identifier>: <issue.title>`, when the targeted protocol supports turn or session titles.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 957,
      "lineEnd": 957
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-advertise-implemented-client-side-tools-using-the-targeted-protocol",
    "type": "claim",
    "title": "Advertise implemented client-side tools using the targeted protocol.",
    "text": "Advertise implemented client-side tools using the targeted protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 959,
      "lineEnd": 959
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser",
    "type": "claim",
    "title": "Extract threadid from the thread identity returned by the targeted Codex app-server p...",
    "text": "Extract `thread_id` from the thread identity returned by the targeted Codex app-server protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 963,
      "lineEnd": 963
    }
  },
  {
    "id": "claim-10-2-session-startup-responsibilities-extract-turnid-from-each-turn-identity-returned-by-the-targeted-codex-app-server",
    "type": "claim",
    "title": "Extract turnid from each turn identity returned by the targeted Codex app-server prot...",
    "text": "Extract `turn_id` from each turn identity returned by the targeted Codex app-server protocol.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 964,
      "lineEnd": 964
    }
  }
]
```

Source Markdown blocks:
```json
[
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
    "id": "block-0513-list-start-the-app-server-subprocess-in-the-per-issue-workspace-initialize-the-app-se",
    "type": "list",
    "lineStart": 948,
    "lineEnd": 960,
    "generatedClaimIds": [
      "claim-10-2-session-startup-responsibilities-initialize-the-app-server-session-using-the-targeted-codex-app-server-protocol",
      "claim-10-2-session-startup-responsibilities-create-or-resume-a-coding-agent-thread-according-to-the-targeted-protocol",
      "claim-10-2-session-startup-responsibilities-supply-the-absolute-per-issue-workspace-path-as-the-thread-turn-working-director",
      "claim-10-2-session-startup-responsibilities-start-the-first-turn-with-the-rendered-issue-prompt",
      "claim-10-2-session-startup-responsibilities-start-later-in-worker-continuation-turns-on-the-same-live-thread-with-continuati",
      "claim-10-2-session-startup-responsibilities-supply-the-implementation-s-documented-approval-and-sandbox-policy-using-fields-",
      "claim-10-2-session-startup-responsibilities-include-issue-identifying-metadata-such-as-issue-identifier-issue-title-when-t",
      "claim-10-2-session-startup-responsibilities-advertise-implemented-client-side-tools-using-the-targeted-protocol"
    ],
    "rawMarkdown": "- Start the app-server subprocess in the per-issue workspace.\n- Initialize the app-server session using the targeted Codex app-server protocol.\n- Create or resume a coding-agent thread according to the targeted protocol.\n- Supply the absolute per-issue workspace path as the thread/turn working directory wherever the\n  targeted protocol accepts cwd.\n- Start the first turn with the rendered issue prompt.\n- Start later in-worker continuation turns on the same live thread with continuation guidance rather\n  than resending the original issue prompt.\n- Supply the implementation's documented approval and sandbox policy using fields supported by the\n  targeted protocol.\n- Include issue-identifying metadata, such as `<issue.identifier>: <issue.title>`, when the targeted\n  protocol supports turn or session titles.\n- Advertise implemented client-side tools using the targeted protocol."
  },
  {
    "id": "block-0516-blank-blank",
    "type": "blank",
    "lineStart": 963,
    "lineEnd": 963,
    "generatedClaimIds": [
      "claim-10-2-session-startup-responsibilities-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0517-list-extract-threadid-from-the-thread-identity-returned-by-the-targeted-codex-app-ser",
    "type": "list",
    "lineStart": 964,
    "lineEnd": 967,
    "generatedClaimIds": [
      "claim-10-2-session-startup-responsibilities-extract-turnid-from-each-turn-identity-returned-by-the-targeted-codex-app-server",
      "claim-10-2-session-startup-responsibilities-emit-sessionid-threadid-turnid",
      "claim-10-2-session-startup-responsibilities-reuse-the-same-threadid-for-all-continuation-turns-inside-one-worker-run"
    ],
    "rawMarkdown": "- Extract `thread_id` from the thread identity returned by the targeted Codex app-server protocol.\n- Extract `turn_id` from each turn identity returned by the targeted Codex app-server protocol.\n- Emit `session_id = \"<thread_id>-<turn_id>\"`\n- Reuse the same `thread_id` for all continuation turns inside one worker run"
  }
]
```
