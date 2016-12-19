#! /usr/bin/python
# -*- coding: utf-8 -*-
u"""
dotfiles setup script

author: Atsushi Sakai
"""
import subprocess


def main():
    print("dotfiles install!!")

    clone_dotfiles()


def clone_dotfiles():
    u"""
    clone dotfiles
    """
    cmd = "git clone git@github.com:AtsushiSakai/dotfiles.git ~/dotfiles"
    subprocess.call(cmd, shell=True)


if __name__ == '__main__':
    main()
