#!/bin/bash
echo "$(basename $0) start!"
cd $(dirname "$0")

ln -snf ~/dotfiles/vim/.vim ~/.vim
ln -sf ~/dotfiles/vim/.vimrc ~/.vimrc
ln -sf ~/dotfiles/vim/.ideavimrc ~/.ideavimrc

echo "$(basename $0) done!"
exit 0

