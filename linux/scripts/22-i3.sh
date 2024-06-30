#!/bin/bash

set -euo pipefail

# i3 - https://i3wm.org/docs/repositories.html
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb /tmp/keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734
sudo dpkg -i /tmp/keyring.deb
echo \
  "deb [arch=$(dpkg --print-architecture)] http://debian.sur5r.net/i3/ $(lsb_release -cs) universe" \
  | sudo tee /etc/apt/sources.list.d/sur5r-i3.list > /dev/null
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
