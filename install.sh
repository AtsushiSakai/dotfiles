#!/bin/bash
echo "$(basename $0) start!"
cd $(dirname "$0")

if [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then
    # ln command does not work in Windows, so override these files
    rm -rf ~/.vim
    cp -rf ~/dotfiles/vim/.vim ~/.vim
    rm -rf ~/vimfiles
    cp -rf ~/dotfiles/vim/.vim ~/vimfiles

    rm -rf ~/.vimrc
    cp -rf ~/dotfiles/vim/.vimrc ~/.vimrc
    rm -rf ~/.gvimrc
    cp -rf ~/dotfiles/vim/.gvimrc ~/.gvimrc

    rm -rf ~/.ideavimrc
    cp -rf ~/dotfiles/vim/.ideavimrc ~/.ideavimrc
    rm -rf ~/.julia/config/startup.jl
    cp -rf ~/dotfiles/startup.jl ~/.julia/config/startup.jl
    rm -rf ~/.matplotlib/matplotlibrc
    cp -rf ~/dotfiles/matplotlib/matplotlibrc ~/.matplotlib/matplotlibrc
else
    ln -nsf ~/dotfiles/vim/.vim ~/.vim
    ln -nsf ~/dotfiles/vim/.vimrc ~/.vimrc
    ln -nsf ~/dotfiles/vim/.gvimrc ~/.gvimrc
    ln -nsf ~/dotfiles/vim/.ideavimrc ~/.ideavimrc
    ln -nsf ~/dotfiles/startup.jl ~/.julia/config/startup.jl
    ln -nsf ~/dotfiles/matplotlib/matplotlibrc ~/.matplotlib/matplotlibrc
fi
 
rm -rf ~/.gitconfig
cp -rf ~/dotfiles/git/gitconfig ~/.gitconfig

echo "$(basename $0) done!"
exit 0

