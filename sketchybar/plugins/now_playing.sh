#!/bin/bash

source "$CONFIG_DIR/colors.sh"

media_json="$(nowplaying-cli get --json title artist playbackRate clientBundleIdentifier 2>/dev/null)"
playing="$(jq -r '(.playbackRate // 0) > 0 and (.title // "") != ""' <<< "$media_json")"

if [ "$playing" = true ]; then
  title="$(jq -r '.title // ""' <<< "$media_json")"
  artist="$(jq -r '.artist // ""' <<< "$media_json")"
  bundle_identifier="$(jq -r '.clientBundleIdentifier // ""' <<< "$media_json")"
  text="$title"
  [ -n "$artist" ] && text="$artist · $title"
  text="$(printf '%s' "$text" | cut -c1-24)"

  icon="􀊆"
  icon_font="SF Pro:Bold:13.0"
  icon_color="$BLUE"
  if [ "$bundle_identifier" = "com.spotify.client" ]; then
    icon=":spotify:"
    icon_font="sketchybar-app-font:Regular:15.0"
    icon_color="$GREEN"
  fi

  sketchybar --set now_playing drawing=on icon="$icon" icon.font="$icon_font" icon.color="$icon_color" label="$text" \
             --set bar.now_playing background.drawing=on
else
  sketchybar --set now_playing drawing=off \
             --set bar.now_playing background.drawing=off
fi
