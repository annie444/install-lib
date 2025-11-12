# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_UI_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_UI_LOADED=1

il::ui::prompt_yes_no() {
  local prompt="$1"
  shift || true
  local default="${1:-y}"
  local hint
  if [[ "$default" == "y" ]]; then
    hint="[Y/n]"
  else
    hint="[y/N]"
  fi
  while true; do
    read -r -p "${prompt} ${hint} " reply
    reply="${reply:-$default}"
    case "${reply,,}" in
    y | yes) return 0 ;;
    n | no) return 1 ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

il::ui::section() {
  local title="$1"
  printf '\n=== %s ===\n' "$title"
}

il::ui::is_tty() {
  [[ -t 1 ]]
}

il::ui::has_tput() {
  command -v tput >/dev/null 2>&1
}

il::ui::cursor_hide() {
  tput civis || true
}

il::ui::cursor_show() {
  tput cnorm || true
}

il::ui::clear_line() {
  tput el || true
}

il::ui::cursor_save() {
  tput sc || true
}

il::ui::cursor_restore() {
  tput rc || true
}

# vim: set ft=bash:
