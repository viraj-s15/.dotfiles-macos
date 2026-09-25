# macOS dotfiles

Catppuccin SketchyBar islands, ten AeroSpace workspaces, a small Fastfetch setup, and a Starship prompt.

![Desktop with SketchyBar and Fastfetch](assets/desktop.png)

## Install

- Clone the repo and run the installer:

  ```sh
  git clone https://github.com/viraj-s15/.dotfiles-macos.git "$HOME/.dotfiles-macos"
  cd "$HOME/.dotfiles-macos"
  ./install.sh
  ```

- Existing config folders and files are moved to timestamped backups before the new symlinks are created.
- Rerun the script after Apple Command Line Tools finish installing if prompted.
- Starship is installed and `~/.config/starship.toml` is linked; initialize the prompt in your shell (for zsh: `eval "$(starship init zsh)"` in `~/.zshrc`).
- Three-finger horizontal swipes cycle through all ten AeroSpace workspaces (including empty ones); swiping left advances, swiping right goes back, and the ends wrap around.
- The installer disables macOS's three-finger horizontal Space swipe (four-finger gestures are unchanged). Grant **Accessibility** access to **AerospaceSwipe** in **System Settings → Privacy & Security → Accessibility** when prompted. If macOS still switches native Spaces, check **Swipe between full-screen applications** in **System Settings → Trackpad → More Gestures**.

## macOS settings

- Grant **Accessibility** access to AeroSpace and SketchyBar in **System Settings → Privacy & Security → Accessibility**.
- Hide the stock menu bar in **System Settings → Control Center → Automatically hide and show the menu bar → Always**.
- Keep **Displays have separate Spaces** enabled in **System Settings → Desktop & Dock**.
