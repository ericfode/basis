# Bad Technical Spec Style Catalog

Date: 2026-05-08

Purpose: identify technically correct but bad specification styles worth testing
against the `ls-lite` fixture.

This catalog focuses on the case the experiment actually cares about:

> The spec is technically true, but its shape may make implementation less
> reliable, slower, more repair-heavy, or less robust under weaker agents.

## Prior Art Scraped

- NASA Systems Engineering Handbook, Appendix C: requirement terms, clarity,
  completeness, traceability, consistency, implementation freedom,
  verifiability, and weak coupling.
- EARS: natural-language requirements are imprecise unless constrained; clauses
  are easier to read when they appear in a stable order.
- Requirements-smell literature: ambiguity, vagueness, loopholes,
  unverifiability, complexity, passive voice, coordination ambiguity, pronouns,
  subjective terms, and implementation leakage recur as detectable smells.
- Mature `ls` references: utility manuals show how much behavior is in option
  semantics, operand partitioning, hidden-name rules, file-type markers,
  recursion, stdout/stderr, and exit status.

## Interpretation For This Experiment

Behavioral hidden tests can only tell whether builders recovered the behavior.
They do not directly measure whether the spec was painful. A technically correct
but bad spec may still produce perfect builds when the model is strong and the
target is small.

Therefore each style below has two evaluation modes:

- `behavior`: hidden tests over the final program
- `process`: first-pass success rate, repair iterations, wall time, token load,
  number of ambiguity questions, and robustness under lower-capability agents

The second mode is needed to detect "correct but suboptimal" specs.

## Styles

### 1. Verbose Redundant Restatement

The spec repeats the same rules in many places using slightly different wording.

Expected damage: extra token load, more chance of local contradiction, slower
traceability.

Technically correct if every restatement is semantically identical.

Primary prior art: NASA concision and one-thought guidance; EARS wordiness and
complexity motivation.

### 2. Non-Technical Metaphor

The spec replaces precise operational terms with folk language: "show things the
normal way", "make folders feel like folders", "do the friendly thing".

Expected damage: agents infer host-specific conventions instead of the intended
portable subset.

Technically correct only if precise facts still appear elsewhere.

Primary prior art: NASA unverifiable terms; requirements-smell subjective
language.

### 3. Entangled Obligations

Several independent rules are fused into one paragraph or sentence, such as
sorting, hidden-file policy, indicator suffixes, and recursive traversal all in
one block.

Expected damage: missed child obligations and partial implementation.

Technically correct if the fused paragraph contains all facts.

Primary prior art: NASA one thought per requirement; requirements-smell
coordination ambiguity and non-atomic requirements.

### 4. Examples Before General Rules

The spec gives correct examples, then later implies the general rule in prose.

Expected damage: builders overfit examples and miss unshown cases.

Technically correct if examples and prose jointly cover the rule.

Primary prior art: NASA completeness/verifiability; ProgramBench-style hidden
behavior testing.

### 5. General Rules Before Definitions

The spec uses terms such as "operand", "hidden", "directory block", "indicator",
and "partition" before defining them.

Expected damage: early misparse that contaminates later implementation.

Technically correct if definitions eventually appear.

Primary prior art: NASA consistent terminology and glossary guidance.

### 6. Scattered Edge Cases

Edge cases are placed in notes, examples, footnotes, appendix-like sections, or
parenthetical remarks instead of next to the rule they qualify.

Expected damage: otherwise-good implementation misses errors and corner cases.

Technically correct if all edge cases are present.

Primary prior art: NASA requirement located in proper section; completeness
checklists.

### 7. Cross-Reference Maze

Rules are split into many small numbered fragments that refer to each other:
"except as described in 4.2 unless 6.1 applies".

Expected damage: traceability burden and missed precedence.

Technically correct if references are resolvable and acyclic.

Primary prior art: NASA traceability and unique reference guidance.

### 8. Inconsistent Synonyms

The same concept is called "path", "operand", "target", "argument", and "entry"
without a glossary.

Expected damage: wrong level of behavior, especially file operands vs displayed
entries.

Technically correct if context disambiguates every occurrence.

Primary prior art: NASA consistent terminology.

### 9. Pronoun And Deictic Drift

The spec uses "it", "this", "those", "the former", "the latter" across long
paragraphs.

Expected damage: wrong rule attachment.

Technically correct if a careful human can resolve references.

Primary prior art: NASA warns against indefinite pronouns; requirements-smell
anaphora/vague pronouns.

### 10. Vague Qualifiers Around Precise Rules

The spec contains the exact rule but wraps it in words like "usually", "normal",
"reasonable", "where appropriate", or "in most cases".

Expected damage: agents treat required behavior as optional.

Technically correct only if another clause removes the ambiguity.

Primary prior art: NASA unverifiable term list; requirements-smell vagueness and
loopholes.

### 11. Modal Blur

Required behavior is mixed with `should`, `may`, "try to", or "prefer" even
though the behavior is part of the benchmark.

Expected damage: incomplete implementation because agents choose not to enforce
some behavior.

Technically correct only if the document states those modals are normative for
this task.

