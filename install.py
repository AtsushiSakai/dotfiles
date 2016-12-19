#! /usr/bin/python
# -*- coding: utf-8 -*-
u"""
dotfiles setup script

author: Atsushi Sakai
"""
import subprocess
import os


def main():
    print("dotfiles install start!!")

    clone_dotfiles()
    add_mybashrc_sourse_on_bashrc()
    install_enhancd()


def install_enhancd():
    u"""
    install enhancd
    """
    print("[install_enhancd]")

    cmd = "git clone https://github.com/b4b4r07/enhancd ~/dotfiles/src/enhancd/"
    subprocess.call(cmd, shell=True)


def add_mybashrc_sourse_on_bashrc():
    u"""
    add mybashrc sourse code on bashrc
    """
    print("[add_mybashrc_sourse_on_bashrc]")

    bashrc_path = os.path.expanduser('~/.bashrc')

    if os.path.exists(bashrc_path):
        ld = open(bashrc_path)
        lines = ld.readlines()
        ld.close()

        for line in lines:
            if line.find("mybashrc.bash") >= 0:
                print("found mybashrc sourse code")
                return

    cmd = 'echo "source ~/dotfiles/mybashrc.bash" | sudo tee -a ~/.bashrc'
    subprocess.call(cmd, shell=True)


def clone_dotfiles():
    u"""
    clone dotfiles
    """
    print("[clone_dotfiles]")
    cmd = "git clone git@github.com:AtsushiSakai/dotfiles.git ~/dotfiles"
    subprocess.call(cmd, shell=True)


if __name__ == '__main__':
    main()
