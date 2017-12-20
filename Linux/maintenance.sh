#!/bin/sh

sudo -v

echo "#   SYSTEM   ##################################################"
# Security updates only
sudo apt update
sudo apt -yt $(lsb_release -cs)-security dist-upgrade
sudo apt --trivial-only dist-upgrade

echo "#   UPDATE   ##################################################"
sudo apt --yes upgrade

echo "#   CLEANUP   #################################################"
sudo apt autoremove
sudo apt autoclean

echo "###############################################################"
