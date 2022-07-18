#!/bin/bash

set -euo pipefail

print_usage() {
    echo 'Usage: bash backup.sh [--config $config_file] --target $target_folder'
    exit 1
}

CONFIG_FILE='rsync-dotfiles'
TARGET_FOLDER='dotfiles'

while getopts ':-:' flag; do
  case "${flag}" in
    -)
      case "${OPTARG}" in
        config)
          CONFIG_FILE="${!OPTIND}";
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

SOURCE_FOLDER=$HOME
TARGET_FOLDER=$(realpath -s $TARGET_FOLDER)
RSYNC_LIST="$(dirname $(realpath -s $0))/$CONFIG_FILE"

rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$RSYNC_LIST" $SOURCE_FOLDER $TARGET_FOLDER

echo ""
echo "---------------------------------------------------------------"
echo "Finished syncing dotfiles from $SOURCE_FOLDER to $TARGET_FOLDER"
