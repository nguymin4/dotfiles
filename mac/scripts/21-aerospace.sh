#!/bin/bash

set -euo pipefail

brew install --cask nikitabobko/tap/aerospace
brew install koekeishiya/formulae/skhd

# Detect app-id to use in aerospace config
# osascript -e 'id of app "Microsoft Teams"'
