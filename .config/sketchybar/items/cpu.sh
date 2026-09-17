#!/bin/bash

cpu_percent=(
  label="--%"
  label.font="$FONT:Heavy:12"
  label.color=$BLUE
  icon.drawing=off
  padding_left=6
  padding_right=10
  update_freq=2
  updates=on
  script="$PLUGIN_DIR/cpu.sh"
)

sketchybar --add item cpu.percent right \
           --set cpu.percent "${cpu_percent[@]}"
