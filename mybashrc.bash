#!/bin/sh -x
# mybashrc
# author: Atsushi Sakai
# echo "Source mybashrc"

# for pyenv
# export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

# for percol setting
source ~/dotfiles/mypercol.bash

# for enhancd setting
source ~/dotfiles/src/enhancd/init.sh
