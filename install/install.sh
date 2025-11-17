#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

@install.os::require_cmd rsync
@install.os::require_cmd just

@install.ui::choose "install_lib_prefix" "Install install-lib to:" \
  "$HOME/.local/share/install-lib" "User local share (~/.local/share/install-lib)" \
  "other" "Custom location"

TARGET="${INSTALL_LIB_PREFIX:-$HOME/.local/share/install-lib}"
mkdir -p "$TARGET"

@install.run::step "Build install-lib artifacts" bash -c "cd \"$ROOT\" && just build"

SYNC_CMD=(rsync -avP0 --delete --exclude '.git' --exclude '.github' --exclude '.serena' --exclude 'install' "$ROOT/" "$TARGET/")
@install.run::step "Sync install-lib to $TARGET" "${SYNC_CMD[@]}"

touch "$TARGET/.installed"

printf '\ninstall-lib is ready at %s\n' "$TARGET"
printf 'Source %s/dist/install-lib.min.sh in your installers.\n' "$TARGET"
