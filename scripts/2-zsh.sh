#!/bin/bash

sudo apt install -y zsh
chsh -s $(which zsh) $(whoami)

git clone https://github.com/nguymin4/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
bash ./install-custom-plugins.sh
