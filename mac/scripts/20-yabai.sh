#!/bin/bash

set -euo pipefail

# yabai
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# yabai --start-service
# skhd --start-service

brew install --cask spaceid
xattr -rd com.apple.quarantine /Applications/SpaceId.app

# NOTES: Change these settings
# - Accessibility > Reduce Motion -> on
# - Desktop & Dock > Automatically rearrange Spaces based on recently used -> off
# - Desktop & Dock > Displays have separate Spaces -> on
# - Setup multiple spaces
# - Mission Control
#   - > Enable: Switch to Desktop 1, 2, 3
#   - > Disable: Move to next and previous Desktop (to navigate between words instead)
