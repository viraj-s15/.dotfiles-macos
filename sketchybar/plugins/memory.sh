#!/bin/bash

free_percent=$(memory_pressure -Q | awk '/System-wide memory free percentage:/ {gsub(/%/, "", $5); print $5}')

if [ -n "$free_percent" ]; then
  sketchybar --set "$NAME" label="$((100 - free_percent))%"
fi
