#!/bin/bash

set -euo pipefail

brew install bat cmake coreutils fd git gnu-sed htop jq mkcert neofetch nmap ranger tig watchman

sudo ln -sf /opt/homebrew/bin/python3 /opt/homebrew/bin/python
sudo ln -sf /opt/homebrew/bin/pip3 /opt/homebrew/bin/pip

# Check cloud components installation
brew install --cask alacritty google-cloud-sdk spaceid stats ueli visual-studio-code
xattr -rd com.apple.quarantine /Applications/Alacritty.app
xattr -rd com.apple.quarantine /Applications/SpaceId.app
xattr -rd com.apple.quarantine /Applications/ueli.app

# Fonts
brew tap homebrew/cask-fonts
brew install font-ubuntu-nerd-font font-ubuntu-mono-nerd-font
