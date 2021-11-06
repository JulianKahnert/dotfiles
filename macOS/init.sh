#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Get Homebrew: brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install zsh and oh-my-zsh.
brew install zsh
brew install zsh-syntax-hightlighting

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi

# Install other useful binaries.
brew install git openssh ag fzf ag tmux ssh-copy-id tree htop fd bat
brew install mas
brew install appcleaner
brew install caffeine
brew install sourcetree
brew install visual-studio-code


# Install fonts
brew tap homebrew/cask-fonts
brew install font-fantasque-sans-mono
brew install font-input
brew install font-source-code-pro
brew install font-fontawesome

# Link installed apps.
brew linkapps

# Remove outdated versions from the cellar.
brew cleanup

# Install apps via the MacAppStore-cli
# required: brew install mas
mas install 409203825   # Numbers
mas install 409201541   # Pages
mas install 409183694   # Keynote
mas install 443987910   # 1Password
mas install 470158793   # Keka
mas install 904280696   # Things 3
mas install 441258766   # Magnet

# use osxkeychain for git credentials
# https://stackoverflow.com/a/39159951
git config --global credential.helper osxkeychain

# To install useful FZF key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
