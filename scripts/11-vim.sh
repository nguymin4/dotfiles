#!/bin/bash

set -euo pipefail

sudo add-apt-repository -y ppa:jonathonf/vim-daily
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt install -y ack vim-gtk3 neovim trash-cli libbz2-dev libreadline-dev libsqlite3-dev libssl-dev libffi-dev liblzma-dev tk-dev texlive texlive-luatex texlive-pictures texlive-latex-extra latexmk

pip install -U pynvim
zsh -c "source ~/.zshrc && vim +PlugInstall +qall"
