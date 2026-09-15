#!/bin/bash

# AeroSpace workspaces are independent of macOS Spaces. Keep these in sync with
# persistent-workspaces in ~/.config/aerospace/aerospace.toml.
sketchybar --add event aerospace_workspace_change

for sid in 1 2 3 4 5; do
  space=(
    icon="$sid"
    icon.padding_left=13
    icon.padding_right=13
    icon.highlight_color=0xffcba6f7
    label.drawing=off
    label.font="sketchybar-app-font:Regular:10.0"
    label.padding_left=12
    label.padding_right=12
    label.y_offset=0
    label.background.height=22
    label.background.corner_radius=8
    label.background.color=0xff494d64
    label.background.drawing=off
    padding_left=2
    padding_right=2
    y_offset=0
    background.drawing=off
    script="$PLUGIN_DIR/space.sh $sid"
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item "space.$sid" left \
             --set "space.$sid" "${space[@]}" \
             --subscribe "space.$sid" aerospace_workspace_change front_app_switched
done

spaces=(
  background.color=0xff3c3e4f
  background.border_width=0
  background.corner_radius=9
  background.drawing=on
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"

sketchybar --trigger aerospace_workspace_change \
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
