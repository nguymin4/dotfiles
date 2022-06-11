#!/bin/bash

set -euo pipefail

sudo apt install -y zsh
chsh -s $(which zsh) $(whoami)

git clone https://github.com/nguymin4/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
bash ./install-custom-plugins.sh

# Experimental
sudo apt install fd-find bat
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin --completion --key-bindings
