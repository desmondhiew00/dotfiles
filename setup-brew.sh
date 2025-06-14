#!/bin/bash

set -euo pipefail

echo "🚀 Setting up macOS development environment..."

# === Ensure .config exists
mkdir -p "$HOME/.config"

# === Install Homebrew if needed
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

echo "🔄 Updating Homebrew..."
brew update
brew bundle --file ./Brewfile

echo "✅ Brew setup complete!"