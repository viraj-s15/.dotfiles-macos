#!/bin/bash

HELPER="$CONFIG_DIR/helper/notification-center"
STATE_FILE="${TMPDIR:-/tmp}/sketchybar-notification-center-open"

# Clicking SketchyBar already dismisses an open Notification Center. Avoid
# toggling it open again after that native outside click.
if [ -f "$STATE_FILE" ]; then
  rm -f "$STATE_FILE"
  exit 0
fi

if [ -x "$HELPER" ]; then
  "$HELPER"
  touch "$STATE_FILE"

  # Clear stale state when Notification Center is dismissed some other way.
  (
    sleep 1
    while [ -f "$STATE_FILE" ]; do
      window_count=$(osascript -e 'tell application "System Events" to tell process "NotificationCenter" to get count of windows' 2>/dev/null || echo 0)
      [ "$window_count" -gt 0 ] || {
        rm -f "$STATE_FILE"
        break
      }
      sleep 0.25
    done
  ) >/dev/null 2>&1 &
else
  osascript -e 'display notification "Notification Center helper is missing" with title "SketchyBar"'
fi
