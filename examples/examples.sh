#!/usr/bin/env bash
# shellcheck shell=bash

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck disable=SC1090
source "$ROOT/lib/install-lib.sh"

choose() {
  @install.ui::choose "EXAMPLE_CHOICE" "Which example do you want to see?" \
    "examples/color.sh" "Color Examples" \
    "examples/logging.sh" "Logging Examples" \
    "examples/os.sh" "OS Detection Examples" \
    "examples/packages.sh" "Package Management Examples" \
    "examples/run.sh" "Running Commands Examples" \
    "examples/ui.sh" "UI Examples"

  bash "$ROOT/$EXAMPLE_CHOICE"
}

choose
while @install.ui::prompt_yes_no "Would you like to choose another example?"; do
  choose
done
# vim: set ft=bash:
