# install-lib

[![CI](https://github.com/<you>/<repo>/actions/workflows/ci.yml/badge.svg)](https://github.com/<you>/<repo>/actions/workflows/ci.yml)

Reusable bash helpers for installer scripts. Source a single entrypoint in remote installers via
`curl -fsSL ... | source` and get batteries-included utilities for logging, prompting, package
detection, and more.

## Repo layout

- `lib/` – modular bash sources that define install-lib functions.
- `tests/` – Bats-based sanity checks.
- `justfile` – automation entrypoint for lint/test/build.
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
curl -fsSL https://raw.githubusercontent.com/<you>/<repo>/main/dist/install-lib.min.sh | source
il::log info "Ready to install"
il::pkg ensure "brew" "git"
```

The `dist/install-lib.sh` artifact is the readable version; `dist/install-lib.min.sh` strips
comments/blank lines to reduce download size. Both source-safe wrap every helper. You can also
`source lib/install-lib.sh` locally during development.

## Roadmap ideas

- Additional audiences (e.g., dotfiles bootstrap, language-specific installers).
- Rich text UI (colors, spinners, progress bars).
- Package manager adapters beyond apt/brew.
- Self-tests runnable on multiple OS targets (gh actions matrix).
