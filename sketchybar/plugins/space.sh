#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
target=$(( (focused - 1) * 28 ))

sketchybar --animate tanh 12 --set space.1 background.x_offset="$target"

workspace_list="$(aerospace list-windows --all --format '%{workspace}' 2>/dev/null)"

space_color() {
  if grep -qx "$1" <<< "$workspace_list"; then
    printf '%s' "$WHITE"
  else
    printf '%s' "$GREY"
  fi
}

[ "$(aerospace list-workspaces --focused)" = "$focused" ] || exit 0

args=()
for sid in {1..10}; do
  color="$(space_color "$sid")"
  [ "$sid" = "$focused" ] && color=$BLACK
  args+=(--set "space.$sid" icon.color="$color")
done
sketchybar --animate tanh 12 "${args[@]}"
