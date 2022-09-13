#!/bin/bash

set -euo pipefail

# Albert launcher
echo "deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL "https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_$(lsb_release -rs)/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null

sudo apt update && sudo apt install -y variety dunst lm-sensors albert

# GTK
sudo apt install -y lxappearance arc-theme breeze-cursor-theme

# Qt theme
sudo add-apt-repository ppa:papirus/papirus
sudo apt install qt5ct qt5-style-kvantum qt5-style-kvantum-themes arc-kde

# Icon
git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/Programs/arc-icon-theme
cd ~/Programs/arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install

# Fonts
sudo apt install fonts-open-sans
fc-cache -f
