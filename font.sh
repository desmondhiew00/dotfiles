# # === Fonts (Nerd Fonts)
# echo "🔤 Installing Nerd Font (Fira Code)..."
# FONT_DIR="$HOME/.local/share/fonts"
# mkdir -p "$FONT_DIR"

# if [ ! -f "$FONT_DIR/FiraMono.zip" ]; then
# curl -fsSL -o "$FONT_DIR/FiraMono.zip" \
#   "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip"
#   unzip -o "$FONT_DIR/FiraMono.zip" -d "$FONT_DIR"
#   fc-cache -fv
# fi