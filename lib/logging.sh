# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_LOGGING_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_LOGGING_LOADED=1

@install.log() {
  local level="$1"
  shift
  local ts msg color
  ts="$(date +%H:%M:%S)"
  msg="$*"
  case "$level" in
  info) color="$INSTALL_LIB_COLOR_INFO" ;;
  warn) color="$INSTALL_LIB_COLOR_WARN" ;;
  error) color="$INSTALL_LIB_COLOR_ERROR" ;;
  debug) color="$INSTALL_LIB_COLOR_DEBUG" ;;
  *) color="" ;;
  esac
  printf '%s[%s] %s%s%s\n' "$color" "$level" "$ts " "$msg" "$INSTALL_LIB_COLOR_RESET" >&2
}

@install.log::info() { @install.log info "$@"; }
@install.log::warn() { @install.log warn "$@"; }
@install.log::error() { @install.log error "$@"; }
@install.log::debug() { @install.log debug "$@"; }

@install.die() {
  local exit_code=1
  if [[ -n "${1:-}" && "$1" =~ ^[0-9]+$ ]]; then
    exit_code="$1"
    shift
  fi
  @install.log::error "$@"
  exit "$exit_code"
}

# vim: set ft=bash:
