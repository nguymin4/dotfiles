#!/bin/bash

set -euo pipefail

brew install bat coreutils fd git gnu-sed grep htop jq neofetch nmap ranger tig

ln -sf /opt/homebrew/opt/gnu-sed/libexec/gnubin/sed ~/.local/bin/sed
ln -sf /opt/homebrew/bin/ggrep ~/.local/bin/grep
sudo ln -sf /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip
sudo ln -sf /opt/homebrew/bin/python3 /opt/homebrew/bin/python

# Check cloud components installation
brew install --cask alacritty alfred google-cloud-sdk spaceid stats visual-studio-code
xattr -rd com.apple.quarantine /Applications/Alacritty.app
xattr -rd com.apple.quarantine /Applications/SpaceId.app

# Fonts
brew tap homebrew/cask-fonts
brew install font-ubuntu-nerd-font font-ubuntu-mono-nerd-font
