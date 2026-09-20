#!/bin/bash

calendar=(
  icon=cal
  icon.font="$FONT:Black:12.0"
  icon.padding_left=0
  icon.padding_right=6
  label.width=38
  label.align=right
  label.padding_left=6
  label.padding_right=0
  padding_left=6
  padding_right=6
  update_freq=30
  script="$PLUGIN_DIR/calendar.sh"
  click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right       \
           --set calendar "${calendar[@]}" \
           --subscribe calendar system_woke
