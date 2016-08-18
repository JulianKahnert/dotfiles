My personal set of config files for vim & zsh

Requiered packages: `vim zsh tmux cmake`
Install before `dotfiles.sh install` to avoid glitches!

# Installation
```
git clone https://github.com/JulianKahnert/.dotfiles.git
~/.dotfiles/dotfiles.sh install
```
Also needed:
* flake8: `conda install flake8`
* LaTex: `brew cask install mactex`

# Update dotfiles
```
~/.dotfiles/dotfiles.sh update
```

# Cheat Sheet
```
<F5>    LaTex: start/stop compile
<F6>    Change color theme
<F7>    Syntax check toggle 
<F8>    Markdown Preview: start
<F9>    Markdown Preview: stop

<Space> Fold code
<S-n>   NERD Tree toggle
<S-hjkl>NERD Tree Navigation

gcc     comment current line
VIS: gc comment section
```

# Skript: `dotfiles.sh`
* `~/.dotfiles/dotfiles.sh install`
* `~/.dotfiles/dotfiles.sh update`
* `~/.dotfiles/dotfiles.sh info`
* `~/.dotfiles/dotfiles.sh maintenance`
* `~/.dotfiles/dotfiles.sh init`

# ToDo

* Makefile
* `init.sh for Linux and FreeBSD
* write Help for dotfiles.sh
