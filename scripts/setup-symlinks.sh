#!/bin/bash

IS_MACOS=$(uname -s | grep -q Darwin && echo "true" || echo "false")
if [ "$IS_MACOS" = "false" ]; then
  echo "Only macOS is supported for now."
  exit 1
fi

APP_SUPPORT_DIR="$HOME/Library/Application Support"


echo "🔗 Symlinking nushell config..."
ln -s "$APP_SUPPORT_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu"
ln -s "$APP_SUPPORT_DIR/nushell/env.nu" "$HOME/.config/nushell/env.nu"
echo "✅ Symlinked nushell config.\n"

echo "🔗 Symlinking karabiner config..."
# karabiner will recreate the orignial karabiner.json file, so we need to symlink it other location (put on .dotfiles dir)
ln -s "$HOME/.config/karabiner/karabiner.json" "./karabiner/karabiner.json"
echo "✅ Symlinked karabiner config.\n"

echo "🔗 Symlinking sublime config..."
mkdir -p "./sublime/.config"
ln -s "$APP_SUPPORT_DIR/Sublime Text/Packages/User" "./sublime/.config/sublime"
echo "✅ Symlinked sublime config.\n"

echo "🔗 Symlinking cursor config..."
mkdir -p "./cursor/.config/cursor"
ln -s "$APP_SUPPORT_DIR/Cursor/User/keybindings.json" "./cursor/.config/cursor/keybindings.json"
ln -s "$APP_SUPPORT_DIR/Cursor/User/settings.json" "./cursor/.config/cursor/settings.json"
echo "✅ Symlinked cursor config.\n"
