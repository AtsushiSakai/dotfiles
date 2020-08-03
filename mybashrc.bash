#!/bin/sh -x
#
# mybashrc setting
#
# author: Atsushi Sakai
#
# echo "Source mybashrc"

source ~/dotfiles/src/esh/esh.sh

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if type "exa" > /dev/null 2>&1; then
    alias lls='exa -l --git'
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if git rev-parse --git-dir > /dev/null 2>&1; then
    # git repo!
    export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
else
    # NOT a git repo!
    export PS1="\W\[\033[32m\](not git repo)\[\033[00m\] $"
fi



# ==== bash history setting ====
export HISTSIZE=10000

# save command history immediately setting
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# bash completio for mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# ==== git setting ====

# Sample git setting
git config --global user.name "Atsushi Sakai"
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global core.autocrlf input
git config --global core.quotepath false #for Japanese encode
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global merge.ff false
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false
git config --global push.default simple
git config --global pull.ff only
git config --global github.user AtsushiSakai
git config --global diff.ignoreSubmodules dirty

git config --global alias.c "commit -av"
git config --global alias.wdiff "diff --color-words"
git config --global alias.p "!git push origin `git rev-parse --abbrev-ref HEAD`"
git config --global alias.force-pull "!git fetch && git reset --hard origin/`git current-branch`"


# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh

# alias
alias pyjsonviewer='python -m pyjsonviewer'
alias jupercol='find . -name "*.ipynb" -not -name '*checkpoint*'| percol | xargs jupyter notebook'

alias pipallupdate='pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U --user'

# Julia setting
alias julia='julia --color=yes'
export JULIA_NUM_THREADS=4
export JULIA_EDITOR=vim

