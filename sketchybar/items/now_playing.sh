#!/bin/bash

now_playing=(
  drawing=off
  icon="􀊆"
  icon.font="$FONT:Bold:13.0"
  icon.color=$BLUE
  icon.padding_left=7
  icon.padding_right=6
  label.drawing=on
  label.font="$FONT:Semibold:12.0"
  label.padding_left=0
  label.padding_right=7
  width=168
  padding_left=0
  padding_right=0
  update_freq=3
  updates=on
  script="$PLUGIN_DIR/now_playing.sh"
)

sketchybar --add item now_playing left \
           --set now_playing "${now_playing[@]}"
