# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh/custom
export DOTFILES=$HOME/.dotfiles

# Basic work environment
export DEFAULT_USER=Julian
export EDITOR=vim

# Set the theme
case $(tty) in
    /dev/tty[0-9])
        ZSH_THEME="af-magic"
    ;;
    *)
        ZSH_THEME="powerlevel9k/powerlevel9k"
esac

# Modify powerline styling
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator virtualenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_VIRTUALENV_BACKGROUND="black"
POWERLEVEL9K_VIRTUALENV_FOREGROUND="white"
# change background color for each system
if [ "$(uname)" = "Darwin" ]
then
	color_foreground="white"
	color_background="black"

	ZSH_TMUX_AUTOSTART="false"
	ZSH_TMUX_AUTOSTART_ONCE="false"

elif [ "$(uname)" = "Linux" ]
then
	color_foreground="white"
	color_background="089"

	ZSH_TMUX_AUTOSTART="true"
	ZSH_TMUX_AUTOSTART_ONCE="true"

elif [ "$(uname)" = "FreeBSD" ]
then
	color_foreground="white"
	color_background="124"

	ZSH_TMUX_AUTOSTART="false"
	ZSH_TMUX_AUTOSTART_ONCE="false"

fi
POWERLEVEL9K_DIR_HOME_BACKGROUND=$color_background
POWERLEVEL9K_DIR_HOME_FOREGROUND=$color_foreground
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=$color_background
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=$color_foreground
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=$color_background
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=$color_foreground
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx sublime sudo Forklift tmux)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.anaconda/bin"
if [ "$(uname)" = "Darwin" ]
then
    export PATH="$PATH:/usr/local/texlive/2016/bin/universal-darwin"
    export PATH="$PATH:$(brew --prefix coreutils)/libexec/gnubin"
fi
source $ZSH/oh-my-zsh.sh

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

eval tmux ls

