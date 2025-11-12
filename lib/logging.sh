# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_LOGGING_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_LOGGING_LOADED=1

il::log() {
  local level="$1"
  shift
  local ts msg color
  ts="$(date +%H:%M:%S)"
  msg="$*"
  case "$level" in
  info) color="$IL_COLOR_INFO" ;;
  warn) color="$IL_COLOR_WARN" ;;
  error) color="$IL_COLOR_ERROR" ;;
  debug) color="$IL_COLOR_DEBUG" ;;
  *) color="" ;;
  esac
  printf '%s[%s] %s%s%s\n' "$color" "$level" "$ts " "$msg" "$IL_COLOR_RESET" >&2
}

il::log::info() { il::log info "$@"; }
il::log::warn() { il::log warn "$@"; }
il::log::error() { il::log error "$@"; }
il::log::debug() { il::log debug "$@"; }

il::die() {
  local exit_code=1
  if [[ -n "${1:-}" && "$1" =~ ^[0-9]+$ ]]; then
    exit_code="$1"
    shift
  fi
  il::log::error "$@"
  exit "$exit_code"
}

# vim: set ft=bash:
