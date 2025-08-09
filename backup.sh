#!/bin/bash

set -euo pipefail

help() {
    cat << EOF
Usage: bash backup.sh [OPTIONS]
--help        Show this message
--linux
--mac
--windows
EOF
}

PLATFORM=""
for opt in "$@"; do
  case $opt in
    --linux|--mac|--windows)
      PLATFORM=$opt
      ;;
    --help)
      help
      exit 0
      ;;
    *)
      echo "Unknown option: $opt"
      help
      exit 1
      ;;
  esac
done

if [[ -z $PLATFORM ]]; then
  help
  exit 1
fi

# Execute syncing process
DOTFILES_ROOT=$(dirname "$(realpath "$0")")

function run_rsync() {
  rsync_file_path="$DOTFILES_ROOT/$1/rsync.conf"
  target_folder="$DOTFILES_ROOT/$1/dotfiles"

  rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$rsync_file_path" "$HOME" "$target_folder"

  echo ""
  echo "Finished backing up dotfiles to ${target_folder/$HOME/\~}"
  echo "========================================================="
  echo ""
}

case $PLATFORM in
  --linux)
    run_rsync shared
    run_rsync linux
    ;;
  --mac)
    run_rsync shared
    run_rsync mac
    ;;
  --windows)
    run_rsync shared
    run_rsync windows
    ;;
esac
