# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_OS_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_OS_LOADED=1

@install.os::name() {
  if [[ -n "${INSTALL_LIB_OS_OVERRIDE:-}" ]]; then
    printf '%s\n' "$INSTALL_LIB_OS_OVERRIDE"
    return
  fi
  local uname_out
  uname_out="$(uname -s 2>/dev/null | tr '[:upper:]' '[:lower:]')"
  case "$uname_out" in
  linux*) printf 'linux\n' ;;
  darwin*) printf 'darwin\n' ;;
  msys* | mingw* | cygwin*) printf 'windows\n' ;;
  *) printf 'unknown\n' ;;
  esac
}

@install.os::require_cmd() {
  local bin="$1"
  command -v "$bin" >/dev/null 2>&1 && return 0
  @install.die 127 "Missing required command: $bin"
}

@install.os::has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# vim: set ft=bash:
