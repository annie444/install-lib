# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_COLOR_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_COLOR_LOADED=1

_il_color_supports() {
  if [[ -n "${IL_NO_COLOR:-}" ]]; then
    return 1
  fi
  if [[ -t 1 || -t 2 ]]; then
    local colors
    colors=$(tput colors || printf '0')
    if ((colors > 0)); then
      return
    fi
  fi
  return 1
}

# shellcheck disable=SC2034
if _il_color_supports; then
  IL_COLOR_RESET=$'\033[0m'
  IL_COLOR_BOLD=$'\033[1m'
  IL_COLOR_DIM=$'\033[2m'
  IL_COLOR_ITALIC=$'\033[3m'
  IL_COLOR_UNDERLINE=$'\033[4m'
  IL_COLOR_BLINK=$'\033[5m'
  IL_COLOR_REVERSE=$'\033[7m'
  IL_COLOR_HIDDEN=$'\033[8m'
  IL_COLOR_STRIKETHROUGH=$'\033[9m'
  IL_COLOR_INFO=$'\033[32m'
  IL_COLOR_WARN=$'\033[33m'
  IL_COLOR_ERROR=$'\033[31m'
  IL_COLOR_DEBUG=$'\033[36m'
  IL_COLOR_ACCENT=$'\033[34m'
  IL_COLOR_SUCCESS=$'\033[32m'
  IL_COLOR_FAIL=$'\033[31m'
else
  IL_COLOR_RESET=""
  IL_COLOR_BOLD=""
  IL_COLOR_DIM=""
  IL_COLOR_ITALIC=""
  IL_COLOR_UNDERLINE=""
  IL_COLOR_BLINK=""
  IL_COLOR_REVERSE=""
  IL_COLOR_HIDDEN=""
  IL_COLOR_STRIKETHROUGH=""
  IL_COLOR_INFO=""
  IL_COLOR_WARN=""
  IL_COLOR_ERROR=""
  IL_COLOR_DEBUG=""
  IL_COLOR_ACCENT=""
  IL_COLOR_SUCCESS=""
  IL_COLOR_FAIL=""
fi

# shellcheck disable=SC2034
IL_ICON_CHECK="✔"
# shellcheck disable=SC2034
IL_ICON_CROSS="✖"

il::color::bold() {
  il::color::wrap "$IL_COLOR_BOLD" "$*"
}
il::color::dim() {
  il::color::wrap "$IL_COLOR_DIM" "$*"
}
il::color::italic() {
  il::color::wrap "$IL_COLOR_ITALIC" "$*"
}
il::color::underline() {
  il::color::wrap "$IL_COLOR_UNDERLINE" "$*"
}
il::color::blink() {
  il::color::wrap "$IL_COLOR_BLINK" "$*"
}
il::color::reverse() {
  il::color::wrap "$IL_COLOR_REVERSE" "$*"
}
il::color::hidden() {
  il::color::wrap "$IL_COLOR_HIDDEN" "$*"
}
il::color::strikethrough() {
  il::color::wrap "$IL_COLOR_STRIKETHROUGH" "$*"
}

il::color::wrap() {
  local code="$1"
  shift
  local string="$*"
  if [[ -z "$code" ]]; then
    printf '%s' "$*"
  else
    if [[ "${string: -2}" == '\n' ]]; then
      string="${string%\\n}"
      printf '%s%s%s\n' "$code" "$string" "$IL_COLOR_RESET"
      return
    fi
    printf '%s%s%s' "$code" "$string" "$IL_COLOR_RESET"
  fi
}

il::color::accent() {
  il::color::wrap "$IL_COLOR_ACCENT" "$*"
}

# shellcheck disable=SC2034
IL_ICON_SPINNER_ASCII=('-' $'\\' '|' '/')
# shellcheck disable=SC2034
IL_ICON_SPINNER_BRAILLE=($'\u280b' $'\u2809' $'\u280a' $'\u280c' $'\u284c' $'\u284e' $'\u2846' $'\u2844')

unset -f _il_color_supports
