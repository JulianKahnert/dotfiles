#!/bin/sh

sudo -v

echo "#   SOFTWARE   ################################################"
# show outdated packages
sudo pkg update
sudo pkg version -l "<"

echo "#   SPACE   ###################################################"
# show disk space
zpool list

echo "---------------------------------------------------------------"
# show errors in zpools
zpool status

echo "#   SNAPSHOTS   ###############################################"
# are snapshots running
NUM_SNAPS=5
echo "These are the latest ($NUM_SNAPS) snapshots:"
zfs list -r -t snapshot -o name,creation -s creation | tail -$NUM_SNAPS
echo "###############################################################"
