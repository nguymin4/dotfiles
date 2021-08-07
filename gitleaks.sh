#!/bin/bash

set -o errexit

TARGET_FOLDER=$(realpath -s ${1:-dotfiles})

docker pull zricethezav/gitleaks

docker run -v ${TARGET_FOLDER}:/dotfiles zricethezav/gitleaks:latest --path="/dotfiles" --no-git --verbose
