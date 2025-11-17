#!/usr/bin/env bash
# shellcheck shell=bash
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

_show_cmd() {
  local func="$1"
  shift || true
  if [[ -n "${1:-}" ]]; then
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.pkg::$func" "'$1'")]"
  else
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.pkg::$func")]"
  fi
}

choose() {
  @install.ui::choose "PKG_CHOICE" "Which package management example do you want to see?" \
    "@install.pkg::detect_manager" "Detect Package Manager $(_show_cmd "detect_manager")" \
    "@install.pkg::ensure 'bash'" "Ensure Package 'bash' is installed $(_show_cmd ensure "bash")" \
    "@install.pkg::ensure 'some-nonexistent-package'" "Ensure Package 'some-nonexistent-package' is installed $(_show_cmd ensure "some-nonexistent-package")"

  eval "$PKG_CHOICE"
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another package management example?"; do
  choose
done
# vim: set ft=bash:
