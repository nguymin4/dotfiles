#!/bin/bash

set -euo pipefail

help() {
    cat <<- EOF
Usage: bash install.sh [OPTIONS] --target \$target_folder
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

if [[ -z $TARGET_FOLDER || -z $TYPE ]] 
then
    help
    exit 1
fi

function run_rsync() {
  source_folder=$1
  rsync -avi $source_folder/ $TARGET_FOLDER
  echo "Synced dotfiles from $source_folder to $TARGET_FOLDER"
}

case $TYPE in
  linux)
    run_rsync dotfiles ;;
  vm)
    run_rsync dotfiles-vm ;;
  windows)
    run_rsync dotfiles-windows ;;
esac

