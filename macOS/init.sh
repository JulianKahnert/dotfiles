#!/bin/bash

# Homebrew (brew.sh) has to be installed already
if [ ! -x /opt/homebrew/bin/brew ]; then
    echo "Error: Homebrew not found, install it first: https://brew.sh" >&2
    exit 1
fi
# Make brew available in this script
eval "$(/opt/homebrew/bin/brew shellenv)"

# Never stop at "Do you want to proceed?"
export HOMEBREW_NO_ASK=1

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install zsh and some other useful tools
brew install zsh-syntax-highlighting \
    git openssh ag fzf tmux ssh-copy-id tree htop fd bat mole \
    neovim mas caffeine \
    fork zed lazygit \
    claude-code

# Install fonts
brew install font-sf-mono-nerd-font-ligaturized

# Remove outdated versions from the cellar.
brew cleanup

# Install apps via the MacAppStore-cli (needs an App Store login)
mas install 470158793 # Keka
mas install 904280696 # Things 3

# To install useful FZF key bindings and fuzzy completion (.zshrc sources ~/.fzf.zsh)
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
