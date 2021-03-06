#!/bin/bash
echo "$(basename $0) start!"

echo "update vim it's self"
if [ "$(uname)" == 'Darwin' ]; then
    brew upgrade vim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    if type yum > /dev/null 2>&1; then
        sudo yum update vim
    else # Ubuntu
        sudo apt install vim
    fi
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then                                                    
    OS='Windows'
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

echo "Update vim code"
git pull
git pull --recurse-submodules
git submodule update --init --recursive
git submodule foreach git pull origin master

echo "$(basename $0) done!"
exit 0

