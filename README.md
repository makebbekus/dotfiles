# dotfiles

Personal shell configuration for macOS, Linux (including [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)), and [GitHub Codespaces](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles).

## Prerequisites

- **macOS or Linux** — Assumes `curl` and `bash` are installed. Used to install [Homebrew](https://brew.sh) if it is missing
- On **macOS**, the Homebrew installer may prompt to install the Xcode Command Line Tools the first time; fully unattended setups sometimes need those tools preinstalled.
- If the Brew formulas are missing later, your shell still starts; `.zshrc` only sources those files when they exist under `$HOMEBREW_PREFIX`.

## Install

Clone this repo and run:

```bash
./install.sh
```

This ensures Homebrew is available, installs the zsh theme/plugins above, then symlinks `zsh/.zshrc` → `~/.zshrc`, `zsh/.zprofile` → `~/.zprofile`, and `git/gitconfig` → `~/.gitconfig` (author name and email for Git).

Open a new terminal (or run `exec zsh`) so the links take effect.

`~/.gitconfig` becomes a symlink to this repo; if you had other Git settings there, move them into [`git/gitconfig`](git/gitconfig) (or use Git’s `[include]` in that file) so they are not lost.

## GitHub Codespaces

In GitHub: **Settings → Codespaces → Dotfiles** → select this repository. Codespaces clones it to `~/dotfiles` and runs `./install.sh` when the container is created.

`install.sh` runs on codespace creation; it will install Homebrew on Linux if needed (requires network). Some images may need extra packages or permissions for the Brew installer—if it fails, check the Codespaces log for the dotfiles step.

## Changing the prompt

Run `p10k configure`, then replace `zsh/p10k.zsh` with your new `~/.p10k.zsh` and commit.

## Layout

| Path | Purpose |
|------|---------|
| `install.sh` | Install Homebrew if missing, `brew install` zsh theme/plugins, symlink zsh + git configs into `$HOME` |
| `git/gitconfig` | Git `user.name` and `user.email` |
| `zsh/.zshrc` | Interactive zsh (p10k, plugins, `PATH`) |
| `zsh/.zprofile` | Login zsh (Homebrew) |
| `zsh/p10k.zsh` | Powerlevel10k wizard output |
