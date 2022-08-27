#!/bin/bash

set -euo pipefail

# https://wiki.archlinux.org/title/SDDM
sudo apt install --no-install-recommends -y sddm qml-module-qtquick-layouts qml-module-qtgraphicaleffects qml-module-qtquick-controls2 libqt5svg5 gstreamer1.0-libav qml-module-qtmultimedia libqt5multimedia5-plugins

# Setup sugar-candy theme
if [ -d /usr/share/sddm/themes/sugar-candy ];
then
  cd /usr/share/sddm/themes/sugar-candy
  sudo git pull
else
  sudo git clone --depth=1 https://github.com/nguymin4/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy
fi

sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/sddm.conf > /dev/null <<- 'EOH'
[General]
EnableHiDPI=true

[Theme]
Current=sugar-candy
CursorTheme=Breeze_Snow

[X11]
SessionDir=/usr/local/share/xsessions
EOH
