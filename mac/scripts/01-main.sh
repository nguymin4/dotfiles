#!/bin/bash

set -euo pipefail

brew install coreutils fastfetch fd gnu-sed grep htop jq nmap rg tig wget yazi

sudo ln -sf /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip
sudo ln -sf /opt/homebrew/bin/python3 /opt/homebrew/bin/python

brew install --cask alacritty alfred spaceid stats visual-studio-code wezterm
xattr -rd com.apple.quarantine /Applications/Alacritty.app

# Fonts
brew install font-ubuntu-nerd-font font-ubuntu-mono-nerd-font font-codicon
