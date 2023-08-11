#!/bin/bash

set -euo pipefail

# Command Line Tools (CLT) for Xcode
xcode-select --install

# Install homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
