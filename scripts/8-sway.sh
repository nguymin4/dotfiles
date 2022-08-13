#!/bin/bash

set -euo pipefail

sudo apt install -y wl-clipboard wlr-randr kanshi sway swaylock swayidle slurp waybar

pip install --user swaytools

chmod u+x -R ~/.config/waybar/blocks
