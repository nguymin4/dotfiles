#!/bin/bash

sudo apt install -y libevent-dev libncurses-dev byacc

rm -rf ~/Programs/tmux && git clone https://github.com/tmux/tmux.git ~/Programs/tmux

cd ~/Programs/tmux
git checkout $(git tag | egrep '^[0-9]' | sort | tail -n 1)
sh autogen.sh && ./configure && make
sudo make install

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

pip3 install -U powerline-status

gem install --user-install tmuxinator