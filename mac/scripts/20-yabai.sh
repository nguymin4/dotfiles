#!/bin/bash

set -euo pipefail

# yabai
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# yabai --start-service
# skhd --start-service

# NOTES: Change these settings
# - Accessibility > Reduce Motion -> on
# - Desktop & Dock > Automatically rearrange Spaces based on recently used -> off
# - Setup multiple spaces
# - Mission Control
#   - > Enable: Switch to Desktop 1, 2, 3
#   - > Disable: Move to next and previous Desktop (to navigate between words instead)

# TODO:
# - Check window stack: https://github.com/AdamWagner/stackline
