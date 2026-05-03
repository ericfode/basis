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
    "id": "claim-6-codex-app-server-runner-protocolmismatch",
    "type": "claim",
    "title": "protocolmismatch",
    "text": "`protocol_mismatch`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 636,
      "lineEnd": 636
    }
  },
  {
    "id": "dependency-11-projection-boundary-emitted-files-or-api-calls",
    "type": "dependency",
    "title": "emitted files or API calls",
    "text": "emitted files or API calls",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 740,
      "lineEnd": 740
    }
  },
  {
    "id": "test-13-definition-of-done-for-current-increment-codex-app-server-participation-is-bounded-by-the-runner-contract",
    "type": "test",
    "title": "Codex app-server participation is bounded by the runner contract.",
    "text": "Codex `app-server` participation is bounded by the runner contract.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 772,
      "lineEnd": 772
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0267-heading-6-codex-app-server-runner",
    "type": "heading",
    "lineStart": 593,
    "lineEnd": 593,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 6. Codex App-Server Runner"
  },
  {
    "id": "block-0289-list-appserverunavailable-protocolmismatch-invalidoutputschema-missingsourceanchor",
    "type": "list",
    "lineStart": 636,
    "lineEnd": 645,
    "generatedClaimIds": [
      "claim-6-codex-app-server-runner-protocolmismatch",
      "claim-6-codex-app-server-runner-invalidoutputschema",
      "claim-6-codex-app-server-runner-missingsourceanchor",
      "claim-6-codex-app-server-runner-unsafesourcemutation",
      "claim-6-codex-app-server-runner-timeout",
      "claim-6-codex-app-server-runner-runnerrejected",
      "claim-6-codex-app-server-runner-roundtripmismatch",
      "claim-6-codex-app-server-runner-projectiondriftexceedsbudget",
      "claim-6-codex-app-server-runner-llmcallplaninvalid"
    ],
    "rawMarkdown": "- `app_server_unavailable`\n- `protocol_mismatch`\n- `invalid_output_schema`\n- `missing_source_anchor`\n- `unsafe_source_mutation`\n- `timeout`\n- `runner_rejected`\n- `roundtrip_mismatch`\n- `projection_drift_exceeds_budget`\n- `llm_call_plan_invalid`"
  },
  {
    "id": "block-0329-heading-11-projection-boundary",
    "type": "heading",
    "lineStart": 720,
    "lineEnd": 720,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 11. Projection Boundary"
  },
  {
    "id": "block-0339-list-capability-served-input-schema-version-emitted-files-or-api-calls-import-or-e",
    "type": "list",
    "lineStart": 739,
    "lineEnd": 744,
    "generatedClaimIds": [
      "claim-11-projection-boundary-input-schema-version",
      "dependency-11-projection-boundary-emitted-files-or-api-calls",
      "claim-11-projection-boundary-import-or-execution-instructions",
      "claim-11-projection-boundary-lossy-transformations",
      "test-11-projection-boundary-verification-command-or-manual-check"
    ],
    "rawMarkdown": "- capability served\n- input schema version\n- emitted files or API calls\n- import or execution instructions\n- lossy transformations\n- verification command or manual check"
  },
  {
    "id": "block-0353-heading-13-definition-of-done-for-current-increment",
    "type": "heading",
    "lineStart": 762,
    "lineEnd": 762,
    "semanticRole": "test",
    "generatedClaimIds": [],
    "rawMarkdown": "## 13. Definition of Done for Current Increment"
  },
  {
    "id": "block-0357-list-spec-md-is-the-top-level-authoritative-specification-the-primary-cli-is-specgym",
    "type": "list",
    "lineStart": 766,
    "lineEnd": 779,
    "generatedClaimIds": [
      "test-13-definition-of-done-for-current-increment-the-primary-cli-is-specgym",
      "test-13-definition-of-done-for-current-increment-spec-to-dataifiedspec-is-defined-as-the-first-transform",
      "test-13-definition-of-done-for-current-increment-dataifiedspec-to-specdraft-is-defined-as-the-first-reverse-transform",
      "test-13-definition-of-done-for-current-increment-claim-to-specdraft-is-documented-as-a-lossy-fallback",
      "test-13-definition-of-done-for-current-increment-projection-execution-emits-focused-llm-call-packets-instead-of-locally-synthesiz",
      "test-13-definition-of-done-for-current-increment-codex-app-server-participation-is-bounded-by-the-runner-contract",
      "test-13-definition-of-done-for-current-increment-default-generation-emits-only-core-artifacts",
      "test-13-definition-of-done-for-current-increment-named-projections-are-opt-in",
      "test-13-definition-of-done-for-current-increment-the-projection-boundary-is-documented",
      "test-13-definition-of-done-for-current-increment-the-symphony-service-specification-can-be-played-as-an-example-input",
      "test-13-definition-of-done-for-current-increment-the-lean-mock-model-type-checks",
      "test-13-definition-of-done-for-current-increment-the-local-tests-pass"
    ],
    "rawMarkdown": "- `spec.md` is the top-level authoritative specification.\n- The primary CLI is `specgym`.\n- `spec` to `dataified_spec` is defined as the first transform.\n- `dataified_spec` to `spec_draft` is defined as the first reverse transform.\n- `claim` to `spec_draft` is documented as a lossy fallback.\n- Projection execution emits focused LLM call packets instead of locally\n  synthesized projection content.\n- Codex `app-server` participation is bounded by the runner contract.\n- Default generation emits only core artifacts.\n- Named projections are opt-in.\n- The projection boundary is documented.\n- The Symphony service specification can be played as an example input.\n- The Lean mock model type-checks.\n- The local tests pass."
  }
]
```
