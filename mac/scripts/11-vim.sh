#!/bin/bash

set -euo pipefail

brew install neovim ack golangci-lint shellcheck trash-cli

pip install pynvim
zsh -c "source ~/.zshrc && nvim +PlugInstall +qall"
