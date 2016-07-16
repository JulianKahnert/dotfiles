#!/bin/sh

# Change directory into the repository if called from elsewhere
cd "$(dirname "$0")"
DOTDIR=$(pwd)

echo "Updating Dotfiles. Stashing changes if necessary."
cd "$DOTDIR"
git stash
if git pull --rebase --stat origin master 
then
  vim +BundleInstall +BundleUpdate +BundleClean +qall
  echo  "Your dotfiles have been updated and/or is at the current version."
else
  echo "There was an error updating. Try again later?"
fi

# Link font to library and clear font cache for user fonts
if [ "$(uname)" = "Darwin" ]
then
    sh $DOTDIR/macOS.sh
fi

git stash apply
