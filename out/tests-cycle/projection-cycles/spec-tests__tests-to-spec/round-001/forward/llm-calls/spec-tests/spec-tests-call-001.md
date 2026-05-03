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
    "id": "test-3-1-form-registry-validation-command-or-manual-check",
    "type": "test",
    "title": "validation command or manual check",
    "text": "validation command or manual check",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 166,
      "lineEnd": 166
    }
  },
  {
    "id": "claim-3-1-form-registry-specdraft-generated-markdown-awaiting-review-or-acceptance-as-source",
    "type": "claim",
    "title": "specdraft: generated Markdown awaiting review or acceptance as source.",
    "text": "`spec_draft`: generated Markdown awaiting review or acceptance as source.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 172,
      "lineEnd": 172
    }
  },
  {
    "id": "test-3-1-form-registry-testsuite-test-plan-executable-test-outline-or-focused-test-slices-used-as-proje",
    "type": "test",
    "title": "testsuite: test plan, executable-test outline, or focused test slices used as project...",
    "text": "`test_suite`: test plan, executable-test outline, or focused test slices used as projection output or reverse input.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 179,
      "lineEnd": 179
    }
  },
  {
    "id": "test-3-2-projection-registry-validation-command-or-manual-check",
    "type": "test",
    "title": "validation command or manual check",
    "text": "validation command or manual check",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 200,
      "lineEnd": 200
    }
  },
  {
    "id": "claim-3-2-projection-registry-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-and",
    "type": "claim",
    "title": "requirementsjson: emits requirements.json from requirement, goal, non-goal, risk, and...",
    "text": "`requirements_json`: emits `requirements.json` from requirement, goal, non-goal, risk, and validation claims.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 208,
      "lineEnd": 208
    }
  },
  {
    "id": "claim-3-2-projection-registry-architecturemarkdown-emits-architecture-md-from-component-dependency-risk-and-va",
    "type": "claim",
    "title": "architecturemarkdown: emits architecture.md from component, dependency, risk, and val...",
    "text": "`architecture_markdown`: emits `architecture.md` from component, dependency, risk, and validation claims.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 210,
      "lineEnd": 210
    }
  },
  {
    "id": "test-3-3-type-registry-types-test-suite-schema-json",
    "type": "test",
    "title": "types/test-suite.schema.json",
    "text": "`types/test-suite.schema.json`",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 248,
      "lineEnd": 248
    }
  },
  {
    "id": "claim-3-5-transform-record-validation-gates",
    "type": "claim",
    "title": "validation gates",
    "text": "validation gates",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 310,
      "lineEnd": 310
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
    "id": "block-0073-list-spec-normalized-markdown-input-with-source-anchors-dataifiedspec-low-loss-stru",
    "type": "list",
    "lineStart": 171,
    "lineEnd": 181,
    "generatedClaimIds": [
      "claim-3-1-form-registry-dataifiedspec-low-loss-structured-spec-with-raw-markdown-preservation",
      "claim-3-1-form-registry-specdraft-generated-markdown-awaiting-review-or-acceptance-as-source",
      "claim-3-1-form-registry-claim-typed-claim-lattice-and-source-backed-graph",
      "claim-3-1-form-registry-critique-bad-idea-pressure-over-the-claim-form",
      "claim-3-1-form-registry-refinement-the-next-narrow-correction-packet",
      "claim-3-1-form-registry-provermock-prover-facing-model-derived-from-the-claim-form",
      "claim-3-1-form-registry-architecturedocument-architecture-markdown-or-structured-architecture-extracted-",
      "test-3-1-form-registry-testsuite-test-plan-executable-test-outline-or-focused-test-slices-used-as-proje"
    ],
    "rawMarkdown": "- `spec`: normalized Markdown input with source anchors.\n- `dataified_spec`: low-loss structured spec with raw Markdown preservation.\n- `spec_draft`: generated Markdown awaiting review or acceptance as source.\n- `claim`: typed claim lattice and source-backed graph.\n- `critique`: bad-idea pressure over the claim form.\n- `refinement`: the next narrow correction packet.\n- `prover_mock`: prover-facing model derived from the claim form.\n- `architecture_document`: architecture Markdown or structured architecture\n  extracted from the spec or used as reverse input.\n- `test_suite`: test plan, executable-test outline, or focused test slices used\n  as projection output or reverse input."
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
    "id": "block-0086-blank-blank",
    "type": "blank",
    "lineStart": 208,
    "lineEnd": 208,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-and"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0087-list-requirementsjson-emits-requirements-json-from-requirement-goal-non-goal-risk-a",
    "type": "list",
    "lineStart": 209,
    "lineEnd": 219,
    "generatedClaimIds": [
      "claim-3-2-projection-registry-architecturemarkdown-emits-architecture-md-from-component-dependency-risk-and-va",
      "claim-3-2-projection-registry-protobufschema-emits-a-proto-schema-for-the-selected-spec-interface-or-interchan",
      "claim-3-2-projection-registry-graphdataset-emits-graph-import-files-for-graph-query-or-collaborative-map-tools",
      "claim-3-2-projection-registry-provermodel-emits-prover-facing-facts-and-mock-models",
      "claim-3-2-projection-registry-executionpacket-emits-work-packets-for-humans-agents-or-orchestration-systems"
    ],
    "rawMarkdown": "- `requirements_json`: emits `requirements.json` from requirement, goal,\n  non-goal, risk, and validation claims.\n- `architecture_markdown`: emits `architecture.md` from component, dependency,\n  risk, and validation claims.\n- `protobuf_schema`: emits a `.proto` schema for the selected spec interface or\n  interchange model.\n- `graph_dataset`: emits graph import files for graph-query or collaborative\n  map tools.\n- `prover_model`: emits prover-facing facts and mock models.\n- `execution_packet`: emits work packets for humans, agents, or orchestration\n  systems."
  },
  {
    "id": "block-0095-heading-3-3-type-registry",
    "type": "heading",
    "lineStart": 236,
    "lineEnd": 236,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.3 Type Registry"
  },
  {
    "id": "block-0101-list-types-data-type-schema-json-types-protocol-schema-json-types-requirement-schema",
    "type": "list",
    "lineStart": 242,
    "lineEnd": 250,
    "generatedClaimIds": [
      "claim-3-3-type-registry-types-protocol-schema-json",
      "claim-3-3-type-registry-types-requirement-schema-json",
      "claim-3-3-type-registry-types-architecture-document-schema-json",
      "claim-3-3-type-registry-types-implementation-question-schema-json",
      "claim-3-3-type-registry-types-protobuf-schema-schema-json",
      "claim-3-3-type-registry-types-spec-draft-schema-json",
      "test-3-3-type-registry-types-test-suite-schema-json",
      "claim-3-3-type-registry-types-projection-cycle-schema-json"
    ],
    "rawMarkdown": "- `types/data-type.schema.json`\n- `types/protocol.schema.json`\n- `types/requirement.schema.json`\n- `types/architecture-document.schema.json`\n- `types/implementation-question.schema.json`\n- `types/protobuf-schema.schema.json`\n- `types/spec-draft.schema.json`\n- `types/test-suite.schema.json`\n- `types/projection-cycle.schema.json`"
  },
  {
    "id": "block-0117-heading-3-5-transform-record",
    "type": "heading",
    "lineStart": 296,
    "lineEnd": 296,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 3.5 Transform Record"
  },
  {
    "id": "block-0121-list-source-path-source-hash-source-form-target-form-target-schema-version-run",
    "type": "list",
    "lineStart": 301,
    "lineEnd": 312,
    "generatedClaimIds": [
      "claim-3-5-transform-record-source-hash",
      "claim-3-5-transform-record-source-form",
      "claim-3-5-transform-record-target-form",
      "claim-3-5-transform-record-target-schema-version",
      "claim-3-5-transform-record-runner",
      "claim-3-5-transform-record-runner-command",
      "claim-3-5-transform-record-codex-app-server-protocol-evidence-or-generated-schema-path-when-available",
      "claim-3-5-transform-record-prompt-or-instruction-digest",
      "claim-3-5-transform-record-output-artifact-paths",
      "claim-3-5-transform-record-validation-gates",
      "claim-3-5-transform-record-failure-state-when-the-transform-is-rejected"
    ],
    "rawMarkdown": "- source path\n- source hash\n- source form\n- target form\n- target schema version\n- runner\n- runner command\n- Codex `app-server` protocol evidence or generated schema path when available\n- prompt or instruction digest\n- output artifact paths\n- validation gates\n- failure state when the transform is rejected"
  }
]
```
