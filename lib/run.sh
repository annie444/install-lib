# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_RUN_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_RUN_LOADED=1

INSTALL_LIB_RUN_STEP_INDEX=0
INSTALL_LIB_RUN_LINES=()

if [[ -n "${INSTALL_LIB_ASCII_ONLY:-}" ]]; then
  INSTALL_LIB_RUN_SPINNER_FRAMES=("${INSTALL_LIB_ICON_SPINNER_ASCII[@]}")
else
  INSTALL_LIB_RUN_SPINNER_FRAMES=("${INSTALL_LIB_ICON_SPINNER_BRAILLE[@]}")
fi

_install_lib_run_use_tui() {
  [[ -z "${INSTALL_LIB_RUN_FORCE_PLAIN:-}" ]] &&
    @install.ui::is_tty &&
    @install.ui::has_tput &&
    command -v mkfifo >/dev/null 2>&1
}

_install_lib_run_draw_block() {
  local icon="$1"
  local block_height="$2"
  local is_final="${3:-0}"
  local log_capacity=$((block_height - 1))
  ((log_capacity < 1)) && log_capacity=1
  local total=${#INSTALL_LIB_RUN_LINES[@]}
  local status_line="[no output yet]"
  if ((total > 0)); then
    status_line="${INSTALL_LIB_RUN_LINES[total - 1]}"
  fi

  local icon_color="$INSTALL_LIB_COLOR_ACCENT"
  if [[ "$icon" == "$INSTALL_LIB_ICON_CHECK" ]]; then
    icon_color="$INSTALL_LIB_COLOR_SUCCESS"
  elif [[ "$icon" == "$INSTALL_LIB_ICON_CROSS" ]]; then
    icon_color="$INSTALL_LIB_COLOR_FAIL"
  fi
  local icon_display
  icon_display="$(@install.color::wrap "$icon_color" "$icon")"

  @install.ui::clear_line
  printf '   %s %s\n' "$icon_display" "$(@install.color::dim "$status_line")"

  local log_start=0
  if ((total > log_capacity)); then
    log_start=$((total - log_capacity))
  fi

  local i
  for ((i = 0; i < log_capacity; i++)); do
    @install.ui::clear_line
    local idx=$((log_start + i))
    if ((idx < total)); then
      printf '   │ %s\n' "$(@install.color::dim "${INSTALL_LIB_RUN_LINES[idx]}")"
    else
      printf '   │\n'
    fi
  done

  if [[ "$is_final" != "1" ]]; then
    @install.ui::cursor_up "$block_height"
  fi
}

_install_lib_run_with_tui() {
  local log_file="$1"
  local block_lines="$2"
  shift 2
  local cmd=("$@")
  if ((block_lines < 3)); then
    block_lines=3
  fi
  local log_capacity=$((block_lines - 1))
  ((log_capacity < 2)) && log_capacity=2

  local fifo
  fifo="$(mktemp -u "${TMPDIR:-/tmp}/install-lib-run.XXXXXX")"
  mkfifo "$fifo"

  @install.ui::cursor_hide
  INSTALL_LIB_RUN_LINES=()
  trap '@install.ui::cursor_show; rm -f "$fifo"' EXIT INT TERM

  : >"$log_file"
  (
    set -o pipefail
    "${cmd[@]}"
  ) >"$fifo" 2>&1 &
  local cmd_pid=$!

  exec 3<"$fifo"

  local frames=("${INSTALL_LIB_RUN_SPINNER_FRAMES[@]}")
  local frame_count=${#frames[@]}
  local frame_idx=0

  local i line
  for ((i = 0; i < block_lines; i++)); do
    printf '   │\n'
  done
  @install.ui::cursor_up "$block_lines"

  while true; do
    local had_line=0
    while IFS= read -r -t 0.05 line <&3; do
      had_line=1
      printf '%s\n' "$line" >>"$log_file"
      INSTALL_LIB_RUN_LINES+=("$line")
      if ((${#INSTALL_LIB_RUN_LINES[@]} > log_capacity)); then
        INSTALL_LIB_RUN_LINES=("${INSTALL_LIB_RUN_LINES[@]:1}")
      fi
    done
    _install_lib_run_draw_block "${frames[frame_idx]}" "$block_lines" 0
    frame_idx=$(((frame_idx + 1) % frame_count))
    if ! kill -0 "$cmd_pid" >/dev/null 2>&1 && [[ $had_line -eq 0 ]]; then
      break
    fi
  done

  while IFS= read -r line <&3; do
    printf '%s\n' "$line" >>"$log_file"
    INSTALL_LIB_RUN_LINES+=("$line")
    if ((${#INSTALL_LIB_RUN_LINES[@]} > log_capacity)); then
      INSTALL_LIB_RUN_LINES=("${INSTALL_LIB_RUN_LINES[@]:1}")
    fi
    _install_lib_run_draw_block "${frames[frame_idx]}" "$block_lines" 0
  done

  exec 3<&-

  wait "$cmd_pid"
  local status=$?
  local icon="$INSTALL_LIB_ICON_CROSS"
  if ((status == 0)); then
    icon="$INSTALL_LIB_ICON_CHECK"
  fi
  _install_lib_run_draw_block "$icon" "$block_lines" 1
  trap - EXIT INT TERM
  @install.ui::cursor_show
  rm -f "$fifo"
  return "$status"
}

_install_lib_run_plain() {
  local log_file="$1"
  local tail_lines="$2"
  shift 2
  local cmd=("$@")
  if ((tail_lines < 1)); then
    tail_lines=10
  fi
  (
    set -o pipefail
    "${cmd[@]}"
  ) 2>&1 | tee "$log_file"
  local status=${PIPESTATUS[0]}
  local summary
  summary="$(tail -n "$tail_lines" "$log_file" 2>/dev/null || true)"
  if [[ -n "$summary" ]]; then
    while IFS= read -r line; do
      printf '   │ %s\n' "$(@install.color::dim "$line")"
    done <<<"$summary"
  fi
  return "$status"
}

@install.run::step() {
  local description="$1"
  shift || true
  if [[ -z "$description" || $# -eq 0 ]]; then
    @install.die "run::step requires a description and a command"
  fi
  local cmd=("$@")
  INSTALL_LIB_RUN_STEP_INDEX=$((INSTALL_LIB_RUN_STEP_INDEX + 1))
  local tag="#${INSTALL_LIB_RUN_STEP_INDEX}"
  printf '%s %s\n' "$(@install.color::accent "$tag")" "$description"
  printf '   $ %s\n' "$(@install.color::dim "${cmd[*]}")"
  local log_file
  log_file="$(mktemp "${TMPDIR:-/tmp}/install-lib-step.XXXXXX")"
  local tail="${INSTALL_LIB_RUN_TAIL_LINES:-8}"
  if ((tail < 2)); then
    tail=8
  fi
  local status
  if _install_lib_run_use_tui; then
    _install_lib_run_with_tui "$log_file" "$tail" "${cmd[@]}"
    status=$?
  else
    _install_lib_run_plain "$log_file" "$tail" "${cmd[@]}"
    status=$?
  fi
  if ((status == 0)); then
    printf '   %s %s\n' "$(@install.color::wrap "$INSTALL_LIB_COLOR_SUCCESS" "$INSTALL_LIB_ICON_CHECK")" "$description"
  else
    printf '   %s %s (exit %s)\n' "$(@install.color::wrap "$INSTALL_LIB_COLOR_FAIL" "$INSTALL_LIB_ICON_CROSS")" "$description" "$status"
  fi
  rm -f "$log_file"
  return "$status"
}

# vim: set ft=bash:
