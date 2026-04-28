#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== MacBook Windows-like Setup ==="
echo ""

# -------------------------------------------------------
# 1. Karabiner-Elements
# -------------------------------------------------------
echo "[1/5] Karabiner-Elements"

if [ ! -d "/Applications/Karabiner-Elements.app" ]; then
  echo "  Downloading Karabiner-Elements v15.9.0..."
  curl -sL -o /tmp/Karabiner-Elements.dmg \
    "https://github.com/pqrs-org/Karabiner-Elements/releases/download/v15.9.0/Karabiner-Elements-15.9.0.dmg"
  hdiutil attach /tmp/Karabiner-Elements.dmg -nobrowse -quiet
  open "/Volumes/Karabiner-Elements-15.9.0/Karabiner-Elements.pkg"
  echo "  -> Installer opened. Complete installation, then re-run this script."
  exit 0
else
  echo "  Already installed."
fi

echo "  Copying Karabiner config files..."
mkdir -p "$HOME/.config/karabiner/assets/complex_modifications"
cp "$SCRIPT_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
cp "$SCRIPT_DIR/karabiner/windows_like_jis.json" \
   "$HOME/.config/karabiner/assets/complex_modifications/windows_like_jis.json"

if command -v /Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli &>/dev/null; then
  "/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli" \
    --set-variables '{"system.temporarily_ignore_all_devices":0}'
fi

echo "  Done."

# -------------------------------------------------------
# 2. Rectangle
# -------------------------------------------------------
echo "[2/5] Rectangle"

if [ ! -d "/Applications/Rectangle.app" ]; then
  echo "  Downloading Rectangle v0.95..."
  curl -sL -o /tmp/Rectangle.dmg \
    "https://github.com/rxhanson/Rectangle/releases/download/v0.95/Rectangle0.95.dmg"
  hdiutil attach /tmp/Rectangle.dmg -nobrowse -quiet
  cp -R "/Volumes/Rectangle0.95/Rectangle.app" /Applications/
  hdiutil detach "/Volumes/Rectangle0.95" -quiet 2>/dev/null || true
  echo "  Installed."
else
  echo "  Already installed."
fi

defaults write com.knollsoft.Rectangle nextDisplay \
  -dict keyCode -int 124 modifierFlags -int 1179914
defaults write com.knollsoft.Rectangle previousDisplay \
  -dict keyCode -int 123 modifierFlags -int 1179914

open -a "Rectangle" 2>/dev/null || true
echo "  Shortcuts configured: Shift+Cmd+Arrow for display move."

# -------------------------------------------------------
# 3. macOS: F-keys as standard function keys
# -------------------------------------------------------
echo "[3/5] Function keys (F1-F12 = standard, not media)"

defaults write -g com.apple.keyboard.fnState -bool true
defaults -currentHost write -g com.apple.keyboard.fnState -bool true
echo "  Done. (Restart may be needed to take full effect.)"

# -------------------------------------------------------
# 4. macOS: Japanese IME settings
# -------------------------------------------------------
echo "[4/5] Japanese IME (live conversion OFF, Windows-style keybind ON)"

echo "  -> Open: System Settings > Keyboard > Input Sources > Japanese"
echo "     - Live Conversion: OFF"
echo "     - Windows-style Key Binding: ON"
echo "  (These must be set manually in System Settings.)"

# -------------------------------------------------------
# 5. Permissions reminder
# -------------------------------------------------------
echo "[5/5] Required permissions (manual)"
echo ""
echo "  Open System Settings > Privacy & Security and enable:"
echo "    - Accessibility: Karabiner-Elements, Rectangle"
echo "    - Input Monitoring: Karabiner-Elements, karabiner_grabber"
echo "    - General > Login Items & Extensions > Driver Extensions:"
echo "      Enable 'Karabiner-DriverKit-VirtualHIDDevice'"
echo ""
echo "=== Setup complete ==="
echo "  Restart recommended to apply all changes."
