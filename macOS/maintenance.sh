#!/bin/sh

echo "#   SOFTWARE   ################################################"
# update Apple software
softwareupdate --install --all

echo "---------------------------------------------------------------"
# update and clean homebrew
brew update
brew doctor
brew upgrade
brew cask upgrade
brew cleanup

echo "---------------------------------------------------------------"
# keep MacAppStore Apps up-to-date
mas upgrade

echo "#   TIME MACHINE BACKUP   #####################################"
# start Time Machine backup
#tmutil startbackup
echo "###############################################################"
