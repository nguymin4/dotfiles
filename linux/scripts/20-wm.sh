#!/bin/bash

set -euo pipefail

# Allow GUI application authentication as root
sudo apt install -y lxpolkit libcanberra-gtk-module

# Core utils
sudo apt install -y dunst lm-sensors variety vlc

# Optional utils
# google-chrome, vscode, slack
# cmus, ministat, pinta, piper, youtubedl-gui

# Albert launcher
albert_repo_url="http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$(lsb_release -rs)"
echo "deb ${albert_repo_url}/ /" | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL "${albert_repo_url}/Release.key" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt update && sudo apt install -y albert

# thunar
sudo apt install -y thunar thunar-archive-plugin
xdg-mime default thunar.desktop inode/directory

# GTK theme
sudo apt install -y lxappearance arc-theme breeze-cursor-theme

# QT theme
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt install -y qt5ct qt5-style-kvantum qt5-style-kvantum-themes arc-kde

# Icon
rm -rf ~/Programs/arc-icon-theme && git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/Programs/arc-icon-theme
cd ~/Programs/arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install

# brightnessctl
sudo apt install -y brightnessctl
sudo usermod -aG video "$(whoami)"
