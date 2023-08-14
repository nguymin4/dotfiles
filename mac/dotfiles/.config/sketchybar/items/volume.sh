#!/bin/bash

volume_slider=(
  icon.drawing=off
  label.drawing=off
  script="$PLUGIN_DIR/volume.sh"
  slider.background.color=$BACKGROUND_2
  slider.background.corner_radius=3
  slider.background.height=5
  slider.highlight_color=$BLUE
  slider.knob.drawing=off
  slider.knob=
  updates=on
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  icon.align=left
  icon.color=$GREY
  icon.font="$FONT:Regular:14.0"
  icon.width=0
  icon=$VOLUME_100
  label.align=left
  label.font="$FONT:Regular:14.0"
  label.width=25
  padding_left=10
)
status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
                              mouse.entered     \
                              mouse.exited      \
                                                \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"

sketchybar --add bracket status brew github.bell volume_icon \
           --set status "${status_bracket[@]}"
