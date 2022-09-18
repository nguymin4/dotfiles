#!/bin/bash

set -euo pipefail

# Dependencies
sudo apt install -y ninja-build meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

# i3-gaps
sudo apt install -y --no-install-recommends i3status i3blocks polybar
rm -rf ~/Programs/i3 && git clone https://github.com/Airblader/i3.git ~/Programs/i3
cd ~/Programs/i3
mkdir -p build && cd build
meson ..
ninja
sudo meson install
chmod u+x -R ~/.config/i3/blocks

# X11
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt install -y picom xclip xautolock gnome-screensaver feh flameshot peek

# ibus
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo apt install -y ibus-bamboo
ibus restart
