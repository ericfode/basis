---
tracker:
  kind: linear
  api_key: $LINEAR_API_KEY
  project_slug: "__SYMPHONY_LINEAR_PROJECT_SLUG__"
  active_states:
    - Todo
    - In Progress
    - Rework
  terminal_states:
    - Closed
    - Cancelled
    - Canceled
    - Duplicate
    - Done
polling:
  interval_ms: 30000
workspace:
  root: $SYMPHONY_WORKSPACE_ROOT
hooks:
  after_create: |
    set -euo pipefail

    source_root="${PROJECT_SOURCE_ROOT:-__PROJECT_SOURCE_ROOT__}"
    if [ ! -d "$source_root" ]; then
      echo "project source root not found: $source_root" >&2
      exit 1
    fi

    rsync -a --delete \
      --exclude '.git' \
      --exclude '.symphony' \
      --exclude 'node_modules' \
      --exclude '.lake' \
      --exclude '__pycache__' \
      --exclude '.pytest_cache' \
      --exclude '.mypy_cache' \
      --exclude '.ruff_cache' \
      "$source_root"/ .

    git init -q
    git config user.name "Symphony Agent"
    git config user.email "symphony-agent@example.invalid"
    git add -A
    git commit -qm "Import project workspace snapshot" || true
agent:
  max_concurrent_agents: 2
  max_turns: 12
codex:
  command: codex --config shell_environment_policy.inherit=all --config 'model="gpt-5.5"' --config model_reasoning_effort=high app-server
  approval_policy: never
  thread_sandbox: workspace-write
server:
  port: __SYMPHONY_PORT__
---

You are working on a Linear ticket for the Spec Gym in an isolated
Symphony workspace.

Issue:

- Identifier: `{{ issue.identifier }}`
- Title: `{{ issue.title }}`
- State: `{{ issue.state }}`
- URL: `{{ issue.url }}`

Description:

{% if issue.description %}
{{ issue.description }}
{% else %}
No description provided.
{% endif %}

Operating contract:

1. Work only inside the provided workspace. Do not edit the source checkout
   directly from a Symphony run.
2. Start by reading `AGENTS.md`, `spec.md`, `README.md`,
   `docs/adapter-boundary.md`, and the files directly relevant to the ticket.
3. Recover concrete state before acting: `git status --short --branch`, current
   files, and the exact validation gate for the issue.
4. Implement one narrow, meaningful increment. Keep changes scoped to the ticket.
5. Keep the product boundary intact: this repo is a tool-neutral Spec Gym
   kernel with optional adapters.
6. If Linear tooling is available, keep a single issue workpad comment current.
   If it is not available, record that as a blocker in the final message.
7. Do not invent a GitHub remote, PR, or publish path. If the workspace has no
   remote, leave a clean local commit and report the workspace path plus
   validation evidence.

Required validation:

```sh
npm test
npm run play:self
npm run play:symphony
lean out/symphony/ClaimLattice.lean
node --check src/specgym.mjs
git diff --check
```

Handoff:

- Final message reports completed actions, validation run, remaining blockers,
  and the local commit if one was created.
- Do not include generic next steps unless blocked by a specific missing
  credential or project decision.
