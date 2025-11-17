# shellcheck shell=bash
# @name install-lib packages
# @file install-lib packages
# @brief Package manager detection and installation helpers.

if [[ -n "${INSTALL_LIB_PACKAGES_LOADED:-}" ]]; then
  return 0
fi
INSTALL_LIB_PACKAGES_LOADED=1

# @brief Detect available package manager (brew/apt/apt-get/dnf5/dnf/yum) or return unknown.
# @description
#   Checks PATH for well-known package managers in priority order.
#
# @stdout Manager name or "unknown".
# @exitcode 0 when detection completes.
#
# @example
#   mgr="$(@install.pkg::detect_manager)"
@install.pkg::detect_manager() {
  if @install.os::has_cmd brew; then
    printf 'brew\n'
  elif @install.os::has_cmd apt; then
    printf 'apt\n'
  elif @install.os::has_cmd apt-get; then
    printf 'apt-get\n'
  elif @install.os::has_cmd dnf5; then
    printf 'dnf5\n'
  elif @install.os::has_cmd dnf; then
    printf 'dnf\n'
  elif @install.os::has_cmd yum; then
    printf 'yum\n'
  else
    printf 'unknown\n'
  fi
}

# @brief Install packages using detected manager; warn if manager is unknown.
#
# @arg $@ string Package names to ensure are installed.
#
# @stderr Progress or warnings.
# @exitcode Pass-through of package manager; 0 on success else manager exit.
#
# @example
#   @install.pkg::ensure git curl
@install.pkg::ensure() {
  local manager
  manager="$(@install.pkg::detect_manager)"
  local pkg
  for pkg in "$@"; do
    case "$manager" in
    brew)
      if ! brew list "$pkg" >/dev/null 2>&1; then
        @install.log::info "Installing $pkg via brew"
        brew install "$pkg"
      else
        @install.log::debug "$pkg already installed"
      fi
      ;;
    apt-get | apt)
      if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        @install.log::info "Installing $pkg via apt"
        if ((UID != 0)) && ((EUID != 0)); then
          sudo apt-get update -y
          sudo apt-get install -y "$pkg"
        else
          apt-get update -y
          apt-get install -y "$pkg"
        fi
      else
        @install.log::debug "$pkg already installed"
      fi
      ;;
    yum | dnf | dnf5)
      if ! rpm -q "$pkg" >/dev/null 2>&1; then
        @install.log::info "Installing $pkg via yum"
        if ((UID != 0)) && ((EUID != 0)); then
          sudo "$manager" install -y "$pkg"
        else
          "$manager" install -y "$pkg"
        fi
      else
        @install.log::debug "$pkg already installed"
      fi
      ;;
    *)
      @install.log::warn "Unknown package manager; install $pkg manually"
      ;;
    esac
  done
}

# vim: set ft=bash:
