#!/bin/bash

WIDTH=80
current_width=$(sketchybar --query brightness | jq -r '.slider.width')

if [ "$current_width" -eq 0 ]; then
  sketchybar --animate tanh 30 --set brightness slider.width=$WIDTH
else
  sketchybar --animate tanh 30 --set brightness slider.width=0
fi
