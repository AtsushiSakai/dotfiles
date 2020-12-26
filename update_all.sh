#!/bin/bash
echo "$(basename $0) start!"

set -x # debug mode

cd $(dirname $0) || exit 1

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
    PYTHON_RUN="python3.9"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    echo "OS is Linux"
    PYTHON_RUN="python3.9"
    sudo apt autoremove
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then
    echo "OS is Windows"
    git update-git-for-windows
    choco upgrade all
    PYTHON_RUN="python3"
else
    echo "Your platform ($(uname -a)) is not supported."
fi

echo "update vim files"
vim/update_all.sh

echo "update python files"
${PYTHON_RUN} -m pip install --upgrade pip
${PYTHON_RUN} -m pip freeze > requirements.txt
sed -i -e 's/==/>=/g' requirements.txt
${PYTHON_RUN} -m pip install -r requirements.txt --upgrade
rm requirements.txt

echo "$(basename $0) done!"
exit 0

