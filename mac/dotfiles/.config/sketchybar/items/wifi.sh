#!/bin/bash

source "$CONFIG_DIR/icons.sh"

wifi=(
  icon="$WIFI_DISCONNECTED"
  label.width=0
  padding_right=0
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked
