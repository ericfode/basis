# Symphony Elixir Runbook

This repository can be managed by a project-local Symphony daemon backed by
Linear. That is an operations adapter, not part of the Basis core model.

## Paths

- Project repo: `/Users/ericfode/Documents/basis`
- Shared Symphony checkout: `/Users/ericfode/src/openai-symphony`
- Linear project: `Basis`
- Linear project slug: `spec-gym-af9f6c965d84`
- Private env file: `/Users/ericfode/.config/symphony/env`
- Project workflow template: `WORKFLOW.md`
- Generated workflow: `.symphony/WORKFLOW.generated.md`
- Workspaces: `.symphony/workspaces`
- Logs: `.symphony/logs`

The `.symphony/` directory is runtime state and is ignored by Git.

## Prepare

```sh
SYMPHONY_LINEAR_PROJECT_SLUG=spec-gym-af9f6c965d84 \
SYMPHONY_ACCEPT_PREVIEW_RISK=1 \
SYMPHONY_SKIP_BUILD=1 \
scripts/symphony-elixir.sh --prepare-only
```

Prepare-only verifies the project-local workflow generation path without
starting the daemon.

## Start

```sh
SYMPHONY_PORT=4127 \
SYMPHONY_LINEAR_PROJECT_SLUG=spec-gym-af9f6c965d84 \
SYMPHONY_ACCEPT_PREVIEW_RISK=1 \
scripts/symphony-elixir.sh
```

The runner sources `/Users/ericfode/.config/symphony/env` if it exists. Do not
store `LINEAR_API_KEY` in this repository.

## Issue Contract

Symphony polls Linear issues in the configured project with active states:

- `Todo`
- `In Progress`
- `Rework`

Each issue runs in an isolated workspace copied from the source checkout. The
agent must keep work scoped to one narrow increment and run:

```sh
npm test
npm run play:self
npm run play:symphony
lean out/spec/ClaimLattice.lean
lean out/symphony/ClaimLattice.lean
node --check src/basis.mjs
git diff --check
```

## Debugging

Check:

```sh
cat .symphony/WORKFLOW.generated.md
find .symphony/logs -type f | sort
find .symphony/workspaces -maxdepth 2 -type d | sort
```

The generated workflow should contain the real Linear project slug and should
not contain `__SYMPHONY_LINEAR_PROJECT_SLUG__`.
