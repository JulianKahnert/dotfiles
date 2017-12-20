#!/bin/sh

# get ports the first time
su
portsnap fetch
portsnap extract

# install portmaster
cd /usr/ports/ports-mgmt/portmaster/ && make install

# install ports
portmaster /usr/ports/shells/zsh
portmaster /usr/ports/sysutils/ezjail

# install some packages
pkg update
pkg upgrade
pkg install tmux vim zsh
pkg install security/sudo devel/git editors/vim
pkg install zfstools
