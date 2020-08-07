#!/bin/bash
echo "$(basename $0) start!"
cd $(dirname "$0")

ln -nsf ~/dotfiles/vim/.vim ~/.vim
ln -nsf ~/dotfiles/vim/.vimrc ~/.vimrc
ln -nsf ~/dotfiles/vim/.ideavimrc ~/.ideavimrc
ln -nsf ~/dotfiles/startup.jl ~/.julia/config/startup.jl
ln -nsf ~/dotfiles/matplotlib/matplotlibrc ~/.matplotlib/matplotlibrc

ln -nsf ~/dotfiles/git/gitconfig ~/.gitconfig

echo "$(basename $0) done!"
exit 0

