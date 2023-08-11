#!/bin/bash

set -euo pipefail

sudo apt install -y libevent-dev libncurses-dev byacc

rm -rf ~/Programs/tmux && git clone https://github.com/tmux/tmux.git ~/Programs/tmux

cd ~/Programs/tmux
git checkout `git describe --abbrev=0 --tags --match "[0-9]*" $(git rev-list --tags --max-count=1)`
sh autogen.sh && ./configure && make
sudo make install

# tpm - plugin manager
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# powerline-status
pip install --user git+https://github.com/powerline/powerline

# tmuxp
pip install --user tmuxp
