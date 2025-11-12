#!/usr/bin/env bats

setup() {
  source "$BATS_TEST_DIRNAME/../lib/install-lib.sh"
}

@test "il::os::name honors override" {
  export IL_OS_OVERRIDE="darwin"
  run il::os::name
  [ "$status" -eq 0 ]
  [ "$output" = "darwin" ]
}

@test "il::pkg::detect_manager sees brew on custom PATH" {
  local fake_bin
  fake_bin="$BATS_TEST_TMPDIR/bin"
  mkdir -p "$fake_bin"
  cat <<'SH' >"$fake_bin/brew"
#!/usr/bin/env bash
exit 0
SH
  chmod +x "$fake_bin/brew"
  PATH="$fake_bin:$PATH" run bash -c "source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; il::pkg::detect_manager"
  [ "$status" -eq 0 ]
  [ "$output" = "brew" ]
}

@test "logging helpers exist" {
  run type il::log::info
  [ "$status" -eq 0 ]
  [[ "$output" == *"il::log::info"* ]]
}

@test "il::run::step executes commands in plain mode" {
  run bash -lc "IL_RUN_FORCE_PLAIN=1; source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; il::run::step 'echo hi' bash -c 'echo hi'"
  [ "$status" -eq 0 ]
  [[ "$output" == *"hi"* ]]
}

@test "il::run::step propagates failures" {
  run bash -lc "IL_RUN_FORCE_PLAIN=1; source '$BATS_TEST_DIRNAME/../lib/install-lib.sh'; il::run::step 'fail' bash -c 'exit 7'"
  [ "$status" -eq 7 ]
  [[ "$output" == *"exit 7"* ]]
}
