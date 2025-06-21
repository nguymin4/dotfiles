#!/bin/bash

set -euo pipefail

# CLI
brew install coreutils fastfetch fd gnu-sed grep htop jq nmap rg tig watch wget yazi

# Python
sudo ln -sf /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip
sudo ln -sf /opt/homebrew/bin/python3 /opt/homebrew/bin/python

# Cask
brew install --cask alacritty alfred visual-studio-code wezterm
xattr -rd com.apple.quarantine /Applications/Alacritty.app
# brew install --cask spaceid stats 

# Fonts
brew install font-ubuntu-nerd-font font-ubuntu-mono-nerd-font font-codicon
