#!/bin/bash

set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This installer only supports macOS."
  exit 1
fi

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
FONT_DIR="$HOME/Library/Fonts"
APP_FONT="$FONT_DIR/sketchybar-app-font.ttf"
BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Installing Apple Command Line Tools. Rerun this script when the installation finishes."
  xcode-select --install
  exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

install_formula() {
  local formula="$1"
  if brew list --formula "$formula" >/dev/null 2>&1; then
    echo "$formula is already installed."
  else
    brew install "$formula"
  fi
}

install_cask() {
  local cask="$1"
  local token="${cask##*/}"
  if brew list --cask "$token" >/dev/null 2>&1; then
    echo "$token is already installed."
  else
    brew install --cask "$cask"
  fi
}

brew tap FelixKratz/formulae
install_formula sketchybar
install_formula fastfetch
install_formula starship
install_formula nowplaying-cli
install_formula macmon

if ! command -v jq >/dev/null 2>&1; then
  install_formula jq
fi

install_cask nikitabobko/tap/aerospace
install_cask ghostty
install_cask font-sf-pro
install_cask sf-symbols

mkdir -p "$FONT_DIR"
if [ -s "$APP_FONT" ]; then
  echo "sketchybar-app-font is already installed."
else
  curl -fsSL https://github.com/kvndrsslr/sketchybar-app-font/releases/latest/download/sketchybar-app-font.ttf \
    -o "$APP_FONT"
fi

mkdir -p "$CONFIG_DIR"

link_config() {
  local name="$1"
  local source="$REPO_DIR/$name"
  local target="$CONFIG_DIR/$name"

  if [ -L "$target" ] && [ "$target" -ef "$source" ]; then
    echo "$name is already linked."
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    local backup="$target.backup-$BACKUP_SUFFIX"
    mv "$target" "$backup"
    echo "Backed up $target to $backup."
  fi

  ln -s "$source" "$target"
  echo "Linked $name."
}

link_config aerospace
link_config sketchybar
link_config fastfetch
link_config ghostty
link_config starship.toml

SUDOERS_SOURCE="$REPO_DIR/sketchybar/helper/sketchybar-power-mode.sudoers"
SUDOERS_TEMP="$(mktemp)"
trap 'rm -f "$SUDOERS_TEMP"' EXIT
sed "s/^veer /$USER /" "$SUDOERS_SOURCE" > "$SUDOERS_TEMP"
/usr/sbin/visudo -cf "$SUDOERS_TEMP" >/dev/null

POWER_HELPER_SOURCE="$REPO_DIR/sketchybar/helper/sketchybar-power-mode"
POWER_HELPER_TARGET="/usr/local/libexec/sketchybar-power-mode"
SUDOERS_TARGET="/etc/sudoers.d/sketchybar-power-mode"

if [ -x "$POWER_HELPER_TARGET" ] && cmp -s "$POWER_HELPER_SOURCE" "$POWER_HELPER_TARGET" && [ -f "$SUDOERS_TARGET" ]; then
  echo "Battery power-mode helper is already installed."
else
  sudo mkdir -p /usr/local/libexec /etc/sudoers.d
  sudo install -o root -g wheel -m 755 "$POWER_HELPER_SOURCE" "$POWER_HELPER_TARGET"
  sudo install -o root -g wheel -m 440 "$SUDOERS_TEMP" "$SUDOERS_TARGET"
  sudo /usr/sbin/visudo -cf "$SUDOERS_TARGET"
fi

if brew services list | awk '$1 == "sketchybar" && $2 == "started" { found = 1 } END { exit !found }'; then
  sketchybar --reload
  echo "SketchyBar reloaded."
else
  brew services start sketchybar
fi

if pgrep -x AeroSpace >/dev/null 2>&1; then
  echo "AeroSpace is already running."
else
  open -a AeroSpace
fi

echo
echo "Setup complete."
echo "Grant Accessibility access to AeroSpace and SketchyBar in System Settings."
echo "Hide the stock menu bar and keep Displays have separate Spaces enabled."
