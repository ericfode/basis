# ProgramBench-Lite Spec Fitness Experiment

This experiment repeats the spec-fitness discrimination test with a more
ProgramBench-like target.

ProgramBench-style constraint:

- builders receive usage documentation
- builders may run a black-box reference executable
- builders must implement a replacement program from scratch
- evaluation uses hidden behavioral tests over stdout, stderr, exit status, and
  file/stdin behavior

The target here is intentionally small enough to run locally, but it is a real
CLI reconstruction task rather than a single exported function.

Conditions:

- `good-spec.md`: explicit CLI contract and observable behavior
- `bad-spec.md`: same purpose and command names, but underspecified behavior

Builder output:

- a Node.js ES module CLI named `solution.mjs`

Evaluator:

- `evaluator.mjs` runs hidden cases against each candidate
- it emits a score vector for interface, behavior, edge cases, errors, JSON,
  and purity

Reference executable:

- during the run, `fixtures/oracle-cfgtool.mjs` is copied to
  `/private/tmp/basis-programbench-lite/oracle/cfgtool`
- builders are told they may execute that path but must not inspect its source
