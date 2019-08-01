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
fi

export HISTSIZE=10000

# bash completio for mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# git setting
git config --global user.name "Atsushi Sakai"
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global push.default simple

# for git merge
git config --global merge.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false

# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh

# for pyenv
if [ "$(expr substr $(uname -s) 1 10)" != 'MINGW64_NT' ]; then                                                                                           
    if [ -x "`which pyenv `" ]; then
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$HOME/.pyenv/bin:$PATH"
        eval "$(pyenv init -)"
    fi 
fi

# alias
alias pyjsonviewer='python -m pyjsonviewer'
alias jupercol='find . -name "*.ipynb" -not -name '*checkpoint*'| percol | xargs jupyter notebook'

# Julia setting
export JULIA_NUM_THREADS=4
export JULIA_EDITOR=vim

