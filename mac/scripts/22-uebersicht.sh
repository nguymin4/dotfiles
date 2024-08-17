#!/bin/bash

set -euo pipefail

brew install --cask ubersicht

UEBERSICHT_FOLDER="$HOME/.config/uebersicht"
WIDGET_FOLDER="$UEBERSICHT_FOLDER/widgets"
mkdir -p "$WIDGET_FOLDER"
git clone https://github.com/nguymin4/simple-bar.git "$WIDGET_FOLDER/simple-bar"
git clone https://github.com/nguymin4/simple-bar-server.git "$UEBERSICHT_FOLDER"
