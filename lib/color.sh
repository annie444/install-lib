# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_COLOR_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_COLOR_LOADED=1

_install_lib_supports_color() {
  if [[ -n "${INSTALL_LIB_FORCE_COLOR:-}" ]]; then
    return 0
  fi
  if [[ -n "${INSTALL_LIB_NO_COLOR:-}" ]]; then
    return 1
  fi
  if [[ -t 1 || -t 2 ]]; then
    local colors
    colors="$(tput colors || printf '0')"
    if ((colors > 0)); then
      return
    fi
  fi
  return 1
}

# shellcheck disable=SC2034
if _install_lib_supports_color; then
  INSTALL_LIB_COLOR_RESET=$'\033[0m'
  INSTALL_LIB_COLOR_BOLD=$'\033[1m'
  INSTALL_LIB_COLOR_DIM=$'\033[2m'
  INSTALL_LIB_COLOR_ITALIC=$'\033[3m'
  INSTALL_LIB_COLOR_UNDERLINE=$'\033[4m'
  INSTALL_LIB_COLOR_BLINK=$'\033[5m'
  INSTALL_LIB_COLOR_REVERSE=$'\033[7m'
  INSTALL_LIB_COLOR_HIDDEN=$'\033[8m'
  INSTALL_LIB_COLOR_STRIKETHROUGH=$'\033[9m'
  INSTALL_LIB_COLOR_FG_BLACK=$'\033[30m'
  INSTALL_LIB_COLOR_FG_RED=$'\033[31m'
  INSTALL_LIB_COLOR_FG_GREEN=$'\033[32m'
  INSTALL_LIB_COLOR_FG_YELLOW=$'\033[33m'
  INSTALL_LIB_COLOR_FG_BLUE=$'\033[34m'
  INSTALL_LIB_COLOR_FG_MAGENTA=$'\033[35m'
  INSTALL_LIB_COLOR_FG_CYAN=$'\033[36m'
  INSTALL_LIB_COLOR_FG_WHITE=$'\033[37m'
  INSTALL_LIB_COLOR_FG_BBLACK=$'\033[90m'
  INSTALL_LIB_COLOR_FG_BRED=$'\033[91m'
  INSTALL_LIB_COLOR_FG_BGREEN=$'\033[92m'
  INSTALL_LIB_COLOR_FG_BYELLOW=$'\033[93m'
  INSTALL_LIB_COLOR_FG_BBLUE=$'\033[94m'
  INSTALL_LIB_COLOR_FG_BMAGENTA=$'\033[95m'
  INSTALL_LIB_COLOR_FG_BCYAN=$'\033[96m'
  INSTALL_LIB_COLOR_FG_BWHITE=$'\033[97m'
  INSTALL_LIB_COLOR_BG_BLACK=$'\033[40m'
  INSTALL_LIB_COLOR_BG_RED=$'\033[41m'
  INSTALL_LIB_COLOR_BG_GREEN=$'\033[42m'
  INSTALL_LIB_COLOR_BG_YELLOW=$'\033[43m'
  INSTALL_LIB_COLOR_BG_BLUE=$'\033[44m'
  INSTALL_LIB_COLOR_BG_MAGENTA=$'\033[45m'
  INSTALL_LIB_COLOR_BG_CYAN=$'\033[46m'
  INSTALL_LIB_COLOR_BG_WHITE=$'\033[47m'
  INSTALL_LIB_COLOR_BG_BBLACK=$'\033[100m'
  INSTALL_LIB_COLOR_BG_BRED=$'\033[101m'
  INSTALL_LIB_COLOR_BG_BGREEN=$'\033[102m'
  INSTALL_LIB_COLOR_BG_BYELLOW=$'\033[103m'
  INSTALL_LIB_COLOR_BG_BBLUE=$'\033[104m'
  INSTALL_LIB_COLOR_BG_BMAGENTA=$'\033[105m'
  INSTALL_LIB_COLOR_BG_BCYAN=$'\033[106m'
  INSTALL_LIB_COLOR_BG_BWHITE=$'\033[107m'
  INSTALL_LIB_COLOR_INFO="$INSTALL_LIB_COLOR_FG_GREEN"
  INSTALL_LIB_COLOR_WARN="$INSTALL_LIB_COLOR_FG_YELLOW"
  INSTALL_LIB_COLOR_ERROR="$INSTALL_LIB_COLOR_FG_RED"
  INSTALL_LIB_COLOR_DEBUG="$INSTALL_LIB_COLOR_FG_CYAN"
  INSTALL_LIB_COLOR_ACCENT="$INSTALL_LIB_COLOR_FG_BLUE"
  INSTALL_LIB_COLOR_SUCCESS="$INSTALL_LIB_COLOR_FG_GREEN"
  INSTALL_LIB_COLOR_FAIL="$INSTALL_LIB_COLOR_FG_RED"
