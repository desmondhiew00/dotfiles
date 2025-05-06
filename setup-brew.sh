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

# === Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Installing Oh My Zsh..."
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed."
fi

# === Clone or update Git repo (plugin/theme)
clone_or_pull() {
  local repo_url=$1
  local target_dir=$2

  if [ ! -d "$target_dir/.git" ]; then
    echo "📦 Cloning: $repo_url → $target_dir"
    git clone --depth 1 "$repo_url" "$target_dir"
  else
    echo "🔁 Updating: $target_dir"
    git -C "$target_dir" pull
  fi
}

# === Install Zsh plugin or theme
install_omz_plugin() {
  local type=$1
  local name=$2
  local repo=$3
  local base_path="$HOME/.oh-my-zsh/custom"

  local target_dir

  if [ "$type" = "theme" ]; then
    plugin_path=$ZSH_CUSTOM/themes
  elif [ "$type" = "plugin" ]; then
    plugin_path=$ZSH_CUSTOM/plugins
  else
    echo "Invalid type: $type"
    return 1
  fi

  plugin_path=$plugin_path/$name
  clone_or_pull "$repo" "$plugin_path"
}

# === Install OMZ themes and plugins
install_omz_plugin theme powerlevel10k https://github.com/romkatv/powerlevel10k.git
install_omz_plugin plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions.git

echo "✅ macOS shell environment setup complete!"

# === Apply dotfile symlinks
echo "🛠 Applying dotfile symlinks..."
bash ./symlinks.sh