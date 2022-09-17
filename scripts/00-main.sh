#!/bin/bash

set -euo pipefail

# Enable firewall
sudo ufw enable

sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:aslatter/ppa
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y build-essential autoconf automake cmake git curl python3-dev python3-pip ruby-dev gem alacritty htop nmap

function get_latest_tag_from_github() {
  GITHUB_REPO_URL="https://github.com/$1"
  curl -s "${GITHUB_REPO_URL}/tags" | grep -w releases | grep -o '[0-9]\.[0-9]*\.[0-9-]*' | grep -v - | head -n 1
}

# Docker
sudo apt install -y docker.io
sudo usermod -aG docker $(whoami)

# docker-compose
DOCKER_COMPOSE_VERSION=$(get_latest_tag_from_github 'docker/compose')
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-Linux-x86_64" -o ~/.local/bin/docker-compose
chmod u+x ~/.local/bin/docker-compose

# mkcert
sudo apt install -y libnss3-tools
MKCERT_VERSION=$(get_latest_tag_from_github 'FiloSottile/mkcert')
curl -L "https://github.com/FiloSottile/mkcert/releases/download/v${MKCERT_VERSION}/mkcert-v${MKCERT_VERSION}-linux-amd64" -o ~/.local/bin/mkcert
sudo chmod u+x ~/.local/bin/mkcert
# ~/.local/bin/mkcert install
