#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo '[0-9]+%' | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON=$BATTERY_100
  ;;
  [6-8][0-9]) ICON=$BATTERY_75
  ;;
  [3-5][0-9]) ICON=$BATTERY_50
  ;;
  [1-2][0-9]) ICON=$BATTERY_25
  ;;
  *) ICON=$BATTERY_0
esac

if [[ $CHARGING != "" ]]; then
  ICON=$BATTERY_CHARGING
fi

POWER_MODE=$(pmset -g | awk '/powermode/ { print $2; exit }')
case "$POWER_MODE" in
  1) COLOR=$YELLOW ;;
  2) COLOR=$ORANGE ;;
  *) COLOR=$WHITE ;;
esac

sketchybar --set "$NAME" drawing=on \
           icon="$ICON" icon.color="$COLOR" \
           label="${PERCENTAGE}%" label.color="$COLOR"
