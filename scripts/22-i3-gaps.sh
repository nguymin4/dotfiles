#!/bin/bash

set -euo pipefail

# i3
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2022.02.17_all.deb /tmp/keyring.deb SHA256:52053550c4ecb4e97c48900c61b2df4ec50728249d054190e8a0925addb12fc6
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
