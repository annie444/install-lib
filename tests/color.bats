#!/usr/bin/env bats

@test "@install.color::* initializes when supported" {
  INSTALL_LIB_FORCE_COLOR=1 source "$BATS_TEST_DIRNAME/../lib/color.sh"

  [ "$INSTALL_LIB_COLOR_FG_RED" = $'\033[31m' ]
  [ "$INSTALL_LIB_COLOR_INFO" = "$INSTALL_LIB_COLOR_FG_GREEN" ]

  run @install.color::fg::red "hi"
  [ "$status" -eq 0 ]
  [ "$output" = $'\033[31mhi\033[0m' ]
}

@test "@install.color::* disables when unsupported" {
  INSTALL_LIB_NO_COLOR=1 source "$BATS_TEST_DIRNAME/../lib/color.sh"

  [ -z "$INSTALL_LIB_COLOR_FG_BLUE" ]
  run @install.color::fg::blue "hi"
  [ "$status" -eq 0 ]
  [ "$output" = "hi" ]
}
