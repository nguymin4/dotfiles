#!/bin/bash

set -euo pipefail

USE_CUSTOM_LOCATION=""

if [[ -z $USE_CUSTOM_LOCATION ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  HOMEBREW_ROOT=~/.homebrew

  if [[ ! -d $HOMEBREW_ROOT ]]; then
    git clone https://github.com/Homebrew/brew $HOMEBREW_ROOT
  else
    echo "$HOMEBREW_ROOT exists. Skipped cloning homebrew"
  fi

  eval "$($HOMEBREW_ROOT/bin/brew shellenv)"
  brew update --force --quiet
  chmod -R go-w "$(brew --prefix)/share/zsh"
fi

brew install efm-langserver fd fish fisher starship tmux
