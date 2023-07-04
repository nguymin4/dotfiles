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
sudo apt install -y build-essential autoconf automake cmake git curl python3-dev python3-pip ruby-dev gem alacritty htop nmap

if [ -f /usr/bin/python3 ]
then
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
fi

# Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $(whoami)
