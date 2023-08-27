#!/bin/bash

set -euo pipefail

help() {
    cat <<- EOF
Usage: bash restore.sh [OPTIONS] [TARGET_FOLDER]
--help        Show this message
--linux
--mac
--vm
--windows
EOF
}

PLATFORM=''
while getopts ':-:' flag; do
  case "${flag}" in
    -)
      case "${OPTARG}" in
        linux|mac|vm|windows)
          PLATFORM=$OPTARG
          ;;
        help)
          help
          exit 0
          ;;
      esac;;
    *)
      echo "Unknown option: $flag"
      help
      exit 1
      ;;
  esac
done

# Last args
shift $((OPTIND - 1))
TARGET_FOLDER="$*"

if [[ -z $PLATFORM || $# -gt 1 ]]; then
  help
  exit 1
fi

# Execute syncing process
TARGET_FOLDER="${TARGET_FOLDER:-$HOME}"
DOTFILES_ROOT=$(dirname "$(realpath "$0")")

function run_rsync() {
  rsync_file_path="$DOTFILES_ROOT/$1/rsync.conf"
  source_folder="$DOTFILES_ROOT/$1/dotfiles"

  rsync -avi --recursive --relative --exclude='*.swp' --files-from="$rsync_file_path" "$source_folder" "$TARGET_FOLDER"

  echo ""
  echo "Finished restoring ${source_folder/$HOME/\~} to $TARGET_FOLDER"
  echo "==============================================================="
  echo ""
}

case $PLATFORM in
  linux)
    run_rsync shared
    run_rsync linux
    ;;
  mac)
    run_rsync shared
    run_rsync mac
    ;;
  vm)
    run_rsync vm
    ;;
  windows)
    run_rsync shared
    run_rsync windows
    ;;
esac
