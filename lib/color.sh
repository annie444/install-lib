# shellcheck shell=bash
# @name install-lib color
# @file install-lib color
# @brief ANSI color helpers and icons for install-lib.
# @description Color support detection and wrapping helpers for install-lib.

if [[ -n "${INSTALL_LIB_COLOR_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_COLOR_LOADED=1

# @internal
# @brief Detect whether color output should be enabled.
# @set INSTALL_LIB_FORCE_COLOR boolean Force color even when not a TTY.
# @set INSTALL_LIB_NO_COLOR boolean Disable color entirely.
# @exitcode 0 when color is allowed; 1 otherwise.
# @example
#   if _install_lib_supports_color; then echo "color"; fi
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

# @brief Apply ANSI code color to text, resetting safely if colors are enabled.
# @description
#    Adds reset code and preserves trailing newlines.
#
# @arg $1 string ANSI color code.
#
# @arg $@ string Text to wrap (variadic).
#
# @stdout Decorated text.
# @stderr None.
# @exitcode Always 0.
#
# @example
#   @install.color::wrap "$INSTALL_LIB_COLOR_FG_GREEN" "ok"  # prints green ok
@install.color::wrap() {
  local code="$1"
  shift
  local string="$*"
  if [[ -z "$code" ]]; then
    printf '%s' "$*"
  else
    if [[ "${string: -2}" == '\n' ]]; then
      string="${string%\\n}"
      printf '%s%s%s\n' "$code" "$string" "$INSTALL_LIB_COLOR_RESET"
      return
    fi
    printf '%s%s%s' "$code" "$string" "$INSTALL_LIB_COLOR_RESET"
  fi
}

# @brief Bold text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bold "Title"
@install.color::bold() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BOLD" "$*"
}

# @brief Dim text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::dim "Note"
@install.color::dim() {
  @install.color::wrap "$INSTALL_LIB_COLOR_DIM" "$*"
}

# @brief Italicize text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::italic "Emphasis"
@install.color::italic() {
  @install.color::wrap "$INSTALL_LIB_COLOR_ITALIC" "$*"
}

# @brief Underline text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::underline "Link"
@install.color::underline() {
  @install.color::wrap "$INSTALL_LIB_COLOR_UNDERLINE" "$*"
}

# @brief Blink text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::blink "Alert"
@install.color::blink() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BLINK" "$*"
}

# @brief Reverse-video text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::reverse "Invert"
@install.color::reverse() {
  @install.color::wrap "$INSTALL_LIB_COLOR_REVERSE" "$*"
}

# @brief Hide text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::hidden "secret"
@install.color::hidden() {
  @install.color::wrap "$INSTALL_LIB_COLOR_HIDDEN" "$*"
}

# @brief Strike through text when color support is available.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::strikethrough "old"
@install.color::strikethrough() {
  @install.color::wrap "$INSTALL_LIB_COLOR_STRIKETHROUGH" "$*"
}

# @brief Black foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::black "text"
@install.color::fg::black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BLACK" "$*"
}

# @brief Red foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::red "text"
@install.color::fg::red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_RED" "$*"
}

# @brief Green foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::green "text"
@install.color::fg::green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_GREEN" "$*"
}

# @brief Yellow foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::yellow "text"
@install.color::fg::yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_YELLOW" "$*"
}

# @brief Blue foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::blue "text"
@install.color::fg::blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BLUE" "$*"
}

# @brief Magenta foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::magenta "text"
@install.color::fg::magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_MAGENTA" "$*"
}

# @brief Cyan foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::cyan "text"
@install.color::fg::cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_CYAN" "$*"
}

# @brief White foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::white "text"
@install.color::fg::white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_WHITE" "$*"
}

# @brief Black background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::black "text"
@install.color::bg::black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BLACK" "$*"
}

# @brief Red background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::red "text"
@install.color::bg::red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_RED" "$*"
}

# @brief Green background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::green "text"
@install.color::bg::green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_GREEN" "$*"
}

# @brief Yellow background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::yellow "text"
@install.color::bg::yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_YELLOW" "$*"
}

# @brief Blue background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::blue "text"
@install.color::bg::blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BLUE" "$*"
}

# @brief Magenta background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::magenta "text"
@install.color::bg::magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_MAGENTA" "$*"
}

# @brief Cyan background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::cyan "text"
@install.color::bg::cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_CYAN" "$*"
}

# @brief White background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::white "text"
@install.color::bg::white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_WHITE" "$*"
}

# @brief Bright black foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_black "text"
@install.color::fg::bright_black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BBLACK" "$*"
}

# @brief Bright red foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_red "text"
@install.color::fg::bright_red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BRED" "$*"
}

# @brief Bright green foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_green "text"
@install.color::fg::bright_green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BGREEN" "$*"
}

# @brief Bright yellow foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_yellow "text"
@install.color::fg::bright_yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BYELLOW" "$*"
}

# @brief Bright blue foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_blue "text"
@install.color::fg::bright_blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BBLUE" "$*"
}

# @brief Bright magenta foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_magenta "text"
@install.color::fg::bright_magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BMAGENTA" "$*"
}

# @brief Bright cyan foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_cyan "text"
@install.color::fg::bright_cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BCYAN" "$*"
}

# @brief Bright white foreground wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::fg::bright_white "text"
@install.color::fg::bright_white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_FG_BWHITE" "$*"
}

# @brief Bright black background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_black "text"
@install.color::bg::bright_black() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BBLACK" "$*"
}

# @brief Bright red background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_red "text"
@install.color::bg::bright_red() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BRED" "$*"
}

# @brief Bright green background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_green "text"
@install.color::bg::bright_green() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BGREEN" "$*"
}

# @brief Bright yellow background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_yellow "text"
@install.color::bg::bright_yellow() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BYELLOW" "$*"
}

# @brief Bright blue background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_blue "text"
@install.color::bg::bright_blue() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BBLUE" "$*"
}

# @brief Bright magenta background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_magenta "text"
@install.color::bg::bright_magenta() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BMAGENTA" "$*"
}
# @brief Bright cyan background wrapper.
# @see @install.color::wrap
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_cyan "text"
@install.color::bg::bright_cyan() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BCYAN" "$*"
}
# @brief Bright white background wrapper.
# @exitcode Always 0.
# @example
#   @install.color::bg::bright_white "example"
@install.color::bg::bright_white() {
  @install.color::wrap "$INSTALL_LIB_COLOR_BG_BWHITE" "$*"
}
# @brief Use accent color wrapper (blue default).
# @see @install.color::wrap
# @stdout Decorated text.
# @exitcode Always 0.
# @example
#   @install.color::accent "heading"
@install.color::accent() {
  @install.color::wrap "$INSTALL_LIB_COLOR_ACCENT" "$*"
}

# shellcheck disable=SC2034
INSTALL_LIB_ICON_SPINNER_ASCII=('-' $'\\' '|' '/')
# shellcheck disable=SC2034
INSTALL_LIB_ICON_SPINNER_BRAILLE=($'\u280b' $'\u2809' $'\u280a' $'\u280c' $'\u284c' $'\u284e' $'\u2846' $'\u2844')

unset -f _install_lib_supports_color
