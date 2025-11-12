# install-lib

[![CI](https://github.com/annie444/install-lib/actions/workflows/ci.yml/badge.svg)](https://github.com/annie444/install-lib/actions/workflows/ci.yml)

Reusable bash helpers for installer scripts. Source a single entrypoint in remote installers via
`curl -fsSL ... | source` and get batteries-included utilities for logging, prompting, package
detection, and more.

## Repo layout

- `lib/` – modular bash sources that define install-lib functions.
- `tests/` – Bats-based sanity checks.
- `justfile` – automation entrypoint for lint/test/build.
- `install/` – smoke-test installer that stages the library to `~/.local/share/install-lib`.
- `dist/` – generated artifacts (ignored from git) including `install-lib.sh` and
  its minified sibling `install-lib.min.sh`.

## Getting started

```bash
# install deps (macOS)
brew install shellcheck bats-core just

# lint and test
just lint
just test

# rebuild distributable script
just build
```

GitHub Actions runs the same `just lint`, `just test`, and `just build` pipeline for every push
and pull request (see `.github/workflows/ci.yml`).

## Usage sketch

```bash
curl -fsSL https://raw.githubusercontent.com/annie444/install-lib/main/dist/install-lib.min.sh | source
il::log info "Ready to install"
il::pkg ensure "brew" "git"

# show friendly progress for long-running commands
il::run::step "Install dotfiles" bash -c 'make bootstrap'
il::run::step "Sync plugins" bash -c 'nvim --headless +PackerSync +qa'
```

The `dist/install-lib.sh` artifact is the readable version; `dist/install-lib.min.sh` strips
comments/blank lines to reduce download size. Both source-safe wrap every helper. You can also
`source lib/install-lib.sh` locally during development. `il::run::step` renders Docker-like step
output on macOS/Linux terminals (with a graceful plain-text fallback—set `IL_RUN_FORCE_PLAIN=1`
to force the fallback in CI or when debugging).

## Local smoke test installer

```bash
./install/install.sh
# optionally override install prefix
INSTALL_LIB_PREFIX="$HOME/.cache/install-lib" ./install/install.sh
```

The installer builds the dist artifacts, then copies the repo into
`$INSTALL_LIB_PREFIX` (default `~/.local/share/install-lib`) using `il::run::step`, so you can see
the progressive output UX immediately.

## Roadmap ideas

- Additional audiences (e.g., dotfiles bootstrap, language-specific installers).
- Rich text UI (colors, spinners, progress bars).
- Package manager adapters beyond apt/brew.
- Self-tests runnable on multiple OS targets (gh actions matrix).
