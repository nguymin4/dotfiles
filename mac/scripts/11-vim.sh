#!/bin/bash

set -euo pipefail

brew install vim neovim ack efm-langserver trash-cli

pip install -U pynvim
zsh -c "source ~/.zshrc && vim +PlugInstall +qall"
