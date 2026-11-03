#!/bin/sh

# special thanks to Mathias Bynens: https://mths.be/macos
echo "Administrator password needed for setting changes:"

# Ask for the administrator password upfront
sudo -v

echo "Start to change the settings ..."

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: enable a CMD+q for quitting the finder
defaults write com.apple.finder QuitMenuItem -bool YES

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Keyboard                                                                    #
###############################################################################

# Fastest key repeat and shortest delay the System Settings sliders offer
# (active after the next login)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Terminal                                                                    #
###############################################################################

# Use the "Clear Dark" profile for new windows
defaults write com.apple.Terminal "Default Window Settings" -string "Clear Dark"
defaults write com.apple.Terminal "Startup Window Settings" -string "Clear Dark"

# Close the window when the shell exited cleanly, instead of "Prozess beendet"
# (0 = always close, 1 = close if exited cleanly, 2 = never close)
TERMINAL_PLIST=$(mktemp)
defaults export com.apple.Terminal "$TERMINAL_PLIST"
plutil -replace "Window Settings.Clear Dark.shellExitAction" -integer 1 "$TERMINAL_PLIST"
defaults import com.apple.Terminal "$TERMINAL_PLIST"
rm -f "$TERMINAL_PLIST"
