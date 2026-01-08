# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing shell configuration, vim, tmux, and macOS system setup. The repository uses symlinks to deploy configuration files from ~/.dotfiles into the home directory and ~/.config.

## Key Architecture

### Main Entry Point: dotfiles.sh

The `dotfiles.sh` script is the central management tool with the following commands:

```bash
./dotfiles.sh install      # Initial setup: submodules, symlinks, macOS init
./dotfiles.sh update       # Pull latest, update submodules, update vim bundles
./dotfiles.sh info         # System information (via macOS/info.sh)
./dotfiles.sh maintenance  # Update all software: Apple, Homebrew, mas
./dotfiles.sh init         # Run macOS initialization and settings
```

### Directory Structure

- **oh-my-zsh/** - Git submodule from ohmyzsh/ohmyzsh
- **macOS/** - macOS-specific initialization and maintenance scripts
  - `init.sh` - Installs Homebrew, packages, fonts, and Mac App Store apps
  - `settings.sh` - Applies macOS system settings and font configuration
  - `maintenance.sh` - Updates system software, Homebrew, and App Store apps
  - `info.sh` - Displays system information
- **config/** - Application configs (currently contains zed/)
- **.zshrc** - Main shell configuration file
- **.vimrc** - Vim editor configuration
- **.tmux.conf** - tmux terminal multiplexer configuration

### Symlink Strategy

Installation creates these symlinks:
- `~/.zshrc` → `~/.dotfiles/.zshrc`
- `~/.vimrc` → `~/.dotfiles/.vimrc`
- `~/.tmux.conf` → `~/.dotfiles/.tmux.conf`
- `~/.claude` → `~/.dotfiles/.claude`
- `~/.config` → `~/.dotfiles/config`

Git configuration is included via `git config --global include.path`.

### Shell Environment (.zshrc)

The zsh configuration includes:

**Key Variables:**
- `DOTFILES=$HOME/.dotfiles` - Repository location reference
- `ZSH="$DOTFILES/oh-my-zsh"` - oh-my-zsh installation path
- Theme: `bira`
- Plugins: git, macos, colored-man-pages, dirpersist, sudo

**Custom Functions:**
- `mkrepo NAME` - Creates new directory with git repo and pyenv virtualenv
- `cdf` - cd to directory of fzf-selected file
- `cdh` - Fuzzy search through directory history
- `gitsavetemp` - Creates temporary branch and pushes current state to origin
- `gitloadtemp` - Loads and applies temporary branch, then deletes it
- `fkill` - Interactive process killer using fzf
- `agrepl SEARCH REPLACE` - Bulk find/replace using ag and sed

**Aliases:**
- `ll` - ls -lah
- `fl` - Open current directory in Forklift
- `youdl` - Download videos with youtube-dl
- `dl-update` - Run dotfiles.sh update
- `dl-main` - Run dotfiles.sh maintenance

### Tools & Dependencies

**Required tools:**
- Homebrew (package manager)
- git, zsh, vim, tmux
- ag (The Silver Searcher) - Fast code search
- fzf - Fuzzy finder for files and commands
- nvm - Node version manager
- pyenv - Python version manager (optional, for mkrepo function)
- mas - Mac App Store CLI

**Search Tools:**
- ag: Fast code search with `.agignore` support
- fzf: Used for CTRL+R (commands), CTRL+T (paths), and custom functions

## Development Workflow

### Making Configuration Changes

When modifying dotfiles:
1. Edit files in `~/.dotfiles/` directory
2. Changes are immediately active via symlinks (no need to reinstall)
3. Commit and push changes to version control
4. On other machines, run `./dotfiles.sh update` to pull changes

### Adding New Configuration Files

To add new config files:
1. Place the file in the appropriate location:
   - Shell configs → Root directory
   - Application configs → `config/` directory
2. Update `dotfiles.sh` install section to create symlink
3. Test installation on a clean setup if possible

### Submodule Management

oh-my-zsh is a git submodule:
- Update: `git submodule update --remote oh-my-zsh`
- The `dotfiles.sh update` command handles submodule updates automatically

### macOS System Setup

For fresh macOS installations:
1. Clone repository with submodules
2. Run `./dotfiles.sh install` - installs Homebrew, packages, creates symlinks
3. Restart shell to activate zsh configuration
4. Optional: Run `./dotfiles.sh init` again to reapply settings

## Git Configuration

Global git settings are managed via include:
- Main config: `gitconfig_global` (user, editor, push defaults)
- Excludes: `gitignore_global`
- Attributes: `gitattributes_global`

Editor is set to vim. Credential helper uses macOS keychain.

## Important Notes

- The repository tracks selected config files only (see .gitignore)
- Language setting: `LANG=de_DE.UTF-8`
- Terminal: xterm-256color
- FZF default command: ag with hidden files, excluding .git
- Directory stack size: 10000 entries
