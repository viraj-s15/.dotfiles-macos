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
  background.corner_radius=9
  background.drawing=on
  blur_radius=20
)

right_section_items=()
[ "$ENABLE_SPOTIFY" = true ] && right_section_items+=(spotify.anchor)
right_section_items+=(memory cpu.percent)
[ "$ENABLE_BRIGHTNESS" = true ] && right_section_items+=(brightness.icon brightness)
[ "$ENABLE_VOLUME" = true ] && right_section_items+=(volume_icon)
right_section_items+=(battery github.bell brew calendar)

status_items=(brew github.bell battery)
[ "$ENABLE_VOLUME" = true ] && status_items+=(volume_icon)
[ "$ENABLE_BRIGHTNESS" = true ] && status_items+=(brightness.icon)

left_section_items=(apple.logo '/^space\..*/' separator)
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

# Bracket backgrounds are drawn in creation order. Recreate the inner groups
# after the section backgrounds so their visual hierarchy remains visible.
sketchybar --remove spaces
sketchybar --remove status

sketchybar --add bracket spaces '/^space\..*/' \
           --set spaces \
             background.color=$BACKGROUND_1 \
             background.border_color=$BACKGROUND_2 \
             background.border_width=2 \
             background.height=24 \
             background.corner_radius=8 \
             background.drawing=on

sketchybar --add bracket status "${status_items[@]}" \
           --set status \
             background.color=$BACKGROUND_1 \
             background.border_color=$BACKGROUND_2 \
             background.border_width=2 \
             background.height=24 \
             background.corner_radius=9 \
             background.drawing=on
