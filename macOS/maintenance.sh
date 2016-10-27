#!/bin/sh

echo "#   SOFTWARE   ################################################"
# update Apple software
softwareupdate --install --all

echo "---------------------------------------------------------------"
# update and clean homebrew
brew update
brew doctor
brew upgrade
brew cleanup

echo "---------------------------------------------------------------"
# keep MacAppStore Apps up-to-date
mas upgrade

echo "#   PYTHON PACKAGES   #########################################"
# update all python3 packages
pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install --upgrade --user > /dev/null

echo "#   TIME MACHINE BACKUP   #####################################"
# start Time Machine backup
#tmutil startbackup
echo "###############################################################"
