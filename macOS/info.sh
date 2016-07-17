#!/bin/sh

echo "#   SOFTWARE   ################################################"
# show outdated software
softwareupdate --list

echo "---------------------------------------------------------------"
# show outdated packages from Homebrew
brew update > /dev/null
brew outdated

echo "---------------------------------------------------------------"
# show outdated MacAppStore apps
mas outdated

echo "#   SPACE   ###################################################"
# show disk space
df -H -T hfs,zfs,exfat
echo "###############################################################"
