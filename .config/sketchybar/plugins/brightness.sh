#!/bin/bash

HELPER="$HOME/.config/sketchybar/helper/brightnessctl"

update() {
  percentage=$($HELPER get 2>/dev/null) || exit 0
  sketchybar --set brightness slider.percentage="$percentage"
}

set_brightness() {
  $HELPER set "$PERCENTAGE" >/dev/null 2>&1 || exit 0
  sketchybar --set brightness slider.percentage="$PERCENTAGE"
}

case "$SENDER" in
  "mouse.clicked") set_brightness ;;
  "mouse.entered") sketchybar --set "$NAME" slider.knob.drawing=on ;;
  "mouse.exited") sketchybar --set "$NAME" slider.knob.drawing=off ;;
  *) update ;;
esac
