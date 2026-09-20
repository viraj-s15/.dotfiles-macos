#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

sid="${NAME#space.}"
focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
window_count=$(aerospace list-windows --workspace "$sid" --format '%{window-id}' | sed '/^$/d' | wc -l | tr -d ' ')

if [ "$sid" = "$focused" ]; then
  highlight_offset=$(( 29 + (sid - 1) * 28 ))
  sketchybar --animate tanh 9 --set workspace.highlight \
    background.x_offset="$highlight_offset"
  # Let the capsule lead, then darken the destination shortly before arrival.
  sleep 0.10
  if [ "$(aerospace list-workspaces --focused)" = "$sid" ]; then
    sketchybar --set "$NAME" icon.color="$BLACK"
  fi
elif [ "$window_count" -gt 0 ]; then
  sketchybar --set "$NAME" icon.color="$WHITE"
else
  sketchybar --set "$NAME" icon.color="$GREY"
fi
