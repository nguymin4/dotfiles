#!/bin/bash

set -euo pipefail

print_usage() {
    echo 'Usage: bash install.sh [--src $source_folder] --target $target_folder'
    exit 1
}

SRC_FOLDER='dotfiles'
TARGET_FOLDER=''

while getopts ':-:' flag; do
  case "${flag}" in
    -)
      case "${OPTARG}" in
        src)
          SRC_FOLDER="${!OPTIND}";
          OPTIND=$(( $OPTIND + 1 ))
          ;;
        target)
          TARGET_FOLDER="${!OPTIND}";
          OPTIND=$(( $OPTIND + 1 ))
          ;;
      esac;;
    *) print_usage ;;
  esac
done

if [ ! "$TARGET_FOLDER" ]
then
    print_usage
fi

rsync -avi $SRC_FOLDER/ $TARGET_FOLDER
echo "Synced dotfiles from $SRC_FOLDER to $TARGET_FOLDER"
