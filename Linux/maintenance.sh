#!/bin/sh

sudo -v

echo "#   SYSTEM   ##################################################"
# Security updates only
sudo apt update
sudo apt --trivial-only dist-upgrade

echo "#   UPDATE   ##################################################"
sudo apt --yes upgrade

echo "#   CLEANUP   #################################################"
sudo apt-get autoremove
sudo apt-get autoclean

echo "###############################################################"
