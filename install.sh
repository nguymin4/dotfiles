#!/bin/bash

set -euo pipefail

help() {
    cat <<- EOF
Usage: bash install.sh [OPTIONS] --target [\$target_folder]
--help        Show this message
--linux
--mac
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
        linux|mac|vm|windows)
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
  rsync_file_path="$DOTFILES_ROOT/$1/rsync.conf"
  source_folder="$DOTFILES_ROOT/$1/dotfiles"

  rsync -avi --recursive --relative --exclude='*.swp' --files-from="$rsync_file_path" $source_folder $TARGET_FOLDER

  echo ""
  echo "Finished installing ${source_folder/$HOME/\~} to $TARGET_FOLDER"
  echo "==============================================================="
  echo ""
}

case $TYPE in
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

