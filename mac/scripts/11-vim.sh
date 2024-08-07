#!/bin/bash

set -euo pipefail

brew install neovim golangci-lint rg shellcheck trash-cli

zsh -c "source ~/.zshrc && nvim +PlugInstall +qall"
