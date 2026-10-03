#!/bin/bash

# Night Shift toggle - event-driven, no polling
# Updates on: click, system_woke, initial load

nightshift_icon=(
  script="$PLUGIN_DIR/nightshift.sh"
  updates=on
  icon=$NIGHTSHIFT_OFF
  icon.color=$YELLOW
  icon.font="$FONT:Regular:15.0"
  padding_left=6
  padding_right=6
  label.drawing=off
)

sketchybar --add item nightshift right \
           --set nightshift "${nightshift_icon[@]}" \
           --subscribe nightshift mouse.clicked system_woke
