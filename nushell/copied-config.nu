# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# -------------------------------------------------------------------------- #
#                                    Path                                    #
# -------------------------------------------------------------------------- #


# -------------------------------------------------------------------------- #
#                                    Alias                                   #
# -------------------------------------------------------------------------- #

alias finder = ^open
alias p = pnpm
alias c = clear
alias cls = clear
alias py = python3
alias pip = pip3
alias fzff = fzf --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'

# IOS / Android Simulator
alias simulator_list = xcrun simctl list devices
def emulator_run [] {
  emulator -list-avds | lines | skip 1 | input list | emulator -avd $in
}

# -------------------------------------------------------------------------- #
#                                   Scripts                                  #
# -------------------------------------------------------------------------- #
# ref: https://github.com/nushell/nu_scripts

source ~/.config/nushell/prompts/starship.nu

source ~/.config/nushell/completions/adb-completions.nu
source ~/.config/nushell/completions/docker-completions.nu
source ~/.config/nushell/completions/git-completions.nu
source ~/.config/nushell/completions/make-completions.nu
source ~/.config/nushell/completions/npm-completions.nu
source ~/.config/nushell/completions/pnpm-completions.nu
source ~/.config/nushell/completions/ssh-completions.nu
source ~/.config/nushell/completions/yarn-v4-completions.nu

# source ~/.config/nushell/zoxide.nu

# -------------------------------- Starship -------------------------------- #
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")