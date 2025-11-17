#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

_demo_cmd() {
  local level="$1"
  shift || true
  local msg=""
  if [[ "${1:-}" =~ ^[a-zA-Z]+$ ]]; then
    msg="$1"
  else
    msg="$level"
  fi
  echo -n "@install.log::$level 'This is the first $msg message.'; @install.log::$level 'This is the second $msg message.'; @install.log::$level 'This is the third $msg message.'"
}

_show_cmd() {
  local func="$1"
  if [[ "$func" == "die" ]]; then
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.$func" 2 "'...'")]"
  else
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.log::$func" "'...'")]"
  fi
}

choose() {
  @install.ui::choose "LOG_CHOICE" "Which log level example do you want to see?" \
    "$(_demo_cmd debug)" "Debug Message $(_show_cmd debug)" \
    "$(_demo_cmd info)" "Info Message $(_show_cmd info)" \
    "$(_demo_cmd warn warning)" "Warning Message $(_show_cmd warn)" \
    "$(_demo_cmd error)" "Error Message $(_show_cmd error)" \
    "@install.die 2 'This is a fatal error message, exiting with code 2.'" "Fatal Error Message $(_show_cmd die)"

  eval "${LOG_CHOICE[*]}"
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another logging example?"; do
  choose
done
# vim: set ft=bash:
