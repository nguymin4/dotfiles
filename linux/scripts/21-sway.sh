#!/bin/bash

set -euo pipefail

sudo apt install -y sway swaylock swayidle waybar slurp grimshot wl-clipboard wlr-randr kanshi

pip install --user swaytools

chmod u+x -R ~/.config/waybar/blocks

# Screen sharing via browser
sudo apt install -y xdg-desktop-portal-wlr wireplumber

# Bluetooth speaker
sudo apt install -y libspa-0.2-bluetooth pipewire-audio-client-libraries
# sudo apt remove pulseaudio-module-bluetooth

# fcitx5
sudo apt install -y fcitx5 fcitx5-unikey
fcitx5 -dr > /dev/null
