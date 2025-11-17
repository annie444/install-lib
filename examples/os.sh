#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

_show_real_cmd() {
  local func="$1"
  echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.os::$func" "'ls'")]"
}
_show_fake_cmd() {
  local func="$1"
  echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.os::$func" "'nonexistant_cmd'")]"
}

choose() {
  @install.ui::choose "OS_CHOICE" "Which command do you want to see" \
    '@install.os::name' "Detect OS Name" \
    '@install.os::require_cmd "ls"' "Check for required command $(_show_real_cmd require_cmd)" \
    '@install.os::require_cmd "nonexistant_cmd"' "Check for required command $(_show_fake_cmd require_cmd)" \
    '@install.os::has_cmd "ls"' "Check if command exists $(_show_real_cmd has_cmd)" \
    '@install.os::has_cmd "nonexistant_cmd"' "Check if command exists $(_show_fake_cmd has_cmd)"

  # shellcheck disable=SC2181
  if eval "$OS_CHOICE"; then
    @install.log::info "Command executed successfully. (This is from $0, not $OS_CHOICE)"
  else
    @install.log::error "Command failed. (This is from $0, not $OS_CHOICE)"
  fi
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another os example?"; do
  choose
done
# vim: set ft=bash:
