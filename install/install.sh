#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

il::os::require_cmd rsync
il::os::require_cmd just

TARGET="${INSTALL_LIB_PREFIX:-$HOME/.local/share/install-lib}"
mkdir -p "$TARGET"

il::run::step "Build install-lib artifacts" bash -c "cd \"$ROOT\" && just build"

SYNC_CMD=(rsync -avP0 --delete --exclude '.git' --exclude '.github' --exclude '.serena' --exclude 'install' "$ROOT/" "$TARGET/")
il::run::step "Sync install-lib to $TARGET" "${SYNC_CMD[@]}"

touch "$TARGET/.installed"

printf '\ninstall-lib is ready at %s\n' "$TARGET"
printf 'Source %s/dist/install-lib.min.sh in your installers.\n' "$TARGET"
