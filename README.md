My personal set of config files for vim & zsh

# Installation

```
git clone --recurse-submodules https://github.com/JulianKahnert/dotfiles.git ~/.dotfiles
~/.dotfiles/dotfiles.sh install
```

# Update dotfiles

```
~/.dotfiles/dotfiles.sh update
```

# Skript: `dotfiles.sh`

- `~/.dotfiles/dotfiles.sh install`
- `~/.dotfiles/dotfiles.sh update`
- `~/.dotfiles/dotfiles.sh info`
- `~/.dotfiles/dotfiles.sh maintenance`
- `~/.dotfiles/dotfiles.sh init`

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

## ZSH Functions

- cdf - cd into the directory of the selected file
- cdh - fuzzy matching in folder history
- fkill - kill process
- mkrepo - create a new repo + pyenv
