#!/bin/bash

privacy_item=(
  icon.font="$FONT:Bold:14.0"
  icon.color=$WHITE
  icon.align=center
  icon.width=30
  icon.padding_left=0
  icon.padding_right=0
  label.drawing=off
  width=30
  padding_left=0
  padding_right=0
  script="$PLUGIN_DIR/privacy.sh"
  update_freq=2
  updates=on
)

sketchybar --add item privacy_mic right \
           --set privacy_mic "${privacy_item[@]}" icon="􀊱" \
           --subscribe privacy_mic mouse.clicked \
           --add item privacy_camera right \
           --set privacy_camera "${privacy_item[@]}" icon="􀍊" update_freq=0 \
           --subscribe privacy_camera mouse.clicked \
           --add item privacy_screen right \
           --set privacy_screen "${privacy_item[@]}" icon="􀏜" update_freq=0 \
           --subscribe privacy_screen mouse.clicked
