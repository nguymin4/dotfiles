#!/bin/bash

set -euo pipefail

cmd=$1
source_folder=${2:-~/Downloads/hyprland}

function remove_if_exist() {
  file_path=$1
  if [ -f $file_path ];
  then
    sudo rm -v $file_path
  fi
}

case "$cmd" in
  install)
    echo "Installing from $source_folder..."
    if [ -d $source_folder ];
    then
      sudo cp -v $source_folder/Hyprland /usr/bin/ 
      sudo cp -v $source_folder/hyprctl /usr/bin/
      sudo cp -v $source_folder/libwlroots.so.11032 /usr/lib/
      sudo cp -v $source_folder/example/hyprland.desktop /usr/share/wayland-sessions/
      if [ ! -f ~/.config/hyprland/hyprland.conf ];
      then
        mkdir -p ~/.config/hyprland
        cp -v $source_folder/example/hyprland.conf ~/.config/hyprland/
      fi
    else
      echo "Installation files in '${source_folder}' not found."
    fi
    ;;
  uninstall)
    echo 'Uninstalling...'
    remove_if_exist /usr/bin/Hyprland
    remove_if_exist /usr/bin/hyprctl
    remove_if_exist /usr/lib/libwlroots.so.11032
    remove_if_exist /usr/share/wayland-sessions/hyprland.desktop
    echo 'Finished uninstalling Hyprland. Local config was untouched.'
    ;;
  *)
    echo 'Usage: <command> [<source_folder>]'
    echo 'Supported commands are: install, uninstall'
    exit 1
    ;;
esac
