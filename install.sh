#!/bin/bash

set -o errexit

if [ -z $1 ]; then
  echo "Error: Missing target folder"
  exit 1
else
  rsync -avi dotfiles/ $1
fi
