#!/bin/sh

sudo -v

echo "#   SOFTWARE   ################################################"
# show outdated packages
sudo apt-get update > /dev/null
sudo apt-get --dry-run upgrade

echo "#   SPACE   ###################################################"
# show disk space
df -H -t ext2                                                                                                       
df -H -t ext4 

echo "###############################################################"
