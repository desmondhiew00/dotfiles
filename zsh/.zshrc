# Load Zsh completion system
autoload -Uz compinit
compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# --------------------------------- Oh-My-Zsh -------------------------------- #
zstyle ':omz:update' mode auto

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  fnm
  fzf
  zsh-syntax-highlighting
  colored-man-pages
  extract
  npm
  yarn
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------------------------------------------------------- #
#                                     PATH                                     #
# ---------------------------------------------------------------------------- #

# Homebrew
export PATH="/opt/homebrew/sbin:$PATH"

# Android SDK
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"

# Go Lang
export GOPATH="$HOME/development/go"
export PATH="$PATH:$(go env GOPATH)/bin"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export GEM_HOME="$HOME/.gem"

# Flutter
export PATH="$HOME/development/flutter/bin:$PATH"

# DENO
export DENO_INSTALL="/Users/desmondhui/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/opt/homebrew/bin/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ---------------------------------------------------------------------------- #
#                                    Aliases                                   #
# ---------------------------------------------------------------------------- #

alias c='clear'
alias emulator-ios='open -a Simulator'
alias sleep='sudo pmset repeat sleep MTWRFSU $@'
alias python='python3'
alias py='python3'
alias pip='pip3'
alias p='pnpm'

# ---------------------------------------------------------------------------- #
#                                      CLI                                     #
# ---------------------------------------------------------------------------- #

# FNM (Fast Node Manager)
eval "$(fnm env --use-on-cd --shell zsh)"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# FZF
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules"

# zoxide
eval "$(zoxide init zsh)"
