# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew — set HOMEBREW_PREFIX / PATH for standard install locations
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
  eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
fi

if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  [[ -r "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
  [[ -r "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [[ -r "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# p10k config lives in this repo; run `p10k configure` to regenerate, then copy to zsh/p10k.zsh
DOTFILES_ZSH_DIR="${${(%):-%x}:A:h}"
[[ ! -r "$DOTFILES_ZSH_DIR/p10k.zsh" ]] || source "$DOTFILES_ZSH_DIR/p10k.zsh"

export PATH="$HOME/.local/bin:$PATH"
