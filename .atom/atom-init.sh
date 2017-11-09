#!/bin/sh

# get all installed packages
# apm list --installed --bare > package-list.txt

# install atom
brew cask install atom

# install packages
apm install auto-detect-indentation
apm install autocomplete-python
apm install file-icons
apm install fold-functions
apm install git-plus
apm install highlight-selected
apm install language-ini
apm install language-latex
apm install language-matlab
apm install language-swift
apm install latex
apm install linter
apm install linter-pycodestyle
apm install markdown-scroll-sync
apm install multi-cursor
apm install package-sync
apm install pdf-view
apm install python-indent
apm install pretty-json
apm install script
apm install ssh-config
apm install todo-show
apm install tomorrow-night-eighties-syntax
