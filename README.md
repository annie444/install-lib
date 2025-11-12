# install-lib

Reusable bash helpers for installer scripts. Source a single entrypoint in remote installers via
`curl -fsSL ... | source` and get batteries-included utilities for logging, prompting, package
detection, and more.

## Repo layout

- `lib/` – modular bash sources that define install-lib functions.
- `tests/` – Bats-based sanity checks.
- `dist/` – generated artifacts (ignored from git).

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

## Usage sketch

```bash
curl -fsSL https://raw.githubusercontent.com/<you>/<repo>/main/dist/install-lib.sh | source
il::log info "Ready to install"
il::pkg ensure "brew" "git"
```

The `dist/install-lib.sh` artifact will source-safe wrap every helper. You can also `source 
lib/install-lib.sh` locally during development.

## Roadmap ideas

- Additional audiences (e.g., dotfiles bootstrap, language-specific installers).
- Rich text UI (colors, spinners, progress bars).
- Package manager adapters beyond apt/brew.
- Self-tests runnable on multiple OS targets (gh actions matrix).
