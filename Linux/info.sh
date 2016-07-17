#!/bin/sh

sudo -v

echo "#   SOFTWARE   ################################################"
# show outdated packages
sudo apt-get update
sudo apt-get --dry-run upgrade

echo "#   SPACE   ###################################################"
# show disk space
df -H -T hfs,zfs,exfat,ext4

echo "###############################################################"
