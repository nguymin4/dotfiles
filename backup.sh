#!/bin/bash

set -o errexit

SOURCE_FOLDER=$HOME
TARGET_FOLDER=$(realpath -s ${1:-dotfiles})
RSYNC_LIST="$(dirname $(realpath -s $0))/rsync-dotfiles"

rsync -avi --recursive --relative --delete --exclude='*.swp' --files-from="$RSYNC_LIST" $SOURCE_FOLDER $TARGET_FOLDER

echo ""
echo "---------------------------------------------------------------"
echo "Finished syncing dotfiles from $SOURCE_FOLDER to $TARGET_FOLDER"