Primary prior art: NASA `shall`/`will`/`should` distinction.

### 12. Passive Voice

The spec says "headers are printed" or "entries are included" without naming the
program or condition.

Expected damage: missing trigger/condition and poorer state modeling.

Technically correct if condition is recoverable nearby.

Primary prior art: NASA active voice guidance; requirements-smell passive voice.

### 13. Requirement Mixed With Rationale

The rule and its explanation are in one paragraph, e.g. "because users expect
scripts to be stable, output is one entry per line".

Expected damage: agents preserve rationale and miss the rule or misweight it.

Technically correct if the rule is explicit.

Primary prior art: NASA says a requirement statement should not mix multiple
requirements or rationale.

### 14. Implementation Leakage

The spec tells builders to use `fs.readdir`, arrays, recursion functions, or
string concatenation instead of stating externally visible behavior.

Expected damage: compliance with implementation hints instead of behavior,
especially when hints are incomplete.

Technically correct if hints do not contradict behavior.

Primary prior art: NASA "what, not how"; requirements-smell design terms.

### 15. Over-Scoped Background

The spec includes long material about GNU, BSD, POSIX history, terminals, locale,
long listings, colors, and permissions even though the task excludes them.

Expected damage: scope confusion and gold-plated behavior.

Technically correct if exclusions are stated somewhere.

Primary prior art: NASA necessary requirements and needs-vs-wants guidance;
gold-plating anti-pattern.

### 16. Negative-Only Definition

The spec says what not to print: no colors, no permissions, no columns, no
timestamps, no totals, but delays the affirmative output shape.

Expected damage: underspecified positive behavior.

Technically correct if affirmative behavior is present elsewhere.

Primary prior art: NASA positive statement guidance.

### 17. Hidden Defaults

The spec relies on external knowledge: "default `ls` behavior applies" or "normal
Unix ordering" without restating the portable subset.

Expected damage: platform-dependent behavior and host-specific drift.

Technically correct if the intended audience already knows the referenced
standard, but bad for agents under isolated instructions.

Primary prior art: mature `ls` manuals show many defaults that casual `ls`
knowledge misses.

### 18. Exception After The Rule

The spec gives a broad rule, then several later exceptions that override it.

Expected damage: implementation locks in the first rule and misses exception
precedence.

Technically correct if exceptions are explicit and non-conflicting.

Primary prior art: EARS stable clause order; NASA clarity and consistency.

### 19. Table-Prose Mismatch

A table lists options while prose later adds constraints not visible in the
table, or examples imply behavior not present in either place.

Expected damage: agents implement the table and miss prose constraints.

Technically correct if table and prose do not contradict.

Primary prior art: requirements-smell incomplete listings and incomplete
references.

### 20. Weak Error Contract

The successful behavior is precise, but diagnostics, exit status, partial
success, and continue-on-error semantics are described narratively.

Expected damage: hidden tests fail on stderr/status while main output passes.

Technically correct if the narrative includes the facts.

Primary prior art: NASA verification/testability and reliability/error handling
checklists.

### 21. Platform-Dependent Terms

The spec says "alphabetical", "executable", "symlink", "current directory", or
"locale" without pinning the portable interpretation.

Expected damage: different but plausible outputs across systems or languages.

Technically correct if the implementation environment is fixed, but bad as a
portable spec.

Primary prior art: `ls` manual variants and locale/collation behavior.

### 22. Duplicate Near-Requirements

The same behavior is stated once generally and once in an example, with different
surface form but no semantic difference.

Expected damage: reader treats one copy as an extra case or misses that they are
the same dimension.

Technically correct if both copies agree.

Primary prior art: EARS duplication problem list; Basis reducer redundancy
model.

### 23. Long Paragraph Morphology

The spec is technically precise but uses very long paragraphs, long sentences,
and dense punctuation.

Expected damage: attention loss and missed clauses.

Technically correct if parseable.

Primary prior art: requirements-smell morphological smells and NASA concision.

### 24. Rhetorical Ordering

The spec is organized like an essay: motivation, history, examples, exceptions,
then contract, instead of contract-first.

Expected damage: implementation starts before full contract is known.

Technically correct if every rule exists.

Primary prior art: EARS clause ordering and NASA proper-section guidance.

## Candidate Next Experiments

Run 3-agent pilots first, then scale only styles that appear discriminative.

Priority candidates:

1. Entangled obligations
2. Scattered edge cases
3. Cross-reference maze
4. Inconsistent synonyms
5. Modal blur
6. Implementation leakage
7. Over-scoped background
8. Exception after the rule
9. Weak error contract
10. Platform-dependent terms

Expected measurement:

- final hidden-test fitness
- first-pass perfect rate
- failure bucket distribution
- solution size
- wall-clock build time
- number of self-check attempts when observable
- variance across weaker/faster agents

Current conclusion from `suboptimal-v2`: if a bad spec still contains all
operational facts in a recoverable way, strong builders can reconstruct the
target perfectly. To prove reducer value, the experiment must measure process
cost or use bad styles that specifically induce recoverable but likely missed
projection pressure.
