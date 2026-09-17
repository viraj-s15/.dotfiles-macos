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
  LABEL_WIDTH=0
  LABEL_BACKGROUND=off
else
  HIGHLIGHT=off
  LABEL_WIDTH=dynamic
  LABEL_BACKGROUND=on
fi

state=$(sketchybar --query "$NAME")
current_drawing=$(echo "$state" | jq -r '.label.drawing')

# Selection changes animate independently so app-icon updates never rebuild or
# flash the complete workspace segment.
sketchybar --animate tanh 12 --set "$NAME" \
  icon.highlight="$HIGHLIGHT" \
  label.width="$LABEL_WIDTH" \
  background.drawing=off

if [ -n "$icon_strip" ]; then
  sketchybar --set "$NAME" \
    label="$icon_strip" \
    label.drawing=on \
    label.background.drawing="$LABEL_BACKGROUND"
elif [ "$current_drawing" = "on" ]; then
  sketchybar --set "$NAME" \
    label.width=0 \
    label.drawing=off \
    label.background.drawing=off
fi
