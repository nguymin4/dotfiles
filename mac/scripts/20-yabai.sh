#!/bin/bash

set -euo pipefail

brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# brew services start yabai
# brew services start skhd

# NOTES: Change these settings
# - Accessibility > Reduce Motion -> on
# - Desktop & Dock > Automatically rearrange Spaces based on recently used -> off
# - Mission Control > Enable Switch to Desktop 1, 2, 3

# TODO: 
# - https://github.com/cmacrae/spacebar vs simple-bar
# - https://github.com/AdamWagner/stackline
