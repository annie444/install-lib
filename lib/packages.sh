# shellcheck shell=bash

if [[ -n "${INSTALL_LIB_PACKAGES_LOADED:-}" ]]; then
  return 0
fi
declare -g INSTALL_LIB_PACKAGES_LOADED=1

il::pkg::detect_manager() {
  if il::os::has_cmd brew; then
    printf 'brew\n'
  elif il::os::has_cmd apt; then
    printf 'apt\n'
  elif il::os::has_cmd apt-get; then
    printf 'apt-get\n'
  elif il::os::has_cmd dnf5; then
    printf 'dnf5\n'
  elif il::os::has_cmd dnf; then
    printf 'dnf\n'
  elif il::os::has_cmd yum; then
    printf 'yum\n'
  else
    printf 'unknown\n'
  fi
}

il::pkg::ensure() {
  local manager
  manager="$(il::pkg::detect_manager)"
  local pkg
  for pkg in "$@"; do
    case "$manager" in
    brew)
      if ! brew list "$pkg" >/dev/null 2>&1; then
        il::log::info "Installing $pkg via brew"
        brew install "$pkg"
      else
        il::log::debug "$pkg already installed"
      fi
      ;;
    apt-get | apt)
      if ! dpkg -s "$pkg" >/dev/null 2>&1; then
        il::log::info "Installing $pkg via apt"
        sudo apt-get update -y
        sudo apt-get install -y "$pkg"
      else
        il::log::debug "$pkg already installed"
      fi
      ;;
    yum | dnf | dnf5)
      if ! rpm -q "$pkg" >/dev/null 2>&1; then
        il::log::info "Installing $pkg via yum"
        sudo "$manager" install -y "$pkg"
      else
        il::log::debug "$pkg already installed"
      fi
      ;;
    *)
      il::log::warn "Unknown package manager; install $pkg manually"
      ;;
    esac
  done
}

# vim: set ft=bash:
