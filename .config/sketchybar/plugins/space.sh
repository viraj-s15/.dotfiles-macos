#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

sid="${NAME#space.}"
focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"

icon_strip=""
while IFS= read -r app; do
  [ -z "$app" ] && continue
  app_icon=$("$HOME/.config/sketchybar/plugins/icon_map.sh" "$app")
  case " $icon_strip " in
    *" $app_icon "*) ;;
    *) icon_strip="$icon_strip $app_icon" ;;
  esac
done < <(aerospace list-windows --workspace "$sid" --format '%{app-name}')

if [ -n "$icon_strip" ]; then
  sketchybar --set "$NAME" label="$icon_strip" label.drawing=on
else
  sketchybar --set "$NAME" label.drawing=off
fi

if [ "$sid" = "$focused" ]; then
  sketchybar --animate tanh 20 --set "$NAME" \
    icon.highlight=on \
    background.drawing=on \
    background.color="$BACKGROUND_2"
else
  sketchybar --animate tanh 20 --set "$NAME" \
    icon.highlight=off \
    background.drawing=off
fi
