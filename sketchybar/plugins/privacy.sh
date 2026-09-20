#!/bin/bash

source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "mouse.clicked" ]; then
  case "$NAME" in
    privacy_mic) open 'x-apple.systempreferences:com.apple.preference.security?Privacy_Microphone' ;;
    privacy_camera) open 'x-apple.systempreferences:com.apple.preference.security?Privacy_Camera' ;;
    privacy_screen) open 'x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture' ;;
  esac
  exit 0
fi

status="$($CONFIG_DIR/helper/privacy-status 2>/dev/null)"
microphone="$(jq -r '.microphone // false' <<< "$status")"
camera="$(jq -r '.camera // false' <<< "$status")"

[ "$microphone" = true ] && mic_color=$GREEN || mic_color=$WHITE
[ "$camera" = true ] && camera_color=$GREEN || camera_color=$WHITE

sketchybar --set privacy_mic icon.color=$mic_color \
           --set privacy_camera icon.color=$camera_color
