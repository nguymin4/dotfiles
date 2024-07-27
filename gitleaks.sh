#!/bin/bash

set -o errexit

DOTFILES_ROOT=$(dirname "$(realpath "$0")")
TARGET_FOLDER=$(realpath "${1:-$DOTFILES_ROOT}")

gitleaks detect --source "$TARGET_FOLDER" --verbose --redact
