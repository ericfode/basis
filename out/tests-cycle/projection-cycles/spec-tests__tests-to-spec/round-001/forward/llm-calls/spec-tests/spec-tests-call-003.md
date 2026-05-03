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
    "id": "requirement-6-codex-app-server-runner-the-runner-must-reject-output-that-cannot-be-parsed-as-the-target-form-or-that",
    "type": "requirement",
    "title": "The runner MUST reject output that cannot be parsed as the target form or that",
    "text": "The runner MUST reject output that cannot be parsed as the target form or that",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 620,
      "lineEnd": 620
    }
  },
  {
    "id": "requirement-6-codex-app-server-runner-failure-states-should-be-normalized-as",
    "type": "requirement",
    "title": "Failure states SHOULD be normalized as:",
    "text": "Failure states SHOULD be normalized as:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 633,
      "lineEnd": 633
    }
  },
  {
    "id": "test-7-environment-boundary-action-split-merge-strengthen-weaken-restate-classify-add-evidence-add-negati",
    "type": "test",
    "title": "action: split, merge, strengthen, weaken, restate, classify, add evidence, add negati...",
    "text": "`action`: split, merge, strengthen, weaken, restate, classify, add evidence, add negative test, add proof obligation, mark non-goal, reject idea, or ask for a narrower experiment.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 654,
      "lineEnd": 654
    }
  },
  {
    "id": "test-7-environment-boundary-actor-human-agent-prover-test-runner-projection-adapter-or-policy",
    "type": "test",
    "title": "actor: human, agent, prover, test runner, projection adapter, or policy.",
    "text": "`actor`: human, agent, prover, test runner, projection adapter, or policy.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 657,
      "lineEnd": 657
    }
  },
  {
    "id": "requirement-8-bad-idea-pressure-the-toolkit-should-detect-at-least-these-failure-modes",
    "type": "requirement",
    "title": "The toolkit SHOULD detect at least these failure modes:",
    "text": "The toolkit SHOULD detect at least these failure modes:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 668,
      "lineEnd": 668
    }
  },
  {
    "id": "claim-8-bad-idea-pressure-unfalsifiable-no-clear-validation-could-prove-the-idea-wrong",
    "type": "claim",
    "title": "unfalsifiable: no clear validation could prove the idea wrong.",
    "text": "`unfalsifiable`: no clear validation could prove the idea wrong.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 675,
      "lineEnd": 675
    }
  },
  {
    "id": "test-11-projection-boundary-verification-command-or-manual-check",
    "type": "test",
    "title": "verification command or manual check",
    "text": "verification command or manual check",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md",
      "lineStart": 743,
      "lineEnd": 743
    }
  },
  {
    "id": "finding-misses-problem-low-overlap",
    "type": "finding",
    "title": "Problem, goals, and tests have weak lexical overlap",
    "text": "Problem-goal overlap 0.06, problem-test overlap 0.07. Low overlap is not proof of failure, but it is a good prompt to link goals and tests explicitly.",
    "normative": [],
    "source": {
      "path": "/Users/ericfode/Documents/New project 4/spec.md"
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
    "id": "block-0280-blank-blank",
    "type": "blank",
    "lineStart": 620,
    "lineEnd": 620,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-the-runner-must-reject-output-that-cannot-be-parsed-as-the-target-form-or-that"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0286-blank-blank",
    "type": "blank",
    "lineStart": 633,
    "lineEnd": 633,
    "generatedClaimIds": [
      "requirement-6-codex-app-server-runner-failure-states-should-be-normalized-as"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0291-heading-7-environment-boundary",
    "type": "heading",
    "lineStart": 647,
    "lineEnd": 647,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 7. Environment Boundary"
  },
  {
    "id": "block-0297-list-observation-source-spec-source-anchors-claim-lattice-obligation-graph-viabilit",
    "type": "list",
    "lineStart": 653,
    "lineEnd": 665,
    "generatedClaimIds": [
      "test-7-environment-boundary-action-split-merge-strengthen-weaken-restate-classify-add-evidence-add-negati",
      "test-7-environment-boundary-actor-human-agent-prover-test-runner-projection-adapter-or-policy",
      "claim-7-environment-boundary-reward-verifiability-score-delta-traceability-score-delta-falsifiability-score-d",
      "claim-7-environment-boundary-done-implementation-ready-threshold-reached-idea-rejected-or-unresolved-state-pr",
      "claim-7-environment-boundary-safetyinvariant-a-player-cannot-improve-score-by-deleting-source-evidence-or-wea"
    ],
    "rawMarkdown": "- `observation`: source spec, source anchors, claim lattice, obligation graph,\n  viability critique, verification surfaces, and projection outputs.\n- `action`: split, merge, strengthen, weaken, restate, classify, add evidence,\n  add negative test, add proof obligation, mark non-goal, reject idea, or ask for\n  a narrower experiment.\n- `actor`: human, agent, prover, test runner, projection adapter, or policy.\n- `reward`: verifiability score delta, traceability score delta,\n  falsifiability score delta, contradiction reduction, ambiguity reduction,\n  obligations discharged, negative tests rejected, or invalid idea rejected.\n- `done`: implementation-ready threshold reached, idea rejected, or unresolved\n  state preserved with named missing evidence.\n- `safetyInvariant`: a player cannot improve score by deleting source evidence\n  or weakening the stated problem without recording that tradeoff."
  },
  {
    "id": "block-0299-heading-8-bad-idea-pressure",
    "type": "heading",
    "lineStart": 667,
    "lineEnd": 667,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "## 8. Bad-Idea Pressure"
  },
  {
    "id": "block-0300-blank-blank",
    "type": "blank",
    "lineStart": 668,
    "lineEnd": 668,
    "generatedClaimIds": [
      "requirement-8-bad-idea-pressure-the-toolkit-should-detect-at-least-these-failure-modes"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0303-list-impossible-constraints-cannot-all-hold-at-once-useless-success-does-not-improv",
    "type": "list",
    "lineStart": 671,
    "lineEnd": 676,
    "generatedClaimIds": [
      "claim-8-bad-idea-pressure-useless-success-does-not-improve-the-stated-problem",
      "claim-8-bad-idea-pressure-morecomplexthannothing-coordination-cost-exceeds-justified-value",
      "claim-8-bad-idea-pressure-missesproblem-machinery-optimizes-adjacent-work-instead-of-the-problem",
      "claim-8-bad-idea-pressure-underspecified-behavior-affecting-choices-are-unnamed",
      "claim-8-bad-idea-pressure-unfalsifiable-no-clear-validation-could-prove-the-idea-wrong"
    ],
    "rawMarkdown": "- `impossible`: constraints cannot all hold at once.\n- `useless`: success does not improve the stated problem.\n- `more_complex_than_nothing`: coordination cost exceeds justified value.\n- `misses_problem`: machinery optimizes adjacent work instead of the problem.\n- `underspecified`: behavior-affecting choices are unnamed.\n- `unfalsifiable`: no clear validation could prove the idea wrong."
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
  }
]
```
