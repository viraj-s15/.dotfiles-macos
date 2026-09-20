#!/bin/bash

focus_mode=(
  icon="$FOCUS_OFF"
  icon.font="$FONT:Bold:15.0"
  icon.padding_left=0
  icon.padding_right=0
  label.drawing=off
  padding_left=6
  padding_right=6
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/focus.sh"
  click_script="$PLUGIN_DIR/focus.sh toggle"
)

sketchybar --add event focus_change \
           --add item focus.mode right \
           --set focus.mode "${focus_mode[@]}" \
           --subscribe focus.mode focus_change system_woke
