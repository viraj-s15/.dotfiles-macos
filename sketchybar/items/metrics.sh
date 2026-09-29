#!/bin/bash

metric_item=(
  icon.drawing=off
  label.font="$FONT:Heavy:12.0"
  label.align=center
  label.padding_left=7
  label.padding_right=7
  padding_left=0
  padding_right=0
)

sketchybar --add item gpu.temperature right \
           --set gpu.temperature "${metric_item[@]}" label="G --°" label.color=$WHITE \
           --add item cpu.temperature right \
           --set cpu.temperature "${metric_item[@]}" label="C --°" label.color=$WHITE \
                 update_freq=60 updates=on script="$PLUGIN_DIR/temperature.sh" \
           --add item memory.percent right \
           --set memory.percent "${metric_item[@]}" label="-- GB" label.color=$WHITE \
           --add item cpu.percent right \
           --set cpu.percent "${metric_item[@]}" label="--%" label.color=$WHITE \
                 update_freq=30 updates=on script="$PLUGIN_DIR/metrics.sh"
