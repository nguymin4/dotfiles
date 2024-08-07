#!/bin/bash

set -euo pipefail

brew install tmux tmuxinator

# tpm - plugin manager
rm -rf ~/.tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh
