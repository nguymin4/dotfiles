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
  rsync_file_path="$DOTFILES_ROOT/$1/rsync.conf"
  target_folder="$DOTFILES_ROOT/$1/dotfiles"

  rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$rsync_file_path" $HOME $target_folder

  echo ""
  echo "Finished backing up dotfiles to ${target_folder/$HOME/\~}"
  echo "========================================================="
  echo ""
}

for opt in "$@"; do
  case $opt in
    --linux)
      run_rsync shared
      run_rsync linux
      ;;
    --mac)
      run_rsync shared
      run_rsync mac
      ;;
    --vm)
      run_rsync vm
      ;;
    --windows)
      run_rsync shared
      run_rsync windows
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
