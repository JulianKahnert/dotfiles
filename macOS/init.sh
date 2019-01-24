#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Get Homebrew: brew.sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install Z shell.
brew install zsh

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi

# Install other useful binaries.
brew install git
brew install fzf
brew install ag
brew install tmux
brew install ssh-copy-id
brew install tree
brew install htop
brew install mas

# Install sound stuff.
brew install lame
brew install flac
brew install ffmpeg
brew install sox

# Install caskroom apps.
brew tap caskroom/versions
brew cask install appcleaner
brew cask install atom
brew cask install caffeine
brew cask install forklift
brew cask install etcher
brew cask install mactex
brew cask install sourcetree

# Install fonts
brew tap caskroom/fonts
brew cask install font-fantasque-sans-mono
brew cask install font-input
brew cask install font-source-code-pro
brew cask install font-fontawesome

# Link installed apps.
brew linkapps

# Remove outdated versions from the cellar.
brew cleanup

# Install apps via the MacAppStore-cli
# required: brew install mas
mas install 409203825   # Numbers
mas install 409201541   # Pages
mas install 409183694   # Keynote
mas install 408981434   # iMovie
mas install 921923693   # LibreOffice Vanilla
mas install 443987910   # 1Password
mas install 430255202   # Mactracker
mas install 470158793   # Keka
mas install 904280696   # Things 3
mas install 441258766   # Magnet

# install python stuff
brew install pyenv
brew install pyenv-virtualenv
# pyenv install 3.6.0

# use osxkeychain for git credentials
# https://stackoverflow.com/a/39159951
git config --global credential.helper osxkeychain

# To install useful FZF key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
