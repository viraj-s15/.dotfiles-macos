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
    *)
      if [ -z "$icon_strip" ]; then
        icon_strip="$app_icon"
      else
        icon_strip="$icon_strip $app_icon"
      fi
      ;;
  esac
done < <(aerospace list-windows --workspace "$sid" --format '%{app-name}')

if [ "$sid" = "$focused" ]; then
  HIGHLIGHT=on
else
  HIGHLIGHT=off
fi

state=$(sketchybar --query "$NAME")
current_label=$(echo "$state" | jq -r '.label.value')
current_drawing=$(echo "$state" | jq -r '.label.drawing')

# Selection changes animate independently so app-icon updates never rebuild or
# flash the complete workspace segment.
sketchybar --animate tanh 12 --set "$NAME" \
  icon.highlight="$HIGHLIGHT" \
  background.drawing=off

if [ -n "$icon_strip" ]; then
  if [ "$current_drawing" != "on" ]; then
    sketchybar --set "$NAME" \
      label="$icon_strip" \
      label.width=dynamic \
      label.drawing=on \
      label.background.drawing=on
  elif [ "$current_label" != "$icon_strip" ]; then
    sketchybar --set "$NAME" label="$icon_strip"
  fi
elif [ "$current_drawing" = "on" ]; then
  sketchybar --set "$NAME" \
    label.width=0 \
    label.drawing=off \
    label.background.drawing=off
fi
