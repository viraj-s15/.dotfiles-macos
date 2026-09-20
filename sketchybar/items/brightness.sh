#!/bin/bash

brightness_slider=(
  script="$PLUGIN_DIR/brightness.sh"
  update_freq=10
  updates=on
  label.drawing=off
  icon.drawing=off
  slider.width=0
  slider.highlight_color=$YELLOW
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=􀀁
  slider.knob.drawing=off
)

brightness_icon=(
  click_script="$PLUGIN_DIR/brightness_click.sh"
  icon=$BRIGHTNESS
  icon.color=$YELLOW
  icon.font="$FONT:Regular:15.0"
  padding_left=10
  padding_right=6
  label.drawing=off
)

sketchybar --add slider brightness right \
           --set brightness "${brightness_slider[@]}" \
           --subscribe brightness mouse.clicked mouse.entered mouse.exited system_woke \
           --add item brightness.icon right \
           --set brightness.icon "${brightness_icon[@]}"
