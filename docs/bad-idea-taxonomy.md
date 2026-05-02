# Bad-Idea Taxonomy

This taxonomy is intentionally adversarial. The goal is to kill bad ideas before
they acquire implementation gravity.

## Impossible

An idea is impossible when its constraints cannot all hold at once.

Signals:

- direct `MUST` / `MUST NOT` contradiction
- unbounded obligation over all users, all inputs, or all environments
- dependency on unavailable authority, state, or physics
- total guarantees over unreliable external systems

Useful response:

- weaken the claim
- add an assumption
- choose an implementation-defined policy
- split the requirement by operating mode

## Useless

An idea is useless when it can succeed without improving the target problem.

Signals:

- no concrete actor
- no problem statement
- no measurable goal
- no validation matrix
- success can be satisfied by documentation alone

Useful response:

- name the actor and job
- name what gets better
- attach a validation test to each goal

## More Complex Than Nothing

An idea is worse than doing nothing when the coordination cost exceeds the value
of the behavior it adds.

Signals:

- many components with few goals
- many optional extensions before a required path works
- state machine without operational leverage
- abstractions that mostly restate the prose

Useful response:

- remove optional surfaces
- define a smallest conformance profile
- prove the simpler baseline inadequate

## Misses Problem

An idea misses the problem when its machinery optimizes adjacent work.

Signals:

- low overlap between problem terms, goals, and tests
- components named before outcomes
- implementation detail appears before user pressure
- tests validate plumbing rather than the stated need

Useful response:

- rewrite goals from the problem statement
- require every component to serve at least one goal
- require every goal to have a test or rejected reason

## Underspecified

An idea is underspecified when implementation choices that affect behavior are
left unnamed.

Signals:

- normative language with vague qualifiers
- `implementation-defined` without a documentation obligation
- optional behavior without compatibility rules
- security or failure policy deferred to future prose

Useful response:

- promote the choice to a typed field
- add defaults
- add conformance cases
- state which behavior is intentionally outside scope
