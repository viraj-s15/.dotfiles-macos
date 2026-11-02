# Agent notes

## SketchyBar clicks show the macOS menu bar (macOS 27.2)

### Symptoms

With the menu bar set to auto-hide, clicking anything on SketchyBar shows the macOS menu bar, and the click never reaches the bar.

### Cause

macOS 27.2 keeps an invisible `MenuBarAgent` window (`MenuBarRevealShield`, about 44pt tall) across the top of the screen. It sits above the bar and takes its clicks. Upstream issue: [FelixKratz/SketchyBar#852](https://github.com/FelixKratz/SketchyBar/issues/852). `topmost=window` doesn't help. `topmost=on` makes clicks work, but then the revealed menu bar draws behind SketchyBar.

### Current fix

`install.sh` installs a patched build, `strayer/tap/sketchybar`. It keeps the bar above the shield while the menu bar is hidden and drops it behind once the menu bar is revealed. `sketchybarrc` uses `topmost=off`, which lets the revealed menu bar draw on top.

### Switching back to upstream SketchyBar

Do this once the fix ships upstream, or if the patched build causes problems.

1. Swap the installed build:

   ```sh
   brew services stop sketchybar
   brew uninstall sketchybar
   brew install felixkratz/formulae/sketchybar
   brew services start sketchybar
   brew untap strayer/tap   # optional
   ```

2. In `install.sh`, replace the `strayer/tap` lines with:

   ```sh
   brew tap FelixKratz/formulae
   install_formula sketchybar
   ```

3. Update the `topmost` comment in `sketchybar/sketchybarrc`. If upstream still has the bug, set `topmost=on` so clicks keep working. The macOS menu bar will then draw behind SketchyBar.
