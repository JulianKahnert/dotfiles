#!/bin/sh

# Install command-line tools using Homebrew.

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
# Note: don’t forget to add `/usr/local/bin/zsh` to `/etc/shells` before
# running `chsh`.
brew install zsh

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  sudo chsh -s /usr/local/bin/zsh $USER;
fi;

# Install more recent versions of some macOS tools.
brew install vim --override-system-vi
brew install homebrew/dupes/openssh

# Install other useful binaries.
brew install git
brew install tmux
brew install lynx
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
brew cask install etcher
brew cask install mactex
brew cask install sourcetree
brew cask install sublime-text
brew cask install things
brew cask install tunnelblick

# Install fonts
brew tap caskroom/fonts
brew cask install font-source-code-pro

# Link installed apps.
brew linkapps

# Remove outdated versions from the cellar.
brew cleanup

# Install apps via the MacAppStore-cli
# required: brew install mas

# Office
mas install 409203825   # Numbers
mas install 409201541   # Pages
mas install 409183694   # Keynote
mas install 408981434   # iMovie
mas install 921923693   # LibreOffice Vanilla

# Utilities
mas install 412448059   # ForkLift
mas install 443987910   # 1Password
mas install 926711151   # Banking 4X
mas install 668429425   # Downcast
mas install 451907568   # Paprika Recipe Manager
# mas install 1063996724  # Tyme2
mas install 430255202   # Mactracker
mas install 470158793   # Keka
mas install 924726344   # Deliveries
mas install 411246225   # Caffeine
