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
  background.shadow.drawing=on
  background.shadow.color=0x40000000
  background.shadow.distance=3
  blur_radius=28
)

right_section_items=()
[ "$ENABLE_SPOTIFY" = true ] && right_section_items+=(spotify.anchor)
[ "$ENABLE_SYSTEM_METRICS" = true ] && right_section_items+=(memory cpu.percent)
[ "$ENABLE_BRIGHTNESS" = true ] && right_section_items+=(brightness.icon brightness)
[ "$ENABLE_VOLUME" = true ] && right_section_items+=(volume_icon)
right_section_items+=(battery github.bell brew calendar)

status_items=(brew github.bell battery)
[ "$ENABLE_VOLUME" = true ] && status_items+=(volume_icon)
[ "$ENABLE_BRIGHTNESS" = true ] && status_items+=(brightness.icon)

left_section_items=(apple.logo '/^space\..*/')
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

# Recreate the status group after the outer glass shell so it remains visible.
sketchybar --remove status
sketchybar --add bracket status "${status_items[@]}" \
           --set status \
             background.color=$BACKGROUND_1 \
             background.border_color=$BACKGROUND_2 \
             background.border_width=1 \
             background.height=24 \
             background.corner_radius=8 \
             background.drawing=on
