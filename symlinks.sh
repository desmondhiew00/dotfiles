#!/bin/bash

set -e  # Exit on error

FORCE=false
if [ "$1" = "-f" ]; then
  FORCE=true
fi

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_bak"

echo "🔍 Checking if dotfiles are already migrated..."
if [ "$FORCE" = false ]; then
  if [ -L "$HOME/.zshrc" ] || [ -L "$HOME/.config/nushell/config.nu" ]; then
    echo "✅ Dotfiles already appear to be symlinked. Skipping migration."
    exit 0
  fi
fi

echo "📦 Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR/.config"

# === Back up existing files ===
echo "📁 Backing up existing files..."

# Top-level files
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/"
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$BACKUP_DIR/"
[ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$BACKUP_DIR/"

# Config files
for dir in zsh stow karabiner nushell starship nvim; do
  if [ -d "$HOME/.config/$dir" ]; then
    echo "↪ Backing up ~/.config/$dir"
    mv "$HOME/.config/$dir" "$BACKUP_DIR/.config/"
  fi
done

# === Apply stow ===
echo "🔗 Applying stow to dotfiles..."
cd "$DOTFILES_DIR"

for module in stow zsh nvim git nushell starship karabiner; do
  echo "🔧 Stowing $module..."
  stow -v "$module"
done

# === Symlink nushell config if on macOS ===
IS_MACOS=$(uname -s | grep -q Darwin && echo "true" || echo "false") 
if [ "$IS_MACOS" = "true" ]; then
  echo "🔗 Symlinking nushell config..."
  ln -s "$HOME/Library/Application Support/nushell/config.nu" "$HOME/.config/nushell/config.nu"
fi

echo "🎉 Migration complete! Your dotfiles are now managed with stow."