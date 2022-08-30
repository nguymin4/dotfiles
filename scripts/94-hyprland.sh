#!/bin/bash

set -euo pipefail

cmd=$1
source_folder=${2:-~/Downloads/hyprland}
libxcb_errors_folder=~/Programs/libxcb-errors

function remove_if_exist() {
  file_path=$1
  if [ -f $file_path ]; then
    sudo rm -v $file_path
  else
    echo "File $file_path not found."
  fi
}

function install_libxcb_errors() {
  echo 'Installing libxcb-errors...'
  ORIGDIR=`pwd`
  sudo apt install -y xutils-dev xcb-proto
  if [ ! -d $libxcb_errors_folder ]; then
    git clone https://gitlab.freedesktop.org/xorg/lib/libxcb-errors --recursive $libxcb_errors_folder
  fi
  cd $libxcb_errors_folder
  ./autogen.sh --prefix=/usr
  sudo make install
  cd $ORIGDIR
  echo 'Installed libxcb-errors.'
}

function uninstall_libxcb_errors() {
  echo 'Uninstalling libxcb-errors...'
  ORIGDIR=`pwd`
  if [ -d $libxcb_errors_folder ]; then
    cd $libxcb_errors_folder
    sudo make uninstall
  else
    echo 'libxcb-errors folder not found. Require manual uninstallation.'
  fi
  sudo apt purge -y xutils-dev xcb-proto
  cd $ORIGDIR
  echo 'Uninstalled libxcb-errors.'
}

case "$cmd" in
  install)
    echo "Installing from $source_folder..."
    install_libxcb_errors
    if [ -d $source_folder ];
    then
      sudo cp -v $source_folder/Hyprland /usr/bin/
      sudo cp -v $source_folder/hyprctl /usr/bin/
      sudo cp -v $source_folder/libwlroots.so.11032 /usr/lib/
      sudo cp -v $source_folder/example/hyprland.desktop /usr/share/wayland-sessions/
      if [ ! -f ~/.config/hypr/hyprland.conf ]; then
        mkdir -p ~/.config/hypr
        cp -v $source_folder/example/hyprland.conf ~/.config/hyprland/
      else
        echo 'Skipped copying default configuration.'
      fi
    else
      echo "Installation files in '${source_folder}' not found."
    fi
    ;;
  uninstall)
    echo 'Uninstalling...'
    uninstall_libxcb_errors
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
