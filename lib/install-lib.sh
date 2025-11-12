# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_LOADED:-}" ]]; then
  return 0
fi
declare -g INSTALL_LIB_LOADED=1

_install_lib_dirname() {
  local src="${BASH_SOURCE[0]}"
  while [[ -L "$src" ]]; do
    local dir
    dir="$(cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd)"
    src="$(readlink "$src")"
    [[ $src != /* ]] && src="$dir/$src"
  done
  cd -P "$(dirname "$src")" >/dev/null 2>&1 && pwd
}

# Directory that contains this file (lib/) even when sourced via dist artifact.
declare -g INSTALL_LIB_ROOT
INSTALL_LIB_ROOT="${INSTALL_LIB_ROOT:-$(_install_lib_dirname)}"
unset -f _install_lib_dirname

_install_lib_try_source() {
  local file="$1"
  local path="${INSTALL_LIB_ROOT}/${file}"
  if [[ -f "$path" ]]; then
    # shellcheck disable=SC1090
    source "$path"
  fi
}

_install_lib_try_source "logging.sh"
_install_lib_try_source "ui.sh"
_install_lib_try_source "os.sh"
_install_lib_try_source "packages.sh"

unset -f _install_lib_try_source

# vim: set ft=bash:
