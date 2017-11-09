# Path to your oh-my-zsh installation.
export DOTFILES=$HOME/.dotfiles
export TERM="xterm-256color"
export WORKON_HOME=~/.envs
export DISABLE_AUTO_TITLE="true"

# Basic work environment
export DEFAULT_USER=juliankahnert
export EDITOR=vim
export LANG=de_DE.UTF-8
export DIRSTACKSIZE=10000

# Avoid homebrew from sending analytics
export HOMEBREW_NO_ANALYTICS=1

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
if [ "$(uname)" = "Darwin" ]
then
    export PATH="$PATH:/usr/local/texlive/2016/bin/universal-darwin"
    export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"

elif [ "$(uname)" = "Linux" ]
then
    # python pip module path (--user)
    export PATH="$HOME/.local/bin:$PATH"

fi

# Bundles from the default repo (robbyrussell's oh-my-zsh).
source $HOME/.dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle colored-man-pages
antigen bundle dirpersist
antigen bundle docker
antigen bundle git
antigen bundle osx
antigen bundle sudo
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen apply

# theme customization
SPACESHIP_TIME_SHOW=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_DOCKER_SHOW=false

# change background color for each system
if [ "$(uname)" = "Darwin" ]
then
    SPACESHIP_PREFIX_HOST="   "

elif [ "$(uname)" = "Linux" ]
then
    SPACESHIP_PREFIX_HOST=" 🐧  "

elif [ "$(uname)" = "FreeBSD" ]
then
    SPACESHIP_PREFIX_HOST=" 😈  "

fi

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Aliases
alias ll='ls -lah'
alias fl='open -a forklift .'
alias youdl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best"'

# Functions
# mkrepo - create a new repo + pyenv
mkrepo () {
    NAME="$*"
    # folder
    if [ -d "$NAME" ]; then
        echo "\nfolder already exists!"
    else
        echo "generate folder and change directory:"
        mkdir $NAME
    fi
    cd $NAME

    # repository
    if [ -d .git ]; then
        echo "\nrepo already exists!"
    else
        echo "\ninitialize repo:"
        git init
    fi

    # virtual environment
    if which pyenv > /dev/null; then
        if [ -f .python-version ]; then
            echo "\nvirtualenv already exists!"
        else
            echo "\ncreate a virtualenv:"
            pyenv virtualenv $NAME
            pyenv local $NAME
        fi
    fi
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# cdh - fuzzy matching in folder history
cdh() {
  eval cd "$( ( dirs -v ) | fzf +s --tac | sed 's/ *[0-9]* *//')"
}

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# agrepl() - bulk search in files and replace string
agrepl() {
  ag -0 -l "$1" | xargs -0 sed -E -i '' 's/'$1'/'$2'/g'
}

# pyenv stuff
if which pyenv > /dev/null
then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export SPACESHIP_VENV_SHOW=false
    export PATH="$HOME/.pyenv/bin:$PATH"

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# user fuzzy finder "fzf"
if which fzf > /dev/null
then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    # don't exclude hidden files, but .git folders
    export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.dotfiles/agignore.txt -g ""'
fi

# start tmux (via alias) if not on a mac
if which tmux > /dev/null
then
    if ! { [ -z $SSH_CONNECTION ] } && ! { [ -n "$TMUX" ]; }
    then
        eval "tmux -f ~/.dotfiles/.tmux.conf attach && exit || tmux -f ~/.dotfiles/.tmux.conf new-session && exit"
    fi
fi
