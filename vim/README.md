# What is this

My vim setting

# Install

1　Checkout software

> $ git clone --recursive https://github.com/AtsushiSakai/myvim ~/

2 Create symboric links

> $ ln -s ~/myvim/.vim ~/.vim

> $ ln -s ~/myvim/.vimrc ~/.vimrc

> $ ln -s ~/myvim/.ideavimrc ~/.ideavimrc

# Plugin management

Using just git and vim pack.

## Add 

1. goto ~/myvim/.vim/pack/mypackage/start or opt

2. add submodule

> $ git submodule add https://github.com/tomasr/molokai

## Update

>$ git submodule init

>$ git submodule pull

>$ git submodule foreach git pull

## Delete

>$ git submodule deinit submodule/

>$ git rm -rf submodule/

## Ref

- [Vim 8 時代のがんばらないプラグイン管理のすすめ \- Humanity](http://tyru.hatenablog.com/entry/2017/12/20/035142)

# Plugins

## Start

- [kamykn/spelunker\.vim: Improved vim spelling plugin \(with camel case support\)\!](https://github.com/kamykn/spelunker.vim)

- [scrooloose/nerdcommenter: Vim plugin for intensely orgasmic commenting](https://github.com/scrooloose/nerdcommenter)

- [maralla/completor\.vim: Async completion framework made ease\.](https://github.com/maralla/completor.vim)

- [vim\-scripts/grep\.vim: Grep search tools integration with Vim](https://github.com/vim-scripts/grep.vim/)

- [yegappan/mru: Most Recently Used \(MRU\) Vim Plugin](https://github.com/yegappan/mru)

## Opt

- [davidhalter/jedi\-vim: Using the jedi autocompletion library for VIM\.](https://github.com/davidhalter/jedi-vim)

- [JuliaEditorSupport/julia\-vim: Vim support for Julia\.](https://github.com/JuliaEditorSupport/julia-vim)

- [AtsushiSakai/julia\.vim: Vim plugin for Julia\.](https://github.com/AtsushiSakai/julia.vim)

- [previm/previm: Realtime preview by Vim\. \(Markdown, reStructuredText, textile\)](https://github.com/previm/previm)

# Language Server Protocol Server

## Python

>$ pip install python-language-server

## C++ (Clangd)

>$ brew install llvm


# Detailed description in Japanese

* [仕事を1.5倍ぐらい早くするVim設定 - MY ENIGMA](http://d.hatena.ne.jp/meison_amsl/20120403/1333452345)

* [おすすめVimプラグイン - MY ENIGMA](http://d.hatena.ne.jp/meison_amsl/20141219)

