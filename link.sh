#!/bin/bash
# Symlink repo configs into ~/.config. Safe to rerun; git hooks run it after pull/checkout.

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_SUFFIX="$(date +%Y%m%d-%H%M%S)"
CONFIGS=(aerospace sketchybar fastfetch ghostty starship.toml aerospace-swipe nvim)

mkdir -p "$CONFIG_DIR"

link_config() {
  local name="$1"
  local source="$REPO_DIR/$name"
  local target="$CONFIG_DIR/$name"

  if [ ! -e "$source" ]; then
    echo "error: $source does not exist; update CONFIGS in link.sh." >&2
    return 1
  fi

  if [ -L "$target" ] && [ "$target" -ef "$source" ]; then
    echo "$name is already linked."
    return
  fi

  # Stale links into this repo (e.g. after a layout change) are replaced without a backup.
  if [ -L "$target" ] && [[ "$(readlink "$target")" == "$REPO_DIR"/* ]]; then
    rm "$target"
  elif [ -e "$target" ] || [ -L "$target" ]; then
    local backup="$target.backup-$BACKUP_SUFFIX"
    mv "$target" "$backup"
    echo "Backed up $target to $backup."
  fi

  ln -s "$source" "$target"
  echo "Linked $name."
}

for name in "${CONFIGS[@]}"; do
  link_config "$name"
done

# Remove any other links into this repo that no longer resolve.
while IFS= read -r link; do
  if [[ "$(readlink "$link")" == "$REPO_DIR"/* ]] && [ ! -e "$link" ]; then
    rm "$link"
    echo "Removed broken link $link."
  fi
done < <(find "$CONFIG_DIR" -maxdepth 2 -type l)

# Reload now so a bad config shows up immediately, not at the next restart.
if pgrep -x AeroSpace >/dev/null 2>&1 && command -v aerospace >/dev/null 2>&1; then
  aerospace reload-config && echo "AeroSpace config reloaded."
fi