else
  INSTALL_LIB_COLOR_RESET=""
  INSTALL_LIB_COLOR_BOLD=""
  INSTALL_LIB_COLOR_DIM=""
  INSTALL_LIB_COLOR_ITALIC=""
  INSTALL_LIB_COLOR_UNDERLINE=""
  INSTALL_LIB_COLOR_BLINK=""
  INSTALL_LIB_COLOR_REVERSE=""
  INSTALL_LIB_COLOR_HIDDEN=""
  INSTALL_LIB_COLOR_STRIKETHROUGH=""
  INSTALL_LIB_COLOR_FG_BLACK=""
  INSTALL_LIB_COLOR_FG_RED=""
  INSTALL_LIB_COLOR_FG_GREEN=""
  INSTALL_LIB_COLOR_FG_YELLOW=""
  INSTALL_LIB_COLOR_FG_BLUE=""
  INSTALL_LIB_COLOR_FG_MAGENTA=""
  INSTALL_LIB_COLOR_FG_CYAN=""
  INSTALL_LIB_COLOR_FG_WHITE=""
  INSTALL_LIB_COLOR_FG_BBLACK=""
  INSTALL_LIB_COLOR_FG_BRED=""
  INSTALL_LIB_COLOR_FG_BGREEN=""
  INSTALL_LIB_COLOR_FG_BYELLOW=""
  INSTALL_LIB_COLOR_FG_BBLUE=""
  INSTALL_LIB_COLOR_FG_BMAGENTA=""
  INSTALL_LIB_COLOR_FG_BCYAN=""
  INSTALL_LIB_COLOR_FG_BWHITE=""
  INSTALL_LIB_COLOR_BG_BLACK=""
  INSTALL_LIB_COLOR_BG_RED=""
  INSTALL_LIB_COLOR_BG_GREEN=""
  INSTALL_LIB_COLOR_BG_YELLOW=""
  INSTALL_LIB_COLOR_BG_BLUE=""
  INSTALL_LIB_COLOR_BG_MAGENTA=""
  INSTALL_LIB_COLOR_BG_CYAN=""
  INSTALL_LIB_COLOR_BG_WHITE=""
  INSTALL_LIB_COLOR_BG_BBLACK=""
  INSTALL_LIB_COLOR_BG_BRED=""
  INSTALL_LIB_COLOR_BG_BGREEN=""
  INSTALL_LIB_COLOR_BG_BYELLOW=""
  INSTALL_LIB_COLOR_BG_BBLUE=""
  INSTALL_LIB_COLOR_BG_BMAGENTA=""
  INSTALL_LIB_COLOR_BG_BCYAN=""
  INSTALL_LIB_COLOR_BG_BWHITE=""
  INSTALL_LIB_COLOR_INFO=""
  INSTALL_LIB_COLOR_WARN=""
  INSTALL_LIB_COLOR_ERROR=""
  INSTALL_LIB_COLOR_DEBUG=""
  INSTALL_LIB_COLOR_ACCENT=""
  INSTALL_LIB_COLOR_SUCCESS=""
  INSTALL_LIB_COLOR_FAIL=""
fi

# shellcheck disable=SC2034
INSTALL_LIB_ICON_CHECK="✔"
# shellcheck disable=SC2034
INSTALL_LIB_ICON_CROSS="✖"

