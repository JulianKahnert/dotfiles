# set some variable
ZSH_THEME="bira"                # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

HOMEBREW_NO_ANALYTICS=1               # Avoid homebrew from sending analytics
HYPHEN_INSENSITIVE="true"             # use hyphen-insensitive completion
DISABLE_AUTO_UPDATE="false"           # disable bi-weekly auto-update checks
DISABLE_UPDATE_PROMPT="true"          # disable update prompt
UPDATE_ZSH_DAYS=7                     # change how often to auto-update (in days)
ENABLE_CORRECTION="true"              # enable command auto-correction
COMPLETION_WAITING_DOTS="true"        # display red dots whilst waiting for completion
DISABLE_UNTRACKED_FILES_DIRTY="true"  # disable marking untracked files under VCS as dirty
COMPLETION_WAITING_DOTS="false"       # disable wating dots while autocomplete tabbing
ENABLE_CORRECTION="false"

# Basic work environment
TERM="xterm-256color"
DISABLE_AUTO_TITLE="true"
EDITOR=vim
LANG=de_DE.UTF-8
DIRSTACKSIZE=10000

# setup paths
DOTFILES=$HOME/.dotfiles
ZSH="$DOTFILES/oh-my-zsh"
ZSH_CUSTOM=$DOTFILES/oh-my-zsh-custom # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
export PATH="/usr/local/sbin:$PATH"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(
  git
  osx
  colored-man-pages
  dirpersist
  docker
  sudo
  zsh-syntax-highlighting
  swiftpm
  kubectl
)
source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -lah'
alias fl='open -a forklift .'
alias youdl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best"'
alias dl-update='~/.dotfiles/dotfiles.sh update'
alias dl-main='~/.dotfiles/dotfiles.sh maintenance'

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

# gitsavetemp - save current state of the repository on origin
gitsavetemp() {
  username=$(git config --global user.name | awk '{print tolower($0)}' | sed 's/ //g')
  git branch $username-temporary-state-branch
  git checkout $username-temporary-state-branch
  git add --all
  git commit -m "temporary commit to save current state"
  git push --set-upstream origin $username-temporary-state-branch
}

# gitloadtemp - load the latest state of the repository from origin
gitloadtemp() {
  username=$(git config --global user.name | awk '{print tolower($0)}' | sed 's/ //g')
  git checkout @{-1}
  git cherry-pick $username-temporary-state-branch --no-commit
  git branch --delete --force $username-temporary-state-branch
  git push origin --delete $username-temporary-state-branch
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
