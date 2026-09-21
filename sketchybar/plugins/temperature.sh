#!/bin/bash

cpu_temp="--"
gpu_temp="--"
if command -v macmon >/dev/null 2>&1; then
  temperatures="$(macmon pipe --samples 1 --interval 200 2>/dev/null)"
  cpu_temp="$(jq -r '.temp.cpu_temp_avg | if type == "number" then round else "--" end' <<< "$temperatures")"
  gpu_temp="$(jq -r '.temp.gpu_temp_avg | if type == "number" then round else "--" end' <<< "$temperatures")"
fi

sketchybar --set cpu.temperature label="C ${cpu_temp}°" \
           --set gpu.temperature label="G ${gpu_temp}°"
