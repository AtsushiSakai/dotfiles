#!/bin/bash
echo "$(basename $0) start!"

echo "Update dotfiles"
git pull origin master
git pull --recurse-submodules origin master
git submodule update --init --recursive
git submodule foreach git pull origin master

echo "Install dotfiles"
./install.sh

echo "=== update software ==="
if [ "$(uname)" == 'Darwin' ]; then
    echo "OS is Mac"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    echo "OS is Linux"
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then
    echo "OS is Windows"
    git update-git-for-windows
    choco upgrade all
else
    echo "Your platform ($(uname -a)) is not supported."
fi

echo "update vim files"
vim/update_all.sh

echo "update python files"
python3 -m pip install --upgrade pip
python3 -m pip freeze > requirements.txt
sed -i -e 's/==/>=/g' requirements.txt
python3 -m pip install -r requirements.txt --upgrade
rm requirements.txt

echo "$(basename $0) done!"
exit 0

