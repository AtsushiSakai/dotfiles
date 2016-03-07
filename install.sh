#!/bin/sh
echo "dotfiles install!"
git clone https://github.com/AtsushiSakai/dotfiles.git ~/dotfiles
echo "source ~/dotfiles/mybashrc.bash" | sudo tee -a ~/.bashrc

