# ProgramBench-Lite `ls` Spec Fitness Experiment

This experiment tests spec-fitness discrimination on a small reconstruction of
`ls`, a real command with many mature implementations and a POSIX-specified
behavioral contract.

The fixture is deliberately bounded. It does not ask agents to rebuild GNU
coreutils. It asks for a Node.js CLI that matches a documented subset:

- directory listing
- hidden-file controls
- directory-as-file mode
- file-type indicators
- recursive traversal
- multiple operands
- deterministic errors

Agents receive either:

- `good-spec.md`: a precise POSIX-like subset contract
- `bad-spec.md`: a vague `ls` reconstruction request

The evaluator creates hidden filesystem trees and checks stdout, stderr, exit
status, source-policy compliance, and edge behavior.

This is closer to ProgramBench than the earlier pure-function fixture because
the candidate must reconstruct observable command behavior over files and
directories.
