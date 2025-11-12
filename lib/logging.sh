# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_LOGGING_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_LOGGING_LOADED=1

_il_detect_color_support() {
  if [[ -n "${IL_NO_COLOR:-}" ]]; then
    echo "false"
  elif [[ -t 2 ]]; then
    echo "true"
  else
    echo "false"
  fi
}

if [[ $(_il_detect_color_support) == "true" ]]; then
  _IL_COLOR_RESET=$'\033[0m'
  _IL_COLOR_INFO=$'\033[32m'
  _IL_COLOR_WARN=$'\033[33m'
  _IL_COLOR_ERROR=$'\033[31m'
  _IL_COLOR_DEBUG=$'\033[90m'
else
  _IL_COLOR_RESET=""
  _IL_COLOR_INFO=""
  _IL_COLOR_WARN=""
  _IL_COLOR_ERROR=""
  _IL_COLOR_DEBUG=""
fi
unset -f _il_detect_color_support

il::log() {
  local level="$1"
  shift
  local ts msg color
  ts="$(date +%H:%M:%S)"
  msg="$*"
  case "$level" in
  info) color="$_IL_COLOR_INFO" ;;
  warn) color="$_IL_COLOR_WARN" ;;
  error) color="$_IL_COLOR_ERROR" ;;
  debug) color="$_IL_COLOR_DEBUG" ;;
  *) color="" ;;
  esac
  printf '%s[%s] %s%s%s\n' "$color" "$level" "$ts " "$msg" "$_IL_COLOR_RESET" >&2
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
