#!/bin/bash

set -euo pipefail

# Dependencies
sudo apt install -y ninja-build meson libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

# i3-gaps
sudo apt install -y --no-install-recommends i3status i3blocks
git clone https://github.com/Airblader/i3.git ~/Programs/i3
cd ~/Programs/i3
mkdir -p build && cd build
meson ..
ninja
sudo meson install
chmod u+x -R ~/.config/i3/blocks


# Icon
git clone https://github.com/horst3180/arc-icon-theme --depth 1 ~/Programs/arc-icon-theme
cd ~/Programs/arc-icon-theme
./autogen.sh --prefix=/usr
sudo make install
fc-cache -f

# Albert launcher
curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_$(lsb_release -rs)/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_$(lsb_release -rs)/Release.key -O - | sudo apt-key add

sudo apt update && sudo apt install -y lxappearance arc-theme breeze-cursor-theme compton feh variety dunst xbacklight xautolock gnome-screensaver lm-sensors albert thunar thunar-archive-plugin acpi sysstat

