#!/bin/bash

cpu_top=(
  icon.drawing=off
  label.font="$FONT:Semibold:7"
  label=CPU
  padding_right=15
  width=0
  y_offset=6
)

cpu_percent=(
  icon.drawing=off
  label.font="$FONT:Heavy:12"
  label=CPU
  mach_helper="$HELPER"
  padding_right=15
  update_freq=4
  width=55
  y_offset=-4
)

cpu_sys=(
  background.color=$TRANSPARENT
  background.drawing=on
  background.height=30
  graph.color=$RED
  graph.fill_color=$RED
  icon.drawing=off
  label.drawing=off
  width=0
)

cpu_user=(
  background.color=$TRANSPARENT
  background.drawing=on
  background.height=30
  graph.color=$BLUE
  icon.drawing=off
  label.drawing=off
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 75          \
           --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
           --add graph cpu.user right 75         \
           --set cpu.user "${cpu_user[@]}"