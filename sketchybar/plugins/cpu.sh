#!/bin/bash

cores=$(sysctl -n hw.ncpu)
percentage=$(ps -A -o %cpu= | awk -v cores="$cores" '{ total += $1 } END { printf "%.0f", total / cores }')

sketchybar --set "$NAME" label="${percentage}%"
