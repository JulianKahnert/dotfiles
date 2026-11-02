#!/bin/sh

# Change directory into the repository if called from elsewhere
cd "$(dirname "$0")" || exit
DOTDIR=$(pwd)

if [ "install" = "$1" ]; then
    # Update all submodules
    git submodule init && git submodule update

    # Create symlinks into the home dir to enable usage of the files
    ln -sf "$DOTDIR/.zshrc"     	"$HOME"
    ln -sf "$DOTDIR/.tmux.conf"     "$HOME"
    ln -sf "$DOTDIR/config" 	    "$HOME/.config"

    # install some other stuff
    echo "Password required for the following steps:"
    sudo -v
    # Keep sudo alive until the install finished, so the password is asked only once
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    bash "$DOTDIR/macOS/init.sh"

    # Link font to library and clear font cache for user fonts
    "$DOTDIR/macOS/settings.sh"

    # Setup git config
    echo "\n\nSetting up global git config ..."
    git config --global include.path "${DOTDIR}/gitconfig_global"

elif [ "update" = "$1" ]; then
    # set repo to current main branch
    git reset --hard main
    git pull --rebase --stat origin main
    # delete all untracked folders, e.g. old submodules
    git clean -f -f -d
    # initialize new submodules
    git submodule init && git submodule update

    # Link font to library and clear font cache for user fonts
    "$DOTDIR/macOS/settings.sh"

elif [ "info" = "$1" ]; then
    "$DOTDIR/macOS/info.sh"

elif [ "maintenance" = "$1" ]; then
    "$DOTDIR/macOS/maintenance.sh"

elif [ "init" = "$1" ]; then
    "$DOTDIR/macOS/init.sh"
    "$DOTDIR/macOS/settings.sh"

else
    cat "$DOTDIR/README.md"
fi
