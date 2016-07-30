#!/bin/sh

sudo -v

echo "#   SYSTEM   ##################################################"
# Update OS
sudo freebsd-update fetch > /dev/null
sudo freebsd-update install

echo "#   UPDATE   ##################################################"
# Update ports
sudo portsnap fetch update
sudo pkg update

# Upgrade ports and packages
sudo portmaster -G -y -a

echo "#   CLEANUP   #################################################"
sudo portmaster --check-depends
sudo portmaster -y --check-port-dbdir
sudo portmaster -s
sudo portmaster -y --clean-distfiles

sudo pkg autoremove -y

echo "#   JAILS   ###################################################"
# Upgrade portstree in jails
sudo ezjail-admin update -b

echo "#   VULNERABILITIES   #########################################"
pkg audit -F

echo "###############################################################"
