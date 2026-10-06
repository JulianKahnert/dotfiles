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

# Every SSH login (Mac, ShellFish) joins the one tmux session, whatever it is named.
# No exec: if tmux cannot start, the login falls back to a plain shell instead of closing.
if [[ -n "$SSH_CONNECTION" && -z "$TMUX" && -o interactive && -t 0 ]]; then
  (
    # cmux points ZDOTDIR and CMUX_* at this one connection; a server started here would
    # hand them to every later window, and cmux deletes that ZDOTDIR when the login ends.
    unset ZDOTDIR ${(M)${(k)parameters}:#CMUX_*}
    tmux -u attach-session 2>/dev/null || tmux -u new-session -s main
  ) && exit
fi

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

    # Use "Resolves" for offblock-business-ios repo, "Part of" elsewhere
    local body_prefix="Part of"
    local remote_url=$(git remote get-url origin 2>/dev/null)
    if [[ "$remote_url" == *"offblock-aero/offblock-business-ios"* ]]; then
        body_prefix="Resolves"
    fi

    # Create PR and capture all output (including stderr for warnings)
    local pr_output=$(gh pr create --title "$commit" --body "$body_prefix $ticket" 2>&1)

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

createPrDraft() {
    # Find the first commit with IOSB2B- ticket
    local commit=$(git log --format=%B -n 5 | grep "IOSB2B-" | head -n 1)

    if [[ -z "$commit" ]]; then
        echo "Error: No commit with IOSB2B- ticket found in the last 5 commits"
        return 1
    fi

    # Extract ticket number
    local ticket=$(echo "$commit" | grep -o -E 'IOSB2B-[0-9]{1,5}')

    # Use "Resolves" for offblock-business-ios repo, "Part of" elsewhere
    local body_prefix="Part of"
    local remote_url=$(git remote get-url origin 2>/dev/null)
    if [[ "$remote_url" == *"offblock-aero/offblock-business-ios"* ]]; then
        body_prefix="Resolves"
    fi

    # Create PR and capture all output (including stderr for warnings)
    local pr_output=$(gh pr create --draft --title "$commit" --body "$body_prefix $ticket" 2>&1)

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

buildAll() {
    /Users/jukaoffblock/GIT/build-all-platforms.swift "$PWD"
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

# run swiftlint with analyze
swiftlintFull() {
    echo "🔨 swift build…"
    swift build -v > build.log || return $?
    echo "🔍 swiftlint analyze…"
    swiftlint analyze --compiler-log-path build.log --progress --fix
    echo "🧹 swiftlint --fix…"
    swiftlint --fix
    rm -f build.log
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

test -e "$HOME/.shellfishrc" && source "$HOME/.shellfishrc"

# ShellFish shows the OSC 2 terminal title as the tab title. Set it to the current
# directory. Only under ShellFish.
if [[ "$LC_TERMINAL" == "ShellFish" ]]; then
  autoload -Uz add-zsh-hook
  _shellfish_dir_title() {
    typeset -f settitle > /dev/null && settitle "${PWD:t}"
  }
  add-zsh-hook precmd _shellfish_dir_title
fi

alias codereview='open -b de.JulianKahnert.CodeReview'

# cmux: name the workspace after the directory (rules in ~/.claude/hooks/cmux-workspace-name.sh)
# `cmux ssh <dest>` opens a new workspace, so its name has to go in as --name up front.
cmux() {
  [[ "$1" == ssh && -n "$2" ]] || { command cmux "$@"; return }
  local script=~/.claude/hooks/cmux-workspace-name.sh name group out rc
  if [[ "$*" != *--name* ]]; then
    name="$("$script" ssh-name "$2" 2>/dev/null)"
    [[ -n "$name" ]] && set -- "$@" --name "$name"
  fi
  group="$("$script" ssh-group "$2" 2>/dev/null)"
  [[ -z "$group" ]] && { command cmux "$@"; return }
  # cmux ssh has no --group flag; the new workspace's ref is only known from its output.
  out="$(command cmux "$@")"
  rc=$?
  print -r -- "$out"
  [[ "$out" =~ 'workspace:[0-9]+' ]] && "$script" join "$MATCH" "$group" >/dev/null 2>&1
  return $rc
}
if [[ -n "$CMUX_WORKSPACE_ID" ]]; then
  _cmux_workspace_name() {
    local name
    name="$(~/.claude/hooks/cmux-workspace-name.sh name 2>/dev/null)" || return
    [[ -z "$name" ]] && return
    [[ "$name" == "$_cmux_last_workspace_name" ]] && return
    _cmux_last_workspace_name="$name"
    ~/.claude/hooks/cmux-workspace-name.sh apply >/dev/null 2>&1
  }
  # While ssh runs, show the host; the next precmd sees a different name and switches back.
  _cmux_workspace_ssh_name() {
    local -a words=(${(z)1})
    [[ "${words[1]}" == ssh ]] || return
    local name
    name="$(~/.claude/hooks/cmux-workspace-name.sh ssh-name "${(Q@)words[2,-1]}" 2>/dev/null)" || return
    [[ -z "$name" ]] && return
    _cmux_last_workspace_name="$name"
    cmux workspace rename --workspace "$CMUX_WORKSPACE_ID" --title "$name" >/dev/null 2>&1
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _cmux_workspace_name
  add-zsh-hook preexec _cmux_workspace_ssh_name
fi

alias gitclear='git reset --hard HEAD && git clean -fd'
