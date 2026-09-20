#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

STATE_FILE="$HOME/Library/Caches/sketchybar-focus-state"

if [ "$1" = "toggle" ]; then
  osascript -e 'tell application "System Events" to key code 97' >/dev/null 2>&1 || exit 1

  if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "on" ]; then
    printf 'off\n' > "$STATE_FILE"
  else
    printf 'on\n' > "$STATE_FILE"
  fi

  sketchybar --trigger focus_change
  exit 0
fi

if [ "$(cat "$STATE_FILE" 2>/dev/null)" = "on" ]; then
  sketchybar --set focus.mode icon="$FOCUS_ON" icon.color="$MAGENTA"
else
  sketchybar --set focus.mode icon="$FOCUS_OFF" icon.color="$GREY"
fi
