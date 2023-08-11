#!/bin/bash

set -euo pipefail

help() {
    cat << EOF
Usage: bash backup.sh [OPTIONS]
--help        Show this message
--linux
--mac
--vm
--windows
EOF
}

DOTFILES_ROOT="$(dirname $(realpath -s $0))"

function run_rsync() {
  rsync_file=$1
  rsync_file_path="$DOTFILES_ROOT/$rsync_file"
  target_folder="$DOTFILES_ROOT/$2"

  rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$rsync_file_path" $HOME $target_folder

  echo ""
  echo "Finished backing up $rsync_file to $target_folder"
  echo "================================================="
  echo ""
}

for opt in "$@"; do
  case $opt in
    --linux)
      run_rsync rsync-dotfiles-core dotfiles
      run_rsync rsync-dotfiles-linux dotfiles
      ;;
    --mac)
      run_rsync rsync-dotfiles-core dotfiles
      run_rsync rsync-dotfiles-mac dotfiles-mac
      ;;
    --vm)
      run_rsync rsync-dotfiles-vm dotfiles-vm ;;
    --windows)
      run_rsync rsync-dotfiles-core dotfiles
      run_rsync rsync-dotfiles-windows dotfiles-windows
      ;;
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
