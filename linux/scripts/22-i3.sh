#!/bin/bash

set -euo pipefail

# i3 - https://i3wm.org/docs/repositories.html
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2025.03.09_all.deb /tmp/keyring.deb SHA256:2c2601e6053d5c68c2c60bcd088fa9797acec5f285151d46de9c830aaba6173c
sudo dpkg -i /tmp/keyring.deb
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/sur5r-keyring.gpg] http://debian.sur5r.net/i3/ $(lsb_release -cs) universe" \
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
