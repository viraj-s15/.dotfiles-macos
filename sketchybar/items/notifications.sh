#!/bin/bash

notifications=(
  icon=$BELL
  icon.font="$FONT:Bold:15.0"
  icon.color=$BLUE
  icon.padding_left=0
  icon.padding_right=0
  label.drawing=off
  padding_left=6
  padding_right=6
  click_script="$PLUGIN_DIR/notification_center.sh"
)

sketchybar --add item notifications right \
           --set notifications "${notifications[@]}"
