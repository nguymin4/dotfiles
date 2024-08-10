#!/bin/bash

set -euo pipefail

brew install neovim golangci-lint shellcheck trash

zsh -c "source ~/.zshrc && nvim +PlugInstall +qall"
