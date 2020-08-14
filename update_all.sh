#!/bin/bash
echo "$(basename $0) start!"

echo "Update dotfiles"
git pull origin master
git pull --recurse-submodules origin master
git submodule update --init --recursive
git submodule foreach git pull origin master

echo "Install dotfiles"
./install.sh

echo "update vim files"
vim/update_all.sh

echo "update python files"
pip install --upgrade pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U --user --no-warn-script-location

echo "$(basename $0) done!"
exit 0

