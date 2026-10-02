#!/bin/bash

set -euo pipefail

# https://wiki.archlinux.org/title/SDDM
sudo apt install --no-install-recommends -y \
  sddm \
  qml-module-qtgraphicaleffects \
  qml-module-qtmultimedia \
  qml-module-qtquick-controls2 \
  qml-module-qtquick-layouts \
  qml6-module-qtquick-effects \
  qml6-module-qtquick-controls \
  qml6-module-qtquick-layouts \
  qml6-module-qtquick-templates \
  qml6-module-qtquick-window

# Setup sugar-candy theme
sudo rm -rf /usr/share/sddm/themes/sugar-candy
sudo git clone --depth=1 https://github.com/nguymin4/sddm-sugar-candy.git /usr/share/sddm/themes/sugar-candy

# Testing theme
# sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sugar-candy

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
