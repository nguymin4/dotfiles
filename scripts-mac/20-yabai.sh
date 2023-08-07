#!/bin/bash

set -euo pipefail

brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
# yabai --start-service
# skhd --start-service

# NOTES: Change these settings
# - Accessibility > Reduce Motion -> on
# - Desktop & Dock > Automatically rearrange Spaces based on recently used -> off

# TODO: setup topbar ~ polybar
