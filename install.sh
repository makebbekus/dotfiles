#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

die() { echo "error: $*" >&2; exit 1; }

ensure_command() {
  command -v "$1" >/dev/null 2>&1 || die "missing required command: $1 (install it and retry)"
}

# Print path to brew if it exists on disk or PATH; stdout only.
brew_executable() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return 0
  fi
  local p
  for p in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
    if [[ -x "$p" ]]; then
      printf '%s\n' "$p"
      return 0
    fi
  done
  return 1
}

load_brew_shellenv() {
  local brew_path
  brew_path="$(brew_executable)" || return 1
  eval "$("$brew_path" shellenv)"
}

install_homebrew() {
  case "$(uname -s)" in
    Darwin | Linux) ;;
    *) die "automatic Homebrew install only supports macOS and Linux (got $(uname -s))" ;;
  esac

  ensure_command curl
  ensure_command bash

  echo "==> Installing Homebrew (non-interactive)..."
  NONINTERACTIVE=1 CI=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

ensure_homebrew() {
  if load_brew_shellenv; then
    return 0
  fi
  install_homebrew
  load_brew_shellenv || die "Homebrew is installed but brew was not found in standard locations; fix PATH and re-run"
}

ensure_homebrew

# Faster, quieter installs in automation (safe defaults for dotfiles bootstrap).
export HOMEBREW_NO_ANALYTICS="${HOMEBREW_NO_ANALYTICS:-1}"
export HOMEBREW_NO_AUTO_UPDATE="${HOMEBREW_NO_AUTO_UPDATE:-1}"
export HOMEBREW_NO_ENV_HINTS="${HOMEBREW_NO_ENV_HINTS:-1}"

echo "==> Installing zsh theme and plugins (Homebrew)..."
HOMEBREW_NONINTERACTIVE=1 brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

ln -sf "$ROOT/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$ROOT/zsh/.zprofile" "$HOME/.zprofile"
ln -sf "$ROOT/git/gitconfig" "$HOME/.gitconfig"

echo "Linked ~/.zshrc, ~/.zprofile -> $ROOT/zsh/; ~/.gitconfig -> $ROOT/git/gitconfig"

# Oh My Zsh — clone framework only; --keep-zshrc preserves symlinked dotfiles .zshrc
ensure_command git
if [[ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
else
  echo "==> Oh My Zsh already installed at ${ZSH:-$HOME/.oh-my-zsh}, skipping"
fi

# Set zsh as the default shell
echo "==> Setting shell to zsh"
sudo chsh -s "$(command -v zsh)" "$(id -un)"
