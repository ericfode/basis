# Basis Rename Session Context

Date: 2026-05-04  
Session goal: Rebrand repository internals from `specgym` to `basis`, including file names, CLI/package references, and docs/types references.

## Scope completed

- Renamed entrypoint files:
  - `src/specgym.mjs` -> `src/basis.mjs`
  - `tests/specgym.test.mjs` -> `tests/basis.test.mjs`
  - `docs/specgym-model.md` -> `docs/basis-model.md`
  - `mockups/specgym-ui.html` -> `mockups/basis-ui.html`
- Renamed function symbol:
  - `buildSpecGymState(...)` -> `buildBasisState(...)` in `src/basis.mjs`
  - Updated callsites in `tests/basis.test.mjs`.
- Updated project-facing references from `specgym` to `basis` in:
  - `AGENTS.md`
  - `README.md`
  - `WORKFLOW.md`
  - `spec.md`
  - `package.json`
  - `docs/adapter-boundary.md`
  - `docs/reference-specs.md`
  - `docs/symphony-elixir.md`
  - `examples/minimal-tool.spec.md`
  - `src/historical-spec.mjs`
  - type schema `$id` fields under `types/*.json`

## Validation executed

- `npm test`
- `npm run play:self`
- `npm run play:symphony`
- `lean out/symphony/ClaimLattice.lean`
- `node --check src/basis.mjs`
- `git diff --check`

All gates passed for the code changes.

## Blockers encountered in this environment

- Renaming the local folder to `/Users/ericfode/Documents/basis` was blocked by filesystem write restrictions.
- Updating git remote URL in `.git/config` to `https://github.com/ericfode/basis.git` was blocked by git config write restrictions.
- Editing llm-wiki files under `/Users/ericfode/wiki` was blocked by filesystem restrictions.
- Restoring/reverting `out/` artifacts was blocked by git index lock errors (`.git/index.lock` not writable).

## Follow-up required for full completion

1. On a writable shell:
   - Rename local folder:
     - `mv "/Users/ericfode/Documents/New project 4" "/Users/ericfode/Documents/basis"`
   - Update remote:
     - `git remote set-url origin https://github.com/ericfode/basis.git`
2. Re-run `npm` gates after move if any path assumptions changed.
3. Update the wiki pages:
   - `/Users/ericfode/wiki/index.md`
   - `/Users/ericfode/wiki/queries/specification-elaboration-naming-frame.md`
   - `/Users/ericfode/wiki/raw/articles/specification-elaboration-naming-research.md`
   - `/Users/ericfode/wiki/log.md`
4. Push this rename commit after remote update.

## Follow-up continuation (2026-05-04)

- Commit created: `92c5a54` with message `chore: rename specgym to basis`.
- `git push` attempted from this environment:
  - Failed: `Could not resolve host: github.com`
- `.git/config` update attempted:
  - `git remote set-url origin https://github.com/ericfode/basis.git`
  - Failed: `could not lock config file .git/config: Operation not permitted`

### Commands that should be rerun locally (writable networked shell)

```sh
git remote set-url origin https://github.com/ericfode/basis.git
git push origin HEAD
```
