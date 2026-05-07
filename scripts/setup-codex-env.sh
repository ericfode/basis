#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

if ! command -v mise >/dev/null 2>&1; then
  if [ -x "$HOME/.local/bin/mise" ]; then
    PATH="$HOME/.local/bin:$PATH"
  elif command -v curl >/dev/null 2>&1; then
    curl https://mise.run | sh
    PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:$PATH"
  else
    echo "mise is required and curl is unavailable to install it." >&2
    exit 1
  fi
fi

cd "$ROOT"

mise trust "$ROOT/mise.toml" >/dev/null 2>&1 || true
mise install -y
mise exec -- mix compile
