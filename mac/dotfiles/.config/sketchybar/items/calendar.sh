#!/bin/bash

calendar=(
  icon.font="$FONT:Black:14.0"
  icon.padding_right=0
  icon=cal
  label.align=right
  label.width=45
  padding_left=15
  script="$PLUGIN_DIR/calendar.sh"
  update_freq=30
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
