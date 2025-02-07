# █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀
# █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█
# plugins

# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh/

# List of plugins used
plugins=(
  git
  sudo
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# ▀█▀ █░█ █▀▀ █▀▄▀█ █▀▀
# ░█░ █▀█ ██▄ █░▀░█ ██▄
# theme

# Powerlevel10k theme
# # Powerlevel10k theme path
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Starship
# https://starship.rs/presets/
# choose a preset theme you like. for example, "Gruvbox Rainbow Preset"
# run `starship preset gruvbox-rainbow -o ~/.config/starship.toml`
eval "$(zoxide init zsh)" # enable zoxide

# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█
# scripts

# Display Pokemon (need install pokemon-colorscripts-git)
pokemon-colorscripts --no-title -r 1,3,6

# In case a command is not found, try to find the package that has it
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

# Add the context of .env to environment
temp_file=$(mktemp)
grep -v '\s*#' $HOME/.env > "$temp_file"
eval export $(envsubst < "$temp_file")
rm "$temp_file"

# ▄▀█ █░░ █ ▄▀█ █▀
# █▀█ █▄▄ █ █▀█ ▄█
# alias

# Common
alias cls='clear'
alias mkdir='mkdir -p'

# List shortcuts
alias l='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree

# Directory navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Package manager shortcuts
alias un='$aurhelper -Rns' # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='code' # gui code editor

# Git
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gp='git push'

# █▀▀ ▀▄▀ █▀█ █▀█ █▀█ ▀█▀
# ██▄ █░█ █▀▀ █▄█ █▀▄ ░█░
# export

export EDITOR='nvim' # set default editor
export PATH=$PATH:$HOME/.local/share/bin # add local bin to PATH
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock # local docker socket

# █▀▀ █░█ ▄▀█ █░░
# ██▄ ▀▄▀ █▀█ █▄▄
# eval

eval "$(starship init zsh)" # enable starship
