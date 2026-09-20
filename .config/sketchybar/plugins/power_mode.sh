#!/bin/bash

current_mode=$(pmset -g | awk '/powermode/ { print $2; exit }')

case "$current_mode" in
  0) next_mode=1 ;;
  1) next_mode=2 ;;
  *) next_mode=0 ;;
esac

if sudo -n /usr/local/libexec/sketchybar-power-mode "$next_mode"; then
  /opt/homebrew/bin/sketchybar --trigger power_mode_change
else
  osascript -e 'display notification "Power-mode helper is not installed" with title "SketchyBar"'
fi
