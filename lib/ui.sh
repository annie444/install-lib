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

il::ui::prompt_enter() {
  local prompt="${1:-Press ENTER to continue...}"
  read -r -p "$prompt"
}

il::ui::choose() {
  local var_name="$1"
  shift || true
  local prompt="$1"
  shift || true
  local options=()
  declare -A values=()
  while (("$#")); do
    local opt="$2"
    local val="$1"
    options+=("$opt")
    values["$opt"]="$val"
    shift 2 || true
  done
  local num_options=${#options[@]}
  if ((num_options == 0)); then
    echo "No options provided to choose from." >&2
    return 1
  fi

  echo "$prompt"
  local i
  export selected=0
  export selected_value="${values[${options[$selected]}]}"
  increment() {
    selected=$((selected + 1))
    if ((selected >= num_options)); then
      selected=0
    fi
    export selected
  }
  decrement() {
    selected=$((selected - 1))
    if ((selected < 0)); then
      selected=$((num_options - 1))
    fi
    export selected
  }

  print_options() {
    shown="${printed:-0}"
    if ((shown != 0)); then
      il::ui::cursor_up "$num_options"
      il::ui::clear_line
    fi
    for ((i = 0; i < num_options; i++)); do
      if ((i == selected)); then
        export selected_value="${values[${options[$selected]}]}"
        il::color::accent "  $IL_ICON_CHECK ${options[i]}\n"
      else
        printf '    %s\n' "${options[i]}"
      fi
    done
    export printed=1
  }

  local escape=$'\x1b'
  local up='[A'
  local down='[B'
  local k_key='k'
  local j_key='j'

  while true; do
    print_options
    IFS= read -rsn 1 key
    if [[ "$key" == "$escape" ]]; then
      read -rsn2 -t 0.1 key
    fi
    case "$key" in
    "$up" | "$k_key") decrement ;;
    "$down" | "$j_key") increment ;;
    "")
      il::ui::cursor_up "$num_options"
      il::ui::clear_line
      echo "You selected: ${options[selected]}"
      eval "export $var_name=\"$selected_value\""
      break
      ;;
    esac
    print_options
  done
}

il::ui::section() {
  local title="$1"
  local separator_line="════════════════════"
  printf '\n%s %s %s\n' "$separator_line" "$title" "$separator_line"
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

il::ui::cursor_up() {
  local lines="$1"
  tput cuu "${lines:-1}" || true
}

# vim: set ft=bash:
