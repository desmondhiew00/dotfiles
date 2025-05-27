$env.path ++= ["~/.local/bin"]
$env.path ++= ["/snap/bin"]
$env.path ++= ["~/go/bin"]

source ~/.config/nushell/completions/adb-completions.nu
source ~/.config/nushell/completions/docker-completions.nu
source ~/.config/nushell/completions/git-completions.nu
source ~/.config/nushell/completions/make-completions.nu
source ~/.config/nushell/completions/npm-completions.nu
source ~/.config/nushell/completions/pnpm-completions.nu
source ~/.config/nushell/completions/ssh-completions.nu
source ~/.config/nushell/completions/yarn-v4-completions.nu

source ~/.config/nushell/zoxide.nu

# === Aliases
alias c = clear
alias python = python3
alias py = python3
alias pip = pip3
alias p = pnpm

# Starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Python
$env.PYENV_ROOT = "~/.pyenv" | path expand
if (( $"($env.PYENV_ROOT)/bin" | path type ) == "dir") {
  $env.PATH = $env.PATH | prepend $"($env.PYENV_ROOT)/bin" }
$env.PATH = $env.PATH | prepend $"(pyenv root)/shims"