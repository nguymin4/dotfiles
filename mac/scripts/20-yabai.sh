#!/bin/bash

set -euo pipefail

# yabai
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# brew services start yabai
# brew services start skhd

# NOTES: Change these settings
# - Accessibility > Reduce Motion -> on
# - Desktop & Dock > Automatically rearrange Spaces based on recently used -> off
# - Mission Control > Enable Switch to Desktop 1, 2, 3

# TODO:
# - Check window stack: https://github.com/AdamWagner/stackline


# sketchybar
brew install FelixKratz/formulae/sketchybar
# brew services start sketchybar

# Hide the default macOS menu bar in System Settings -> Desktop & Dock -> Automatically hide and show the menu bar -> Always
