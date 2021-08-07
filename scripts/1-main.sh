#!/bin/bash

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y build-essential autoconf automake cmake git curl python3-dev python3-pip ruby-dev gem xclip ack htop nmap ranger tig rxvt-unicode docker.io

# Experimental
sudo apt install fd-find bat
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin --completion --key-bindings

DOCKER_COMPOSER_VERSION=$(curl -s 'https://github.com/docker/compose/tags' | grep -w releases | grep -o '[0-9]\.[0-9]*\.[0-9-]*' | grep -v - | head -n 1)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSER_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo usermod -aG docker $(whoami)
