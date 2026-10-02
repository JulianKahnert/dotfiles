# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing shell configuration, vim, tmux, and macOS system setup. The repository uses symlinks to deploy configuration files from ~/.dotfiles into the home directory and ~/.config.

## Main Entry Point: dotfiles.sh

`dotfiles.sh` is the central management tool:

```bash
./dotfiles.sh install      # Initial setup: submodules, symlinks, macOS init
./dotfiles.sh update       # Pull latest, update submodules, update vim bundles
./dotfiles.sh info         # System information (via macOS/info.sh)
./dotfiles.sh maintenance  # Update all software: Apple, Homebrew, mas
./dotfiles.sh init         # Run macOS initialization and settings
```

`install` symlinks the tracked configs into `~` and `~/.config`, and wires global git config via `git config --global include.path`.

## Development Workflow

### Making Configuration Changes

Files are deployed by symlink, so edits in `~/.dotfiles/` are **immediately active — no reinstall needed**. Commit and push, then run `./dotfiles.sh update` on other machines.

### Adding New Configuration Files

1. Place shell configs in the root directory; application configs in `config/`.
2. Add a symlink for the new file to the `dotfiles.sh` install section.
3. Test on a clean setup if possible.

### Submodule Management

oh-my-zsh is a git submodule; `./dotfiles.sh update` updates it automatically (manual: `git submodule update --remote oh-my-zsh`).

### macOS System Setup

For a fresh install: clone with submodules → `./dotfiles.sh install` → restart shell → optionally re-run `./dotfiles.sh init` to reapply settings.

## Important Notes

- The repository tracks selected config files only (see `.gitignore`).
- Language setting: `LANG=de_DE.UTF-8`.
