# set some variables
ZSH_THEME="bira"
export HOMEBREW_NO_ANALYTICS=1               # Avoid homebrew from sending analytics

# Basic work environment
EDITOR=nvim
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

# Override oh-my-zsh termsupport: path is shown via Terminal.app settings,
# so we clear the tab title when idle and show the full command while running.
function omz_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return
  title "" ""
}
# Show full command with arguments (e.g. "yarn start") in tab title while running
function omz_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return
  emulate -L zsh
  local LINE="${2:gs/%/%%}"
  title "$LINE" "%100>...>${LINE}%<<"
}

# user fuzzy finder "fzf"
if which fzf > /dev/null
then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    # don't exclude hidden files, but .git folders
    export FZF_DEFAULT_COMMAND='ag --hidden --path-to-ignore ~/.dotfiles/agignore.txt -g ""'
fi

# Aliases
alias ll='ls -lah'
alias gg='lazygit'
alias youdl='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best"'
alias dl-update='~/.dotfiles/dotfiles.sh update'
alias dl-main='~/.dotfiles/dotfiles.sh maintenance'

## Functions

removeUntrackedGitBranches() {
    git branch -r --merged | grep -v "dev" | grep -v "next" | grep -v "master" | grep -v "main" | sed 's/origin\///' | xargs -n 1 git push origin --delete && git fetch --prune
}

createPr() {
    # Find the first commit with IOSB2B- ticket
    local commit=$(git log --format=%B -n 5 | grep "IOSB2B-" | head -n 1)

    if [[ -z "$commit" ]]; then
        echo "Error: No commit with IOSB2B- ticket found in the last 5 commits"
        return 1
    fi

    # Extract ticket number
    local ticket=$(echo "$commit" | grep -o -E 'IOSB2B-[0-9]{1,5}')

    # Create PR and capture all output (including stderr for warnings)
    local pr_output=$(gh pr create --title "$commit" --body "Part of $ticket" 2>&1)

    # Extract PR URL from output (works for both new and existing PRs)
    local pr_url=$(echo "$pr_output" | grep -o 'https://github.com[^[:space:]]*' | tail -n 1)

    if [[ -z "$pr_url" ]]; then
        echo "Error: Could not extract PR URL from output:"
        echo "$pr_output"
        return 1
    fi

    # Create Slack markdown string with Markdown links
    #local slack_message="🔍 [$ticket](https://ewe-go.atlassian.net/browse/$ticket) ist bereit zum Codereview: [PR]($pr_url)"

    # Copy to clipboard
    #echo "$slack_message" | pbcopy

    # Print confirmation
    echo "✓ PR URL: $pr_url"
    #echo "✓ Slack message copied to clipboard:"
    #echo "$slack_message"
}

# updateRepos - in allen Git-Repos des aktuellen Ordners main auschecken und pullen
updateRepos() {
    local start_dir="$PWD"
    for dir in */; do
        local repo="${dir%/}"
        if [ ! -d "$repo/.git" ]; then
            continue
        fi

        cd "$start_dir/$repo" || continue

        local _mb=""
        if git show-ref --verify --quiet refs/heads/main; then
            _mb="main"
        elif git show-ref --verify --quiet refs/heads/master; then
            _mb="master"
        else
            echo "❌ $repo: weder main noch master Branch gefunden"
            cd "$start_dir"
            continue
        fi

        local _cb=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

        local _stashed=0
        if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
            if git stash push --include-untracked --quiet --message "updateRepos auto-stash" >/dev/null 2>&1; then
                _stashed=1
            else
                echo "❌ $repo: stash der lokalen Änderungen fehlgeschlagen"
                cd "$start_dir"
                continue
            fi
        fi

        local _output=""
        local _ok=1
        if [ "$_cb" != "$_mb" ]; then
            if ! _output=$(git checkout "$_mb" 2>&1); then
                _ok=0
            fi
        fi

        if [ "$_ok" -eq 1 ]; then
            if ! _output=$(git pull --ff-only 2>&1); then
                _ok=0
            fi
        fi

        if [ "$_stashed" -eq 1 ]; then
            local _pop_out=""
            if ! _pop_out=$(git stash pop 2>&1); then
                _output="${_output:+$_output; }stash pop fehlgeschlagen: $_pop_out"
                _ok=0
            fi
        fi

        if [ "$_ok" -eq 1 ]; then
            echo "✅ $repo aktualisiert"
        else
            echo "❌ $repo: $_output"
        fi

        cd "$start_dir"
    done
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
