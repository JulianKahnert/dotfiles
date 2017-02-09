# Path to your oh-my-zsh installation.
export DOTFILES=$HOME/.dotfiles
export TERM="xterm-256color"

# Basic work environment
export DEFAULT_USER=juliankahnert
export EDITOR=vim
export LANG=de_DE.UTF-8

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
if [ "$(uname)" = "Darwin" ]
then
    # python pip module path (--user)
    export PATH="$HOME/Library/Python/3.6/bin:$PATH"

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
antigen bundle git
antigen bundle virtualenvwrapper
antigen bundle osx
antigen bundle sudo
antigen bundle tmux
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen apply

# theme customization
SPACESHIP_TIME_SHOW=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_ADD_NEWLINE=false

# change background color for each system
if [ "$(uname)" = "Darwin" ]
then
    ZSH_TMUX_AUTOSTART="false"
    ZSH_TMUX_AUTOSTART_ONCE="false"

elif [ "$(uname)" = "Linux" ]
then
    ZSH_TMUX_AUTOSTART="true"
    ZSH_TMUX_AUTOSTART_ONCE="true"

elif [ "$(uname)" = "FreeBSD" ]
then
    ZSH_TMUX_AUTOSTART="true"
    ZSH_TMUX_AUTOSTART_ONCE="true"

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

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias UbuntuVersion="lsb_release -a | grep \"Release:\|Codename:\" | awk '{print $2}'"
alias dig='dig ANY'
alias ll='ls -lah'
alias tmx='tmux -f ~/.dotfiles/.tmux.conf attach && exit || tmux -f ~/.dotfiles/.tmux.conf new-session && exit'


# Avoid homebrew from sending analytics
export HOMEBREW_NO_ANALYTICS=1

# Custom functions
upgrade_dotfiles () {
    /bin/sh $DOTFILES/upgrade-dotfiles.sh
}

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# user fuzzy finder "fzf"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# don't exclude hidden files, but .git folders
export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.dotfiles/agignore.txt -g ""'

if [ "$(uname)" != "Darwin" ]
then
    eval cat /etc/motd
fi
