#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

if [ "$1" = "toggle" ]; then
  shortcuts run "SketchyBar Toggle DND" >/dev/null 2>&1 || exit 1
  sketchybar --trigger focus_change
  exit 0
fi

focus="$(shortcuts run "SketchyBar Focus Status" 2>/dev/null)"
if [ "$focus" = "Do Not Disturb" ]; then
  sketchybar --set focus.mode icon="$FOCUS_ON" icon.color="$MAGENTA"
else
  sketchybar --set focus.mode icon="$FOCUS_OFF" icon.color="$WHITE"
fi
