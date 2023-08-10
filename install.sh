#!/bin/bash

set -euo pipefail

help() {
    cat <<- EOF
Usage: bash install.sh [OPTIONS] --target [\$target_folder]
--help        Show this message
--linux
--vm
--windows
EOF
}

TYPE=''
TARGET_FOLDER=''

while getopts ':-:' flag; do
  case "${flag}" in
    -)
      case "${OPTARG}" in
        linux|vm|windows)
          TYPE=$OPTARG
          ;;
        target)
          TARGET_FOLDER="${!OPTIND}";
          OPTIND=$(( $OPTIND + 1 ))
          ;;
        help)
          help
          exit 0
          ;;
      esac;;
    *)
      echo "unknown option: $flag"
      help
      exit 1
      ;;
  esac
done

if [[ -z $TYPE ]]; then
  help
  exit 1
fi

TARGET_FOLDER="${TARGET_FOLDER:-$HOME}"
DOTFILES_ROOT="$(dirname $(realpath -s $0))"

function run_rsync() {
  rsync_list="$DOTFILES_ROOT/$1"
  source_folder="$DOTFILES_ROOT/$2"

  rsync -avi --recursive --relative --exclude='*.swp' --files-from="$rsync_list" $source_folder $TARGET_FOLDER

  echo ""
  echo "Finished syncing dotfiles from $source_folder to $TARGET_FOLDER"
  echo "==============================================================="
  echo ""
}

case $TYPE in
  linux)
    run_rsync rsync-dotfiles-core dotfiles
    run_rsync rsync-dotfiles-linux dotfiles
    ;;
  vm)
    run_rsync rsync-dotfiles-vm dotfiles-vm
    ;;
  windows)
    run_rsync rsync-dotfiles-core dotfiles
    run_rsync rsync-dotfiles-windows dotfiles-windows
    ;;
  *)
    echo "unknown type: $TYPE"
    help
    exit 1
    ;;
esac

