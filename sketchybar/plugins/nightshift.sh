#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

update_icon() {
  status=$(nightlight status 2>/dev/null)
  if [ "$status" = "on" ]; then
    sketchybar --set "$NAME" icon="$NIGHTSHIFT_ON" icon.color=$ORANGE
  else
    sketchybar --set "$NAME" icon="$NIGHTSHIFT_OFF" icon.color=$YELLOW
  fi
}

toggle() {
  nightlight toggle >/dev/null 2>&1
  update_icon
}

case "$SENDER" in
  "mouse.clicked") toggle ;;
  *) update_icon ;;
esac
