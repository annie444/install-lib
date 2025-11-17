# shellcheck shell=bash
# @name install-lib ui
# @file install-lib ui
# @brief Terminal UI helpers for prompts, cursor control, and selection.

if [[ -n "${INSTALL_LIB_UI_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_UI_LOADED=1

# @brief Ask a yes/no question with optional default (y/n).
# @description
#   Reads from stdin and normalizes yes/no responses; defaults to provided value.
#
# @arg $1 string Prompt text.
# @arg $2 string Optional default (y|n).
#
# @stdin User response.
# @exitcode 0 for yes, 1 for no.
#
# @example
#   if @install.ui::prompt_yes_no "Continue?" y; then echo yes; fi
@install.ui::prompt_yes_no() {
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

# @brief Prompt for a single keypress (default: "Press ENTER to continue...").
#
# @arg $1 string Prompt text (optional).
#
# @stdin Single keypress.
# @noargs
# @exitcode 0 after reading input; non-zero on read error.
#
# @example
#   @install.ui::prompt_enter "Next?"
@install.ui::prompt_enter() {
  local prompt="${1:-Press ENTER to continue...}"
  read -r -n 1 -p "$prompt"
}

# @brief Interactive menu driven by arrow keys/enter; exports selected value to var_name.
# @description
#   Accepts either value/label pairs or a simple list (value=label). Uses arrow keys or j/k to move.
#
# @arg $1 string Variable name to export selection to.
# @arg $2 string Prompt to display.
# @arg $@ string Value/option pairs or plain options.
#
# @set selected Selected index (internal, unset before return).
# @set selected_value Selected value (internal, unset before return).
# @set INSTALL_LIB_ICON_CHECK string Icon prefix for the selected option (optional).
#
# @stdin Keypress navigation and Enter to select.
# @stdout Menu rendering and selection announcement.
# @exitcode 0 on selection; 1 when no options.
#
# @example
#   @install.ui::choose CHOICE "Pick" foo "Foo label" bar "Bar label"
@install.ui::choose() {
  local var_name="$1"
  shift || true
  local prompt="$1"
  shift || true
  local options=()
  declare -A values=()
  if (($# % 2 != 0)); then
    while (("$#")); do
      local opt="$1"
      options+=("$opt")
      values["$opt"]="$opt"
      shift || true
    done
  else
    while (("$#")); do
      local opt="$2"
      local val="$1"
      options+=("$opt")
      values["$opt"]="$val"
      shift 2 || true
    done
  fi
  local num_options=${#options[@]}
  if ((num_options == 0)); then
    echo "No options provided to choose from." >&2
    return 1
  fi

  echo "$prompt"
  local i
  export selected=0
  export selected_value="${values[${options[$selected]}]}"

  # @internal
  # @brief Increment selection index and wrap to the start.
  # @exitcode Always 0.
  # @example
  #   _install_lib_increment
  _install_lib_increment() {
    selected=$((selected + 1))
    if ((selected >= num_options)); then
      selected=0
    fi
    export selected
  }

  # @internal
  # @brief Decrement selection index and wrap to the end.
  # @exitcode Always 0.
  # @example
  #   _install_lib_decrement
  _install_lib_decrement() {
    selected=$((selected - 1))
    if ((selected < 0)); then
      selected=$((num_options - 1))
    fi
    export selected
  }

  # @internal
  # @brief Render the option list with the current selection highlighted.
  # @exitcode Always 0.
  # @example
  #   _install_lib_print_options
  _install_lib_print_options() {
    @install.ui::cursor_hide
    shown="${printed:-0}"
    if ((shown != 0)); then
      @install.ui::cursor_up "$num_options"
      @install.ui::clear_lines
    fi
    for ((i = 0; i < num_options; i++)); do
      if ((i == selected)); then
        export selected_value="${values[${options[$selected]}]}"
        @install.color::accent "  $INSTALL_LIB_ICON_CHECK ${options[i]}\n"
      else
        printf '    %s\n' "${options[i]}"
      fi
    done
    export printed=1
    @install.ui::cursor_show
  }

  local escape=$'\x1b'
  local up='[A'
  local down='[B'
  local k_key='k'
  local j_key='j'

  while true; do
    _install_lib_print_options
    IFS= read -rsn 1 key
    if [[ "$key" == "$escape" ]]; then
      read -rsn2 -t 0.1 key
    fi
    case "$key" in
    "$up" | "$k_key") _install_lib_decrement ;;
    "$down" | "$j_key") _install_lib_increment ;;
    "")
      @install.ui::cursor_hide
      @install.ui::cursor_up "$num_options"
      @install.ui::clear_lines
      echo "You selected: ${options[selected]}"
      eval "export $var_name=\"$selected_value\""
      @install.ui::cursor_show
      break
      ;;
    esac
  done
  unset -v printed
  unset -v selected
  unset -v selected_value
  export -n printed
  export -n selected
  export -n selected_value
}

# @brief Print a section header with separators.
# @arg $1 string Title to print.
# @stdout Formatted section line.
# @exitcode Always 0.
# @example
#   @install.ui::section "Setup"
@install.ui::section() {
  local title="$1"
  local separator_line="════════════════════"
  printf '\n%s %s %s\n' "$separator_line" "$title" "$separator_line"
}

# @brief True if stdout is a TTY.
# @exitcode 0 if tty; 1 otherwise.
# @example
#   if @install.ui::is_tty; then echo tty; fi
@install.ui::is_tty() {
  [[ -t 1 ]]
}

# @brief True if `tput` is available in PATH.
# @exitcode 0 if available; 1 otherwise.
# @example
#   @install.ui::has_tput || echo "tput missing"
@install.ui::has_tput() {
  command -v tput >/dev/null 2>&1
}

# @brief Hide cursor if supported.
# @exitcode Always 0.
# @example
#   @install.ui::cursor_hide
@install.ui::cursor_hide() {
  tput civis || true
}

# @brief Restore cursor visibility if supported.
# @exitcode Always 0.
# @example
#   @install.ui::cursor_show
@install.ui::cursor_show() {
  tput cnorm || true
}

# @brief Clear current line via tput.
# @exitcode Always 0.
# @example
#   @install.ui::clear_line
@install.ui::clear_line() {
  tput el || true
}

# @brief Clear screen via tput.
# @exitcode Always 0.
# @example
#   @install.ui::clear_screen
@install.ui::clear_screen() {
  tput clear || true
}

# @brief Clear from cursor to end of display via tput.
# @exitcode Always 0.
# @example
#   @install.ui::clear_lines
@install.ui::clear_lines() {
  tput ed || true
}

# @brief Save cursor position via tput.
# @exitcode Always 0.
# @example
#   @install.ui::cursor_save
@install.ui::cursor_save() {
  tput sc || true
}

# @brief Restore cursor position via tput.
# @exitcode Always 0.
# @example
#   @install.ui::cursor_restore
@install.ui::cursor_restore() {
  tput rc || true
}

# @brief Move cursor up N lines (default 1).
# @arg $1 number Lines to move (optional).
# @exitcode Always 0.
# @example
#   @install.ui::cursor_up 2
@install.ui::cursor_up() {
  local lines
  if [[ -z "${1:-}" ]]; then
    lines=1
  else
    lines="$1"
  fi
  tput cuu "${lines:-1}" || true
}

# vim: set ft=bash:
