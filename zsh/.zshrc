# Load Zsh completion system
autoload -Uz compinit
compinit

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

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

# pnpm
# export PNPM_HOME="/opt/homebrew/bin/pnpm"
# export PATH="$PNPM_HOME:$PATH"

# snap
export PATH=$PATH:/snap/bin

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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

# go 
alias air='$GOPATH/bin/air'

# ---------------------------------------------------------------------------- #
#                                      CLI                                     #
# ---------------------------------------------------------------------------- #

# FNM (Fast Node Manager)
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# FZF
export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type f --hidden --strip-cwd-prefix --exclude .git --exclude node_modules"

# Zoxide
eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/home/hiew/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/hiew/.bun/_bun" ] && source "/home/hiew/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# python
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
eval "$(pyenv init - zsh)"
