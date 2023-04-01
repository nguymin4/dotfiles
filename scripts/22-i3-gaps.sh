#!/bin/bash

set -euo pipefail

# i3
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
sudo dpkg -i /tmp/keyring.deb
echo \
  "deb [arch=$(dpkg --print-architecture)] http://debian.sur5r.net/i3/ $(lsb_release -cs) universe" \
  | sudo tee /etc/apt/sources.list.d/sur5r-i3.list > /dev/null
sudo apt update
sudo apt install -y --no-install-recommends i3 i3blocks polybar
chmod u+x -R ~/.config/i3/blocks

# X11
sudo add-apt-repository -y ppa:peek-developers/stable
sudo apt install -y picom xclip xautolock gnome-screensaver feh flameshot peek

# ibus
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo apt install -y ibus-bamboo
ibus restart
