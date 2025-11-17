#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../lib/install-lib.sh"
}

@test "@install.os::name honors override" {
  export INSTALL_LIB_OS_OVERRIDE="darwin"
  run @install.os::name
  [ "$status" -eq 0 ]
  [ "$output" = "darwin" ]
}

@test "@install.pkg::detect_manager sees brew on custom PATH" {
  local fake_bin
  fake_bin="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$fake_bin"
  cat <<'SH' >"$fake_bin/brew"
#!/usr/bin/env bash
exit 0
SH
  chmod +x "$fake_bin/brew"
  PATH="$fake_bin:$PATH" run bash -c "source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; @install.pkg::detect_manager"
  [ "$status" -eq 0 ]
  [ "$output" = "brew" ]
}

@test "@install.log::info helper exists" {
  run type @install.log::info
  [ "$status" -eq 0 ]
  [[ "$output" == *"@install.log::info"* ]]
}

@test "@install.run::step executes commands in plain mode" {
  run bash -lc "INSTALL_LIB_RUN_FORCE_PLAIN=1; source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; @install.run::step 'echo hi' bash -c 'echo hi'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"hi"* ]]
}

@test "@install.run::step propagates failures" {
  run bash -lc "INSTALL_LIB_RUN_FORCE_PLAIN=1; source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; @install.run::step 'fail' bash -c 'exit 7'"
  [ "$status" -eq 7 ]
  [[ "$output" == *"exit 7"* ]]
}

@test "@install.run::step TUI handles silent commands" {
  run bash -lc "source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; @install.ui::is_tty(){ return 0; }; @install.ui::has_tput(){ return 0; }; tput(){ :; }; unset INSTALL_LIB_RUN_FORCE_PLAIN; @install.run::step 'make dir' bash -c 'mkdir -p \"$BATS_TEST_TMPDIR/tui-silent\"'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"no output yet"* ]]
}

@test "@install.run::step TUI propagates failures" {
  run bash -lc "source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; @install.ui::is_tty(){ return 0; }; @install.ui::has_tput(){ return 0; }; tput(){ :; }; unset INSTALL_LIB_RUN_FORCE_PLAIN; @install.run::step 'fail tui' bash -c 'exit 9'"
  [ "$status" -eq 9 ]
  [[ "$output" == *"exit 9"* ]]
}
