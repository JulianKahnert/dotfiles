#!/bin/sh

# Change directory into the repository if called from elsewhere
cd "$(dirname "$0")" || exit
DOTDIR=$(pwd)

if [ "install" = "$1" ]; then
    # Update all submodules
    git submodule init && git submodule update

    # Create symlinks into the home dir to enable usage of the files
    ln -sf "$DOTDIR/.zshrc"     	"$HOME"
    ln -sf "$DOTDIR/.vimrc"			"$HOME"
    ln -sf "$DOTDIR/.tmux.conf" 	"$HOME"
    ln -sf "$DOTDIR/.claude"        "$HOME"
    ln -sf "$DOTDIR/config" 	    "$HOME/.config"

    # install some other stuff
    echo "Password requried for the following steps:"
    bash "$DOTDIR/macOS/init.sh"

    # Install vim packages
    if which vim > /dev/null
    then
        vim +BundleInstall +BundleClean +qall
    fi

    # Link font to library and clear font cache for user fonts
    "$DOTDIR/macOS/settings.sh"

    # Setup git config
    echo "\n\nSetting up global git config ..."
    git config --global include.path "${DOTDIR}/gitconfig_global"
    git config --global core.excludesfile "${DOTDIR}/gitignore_global"
    git config --global core.attributesfile "${DOTDIR}/gitattributes_global"

elif [ "update" = "$1" ]; then
    # set repo to current main branch
    git reset --hard main
    git pull --rebase --stat origin main
    # delete all untracked folders, e.g. old submodules
    git clean -f -f -d
    # initialize new submodules
    git submodule init && git submodule update

    # update vim
    if which vim > /dev/null
    then
        vim +BundleUpdate +BundleClean +qall
    fi
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
