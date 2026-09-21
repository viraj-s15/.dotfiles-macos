#!/bin/bash

cores="$(sysctl -n hw.ncpu)"
cpu="$(ps -A -o %cpu= | awk -v cores="$cores" '{ total += $1 } END { printf "%.0f", total / cores }')"
memory="--"
if command -v macmon >/dev/null 2>&1; then
  memory="$(macmon pipe --samples 1 --interval 200 2>/dev/null | jq -r '.memory.ram_usage | if type == "number" then (. / 1000000000 | round) else "--" end')"
fi

sketchybar --set cpu.percent label="${cpu}%" \
           --set memory.percent label="${memory} GB"
