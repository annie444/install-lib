# shellcheck shell=bash
# @name install-lib os
# @file install-lib os
# @brief OS detection and command availability helpers.

if [[ -n "${INSTALL_LIB_OS_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_OS_LOADED=1

# @brief Return normalized OS name (darwin|linux|windows|unknown). Honors INSTALL_LIB_OS_OVERRIDE.
# @description
#   Uses uname and lowercases result; override via INSTALL_LIB_OS_OVERRIDE for testing.
#
# @stdout OS name.
# @set INSTALL_LIB_OS_OVERRIDE string Override detected OS value (optional).
# @exitcode 0 on detection; non-zero if uname fails.
#
# @example
#   os="$(@install.os::name)"
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

# @brief Exit with error if the given binary is not available in PATH.
#
# @arg $1 string Command name to require.
#
# @exitcode 0 when found; 127 when missing.
# @stderr Error message when missing.
#
# @example
#   @install.os::require_cmd git
@install.os::require_cmd() {
  local bin="$1"
  command -v "$bin" >/dev/null 2>&1 && return 0
  @install.die 127 "Missing required command: $bin"
}

# @brief True if the given binary exists in PATH.
#
# @arg $1 string Command name to check.
#
# @exitcode 0 when found; 1 when not.
# @example
#   if @install.os::has_cmd brew; then echo "brew present"; fi
#
@install.os::has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# vim: set ft=bash:
