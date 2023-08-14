#!/bin/bash

SPACE_ICONS=(
  "1: "
  "2: "
  "3: "
  "4: "
  "5: "
  "6: 󰦨"
)

for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i+1))
  space=(
    associated_space=$sid
    background.border_color=$BACKGROUND_2
    background.color=$BACKGROUND_1
    background.drawing=off
    click_script="skhd -k 'alt - $sid'"
    icon.highlight_color=$GREEN
    icon.padding_left=10
    icon.padding_right=10
    icon="${SPACE_ICONS[i]}"
    label.color=$GREY
    label.drawing=off
    label.font="$FONT:Regular:14.0"
    label.highlight_color=$WHITE
    label.padding_right=20
    label.y_offset=-1
    padding_left=2
    padding_right=2
    script="$PLUGIN_DIR/spaces.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked
done
