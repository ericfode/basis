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
    "id": "dependency-3-1-form-registry-emitted-artifact-or-api-shape",
    "type": "dependency",
    "title": "emitted artifact or API shape",
    "text": "emitted artifact or API shape",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 163,
      "lineEnd": 163
    }
  },
  {
    "id": "dependency-3-2-projection-registry-emitted-files-or-api-calls",
    "type": "dependency",
    "title": "emitted files or API calls",
    "text": "emitted files or API calls",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 197,
      "lineEnd": 197
    }
  },
  {
    "id": "dependency-5-1-node-types-dependency-external-system-file-tool-api-or-host-assumption",
    "type": "dependency",
    "title": "dependency: external system, file, tool, API, or host assumption.",
    "text": "`dependency`: external system, file, tool, API, or host assumption.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 569,
      "lineEnd": 569
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
    "id": "test-13-definition-of-done-for-current-increment-the-symphony-service-specification-can-be-played-as-an-example-input",
    "type": "test",
    "title": "The Symphony service specification can be played as an example input.",
    "text": "The Symphony service specification can be played as an example input.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 776,
      "lineEnd": 776
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0065-heading-3-1-form-registry",
    "type": "heading",
    "lineStart": 157,
    "lineEnd": 157,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.1 Form Registry"
  },
  {
    "id": "block-0069-list-form-id-purpose-accepted-input-forms-emitted-artifact-or-api-shape-schema-v",
    "type": "list",
    "lineStart": 161,
    "lineEnd": 167,
    "generatedClaimIds": [
      "claim-3-1-form-registry-purpose",
      "claim-3-1-form-registry-accepted-input-forms",
      "dependency-3-1-form-registry-emitted-artifact-or-api-shape",
      "claim-3-1-form-registry-schema-version-when-machine-readable",
      "claim-3-1-form-registry-lossy-transformations",
      "test-3-1-form-registry-validation-command-or-manual-check"
    ],
    "rawMarkdown": "- form ID\n- purpose\n- accepted input forms\n- emitted artifact or API shape\n- schema version when machine-readable\n- lossy transformations\n- validation command or manual check"
  },
  {
    "id": "block-0077-heading-3-2-projection-registry",
    "type": "heading",
    "lineStart": 188,
    "lineEnd": 188,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.2 Projection Registry"
  },
  {
    "id": "block-0083-list-projection-id-purpose-accepted-input-forms-emitted-files-or-api-calls-targe",
    "type": "list",
    "lineStart": 195,
    "lineEnd": 205,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-purpose",
      "claim-3-2-projection-registry-accepted-input-forms",
      "dependency-3-2-projection-registry-emitted-files-or-api-calls",
      "claim-3-2-projection-registry-target-artifact-contract",
      "claim-3-2-projection-registry-lossy-transformations",
      "test-3-2-projection-registry-validation-command-or-manual-check",
      "claim-3-2-projection-registry-focus-strategy-for-small-source-slices",
      "claim-3-2-projection-registry-merge-strategy-for-partial-llm-outputs",
      "requirement-3-2-projection-registry-whether-it-is-included-by-projection-all-reverse-direction-projections-such-as-c"
    ],
    "rawMarkdown": "- projection ID\n- purpose\n- accepted input forms\n- emitted files or API calls\n- target artifact contract\n- lossy transformations\n- validation command or manual check\n- focus strategy for small source slices\n- merge strategy for partial LLM outputs\n- whether it is included by `--projection all`; reverse-direction projections\n  such as code-to-spec SHOULD be explicit-only"
  },
  {
    "id": "block-0251-heading-5-1-node-types",
    "type": "heading",
    "lineStart": 562,
    "lineEnd": 562,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 5.1 Node Types"
  },
  {
    "id": "block-0253-list-spec-root-input-document-section-source-heading-and-line-range-goal-desire",
    "type": "list",
    "lineStart": 564,
    "lineEnd": 574,
    "generatedClaimIds": [
      "claim-5-1-node-types-section-source-heading-and-line-range",
      "claim-5-1-node-types-goal-desired-outcome",
      "claim-5-1-node-types-nongoal-explicit-boundary",
      "claim-5-1-node-types-requirement-normative-claim",
      "claim-5-1-node-types-component-named-subsystem-actor-layer-or-responsibility",
      "dependency-5-1-node-types-dependency-external-system-file-tool-api-or-host-assumption",
      "test-5-1-node-types-test-validation-surface-or-conformance-check",
      "claim-5-1-node-types-risk-safety-recovery-trust-failure-or-ambiguity-pressure",
      "claim-5-1-node-types-claim-extracted-assertion-not-yet-sharpened",
      "claim-5-1-node-types-finding-generated-bad-idea-pressure"
    ],
    "rawMarkdown": "- `spec`: root input document.\n- `section`: source heading and line range.\n- `goal`: desired outcome.\n- `non_goal`: explicit boundary.\n- `requirement`: normative claim.\n- `component`: named subsystem, actor, layer, or responsibility.\n- `dependency`: external system, file, tool, API, or host assumption.\n- `test`: validation surface or conformance check.\n- `risk`: safety, recovery, trust, failure, or ambiguity pressure.\n- `claim`: extracted assertion not yet sharpened.\n- `finding`: generated bad-idea pressure."
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
