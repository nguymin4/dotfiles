#!/bin/bash

set -euo pipefail

help() {
    cat << EOF
Usage: bash backup.sh [OPTIONS] 
--help        Show this message
--linux
--vm
--windows
EOF
}

DOTFILES_ROOT="$(dirname $(realpath -s $0))"

function run_rsync() {
  rsync_list="$DOTFILES_ROOT/$1"
  target_folder="$DOTFILES_ROOT/$2"

  rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$rsync_list" $HOME $target_folder

  echo ""
  echo "---------------------------------------------------------------"
  echo "Finished syncing dotfiles from $HOME to $target_folder"
}

for opt in "$@"; do
  case $opt in
    --linux)
      run_rsync rsync-dotfiles dotfiles ;;
    --vm)
      run_rsync rsync-dotfiles-vm dotfiles-vm ;;
    --windows)
      run_rsync rsync-dotfiles-windows dotfiles-windows ;;
    --help)
      help
      exit 0
      ;;
    *)
      echo "unknown option: $opt"
      help
      exit 1
      ;;
  esac
done
