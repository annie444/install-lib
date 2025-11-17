#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

CUSTOM_COLOR_CODE=$'\033[38;2;255;105;180m' # Hot Pink

_show_cmd() {
  local func="$1"
  shift || true
  if [[ -n "${1:-}" ]]; then
    func="${func}::$1"
  fi
  echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.color::$func" "'Lorem ipsum...'")]"
}

choose() {
  @install.ui::choose "COLOR_EXAMPLE" "Which example do you want to see?" \
    "@install.color::bold" "Bold Text $(_show_cmd bold)" \
    "@install.color::dim" "Dim Text $(_show_cmd dim)" \
    "@install.color::italic" "Italic Text $(_show_cmd italic)" \
    "@install.color::underline" "Underlined Text $(_show_cmd underline)" \
    "@install.color::blink" "Blinking Text $(_show_cmd blink)" \
    "@install.color::reverse" "Reversed Text $(_show_cmd reverse)" \
    "@install.color::hidden" "Hidden Text $(_show_cmd hidden)" \
    "@install.color::strikethrough" "Strikethrough Text $(_show_cmd strikethrough)" \
    "@install.color::fg::black" "Black Text $(_show_cmd fg black)" \
    "@install.color::fg::red" "Red Text $(_show_cmd fg red)" \
    "@install.color::fg::green" "Green Text $(_show_cmd fg green)" \
    "@install.color::fg::yellow" "Yellow Text $(_show_cmd fg yellow)" \
    "@install.color::fg::blue" "Blue Text $(_show_cmd fg blue)" \
    "@install.color::fg::magenta" "Magenta Text $(_show_cmd fg magenta)" \
    "@install.color::fg::cyan" "Cyan Text $(_show_cmd fg cyan)" \
    "@install.color::fg::white" "White Text $(_show_cmd fg white)" \
    "@install.color::bg::black" "Black Background $(_show_cmd bg black)" \
    "@install.color::bg::red" "Red Background $(_show_cmd bg red)" \
    "@install.color::bg::green" "Green Background $(_show_cmd bg green)" \
    "@install.color::bg::yellow" "Yellow Background $(_show_cmd bg yellow)" \
    "@install.color::bg::blue" "Blue Background $(_show_cmd bg blue)" \
    "@install.color::bg::magenta" "Magenta Background $(_show_cmd bg magenta)" \
    "@install.color::bg::cyan" "Cyan Background $(_show_cmd bg cyan)" \
    "@install.color::bg::white" "White Background $(_show_cmd bg white)" \
    "@install.color::fg::bright_black" "Bright Black Text $(_show_cmd fg bright_black)" \
    "@install.color::fg::bright_red" "Bright Red Text $(_show_cmd fg bright_red)" \
    "@install.color::fg::bright_green" "Bright Green Text $(_show_cmd fg bright_green)" \
    "@install.color::fg::bright_yellow" "Bright Yellow Text $(_show_cmd fg bright_yellow)" \
    "@install.color::fg::bright_blue" "Bright Blue Text $(_show_cmd fg bright_blue)" \
    "@install.color::fg::bright_magenta" "Bright Magenta Text $(_show_cmd fg bright_magenta)" \
    "@install.color::fg::bright_cyan" "Bright Cyan Text $(_show_cmd fg bright_cyan)" \
    "@install.color::fg::bright_white" "Bright White Text $(_show_cmd fg bright_white)" \
    "@install.color::bg::bright_black" "Bright Black Background $(_show_cmd bg bright_black)" \
    "@install.color::bg::bright_red" "Bright Red Background $(_show_cmd bg bright_red)" \
    "@install.color::bg::bright_green" "Bright Green Background $(_show_cmd bg bright_green)" \
    "@install.color::bg::bright_yellow" "Bright Yellow Background $(_show_cmd bg bright_yellow)" \
    "@install.color::bg::bright_blue" "Bright Blue Background $(_show_cmd bg bright_blue)" \
    "@install.color::bg::bright_magenta" "Bright Magenta Background $(_show_cmd bg bright_magenta)" \
    "@install.color::bg::bright_cyan" "Bright Cyan Background $(_show_cmd bg bright_cyan)" \
    "@install.color::bg::bright_white" "Bright White Background $(_show_cmd bg bright_white)" \
    "@install.color::wrap" "Text with custom color code $(_show_cmd wrap)" \
    "@install.color::accent" "Accent Text $(_show_cmd accent)"

  if [ "$COLOR_EXAMPLE" = "@install.color::wrap" ]; then
    COLOR_EXAMPLE="@install.color::wrap '$CUSTOM_COLOR_CODE'"
  fi
  eval "$COLOR_EXAMPLE 'Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque.\n'"
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another color example?"; do
  choose
done
# vim: set ft=bash:
