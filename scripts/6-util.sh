#!/bin/bash

set -euo pipefail

# google-chrome, vscode, slack, viber, postman, robomongo
sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository -y ppa:mmstick76/alacritty
sudo add-apt-repository ppa:peek-developers/stable
sudo apt install -y ibus-bamboo neofetch postgresql-client vlc pinta cmus piper

ibus restart

# juliaup
curl -fsSL https://install.julialang.org | sh

# tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* ~/.local/bin

# PgAdmin4
# curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
# sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
# sudo apt install -y pgadmin4

# Heroku
# curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
# heroku plugins:install heroku-accounts
