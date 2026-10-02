#!/bin/bash

set -euo pipefail

# i3
sudo apt update
sudo apt install -y --no-install-recommends i3 i3blocks polybar
chmod u+x -R ~/.config/polybar/blocks

# X11
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt install -y picom xclip xautolock gnome-screensaver feh flameshot peek

# ibus
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo apt install -y ibus-bamboo
ibus restart
