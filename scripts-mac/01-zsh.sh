#!/bin/bash

set -euo pipefail

rm -rf ~/.oh-my-zsh && git clone https://github.com/nguymin4/oh-my-zsh.git ~/.oh-my-zsh
cd ~/.oh-my-zsh
bash ./install-custom-plugins.sh

# fzf
rm -rf ~/.fzf && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin --completion --key-bindings
