#!/bin/bash

set -euo pipefail

sudo apt install -y sway swaylock swayidle waybar slurp grimshot wl-clipboard wlr-randr kanshi
chmod u+x -R ~/.config/waybar/blocks

# Screen sharing via browser
sudo apt install -y xdg-desktop-portal-wlr wireplumber

# Bluetooth speaker
sudo apt install -y libspa-0.2-bluetooth pipewire-audio-client-libraries
# sudo apt remove pulseaudio-module-bluetooth

# fcitx5
sudo apt install -y fcitx5 fcitx5-unikey
fcitx5 -dr > /dev/null

# Multi-GPU setup: Intel-Nvidia
# Use integrated (Intel) card for sway as Nvidia is not officially supported
# Node name `card1` is chosen by cross-checking /dev/dri/by-path and `lspci`
sudo tee /usr/share/wayland-sessions/sway-nvidia.desktop > /dev/null <<- 'EOH'
[Desktop Entry]
Name=Sway - Nvidia
Comment=An i3-compatible Wayland compositor
Exec=env WLR_DRM_DEVICES=/dev/dri/card1 sway --unsupported-gpu
Type=Application
DesktopNames=sway
EOH

# swayinfo similar to xprop
pip install --user swaytools
