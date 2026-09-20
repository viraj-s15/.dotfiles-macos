#!/bin/bash

cores="$(sysctl -n hw.ncpu)"
cpu="$(ps -A -o %cpu= | awk -v cores="$cores" '{ total += $1 } END { printf "%.0f", total / cores }')"
free_percent="$(memory_pressure -Q | awk '/System-wide memory free percentage:/ {gsub(/%/, "", $5); print $5}')"
memory="--"
[ -n "$free_percent" ] && memory=$((100 - free_percent))

sketchybar --set system_metrics label="${cpu}%    ${memory}%"
