#!/bin/bash

# AeroSpace workspaces are independent of macOS Spaces. Keep these in sync with
# persistent-workspaces in ~/.config/aerospace/aerospace.toml.
sketchybar --add event aerospace_workspace_change

for sid in 1 2 3 4 5 6; do
  space=(
    icon="$sid"
    icon.padding_left=10
    icon.padding_right=10
    icon.highlight_color=$RED
    label.drawing=off
    label.font="sketchybar-app-font:Regular:13.5"
    label.padding_left=10
    label.padding_right=10
    label.y_offset=0
    label.background.height=22
    label.background.corner_radius=7
    label.background.color=$BACKGROUND_2
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
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.corner_radius=8
  background.drawing=on
)

sketchybar --add bracket spaces '/^space\..*/' \
           --set spaces "${spaces[@]}"

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:14.0"
  icon.color=$WHITE
  padding_left=8
  padding_right=8
  label.drawing=off
  associated_display=active
)

sketchybar --add item separator left \
           --set separator "${separator[@]}"

sketchybar --trigger aerospace_workspace_change \
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
