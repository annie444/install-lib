#!/usr/bin/env bats

stub_ui() {
  @install.ui::cursor_up() { :; }
  @install.ui::clear_line() { :; }
  @install.ui::cursor_hide() { :; }
  @install.ui::cursor_show() { :; }
  @install.ui::has_tput() { return 0; }
  @install.ui::is_tty() { return 0; }
  @install.color::accent() { printf '%s' "$*"; }
}

@test "@install.ui::choose handles value/option pairs" {
  local bash_bin="${BASH_5:-/opt/homebrew/bin/bash}"
  if [[ ! -x "$bash_bin" ]]; then
    bash_bin="bash"
  fi
  run "$bash_bin" -lc "source '$BATS_TEST_DIRNAME/../lib/color.sh'; source '$BATS_TEST_DIRNAME/../lib/ui.sh'; $(declare -f stub_ui); stub_ui; @install.color::accent(){ printf '%s' \"\$*\"; }; @install.ui::choose CHOICE 'Pick one' valA OptionA valB OptionB <<< $'\n'; printf '%s' \"\$CHOICE\" >'$BATS_TEST_TMPDIR/choice'"
  [ "$status" -eq 0 ]
  choice=$(<"$BATS_TEST_TMPDIR/choice")
  [ "$choice" = "valA" ]
}

@test "@install.ui::choose handles option list when odd args passed" {
  local bash_bin="${BASH_5:-/opt/homebrew/bin/bash}"
  if [[ ! -x "$bash_bin" ]]; then
    bash_bin="bash"
  fi
  run "$bash_bin" -lc "source '$BATS_TEST_DIRNAME/../lib/color.sh'; source '$BATS_TEST_DIRNAME/../lib/ui.sh'; $(declare -f stub_ui); stub_ui; @install.color::accent(){ printf '%s' \"\$*\"; }; @install.ui::choose CHOICE 'Pick one' Option1 Option2 <<< $'\n'; printf '%s' \"\$CHOICE\" >'$BATS_TEST_TMPDIR/choice'"
  [ "$status" -eq 0 ]
  choice=$(<"$BATS_TEST_TMPDIR/choice")
  [ "$choice" = "Option1" ]
}
