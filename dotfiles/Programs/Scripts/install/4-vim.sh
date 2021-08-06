#!/bin/bash

set -o errexit

sudo add-apt-repository -y ppa:jonathonf/vim-daily
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt install -y vim-gtk3 neovim python3-neovim libbz2-dev libreadline-dev libsqlite3-dev libssl-dev libffi-dev liblzma-dev tk-dev texlive latexmk

function checkout_latest_tag() {
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
}

# pyenv install -> create virtualenv -> activate
rm -rf ~/.pyenv && git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
cd ~/.pyenv && checkout_latest_tag
pip install -U pynvim

rm -rf ~/.nvm && git clone https://github.com/nvm-sh/nvm.git ~/.nvm
cd ~/.nvm && checkout_latest_tag

zsh -c "source ~/.zshrc && nvm install --lts && npm install -g yarn"
zsh -c "source ~/.zshrc && vim +PlugInstall +qall"
