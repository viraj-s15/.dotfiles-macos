#!/bin/bash

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
  background.border_width=0
  background.drawing=on
  background.shadow.drawing=off
  blur_radius=75
)

system_items=(battery)
[ "$ENABLE_GITHUB" = true ] && system_items+=(github.bell)
[ "$ENABLE_NOTIFICATIONS" = true ] && system_items+=(notifications)
[ "$ENABLE_FOCUS" = true ] && system_items+=(focus.mode)
system_items+=(brew)

apple_items=(apple.logo)
workspace_items=('/^space\..*/')
[ "$ENABLE_WORKSPACE_SEPARATOR" = true ] && workspace_items+=(separator)
[ "$ENABLE_AEROSPACE_LAYOUT" = true ] && workspace_items+=(aerospace.layout)
workspace_items+=(front_app)

privacy_items=(privacy_mic privacy_camera privacy_screen)

sketchybar --add item bar.notch_left q \
           --set bar.notch_left "${notch_anchor[@]}" \
           --add item bar.notch_right e \
           --set bar.notch_right "${notch_anchor[@]}" \
           --add bracket bar.apple "${apple_items[@]}" \
           --set bar.apple "${section[@]}" background.padding_left=4 background.padding_right=4 \
           --add bracket bar.workspace "${workspace_items[@]}" \
           --set bar.workspace "${section[@]}" background.padding_left=8 background.padding_right=8 \
           --add bracket bar.now_playing now_playing \
           --set bar.now_playing "${section[@]}" background.padding_left=4 background.padding_right=4 background.drawing=off \
           --add bracket bar.privacy "${privacy_items[@]}" \
           --set bar.privacy "${section[@]}" background.padding_left=7 background.padding_right=7 \
           --add bracket bar.spotify spotify_anchor \
           --set bar.spotify "${section[@]}" background.padding_left=4 background.padding_right=4 \
           --add bracket bar.metrics system_metrics \
           --set bar.metrics "${section[@]}" background.padding_left=5 background.padding_right=5 background.x_offset=0 \
           --add bracket bar.system "${system_items[@]}" \
           --set bar.system "${section[@]}" background.padding_left=6 background.padding_right=6 \
           --add bracket bar.clock calendar \
           --set bar.clock "${section[@]}" background.padding_left=8 background.padding_right=8
