#!/bin/sh

sudo -v

echo "#   SYSTEM   ##################################################"
# Security updates only
sudo apt-get update
sudo apt-get -yt $(lsb_release -cs)-security dist-upgrade
sudo apt-get --trivial-only dist-upgrade

echo "#   UPDATE   ##################################################"
sudo apt-get --yes upgrade

echo "#   CLEANUP   #################################################"
sudo apt-get autoremove
sudo apt-get autoclean

echo "###############################################################"
