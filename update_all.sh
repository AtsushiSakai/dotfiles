#!/bin/bash
echo "$(basename $0) start!"

echo "Update dotfiles"
git pull origin master
git pull --recurse-submodules origin master
git submodule update --init --recursive
git submodule foreach git pull origin master

vim/update_all.sh

# Update all python libraries
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H pip install -U --user

echo "$(basename $0) done!"
exit 0

