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

# open finder emulation
if type "xdg-open" > /dev/null 2>&1; then # for ubuntu
    alias open='xdg-open'
fi


parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "


# ==== bash history setting ====
export HISTSIZE=10000

# save command history immediately setting
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# bash completio for mac
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# for percol setting
source ~/dotfiles/mypercol.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh
export ENHANCD_FILTER=fzf

# alias
alias pyjsonviewer='python -m pyjsonviewer'
alias jupercol='find . -name "*.ipynb" -not -name '*checkpoint*'| percol | xargs jupyter notebook'
alias plain_vim='vim -u NONE'

