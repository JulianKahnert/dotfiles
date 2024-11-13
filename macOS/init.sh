#!/bin/sh

# Get Homebrew: brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install zsh and some other useful tools
brew install zsh-syntax-highlighting \
	vim git openssh ag fzf ag tmux ssh-copy-id tree htop fd bat \
	mas appcleaner caffeine \
	fork zed


# Install fonts
brew install font-fantasque-sans-mono font-input font-source-code-pro font-fontawesome

# Link installed apps.
brew linkapps

# Remove outdated versions from the cellar.
brew cleanup

# Install apps via the MacAppStore-cli
# required: brew install mas
mas install 470158793   # Keka
mas install 904280696   # Things 3
mas install 888422857   # Overcast

# To install useful FZF key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
