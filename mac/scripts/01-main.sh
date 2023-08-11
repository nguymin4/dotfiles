#!/bin/bash

set -euo pipefail

brew install bat cmake fd git gnu-sed htop jq mkcert neofetch nmap ranger tig watchman

# Check cloud components installation
brew install --cask alacritty google-cloud-sdk visual-studio-code

# Fonts
brew tap homebrew/cask-fonts
brew install font-ubuntu-nerd-font font-ubuntu-mono-nerd-font