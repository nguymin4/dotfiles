#!/bin/bash

set -euo pipefail

sudo apt install -y zsh
echo "Change default shell to zsh"
chsh -s "$(which zsh)" "$(whoami)"

rm -rf ~/.oh-my-zsh && git clone https://github.com/nguymin4/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
bash ./install-custom-plugins.sh

# fzf
brew install fzf fd bat
"$HOMEBREW_PREFIX"/opt/fzf/install --all --no-update-rc
