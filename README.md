# macOS dotfiles

Catppuccin SketchyBar islands, ten AeroSpace workspaces, and a small Fastfetch setup.

![Desktop with SketchyBar and Fastfetch](assets/desktop.png)

## Install

- Clone the repo and run the installer:

  ```sh
  git clone https://github.com/viraj-s15/.dotfiles-macos.git "$HOME/.dotfiles-macos"
  cd "$HOME/.dotfiles-macos"
  ./install.sh
  ```

- Existing config folders are moved to timestamped backups before the new symlinks are created.
- Rerun the script after Apple Command Line Tools finish installing if prompted.

## macOS settings

- Grant **Accessibility** access to AeroSpace and SketchyBar in **System Settings → Privacy & Security → Accessibility**.
- Hide the stock menu bar in **System Settings → Control Center → Automatically hide and show the menu bar → Always**.
- Keep **Displays have separate Spaces** enabled in **System Settings → Desktop & Dock**.
