#!/bin/bash

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

brew=(
  icon=􀐛
  icon.font="$FONT:Bold:14.0"
  label=?
  padding_left=8
  padding_right=8
  updates=on
  script="$PLUGIN_DIR/brew.sh"
  click_script="nohup /bin/zsh -lc '/opt/homebrew/bin/brew upgrade --no-ask; /opt/homebrew/bin/sketchybar --trigger brew_update' > '$HOME/Library/Logs/sketchybar-brew-upgrade.log' 2>&1 &"
)

sketchybar --add event brew_update \
           --add item brew right   \
           --set brew "${brew[@]}" \
           --subscribe brew brew_update