@install.color::wrap() {
  local code="$1"
  shift
  local string="$*"
  if [[ -z "$code" ]]; then
    printf '%s' "$*"
  else
    local beginning="$INSTALL_LIB_COLOR_RESET"
    if [[ "$string" = *"$beginning"* ]]; then
      beginning=""
    fi
    if [[ "${string: -2}" == '\n' ]]; then
      string="${string%\\n}"
      printf '%s%s%s%s\n' "$beginning" "$code" "$string" "$INSTALL_LIB_COLOR_RESET"
      return
    fi
    printf '%s%s%s%s' "$beginning" "$code" "$string" "$INSTALL_LIB_COLOR_RESET"
  fi
}

@install.color::bold() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BOLD" "$*"
}
@install.color::dim() {
  @install.color::wrap "$INSTALL_LIB_COLOR_DIM" "$*"
}
@install.color::italic() {
  @install.color::wrap "$INSTALL_LIB_COLOR_ITALIC" "$*"
}
@install.color::underline() {
  @install.color::wrap "$INSTALL_LIB_COLOR_UNDERLINE" "$*"
}
@install.color::blink() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BLINK" "$*"
}
@install.color::reverse() {
  @install.color::wrap "$INSTALL_LIB_COLOR_REVERSE" "$*"
}
@install.color::hidden() {
  @install.color::wrap "$INSTALL_LIB_COLOR_HIDDEN" "$*"
}
@install.color::strikethrough() {
  @install.color::wrap "$INSTALL_LIB_COLOR_STRIKETHROUGH" "$*"
}
@install.color::fg::black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BLACK" "$*"
}
@install.color::fg::red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_RED" "$*"
}
@install.color::fg::green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_GREEN" "$*"
}
@install.color::fg::yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_YELLOW" "$*"
}
@install.color::fg::blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BLUE" "$*"
}
@install.color::fg::magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_MAGENTA" "$*"
}
@install.color::fg::cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_CYAN" "$*"
}
@install.color::fg::white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_WHITE" "$*"
}
@install.color::bg::black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BLACK" "$*"
}
@install.color::bg::red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_RED" "$*"
}
@install.color::bg::green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_GREEN" "$*"
}
@install.color::bg::yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_YELLOW" "$*"
}
@install.color::bg::blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BLUE" "$*"
}
@install.color::bg::magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_MAGENTA" "$*"
}
@install.color::bg::cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_CYAN" "$*"
}
@install.color::bg::white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_WHITE" "$*"
}
@install.color::fg::bright_black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BBLACK" "$*"
}
@install.color::fg::bright_red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BRED" "$*"
}
@install.color::fg::bright_green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BGREEN" "$*"
}
@install.color::fg::bright_yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BYELLOW" "$*"
}
@install.color::fg::bright_blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BBLUE" "$*"
}
@install.color::fg::bright_magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BMAGENTA" "$*"
}
@install.color::fg::bright_cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BCYAN" "$*"
}
@install.color::fg::bright_white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BWHITE" "$*"
}
@install.color::bg::bright_black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BBLACK" "$*"
}
@install.color::bg::bright_red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BRED" "$*"
}
@install.color::bg::bright_green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BGREEN" "$*"
}
@install.color::bg::bright_yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BYELLOW" "$*"
}
@install.color::bg::bright_blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BBLUE" "$*"
}
@install.color::bg::bright_magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BMAGENTA" "$*"
}
@install.color::bg::bright_cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BCYAN" "$*"
}
@install.color::bg::bright_white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BWHITE" "$*"
}
@install.color::accent() {
  @install.color::wrap "$INSTALL_LIB_COLOR_ACCENT" "$*"
}

# shellcheck disable=SC2034
INSTALL_LIB_ICON_SPINNER_ASCII=('-' $'\\' '|' '/')
# shellcheck disable=SC2034
INSTALL_LIB_ICON_SPINNER_BRAILLE=($'\u280b' $'\u2809' $'\u280a' $'\u280c' $'\u284c' $'\u284e' $'\u2846' $'\u2844')

unset -f _install_lib_supports_color
