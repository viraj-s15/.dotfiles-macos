#!/bin/bash

memory=(
  label="--%"
  label.font="$FONT:Heavy:12"
  label.color=$MAGENTA
  icon.drawing=off
  padding_left=4
  padding_right=6
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
           --set memory "${memory[@]}"
