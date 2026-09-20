#!/bin/bash

notifications=(
  icon=$BELL
  icon.font="$FONT:Bold:15.0"
  icon.color=$BLUE
  label.drawing=off
  padding_left=8
  padding_right=8
  click_script="$PLUGIN_DIR/notification_center.sh"
)

sketchybar --add item notifications right \
           --set notifications "${notifications[@]}"
