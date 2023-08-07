#!/bin/bash

set -euo pipefail

brew install tmux tmuxp

# tpm - plugin manager
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# powerline-status
pip install --user git+https://github.com/powerline/powerline
