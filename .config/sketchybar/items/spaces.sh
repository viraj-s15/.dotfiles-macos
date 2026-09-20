#!/bin/bash

# AeroSpace workspaces are independent of macOS Spaces. Keep these in sync with
# persistent-workspaces in ~/.config/aerospace/aerospace.toml.
sketchybar --add event aerospace_workspace_change

for sid in 1 2 3 4 5 6; do
  space=(
    icon="$sid"
    icon.font="$FONT:Bold:13.0"
    icon.padding_left=0
    icon.padding_right=0
    icon.color=$GREY
    label.drawing=off
    width=35
    padding_left=1
    padding_right=1
    y_offset=0
    background.height=22
    background.corner_radius=8
    background.color=$MAGENTA
    background.drawing=off
    script="$PLUGIN_DIR/space.sh $sid"
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item "space.$sid" left \
             --set "space.$sid" "${space[@]}" \
             --subscribe "space.$sid" aerospace_workspace_change front_app_switched
done

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:14.0"
  icon.color=$WHITE
  padding_left=8
  padding_right=8
  label.drawing=off
  associated_display=active
)

if [ "$ENABLE_WORKSPACE_SEPARATOR" = true ]; then
  sketchybar --add item separator left \
             --set separator "${separator[@]}"
fi

sketchybar --trigger aerospace_workspace_change \
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
