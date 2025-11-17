#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

_show_cmd() {
  echo -en "${INSTALL_LIB_COLOR_RESET}[$(@install.log::cmd "@install.run::step" "$@")]"
}

_example_cmd() {
  for i in {1..20}; do
    mapfile -t random_words < <(shuf -n 10 /usr/share/dict/words)
    echo "Building project... Step $i/20 - ${random_words[*]}"
    SLEEP_TIME="$(echo "scale=4; $RANDOM / 32767" | bc -l)"
    sleep "$(printf "%.2f" "$SLEEP_TIME")"
  done
}

while @install.ui::prompt_yes_no "Would you like to run the example command? $(_show_cmd "'This is .. output'" "_example_cmd")"; do
  @install.run::step "This is an example command with random output." _example_cmd
done
# vim: set ft=bash:
