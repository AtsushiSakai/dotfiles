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

# ls with color
if [ "$(uname)" = 'Darwin' ]; then
    alias ls='ls -G'
fi

export HISTSIZE=10000

# bash completio for mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# ==== git setting ====
alias gc="git commit -av"
alias gp="git push"

git config --global user.name "Atsushi Sakai"
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global core.quotepath false #for Japanese encode

# for git merge
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false

# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

# for pyenv
#if [ "$(expr substr $(uname -s) 1 10)" != 'MINGW64_NT' ]; then                                            
    if [ -x "`which pyenv `" ]; then
       eval "$(pyenv init -)"
    fi 
#fi

# alias
alias pyjsonviewer='python -m pyjsonviewer'
alias jupercol='find . -name "*.ipynb" -not -name '*checkpoint*'| percol | xargs jupyter notebook'

# Julia setting
alias julia='julia --color=yes'
export JULIA_NUM_THREADS=4
export JULIA_EDITOR=vim

