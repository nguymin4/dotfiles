#!/bin/bash

set -euo pipefail

HOMEBREW_ROOT=~/.homebrew

if [[ ! -d $HOMEBREW_ROOT ]]; then
  git clone https://github.com/Homebrew/brew $HOMEBREW_ROOT
else
  echo "$HOMEBREW_ROOT exists. Skipped cloning homebrew"
fi

eval "$($HOMEBREW_ROOT/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
