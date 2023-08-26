#!/bin/bash

set -euo pipefail

sudo apt install -y zsh
echo "Change default shell to zsh"
chsh -s $(which zsh) $(whoami)

rm -rf ~/.oh-my-zsh && git clone https://github.com/nguymin4/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
bash ./install-custom-plugins.sh

# fzf
sudo apt install -y fd-find bat
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-update-rc
