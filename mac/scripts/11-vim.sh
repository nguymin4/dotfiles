#!/bin/bash

set -euo pipefail

brew install neovim tree-sitter-cli golangci-lint shellcheck trash

zsh -c "source ~/.zshrc && nvim +PlugInstall +qall"
