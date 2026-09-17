#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  icon.font="$FONT:Regular:19.0"
  icon.padding_right=4
  label.drawing=on
  label.padding_left=0
  padding_right=6
  padding_left=6
  update_freq=60
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
