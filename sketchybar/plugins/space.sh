#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

sid="${NAME#space.}"
focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
window_count=$(aerospace list-windows --workspace "$sid" --format '%{window-id}' | sed '/^$/d' | wc -l | tr -d ' ')

if [ "$sid" = "$focused" ]; then
  sketchybar --animate tanh 10 --set "$NAME" \
    background.color="$MAGENTA" icon.color="$BLACK"
elif [ "$window_count" -gt 0 ]; then
  sketchybar --animate tanh 10 --set "$NAME" \
    background.color="$TRANSPARENT" icon.color="$WHITE"
else
  sketchybar --animate tanh 10 --set "$NAME" \
    background.color="$TRANSPARENT" icon.color="$GREY"
fi
