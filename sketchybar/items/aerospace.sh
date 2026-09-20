#!/bin/bash

aerospace_layout=(
  icon=$YABAI_GRID
  icon.font="$FONT:Bold:16.0"
  icon.width=30
  icon.color=$ORANGE
  label.drawing=off
  padding_left=2
  padding_right=4
  associated_display=active
  click_script="aerospace layout tiles horizontal vertical"
)

sketchybar --add item aerospace.layout left \
           --set aerospace.layout "${aerospace_layout[@]}"
