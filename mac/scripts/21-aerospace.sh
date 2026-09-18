#!/bin/bash

set -euo pipefail

brew install --cask nikitabobko/tap/aerospace
brew trust asmvik/formulae/skhd
brew install asmvik/formulae/skhd

# Detect app-id to use in aerospace config
# osascript -e 'id of app "Microsoft Teams"'
