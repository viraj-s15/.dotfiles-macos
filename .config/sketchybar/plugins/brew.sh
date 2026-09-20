#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

COUNT=$(/opt/homebrew/bin/brew outdated | wc -l | tr -d ' ')

if [ "$COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ "$COUNT" -lt 10 ]; then
  COLOR=$WHITE
elif [ "$COUNT" -lt 30 ]; then
  COLOR=$YELLOW
else
  COLOR=$ORANGE
fi

sketchybar --set "$NAME" drawing=on label="$COUNT" icon.color="$COLOR"
