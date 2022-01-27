#!/bin/bash

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y build-essential autoconf automake cmake git curl python3-dev python3-pip ruby-dev gem xclip ack htop nmap ranger tig rxvt-unicode docker.io libnss3-tools alacritty ministat 

function get_latest_tag_from_github() {
  GITHUB_REPO_URL="https://github.com/$1"
  curl -s "${GITHUB_REPO_URL}/tags" | grep -w releases | grep -o '[0-9]\.[0-9]*\.[0-9-]*' | grep -v - | head -n 1
}

# Docker
sudo usermod -aG docker $(whoami)
DOCKER_COMPOSE_VERSION=$(get_latest_tag_from_github 'docker/compose')
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64" -o ~/.local/bin/docker-compose
chmod u+x ~/.local/bin/docker-compose

# mkcert
MKCERT_VERSION=$(get_latest_tag_from_github 'FiloSottile/mkcert')
curl -L "https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64" -o ~/.local/bin/mkcert
sudo chmod u+x ~/.local/bin/mkcert
~/.local/bin/mkcert install

# Enable firewall
sudo ufw enable
