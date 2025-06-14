#!/bin/bash

set -e  # Exit on error

FORCE=false
if [ "$1" = "-f" ]; then
  FORCE=true
fi

BACKUP_DIR="$HOME/.dotfiles_bak"

echo "🔍 Checking if dotfiles are already migrated..."
if [ "$FORCE" = false ]; then
  if [ -L "$HOME/.zshrc" ] then
    echo "✅ Dotfiles already appear to be symlinked. Skipping migration."
    exit 0
  fi
fi

echo "📦 Creating backup directory: $BACKUP_DIR"

# === Back up existing files ===
echo "📁 Backing up existing files..."

cp -r "$HOME/.config" "$BACKUP_DIR"

# Top-level files
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/"
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$BACKUP_DIR/"
# [ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$BACKUP_DIR/"

# === Apply stow ===
echo "🔗 Applying stow to dotfiles..."

MODULES=(cursor git karabiner nushell nvim starship sublime zed zsh)
for module in "${MODULES[@]}"; do
  echo "🔧 Stowing $module..."
  stow -v "$module"
done

# === Symlink nushell config if on macOS ===
IS_MACOS=$(uname -s | grep -q Darwin && echo "true" || echo "false")
if [ "$IS_MACOS" = "true" ]; then
  echo "🔗 Symlinking nushell config..."
  ln -s "$HOME/Library/Application Support/nushell/config.nu" "$HOME/.config/nushell/config.nu"
fi

echo "✅ Symlinks applied."
