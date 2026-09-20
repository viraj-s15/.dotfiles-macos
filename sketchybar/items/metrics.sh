#!/bin/bash

system_metrics=(
  icon.drawing=off
  label="--%    --%"
  label.font="$FONT:Heavy:12.0"
  label.color=$BLUE
  label.align=center
  label.padding_left=10
  label.padding_right=10
  width=dynamic
  padding_left=0
  padding_right=0
  update_freq=3
  script="$PLUGIN_DIR/metrics.sh"
)

sketchybar --add item system_metrics right \
           --set system_metrics "${system_metrics[@]}"
