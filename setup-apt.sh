#!/bin/bash
set -euo pipefail

echo "🚀 Setting up Ubuntu development environment..."

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# === Essentials
ESSENTIALS=(
  git
  curl
  wget
  unzip
  build-essential
  software-properties-common
  ca-certificates
  gnupg
  lsb-release
  libssl-dev
)

echo "📦 Installing essential packages..."
sudo apt install -y "${ESSENTIALS[@]}"

# === Developer CLI tools
DEV_TOOLS=(
  stow # symlink manager
  neovim # vim alternative
  bat # cat alternative
  fd-find # find alternative
  fzf # fuzzy finder
  htop # process viewer
  tmux # terminal multiplexer
  tldr # man alternative
)

echo "📦 Installing dev tools..."
sudo apt install -y "${DEV_TOOLS[@]}"

# === Install zoxide
if ! command -v zoxide >/dev/null; then
  echo "🔍 Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  source ~/.bashrc
fi

# === Install FNM
if ! command -v fnm >/dev/null; then
  echo "🔍 Installing FNM..."
  curl -fsSL https://fnm.vercel.app/install | bash
  source ~/.bashrc
fi

# === Install Starship
if ! command -v starship >/dev/null; then
  echo "🔍 Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh
  source ~/.bashrc
fi

# === Symlink bat and fd correctly on Ubuntu (they have different names)
if ! command -v bat >/dev/null; then
  mkdir -p ~/.local/bin
  ln -sf "$(which batcat)" ~/.local/bin/bat
  echo "🪄 Symlinked batcat → bat"
fi

if ! command -v fd >/dev/null; then
  mkdir -p ~/.local/bin
  ln -sf "$(which fdfind)" ~/.local/bin/fd
  echo "🪄 Symlinked fdfind → fd"
fi

# === Source profile
source ~/.profile

# === Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💡 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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
  local base_path="$HOME/.oh-my-zsh"

  local target_dir

  if [ "$type" = "theme" ]; then
    plugin_path=$base_path/themes
  elif [ "$type" = "plugin" ]; then
    plugin_path=$base_path/plugins
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
install_omz_plugin plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git

# === Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "🔄 Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

echo "✅ Setup complete!"

# === Apply dotfile symlinks
echo "🛠 Applying dotfile symlinks..."
bash ./symlinks.sh
