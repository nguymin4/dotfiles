#!/bin/bash

set -euo pipefail

brew install neovim ack golangci-lint shellcheck trash-cli

zsh -c "source ~/.zshrc && nvim +PlugInstall +qall"
