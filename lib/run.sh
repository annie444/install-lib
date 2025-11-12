# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_RUN_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_RUN_LOADED=1

_IL_RUN_STEP_INDEX=0
_IL_RUN_LINES=()

if [[ -n "${IL_ASCII_ONLY:-}" ]]; then
  _IL_RUN_SPINNER_FRAMES=("${IL_ICON_SPINNER_ASCII[@]}")
else
  _IL_RUN_SPINNER_FRAMES=("${IL_ICON_SPINNER_BRAILLE[@]}")
fi

_il_run_use_tui() {
  [[ -z "${IL_RUN_FORCE_PLAIN:-}" ]] &&
    il::ui::is_tty &&
    il::ui::has_tput &&
    command -v mkfifo >/dev/null 2>&1
}

_il_run_draw_block() {
  local icon="$1"
  local block_height="$2"
  local log_capacity=$((block_height - 1))
  ((log_capacity < 1)) && log_capacity=1
  local total=${#_IL_RUN_LINES[@]}

  local log_start=0
  if ((total > log_capacity)); then
    log_start=$((total - log_capacity))
  fi

  local i
  for ((i = 0; i < log_capacity; i++)); do
    il::ui::clear_line
    local idx=$((log_start + i))
    if ((idx < total)); then
      printf '   │ %s\n' "$(il::color::dim "${_IL_RUN_LINES[idx]}")"
    else
      printf '   │\n'
    fi
  done
}

_il_run_with_tui() {
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

  il::ui::cursor_hide
  _IL_RUN_LINES=()
  trap 'il::ui::cursor_show; rm -f "$fifo"' EXIT INT TERM

  : >"$log_file"
  (
    set -o pipefail
    "${cmd[@]}"
  ) >"$fifo" 2>&1 &
  local cmd_pid=$!

  exec 3<"$fifo"

  local frames=("${_IL_RUN_SPINNER_FRAMES[@]}")
  local frame_count=${#frames[@]}
  local frame_idx=0

  local i line
  for ((i = 0; i < block_lines; i++)); do
    printf '   │\n'
  done
  tput cuu "$block_lines" || true
  il::ui::cursor_save

  while true; do
    local had_line=0
    while IFS= read -r -t 0.05 line <&3; do
      had_line=1
      printf '%s\n' "$line" >>"$log_file"
      _IL_RUN_LINES+=("$line")
      if ((${#_IL_RUN_LINES[@]} > log_capacity)); then
        _IL_RUN_LINES=("${_IL_RUN_LINES[@]:1}")
      fi
    done
    il::ui::cursor_restore
    _il_run_draw_block "${frames[frame_idx]}" "$block_lines"
    frame_idx=$(((frame_idx + 1) % frame_count))
    if ! kill -0 "$cmd_pid" >/dev/null 2>&1 && [[ $had_line -eq 0 ]]; then
      break
    fi
  done

  while IFS= read -r line <&3; do
    printf '%s\n' "$line" >>"$log_file"
    _IL_RUN_LINES+=("$line")
    if ((${#_IL_RUN_LINES[@]} > log_capacity)); then
      _IL_RUN_LINES=("${_IL_RUN_LINES[@]:1}")
    fi
    il::ui::cursor_restore
    _il_run_draw_block "${frames[frame_idx]}" "$block_lines"
  done

  exec 3<&-

  wait "$cmd_pid"
  local status=$?
  local icon="$IL_ICON_CROSS"
  if ((status == 0)); then
    icon="$IL_ICON_CHECK"
  fi
  il::ui::cursor_restore
  _il_run_draw_block "$icon" "$block_lines"
  tput cud "$block_lines" || true
  trap - EXIT INT TERM
  il::ui::cursor_show
  rm -f "$fifo"
  return "$status"
}

_il_run_plain() {
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
      printf '   │ %s\n' "$(il::color::dim "$line")"
    done <<<"$summary"
  fi
  return "$status"
}

il::run::step() {
  local description="$1"
  shift || true
  if [[ -z "$description" || $# -eq 0 ]]; then
    il::die "il::run::step requires a description and a command"
  fi
  local cmd=("$@")
  _IL_RUN_STEP_INDEX=$((_IL_RUN_STEP_INDEX + 1))
  local tag="#${_IL_RUN_STEP_INDEX}"
  printf '%s %s\n' "$(il::color::accent "$tag")" "$description"
  printf '   $ %s\n' "$(il::color::dim "${cmd[*]}")"
  local log_file
  log_file="$(mktemp "${TMPDIR:-/tmp}/install-lib-step.XXXXXX")"
  local tail="${IL_RUN_TAIL_LINES:-8}"
  if ((tail < 2)); then
    tail=8
  fi
  local status
  if _il_run_use_tui; then
    _il_run_with_tui "$log_file" "$tail" "${cmd[@]}"
    status=$?
  else
    _il_run_plain "$log_file" "$tail" "${cmd[@]}"
    status=$?
  fi
  if ((status == 0)); then
    printf '   %s %s\n' "$(il::color::wrap "$IL_COLOR_SUCCESS" "$IL_ICON_CHECK")" "$description"
  else
    printf '   %s %s (exit %s)\n' "$(il::color::wrap "$IL_COLOR_FAIL" "$IL_ICON_CROSS")" "$description" "$status"
  fi
  rm -f "$log_file"
  return "$status"
}

# vim: set ft=bash:
