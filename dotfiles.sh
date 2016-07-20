#!/bin/sh

# Change directory into the repository if called from elsewhere
cd "$(dirname "$0")"
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


case "$1" in
"install")
    # Update all submodules
    git submodule init && git submodule update

    # Create symlinks into the home dir to enable usage of the files
    ln -sf "$DOTDIR/.oh-my-zsh" 	"$HOME"
    ln -sf "$DOTDIR/.zshrc"     	"$HOME"
    ln -sf "$DOTDIR/.zsh"       	"$HOME"
    ln -sf "$DOTDIR/.vim"       	"$HOME"
    ln -sf "$DOTDIR/.vimrc"			"$HOME"
    ln -sf "$DOTDIR/.tmux.conf" 	"$HOME"

    # Link font to library and clear font cache for user fonts
    if [ SYSTEM = "macOS" ]; then
        "$DOTDIR/brew.sh"          # install Homebrew and some important tools
        "$DOTDIR/macOS.sh"         # change several settings in macOS
        "$DOTDIR/macOS_install.sh" # install Apps from the MacAppStore

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

    vim +BundleInstall +BundleUpdate +BundleClean +qall
    cd "$HOME/.vim/bundle/YouCompleteMe" && ./install.py
;;


"update")
    echo "Updating Dotfiles. Stashing changes if necessary."
    git reset --hard master
    if git pull --rebase --stat origin master 
    then
      vim +BundleInstall +BundleUpdate +BundleClean +qall
      echo  "Your dotfiles have been updated and/or is at the current version."
    else
      echo "There was an error updating. Try again later?"
    fi

    # Link font to library and clear font cache for user fonts
    if [ SYSTEM = "Darwin" ]; then
        "$DOTDIR/macOS.sh"
    fi
;;

"info")
    "$DOTDIR/$SYSTEM/info.sh"
;;

"maintenance")
    "$DOTDIR/$SYSTEM/maintenance.sh"
;;

"init")
    "$DOTDIR/$SYSTEM/init.sh"

    if [ SYSTEM = "macOS" ]; then
        "$DOTDIR/$SYSTEM/settings.sh"
    fi
;;


*)
    cat "$DOTDIR/README.md"
;;
esac

