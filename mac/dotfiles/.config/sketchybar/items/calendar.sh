#!/bin/bash

calendar=(
  icon.font="$FONT:Regular:14.0"
  icon.padding_right=0
  label.font="$FONT:Regular:14.0"
  label.align=right
  label.width=45
  padding_left=15
  script="$PLUGIN_DIR/calendar.sh"
  update_freq=30
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
