#!/bin/bash

IS_MACOS=$(uname -s | grep -q Darwin && echo "true" || echo "false")
if [ "$IS_MACOS" = "false" ]; then
  echo "Only macOS is supported for now."
  exit 1
fi

APP_SUPPORT_DIR="$HOME/Library/Application Support"

echo "🔗 Copying nushell config..."
cp "./nushell/.config/nushell/config.nu" "./nushell/copied-config.nu"
cp "./nushell/.config/nushell/env.nu" "./nushell/copied-env.nu"
echo "✅ Copied nushell config.\n"

echo "🔗 Copying karabiner config..."
cp "./karabiner/karabiner.json" "./karabiner/copied-karabiner.json"
echo "✅ Copied karabiner config.\n"

echo "🔗 Copying sublime config..."
cp "./sublime/.config/sublime/Default\ \(OSX\).sublime-keymap" "./sublime/copied-keybinding.json"
echo "✅ Copied sublime config.\n"

echo "🔗 Copying cursor config..."
cp "./cursor/.config/cursor/keybindings.json" "./cursor/copied-keybindings.json"
cp "./cursor/.config/cursor/settings.json" "./cursor/copied-settings.json"
cursor --list-extensions > ./cursor/cursor-extensions.txt
echo "✅ Copied cursor config.\n"