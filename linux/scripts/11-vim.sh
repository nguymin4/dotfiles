#!/bin/bash

set -euo pipefail

sudo add-apt-repository -y ppa:jonathonf/vim-daily
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt install -y ack vim-gtk3 neovim efm-langserver trash-cli libbz2-dev libreadline-dev libsqlite3-dev libssl-dev libffi-dev liblzma-dev tk-dev texlive texlive-luatex texlive-pictures texlive-latex-extra latexmk

pip install -U pynvim
zsh -c "source ~/.zshrc && vim +PlugInstall +qall"

# Support copy between Windows and WSL
if [[ $(uname -a) =~ (microsoft|WSL) ]]; then
  win_user_folder=$(echo $PATH | grep -Eo 'Users\/(\w+)' | head -n1)
  win32yank_file="/mnt/c/${win_user_folder}/scoop/apps/neovim/current/bin/win32yank.exe"
  [[ -f $win32yank_file ]] && sudo ln -sf $win32yank_file "/usr/local/bin/win32yank.exe"
fi
