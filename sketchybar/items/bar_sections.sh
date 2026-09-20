#!/bin/bash

# Anchor each background to its corresponding physical notch edge. The global
# bar is transparent, leaving two visible continuous sections around the notch.
notch_anchor=(
  width=1
  padding_left=0
  padding_right=0
  ignore_association=on
  icon="|"
  icon.color=$TRANSPARENT
  icon.width=1
  icon.padding_left=0
  icon.padding_right=0
  icon.drawing=on
  label.drawing=off
  background.drawing=off
)

section=(
  background.color=$BAR_COLOR
  background.height=29
  background.corner_radius=10
  background.border_color=$GLASS_BORDER_COLOR
  background.border_width=1
  background.drawing=on
  background.shadow.drawing=off
  blur_radius=28
)

right_section_items=()
[ "$ENABLE_SPOTIFY" = true ] && right_section_items+=(spotify.anchor)
[ "$ENABLE_SYSTEM_METRICS" = true ] && right_section_items+=(memory cpu.percent)
[ "$ENABLE_BRIGHTNESS" = true ] && right_section_items+=(brightness.icon brightness)
[ "$ENABLE_VOLUME" = true ] && right_section_items+=(volume_icon)
right_section_items+=(battery)
[ "$ENABLE_GITHUB" = true ] && right_section_items+=(github.bell)
[ "$ENABLE_NOTIFICATIONS" = true ] && right_section_items+=(notifications)
right_section_items+=(brew calendar)

left_section_items=(apple.logo workspace.highlight '/^space\..*/')
[ "$ENABLE_WORKSPACE_SEPARATOR" = true ] && left_section_items+=(separator)
[ "$ENABLE_AEROSPACE_LAYOUT" = true ] && left_section_items+=(aerospace.layout)
left_section_items+=(front_app)

sketchybar --add item bar.notch_left q \
           --set bar.notch_left "${notch_anchor[@]}" \
           --add item bar.notch_right e \
           --set bar.notch_right "${notch_anchor[@]}" \
           --add bracket bar.left "${left_section_items[@]}" \
           --set bar.left "${section[@]}" background.padding_left=10 \
           --add bracket bar.right "${right_section_items[@]}" \
           --set bar.right "${section[@]}" background.padding_right=10
