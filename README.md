My personal set of config files for vim & zsh

Requiered packages: `vim zsh tmux`
Install before `dotfiles.sh install` to avoid glitches!

# Installation
macOS: choose the the path to zsh in Terminal.app preferences
```
git clone https://github.com/JulianKahnert/dotfiles.git ~/.dotfiles
~/.dotfiles/dotfiles.sh install
```
Also needed:
* Python: `pip install --user flake8 virtualenvwrapper`
* LaTex: `brew cask install mactex`
* Search Tools: `brew install ag fzf`

# Update dotfiles
```
~/.dotfiles/dotfiles.sh update
```

# Cheat Sheet
## Terminal
```
CTRL R      command-searching
CTRL T      path-searching
```

## VIM
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

# Searching

## [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
```
ag PATTERN /PATH/TO/
ag -i PATTERN /PATH/TO/                             # case insensitive
ag --hidden PATTERN /PATH/TO/                       # also search hidden files
ag --hidden --ignore .git -g "" PATTERN /PATH/TO/   # also search hidden files,
                                                    # but not .git folders
```

## [command-line fuzzy finder](https://github.com/junegunn/fzf)
```
CTRL R      commands
CTRL T      paths
```
