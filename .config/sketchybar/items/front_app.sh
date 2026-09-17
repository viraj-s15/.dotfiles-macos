#!/bin/bash

front_app=(
  script='sketchybar --set "$NAME" label="$INFO"'
  icon.drawing=off
  padding_left=0
  padding_right=0
  label.padding_right=0
  label.max_chars=16
  label.color=$WHITE
  label.font="$FONT:Black:12.0"
  associated_display=active
)

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
