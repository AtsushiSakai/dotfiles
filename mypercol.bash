#!/bin/sh -x
# mypercol
# author: Atsushi Sakai
# echo "Source mypercol"

#========history search=======
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000

alias percol='fzf'
alias fzf='fzf --no-sort --tac'
export FZF_CTRL_R_OPTS='--no-sort'
export FZF_DEFAULT_OPTS='--no-sort'

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always %'"


# file search and open vim
f_file_search() {
    vim $(fzf)
}

# fcoc_preview - checkout git commit with previews
f_git_checkout() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
f_git_commit_show() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

# fuzzy branch search
f_git_change_branch() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# fuzzy docker image bash
f_docker_image_bash() {
  docker exec -it `docker ps --format "{{.Names}}" | fzf` bash
}


# for ctrl-r history search
__fzf_history__() {
    local line
    shopt -u nocaseglob nocasematch
    line=$(
        HISTTIMEFORMAT= history | sort -r -k 2 | uniq -f 1 | sort -n |
            FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --tac --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
            command grep '^ *[0-9]'
        ) &&
        if [[ $- =~ H ]]; then
            sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$line"
        else
            sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
        fi
}

