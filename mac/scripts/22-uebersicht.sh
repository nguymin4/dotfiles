#!/bin/bash

set -euo pipefail

brew install --cask ubersicht

WIDGET_FOLDER="$HOME/.config/uebersicht/widgets"
mkdir -p "$WIDGET_FOLDER"
git clone https://github.com/nguymin4/simple-bar.git "$WIDGET_FOLDER/simple-bar"
