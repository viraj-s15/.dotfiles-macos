#!/bin/bash

front_app=(
  script='app_icon=$("$HOME/.config/sketchybar/plugins/icon_map.sh" "$INFO"); sketchybar --set "$NAME" icon="$app_icon"'
  icon.drawing=on
  icon.font="sketchybar-app-font:Regular:16.0"
  icon.color=$WHITE
  icon.padding_left=6
  icon.padding_right=6
  label.drawing=off
  associated_display=active
)

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
