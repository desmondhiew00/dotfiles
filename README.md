# 🏠 Dotfiles

> Personal macOS development environment configuration files

This repository contains my personal dotfiles and development environment setup for macOS. It includes configurations for various tools and applications I use daily.

## 📋 What's Included

- **Shell**: Zsh with Oh My Zsh, Powerlevel10k theme, and useful plugins
- **Editors**: Neovim, Cursor, Sublime Text, and Zed configurations  
- **Terminal**: Starship prompt and Nushell configurations
- **Tools**: Git, Karabiner-Elements (keyboard customization)
- **Package Management**: Homebrew with curated Brewfile
- **Extensions**: Curated list of VS Code/Cursor extensions

## 🚀 Quick Setup

### Prerequisites

### Applications Installed

- Cursor
- Sublime Text
- Zed
- Git
- Karabiner-Elements

### One-Command Setup

```bash
cd ~/dotfiles
bash ./setup-brew.sh
```

This will:

- Install Homebrew (if not already installed)
- Install all packages from the Brewfile
- Set up Oh My Zsh with themes and plugins
- Create symlinks for all configuration files

## 🔧 Manual Setup

If you prefer to set up components individually:

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Packages

```bash
brew bundle
```

### 3. Install Cursor Extensions

```bash
# Install all extensions from the curated list
while IFS= read -r extension; do
  cursor --install-extension "$extension"
done < cursor-extensions.txt
```

### 4. Install Fonts

```bash
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
```

### 5. Apply Configuration Symlinks

```bash
bash ./symlinks.sh
```

To force re-linking (overwrites existing configs):

```bash
bash ./symlinks.sh -f
```

## 📁 Directory Structure

```
dotfiles/
├── cursor/          # Cursor editor settings
├── git/             # Git configuration
├── karabiner/       # Karabiner-Elements config
├── nushell/         # Nushell shell configuration
├── nvim/            # Neovim configuration
├── starship/        # Starship prompt config
├── sublime/         # Sublime Text settings
├── zed/             # Zed editor configuration
├── zsh/             # Zsh shell configuration
├── Brewfile         # Homebrew package definitions
├── setup-brew.sh    # Automated setup script
└── symlinks.sh      # Configuration symlink manager
```

## 🛠 Customization

### Adding New Packages

Edit the `Brewfile` to add new packages:

```ruby
# Add to Brewfile
brew "package-name"
cask "app-name"
```

Then run:

```bash
brew bundle
```

### Managing Extensions

To update the extension list:

```bash
# Export current extensions
cursor --list-extensions > cursor-extensions.txt

# Or for VS Code
code --list-extensions > vscode-extensions.txt
```

### Modifying Configurations

All configuration files are organized in their respective directories. After making changes, run the symlink script to apply them:

```bash
bash ./symlinks.sh
```

## 🔄 Keeping Things Updated

### Update Homebrew Packages

```bash
brew update && brew upgrade
```

### Update Oh My Zsh

```bash
omz update
```

### Sync Dotfiles

```bash
cd ~/dotfiles
git pull origin main
bash ./symlinks.sh
```

## 🆘 Troubleshooting

### Backup and Restore

The symlink script automatically creates backups in `~/dotfiles_bak/` before applying new configurations.

To restore from backup:

```bash
cp -r ~/dotfiles_bak/* ~/
```

### Permission Issues

If you encounter permission issues:

```bash
sudo chown -R $(whoami) ~/dotfiles
```

### Reset Configuration

To start fresh:

```bash
bash ./symlinks.sh -f  # Force overwrite existing configs
```

## 📝 Notes

- Configuration files are managed using GNU Stow for clean symlink management
- Backups are automatically created before applying new configurations
- The setup is optimized for macOS but may work on other Unix-like systems with modifications

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs. If you find improvements or fixes, pull requests are welcome!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
