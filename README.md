My personal set of config files for vim & zsh

# Installation
```
git clone https://github.com/Janwillhaus/.dotfiles.git
sh ~/.dotfiles/install-dotfiles.sh
```
Also needed:
* flake8: `conda install flake8`
* LaTex: `brew cask install mactex`

# Upgrade
```
sh ~/.dotfiles/upgrade-dotfiles.sh
```

# Cheat Sheet
```
<F5>    LaTex: start/stop compile
<F6>    Flake8 => Style Checking
<F7>    Change color theme
<F8>    Markdown Preview: start
<F9>    Markdown Preview: stop

<Space> Fold code
<S-n>   NERD Tree toggle
<S-hjkl>NERD Tree Navigation

gcc     comment current line
VIS: gc comment section
```

# ToDo

* Makefile
* `init.sh for Linux and FreeBSD
* write Help for dotfiles.sh