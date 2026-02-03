# set some variables
ZSH_THEME="bira"

HOMEBREW_NO_ANALYTICS=1               # Avoid homebrew from sending analytics
HYPHEN_INSENSITIVE="true"             # use hyphen-insensitive completion
DISABLE_AUTO_UPDATE="false"           # disable bi-weekly auto-update checks
DISABLE_UPDATE_PROMPT="true"          # disable update prompt
UPDATE_ZSH_DAYS=7                     # change how often to auto-update (in days)
COMPLETION_WAITING_DOTS="false"       # disable waiting dots while autocomplete tabbing
ENABLE_CORRECTION="false"             # disable command auto-correction
DISABLE_UNTRACKED_FILES_DIRTY="true"  # disable marking untracked files under VCS as dirty

# Basic work environment
TERM="xterm-256color"
DISABLE_AUTO_TITLE="true"
EDITOR=vim
LANG=de_DE.UTF-8
DIRSTACKSIZE=10000

# setup paths
DOTFILES=$HOME/.dotfiles
ZSH="$DOTFILES/oh-my-zsh"

# Consolidate PATH exports
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/sbin:$HOME/.mint/bin:$HOME/.local/bin:$PATH"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
plugins=(
  git
  macos
  colored-man-pages
  dirpersist
  sudo
)
# Load zsh-syntax-highlighting if available
if command -v brew &> /dev/null; then
    SYNTAX_HL="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    [ -f "$SYNTAX_HL" ] && source "$SYNTAX_HL"
fi
source $ZSH/oh-my-zsh.sh

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

# Aliases
alias ll='ls -lah'
alias fl='open -a forklift .'
alias youdl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best"'
alias dl-update='~/.dotfiles/dotfiles.sh update'
alias dl-main='~/.dotfiles/dotfiles.sh maintenance'

## Functions

removeUntrackedGitBranches() {
    git branch -r --merged | grep -v "dev" | grep -v "next" | grep -v "master" | grep -v "main" | sed 's/origin\///' | xargs -n 1 git push origin --delete && git fetch --prune
}

createPr() {
    # Find the first commit with EMP- ticket
    local commit=$(git log --format=%B -n 5 | grep "EMP-" | head -n 1)

    if [[ -z "$commit" ]]; then
        echo "Error: No commit with EMP- ticket found in the last 5 commits"
        return 1
    fi

    # Extract ticket number
    local ticket=$(echo "$commit" | grep -o -E 'EMP-[0-9]{1,5}')

    # Create PR and capture all output (including stderr for warnings)
    local pr_output=$(gh pr create --title "$commit" --body "https://ewe-go.atlassian.net/browse/$ticket" 2>&1)

    # Extract PR URL from output (works for both new and existing PRs)
    local pr_url=$(echo "$pr_output" | grep -o 'https://github.com[^[:space:]]*' | tail -n 1)

    if [[ -z "$pr_url" ]]; then
        echo "Error: Could not extract PR URL from output:"
        echo "$pr_output"
        return 1
    fi

    # Create Slack markdown string with Markdown links
    local slack_message="🔍 [$ticket](https://ewe-go.atlassian.net/browse/$ticket) ist bereit zum Codereview: [PR]($pr_url)"

    # Copy to clipboard
    echo "$slack_message" | pbcopy

    # Print confirmation
    echo "✓ PR URL: $pr_url"
    echo "✓ Slack message copied to clipboard:"
    echo "$slack_message"
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


# Function to display the tickets since the last Git tag
ticketsSinceLastGitTag() {
    if [ -d .git ]; then
        git log --oneline $(git describe --tags --abbrev=0)..@ | grep -oE '\bEMP-[0-9]{1,5}\b' | cut -d'-' -f2 | sort -u
    else
        echo "Error: This is not a Git repository."
    fi
}

# Function to open the ticket URLs since the last Git tag
ticketUrlsSinceLastGitTag() {
    if [ -d .git ]; then
        git log --oneline $(git describe --tags --abbrev=0)..@ | grep -oE '\bEMP-[0-9]{1,5}\b' | cut -d'-' -f2 | sort -u | sed 's|^|https://ewe-go.atlassian.net/browse/EMP-|' | while read -r url; do open "$url"; done
    else
        echo "Error: This is not a Git repository."
    fi
}
