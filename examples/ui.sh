#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

_demo_yes_no() {
  @install.ui::prompt_yes_no "This is a yes/no prompt. Do you want to continue?"
}

_demo_prompt_enter() {
  @install.ui::prompt_enter "This is a prompt to press Enter to continue. Press ENTER to proceed..."
}

_demo_choose() {
  @install.ui::choose "chosen_option" "Choose an option from the list below:" \
    "opt1" "Option 1" \
    "opt2" "Option 2" \
    "opt3" "Option 3"
}

_demo_section() {
  @install.ui::section "This is a section header."
}

_show_cmd() {
  local cmd="$1"
  shift || true
  if [[ $# -ge 1 ]]; then
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "$cmd" "$@")]"
  else
    echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "$cmd")]"
  fi
}

choose() {
  @install.ui::choose "UI_CHOICE" "Which UI example do you want to see?" \
    "_demo_yes_no" "Yes/No Prompt $(_show_cmd "@install.ui::prompt_yes_no" "'...'")" \
    "_demo_prompt_enter" "Press Enter Prompt $(_show_cmd "@install.ui::prompt_enter" "'...'")" \
    "_demo_choose" "Choose from List $(_show_cmd "@install.ui::choose" "var" "'prompt ...'" "['opt1' 'opt1 prompt ...']" "...")" \
    "_demo_section" "Section Header $(_show_cmd "@install.ui::section" "'...'")"

  eval "$UI_CHOICE"
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another UI example?"; do
  choose
done
