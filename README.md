# dotfiles

Personal shell configuration for macOS, Linux (including [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)), and [GitHub Codespaces](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles).

## Prerequisites

- **macOS or Linux** — Assumes `curl` and `bash` for [Homebrew](https://brew.sh) and [Oh My Zsh](https://ohmyz.sh/) installers.
- On **macOS**, the Homebrew installer may prompt to install the Xcode Command Line Tools the first time; fully unattended setups sometimes need those tools preinstalled.
- If the Brew formulas are missing later, your shell still starts; `.zshrc` only sources those files when they exist under `$HOMEBREW_PREFIX`.

## Install

Clone this repo and run:

```bash
./install.sh
```


## GitHub Codespaces

In GitHub: **Settings → Codespaces → Dotfiles** → select this repository. Codespaces clones it to `~/dotfiles` and runs `./install.sh` when the container is created.

`install.sh` runs on codespace creation; it will install Homebrew on Linux if needed (requires network). Some images may need extra packages or permissions for the Brew installer—if it fails, check the Codespaces log for the dotfiles step.

## Changing the prompt

Run `p10k configure`, then replace `zsh/p10k.zsh` with your new `~/.p10k.zsh` and commit.

## Layout

| Path | Purpose |
|------|---------|
| `install.sh` | Homebrew + theme/plugins, symlinks, Oh My Zsh clone, `sudo chsh` to zsh |
| `git/gitconfig` | Git `user.name` and `user.email` |
| `zsh/.zshrc` | Interactive zsh (Oh My Zsh, Homebrew p10k/plugins, `PATH`) |
| `zsh/.zprofile` | Login zsh (Homebrew) |
| `zsh/p10k.zsh` | Powerlevel10k wizard output |
