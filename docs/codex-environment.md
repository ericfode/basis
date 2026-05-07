# Codex Environment

Use this setup command for Codex environments and local worktrees:

```sh
scripts/setup-codex-env.sh
```

The script installs the repo runtime through `mise.toml` and compiles the
project. It is safe to run repeatedly.

The reducer runtime is pinned to:

- Erlang/OTP `28.5`
- Elixir `1.19.5-otp-28`

Local gates:

```sh
mise exec -- mix test
```

Local UI:

```sh
mise exec -- mix basis.server --port 8767
```

Then open:

```text
http://127.0.0.1:8767/ui/index.html
```

Use `mise exec -- ...` in non-interactive Codex shells. Do not assume bare
`mix` or `elixir` is on PATH unless the shell has activated `mise`.
