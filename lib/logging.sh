# shellcheck shell=bash
# @name install-lib logging
# @file install-lib logging
# @brief Namespaced logging helpers for install-lib.
# @description Timestamped logging helpers and die wrapper for install-lib.

if [[ -n "${INSTALL_LIB_LOGGING_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_LOGGING_LOADED=1

# @brief Format a command + args with color for log previews.
#
# @arg $1 string Command name.
# @arg $@ string Command arguments (optional).
#
# @stdout Colored command string.
# @exitcode Always 0.
#
# @example
#   echo "$(@install.log::cmd "ls" "-la")"
@install.log::cmd() {
  local cmd=$1
  shift || true
  printf '%s %s' "$(@install.color::fg::cyan "$cmd")" "$(@install.color::fg::yellow "$*")"
}

# @brief Core logger printing `[level]` lines with timestamp and color when available.
# @description
#   Formats a timestamped line with level prefix and optional color to stderr.
#
# @arg $1 string Log level (info|warn|error|debug).
# @arg $@ string Message to log (variadic).
#
# @stderr Formatted log line.
# @set INSTALL_LIB_COLOR_INFO string ANSI color prefix for info messages (optional).
# @set INSTALL_LIB_COLOR_WARN string ANSI color prefix for warn messages (optional).
# @set INSTALL_LIB_COLOR_ERROR string ANSI color prefix for error messages (optional).
# @set INSTALL_LIB_COLOR_DEBUG string ANSI color prefix for debug messages (optional).
# @set INSTALL_LIB_COLOR_RESET string ANSI reset suffix (optional).
# @exitcode Always 0.
#
# @example
#   @install.log info "starting install"
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

# @brief Log an info message with timestamp and color.
# @see @install.log
# @exitcode Always 0.
# @example
#   @install.log::info "Ready"
@install.log::info() { @install.log info "$@"; }

# @brief Log a warning message with timestamp and color.
# @see @install.log
# @exitcode Always 0.
# @example
#   @install.log::warn "Deprecated flag"
@install.log::warn() { @install.log warn "$@"; }

# @brief Log an error message with timestamp and color.
# @see @install.log
# @exitcode Always 0.
# @example
#   @install.log::error "Failed to fetch"
@install.log::error() { @install.log error "$@"; }

# @brief Log a debug message with timestamp and color.
# @see @install.log
# @exitcode Always 0.
# @example
#   @install.log::debug "args=$*"
@install.log::debug() { @install.log debug "$@"; }

# @brief Log an error and exit with the given code (default 1).
#
# @arg $1 number Optional exit code.
# @arg $@ string Error message to log (variadic).
#
# @exitcode The provided exit code (default 1).
# @stderr Error log line.
#
# @example
#   @install.die 2 "missing dependency"
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
