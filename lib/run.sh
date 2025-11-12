# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_RUN_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_RUN_LOADED=1

_IL_RUN_STEP_INDEX=0
_IL_RUN_LINES=()

if [[ -n "${IL_ASCII_ONLY:-}" ]]; then
  # shellcheck disable=SC1003
  _IL_RUN_SPINNER_FRAMES=('-' '\\' '|' '/')
else
  _IL_RUN_SPINNER_FRAMES=($'\u280b' $'\u2809' $'\u280a' $'\u280c' $'\u284c' $'\u284e' $'\u2846' $'\u2844')
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
  local is_final="$3"
  local total=${#_IL_RUN_LINES[@]}
  local i
  for ((i = 0; i < block_height; i++)); do
    il::ui::clear_line
    local prefix='│'
    if ((i == 0)); then
      prefix="$icon"
    fi
    if ((i < total)); then
      printf '   %s %s\n' "$prefix" "${_IL_RUN_LINES[i]}"
    else
      printf '   %s\n' "$prefix"
    fi
  done
  if [[ "$is_final" == "1" ]]; then
    return
  fi
  tput cuu "$block_height" >/dev/null 2>&1 || true
}

_il_run_with_tui() {
  local log_file="$1"
  local block_lines="$2"
  shift 2
  local cmd=("$@")
  if ((block_lines < 3)); then
    block_lines=3
  fi
  local fifo
  fifo="$(mktemp -u "${TMPDIR:-/tmp}/install-lib-run.XXXXXX")"
  mkfifo "$fifo"
  il::ui::cursor_hide
  _IL_RUN_LINES=()
  trap 'il::ui::cursor_show; rm -f "$fifo"' RETURN

  local i
  for ((i = 0; i < block_lines; i++)); do
    printf '   │\n'
  done
  tput cuu "$block_lines" >/dev/null 2>&1 || true

  (
    set -o pipefail
    "${cmd[@]}"
  ) >"$fifo" 2>&1 &
  local cmd_pid=$!

  local frames=("${_IL_RUN_SPINNER_FRAMES[@]}")
  local frame_count=${#frames[@]}
  local frame_idx=0
  local line=""

  while true; do
    local had_line=0
    while IFS= read -r -t 0.05 line <"$fifo"; do
      had_line=1
      printf '%s\n' "$line" >>"$log_file"
      _IL_RUN_LINES+=("$line")
      if ((${#_IL_RUN_LINES[@]} > block_lines)); then
        _IL_RUN_LINES=("${_IL_RUN_LINES[@]:1}")
      fi
    done
    _il_run_draw_block "${frames[frame_idx]}" "$block_lines" 0
    frame_idx=$(((frame_idx + 1) % frame_count))
    if ! kill -0 "$cmd_pid" >/dev/null 2>&1 && [[ $had_line -eq 0 ]]; then
      break
    fi
  done

  while IFS= read -r line <"$fifo"; do
    printf '%s\n' "$line" >>"$log_file"
    _IL_RUN_LINES+=("$line")
    if ((${#_IL_RUN_LINES[@]} > block_lines)); then
      _IL_RUN_LINES=("${_IL_RUN_LINES[@]:1}")
    fi
    _il_run_draw_block "${frames[frame_idx]}" "$block_lines" 0
  done

  wait "$cmd_pid"
  local status=$?
  local icon
  if ((status == 0)); then
    icon='✔'
  else
    icon='✖'
  fi
  _il_run_draw_block "$icon" "$block_lines" 1
  tput cud "$block_lines" >/dev/null 2>&1 || true
  trap - RETURN
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
    printf '%s\n' "$summary" | sed 's/^/   │ /'
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
  printf '%s %s\n' "$tag" "$description"
  printf '   $ %s\n' "${cmd[*]}"
  local log_file
  log_file="$(mktemp "${TMPDIR:-/tmp}/install-lib-step.XXXXXX")"
  local tail="${IL_RUN_TAIL_LINES:-8}"
  if ((tail < 1)); then
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
    printf '   ✔ %s\n' "$description"
  else
    printf '   ✖ %s (exit %s)\n' "$description" "$status"
  fi
  rm -f "$log_file"
  return "$status"
}

# vim: set ft=bash:
