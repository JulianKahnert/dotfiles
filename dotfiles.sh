#!/bin/sh

# Change directory into the repository if called from elsewhere
cd "$(dirname "$0")" || exit
DOTDIR=$(pwd)

if [ "$(uname)" = "Darwin" ]; then
    SYSTEM="macOS"
elif [ "$(uname)" = "Linux" ]; then
    SYSTEM="Linux"
elif [ "$(uname)" = "FreeBSD" ]; then
    SYSTEM="BSD"
else
    exit 1
fi

if [ "install" = "$1" ]; then
    # Update all submodules
    git submodule init && git submodule update
    # Create symlinks into the home dir to enable usage of the files
    ln -sf "$DOTDIR/.oh-my-zsh" 	"$HOME"
    ln -sf "$DOTDIR/.zshrc"     	"$HOME"
    ln -sf "$DOTDIR/.zsh"       	"$HOME"
    ln -sf "$DOTDIR/.vim"       	"$HOME"
    ln -sf "$DOTDIR/.vimrc"			"$HOME"
    ln -sf "$DOTDIR/.tmux.conf" 	"$HOME"
    ln -sf "$DOTDIR/.atom"          "$HOME"

    # Link font to library and clear font cache for user fonts
    if [ $SYSTEM = "macOS" ]; then
        "$DOTDIR/macOS/settings.sh"      # change several settings in macOS
        ln -sf "$DOTDIR/.awesome-terminal-fonts/patched/*.sh" "$HOME/Library/Fonts/"
        ln -sf "$DOTDIR/.awesome-terminal-fonts/patched/*.ttf" "$HOME/Library/Fonts/"
        atsutil databases -remove
    else
        mkdir -p "$HOME/.local/share/fonts"
        ln -sf "$DOTDIR/.awesome-terminal-fonts/patched/*.sh" "$HOME/.local/share/fonts"
        ln -sf "$DOTDIR/.awesome-terminal-fonts/patched/*.ttf" "$HOME/.local/share/fonts"
        fc-cache -f
        echo "Remember to change the console font accordingly!"
    fi
    # Install vim packages
    if hash vim 2>/dev/null; then
        vim +BundleInstall +BundleClean +qall
        cd "$HOME/.vim/bundle/YouCompleteMe" && ./install.py
    fi


elif [ "update" = "$1" ]; then
    git reset --hard master
    git pull --rebase --stat origin master
    git submodule update
    # update vim
    if hash vim 2>/dev/null; then
        vim +BundleUpdate +BundleClean +qall
    fi
    # Link font to library and clear font cache for user fonts
    if [ $SYSTEM = "macOS" ]; then
        "$DOTDIR/$SYSTEM/settings.sh"
    fi

elif [ "info" = "$1" ]; then
    "$DOTDIR/$SYSTEM/info.sh"

elif [ "maintenance" = "$1" ]; then
    "$DOTDIR/$SYSTEM/maintenance.sh"

elif [ "init" = "$1" ]; then
    "$DOTDIR/$SYSTEM/init.sh"
    if [ $SYSTEM = "macOS" ]; then
        "$DOTDIR/$SYSTEM/settings.sh"
    fi

else
    cat "$DOTDIR/README.md"
fi
