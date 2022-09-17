#!/bin/bash

set -euo pipefail

# nvm
rm -rf ~/.nvm && git clone https://github.com/nvm-sh/nvm.git ~/.nvm
zsh -c "source ~/.zshrc && nvm install --lts && npm install -g yarn"

# pyenv
rm -rf ~/.pyenv && git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
[[ ! $(grep 'PYENV' ~/.zprofile) ]] && cat <<-'EOH' >> ~/.zprofile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
[ -s "$PYENV_ROOT/bin/pyenv" ] && eval "$(pyenv init --path)"
EOH

# juliaup
curl -fsSL https://install.julialang.org | sh

# tfenv
rm -rf ~/.tfenv && git clone https://github.com/tfutils/tfenv.git ~/.tfenv
ln -s ~/.tfenv/bin/* ~/.local/bin

# PgAdmin4
# curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add -
# sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
# sudo apt install -y pgadmin4

# Heroku
# curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
# heroku plugins:install heroku-accounts
