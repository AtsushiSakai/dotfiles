#!/bin/sh -x
# mybashrc
# author: Atsushi Sakai
# echo "Source mybashrc"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias lls='exa -l --git'

# ls with color
if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
else
    eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
fi

alias pyjsonviewer='python -m pyjsonviewer'

export HISTSIZE=10000

git config --global user.name "Atsushi Sakai"
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'

# for git merge
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false

# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh

# share bash history
# function share_history {
    # history -a
    # history -c
    # history -r
# }
# PROMPT_COMMAND='share_history'
# shopt -u histappend

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/bin:$PATH"

if [ -x "`which pyenv `" ]; then
    eval "$(pyenv init -)"
fi 


if [ -e /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

export JULIA_NUM_THREADS=4

