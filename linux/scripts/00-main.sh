#!/bin/bash

set -euo pipefail

# Enable firewall
if [[ $(uname -a) =~ (microsoft|WSL) ]]; then
  echo "Skip enabling firewall in WSL"
else
  echo "Enabling firewall"
  sudo ufw enable
fi

# Install core dependencies
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:aslatter/ppa
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y build-essential autoconf automake cmake git git-filter-repo git-lfs curl python3-dev python3-pip alacritty htop nmap

if [ -f /usr/bin/python3 ]
then
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
fi

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install fastfetch jq nnn tig
