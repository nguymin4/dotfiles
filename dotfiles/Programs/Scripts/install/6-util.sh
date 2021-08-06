#!/bin/bash

set -o errexit

# PgAdmin4
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Heroku
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
heroku plugins:install heroku-accounts

sudo add-apt-repository -y ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository -y ppa:mmstick76/alacritty
sudo add-apt-repository ppa:peek-developers/stable
sudo apt install -y ibus-bamboo neofetch postgresql-client pgadmin4 vlc pinta alacritty cmus

ibus restart

# google-chrome, vscode, slack, viber, postman, robomongo
