#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

sid="${NAME#space.}"
focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
window_count=$(aerospace list-windows --workspace "$sid" --format '%{window-id}' | sed '/^$/d' | wc -l | tr -d ' ')

if [ "$sid" = "$focused" ]; then
  icon_color=$BLACK
  background_drawing=on
elif [ "$window_count" -gt 0 ]; then
  icon_color=$WHITE
  background_drawing=off
else
  icon_color=$GREY
  background_drawing=off
fi

sketchybar --animate tanh 12 --set "$NAME" \
  icon.color="$icon_color" \
  background.drawing="$background_drawing"
