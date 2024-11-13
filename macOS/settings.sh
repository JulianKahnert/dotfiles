#!/bin/sh

# special thanks to Mathias Bynens: https://mths.be/macos
echo "Administrator password needed for setting changes:"

# Ask for the administrator password upfront
sudo -v

echo "Start to change the settings ..."

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: enable a CMD+q for quitting the finder
defaults write com.apple.finder QuitMenuItem -bool YES

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes
