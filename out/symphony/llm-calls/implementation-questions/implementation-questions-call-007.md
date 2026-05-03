You are executing Spec Gym projection `implementation-questions`: Implementation Questions.

Projection instructions:
# Implementation Questions

Extract the questions that need answers before moving from spec to
implementation.

The projection should prefer questions grounded in findings, missing validation,
ambiguous requirements, and implementation-defined behavior.

Output contract:
- Format: markdown
- Final artifact path after merge: projections/implementation-questions.md
- Type contracts: implementation-question

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
    "id": "requirement-11-1-required-operations-an-implementation-must-support-these-tracker-adapter-operations",
    "type": "requirement",
    "title": "An implementation MUST support these tracker adapter operations:",
    "text": "An implementation MUST support these tracker adapter operations:",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1136,
      "lineEnd": 1136
    }
  },
  {
    "id": "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp",
    "type": "requirement",
    "title": "A non-Linear implementation MAY change transport details, but the normalized outputs...",
    "text": "A non-Linear implementation MAY change transport details, but the normalized outputs MUST match the",
    "normative": [
      "MAY",
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1166,
      "lineEnd": 1166
    }
  },
  {
    "id": "requirement-11-3-normalization-rules-candidate-issue-normalization-should-produce-fields-listed-in-section-4-1-1",
    "type": "requirement",
    "title": "Candidate issue normalization SHOULD produce fields listed in Section 4.1.1.",
    "text": "Candidate issue normalization SHOULD produce fields listed in Section 4.1.1.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1171,
      "lineEnd": 1171
    }
  },
  {
    "id": "requirement-12-3-retry-continuation-semantics-attempt-should-be-passed-to-the-template-because-the-workflow-prompt-can-provide",
    "type": "requirement",
    "title": "attempt SHOULD be passed to the template because the workflow prompt can provide diff...",
    "text": "`attempt` SHOULD be passed to the template because the workflow prompt can provide different",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1230,
      "lineEnd": 1230
    }
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "requirement",
    "title": "Operators MUST be able to see startup/validation/dispatch failures without attaching...",
    "text": "Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.",
    "normative": [
      "MUST"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1270,
      "lineEnd": 1270
    }
  },
  {
    "id": "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible",
    "type": "requirement",
    "title": "If a configured log sink fails, the service SHOULD continue running when possible and...",
    "text": "If a configured log sink fails, the service SHOULD continue running when possible and emit an operator-visible warning through any remaining sink.",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1272,
      "lineEnd": 1272
    }
  },
  {
    "id": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-should-return",
    "type": "requirement",
    "title": "SHOULD return:",
    "text": "SHOULD return:",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1278,
      "lineEnd": 1278
    }
  },
  {
    "id": "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-each-running-row-should-include-turncount",
    "type": "requirement",
    "title": "each running row SHOULD include turncount",
    "text": "each running row SHOULD include `turn_count`",
    "normative": [
      "SHOULD"
    ],
    "source": {
      "path": "/Users/ericfode/src/openai-symphony/spec.md",
      "lineStart": 1281,
      "lineEnd": 1281
    }
  }
]
```

Source Markdown blocks:
```json
[
  {
    "id": "block-0599-heading-11-1-required-operations",
    "type": "heading",
    "lineStart": 1135,
    "lineEnd": 1135,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.1 REQUIRED Operations"
  },
  {
    "id": "block-0600-blank-blank",
    "type": "blank",
    "lineStart": 1136,
    "lineEnd": 1136,
    "generatedClaimIds": [
      "requirement-11-1-required-operations-an-implementation-must-support-these-tracker-adapter-operations"
    ],
    "rawMarkdown": ""
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
    "id": "block-0618-blank-blank",
    "type": "blank",
    "lineStart": 1166,
    "lineEnd": 1166,
    "generatedClaimIds": [
      "requirement-11-2-query-semantics-linear-a-non-linear-implementation-may-change-transport-details-but-the-normalized-outp"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0621-heading-11-3-normalization-rules",
    "type": "heading",
    "lineStart": 1170,
    "lineEnd": 1170,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 11.3 Normalization Rules"
  },
  {
    "id": "block-0622-blank-blank",
    "type": "blank",
    "lineStart": 1171,
    "lineEnd": 1171,
    "generatedClaimIds": [
      "requirement-11-3-normalization-rules-candidate-issue-normalization-should-produce-fields-listed-in-section-4-1-1"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0657-heading-12-3-retry-continuation-semantics",
    "type": "heading",
    "lineStart": 1229,
    "lineEnd": 1229,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 12.3 Retry/Continuation Semantics"
  },
  {
    "id": "block-0658-blank-blank",
    "type": "blank",
    "lineStart": 1230,
    "lineEnd": 1230,
    "generatedClaimIds": [
      "requirement-12-3-retry-continuation-semantics-attempt-should-be-passed-to-the-template-because-the-workflow-prompt-can-provide"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0685-heading-13-2-logging-outputs-and-sinks",
    "type": "heading",
    "lineStart": 1265,
    "lineEnd": 1265,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.2 Logging Outputs and Sinks"
  },
  {
    "id": "block-0690-blank-blank",
    "type": "blank",
    "lineStart": 1270,
    "lineEnd": 1270,
    "generatedClaimIds": [
      "requirement-13-2-logging-outputs-and-sinks-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac"
    ],
    "rawMarkdown": ""
  },
  {
    "id": "block-0691-list-operators-must-be-able-to-see-startup-validation-dispatch-failures-without-attac",
    "type": "list",
    "lineStart": 1271,
    "lineEnd": 1274,
    "generatedClaimIds": [
      "requirement-13-2-logging-outputs-and-sinks-implementations-may-write-to-one-or-more-sinks",
      "requirement-13-2-logging-outputs-and-sinks-if-a-configured-log-sink-fails-the-service-should-continue-running-when-possible"
    ],
    "rawMarkdown": "- Operators MUST be able to see startup/validation/dispatch failures without attaching a debugger.\n- Implementations MAY write to one or more sinks.\n- If a configured log sink fails, the service SHOULD continue running when possible and emit an\n  operator-visible warning through any remaining sink."
  },
  {
    "id": "block-0693-heading-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended",
    "type": "heading",
    "lineStart": 1276,
    "lineEnd": 1276,
    "semanticRole": "claim",
    "generatedClaimIds": [],
    "rawMarkdown": "### 13.3 Runtime Snapshot / Monitoring Interface (OPTIONAL but RECOMMENDED)"
  },
  {
    "id": "block-0695-paragraph-if-the-implementation-exposes-a-synchronous-runtime-snapshot-for-dashboards-or-m",
    "type": "paragraph",
    "lineStart": 1278,
    "lineEnd": 1279,
    "generatedClaimIds": [
      "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-should-return"
    ],
    "rawMarkdown": "If the implementation exposes a synchronous runtime snapshot (for dashboards or monitoring), it\nSHOULD return:"
  },
  {
    "id": "block-0697-list-running-list-of-running-session-rows-each-running-row-should-include-turncount",
    "type": "list",
    "lineStart": 1281,
    "lineEnd": 1289,
    "generatedClaimIds": [
      "requirement-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-each-running-row-should-include-turncount",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-retrying-list-of-retry-queue-rows",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-codextotals",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-inputtokens",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-outputtokens",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-totaltokens",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-secondsrunning-aggregate-runtime-seconds-as-of-snapshot-time-including-active-se",
      "claim-13-3-runtime-snapshot-monitoring-interface-optional-but-recommended-ratelimits-latest-coding-agent-rate-limit-payload-if-available"
    ],
    "rawMarkdown": "- `running` (list of running session rows)\n- each running row SHOULD include `turn_count`\n- `retrying` (list of retry queue rows)\n- `codex_totals`\n  - `input_tokens`\n  - `output_tokens`\n  - `total_tokens`\n  - `seconds_running` (aggregate runtime seconds as of snapshot time, including active sessions)\n- `rate_limits` (latest coding-agent rate limit payload, if available)"
  }
]
```
