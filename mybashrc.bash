#!/bin/sh -x
# mybashrc
# author: Atsushi Sakai
# echo "Source mybashrc"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='exa -l --git'

export HISTSIZE=10000

# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh

# share bash history
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

# for pyenv
if [ -x "`which pyenv `" ]; then
    # export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
fi 

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

