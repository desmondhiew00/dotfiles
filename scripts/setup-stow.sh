#!/bin/bash

BACKUP_DIR="$HOME/.dotfiles_bak"

# === Back up existing files ===
echo "📁 Backing up existing files..."

cp -r "$HOME/.config" "$BACKUP_DIR"

# Top-level files
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$BACKUP_DIR/"
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$BACKUP_DIR/"

# === Apply stow ===
echo "🔗 Applying stow to dotfiles..."

MODULES=(git nushell nvim starship zed zsh)
for module in "${MODULES[@]}"; do
  echo "🔧 Stowing $module..."
  stow -v "$module"
done