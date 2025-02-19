# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█
# scripts

# Display Pokemon (need install pokemon-colorscripts-git or pokego-bin)
# pokemon-colorscripts --no-title -r 1,3,6
pokego --no-title -random 1,3,6

# Detect AUR wrapper
if pacman -Qi yay >/dev/null
    set aurhelper yay
else if pacman -Qi paru >/dev/null
    set aurhelper paru
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# ▄▀█ █░░ █ ▄▀█ █▀
# █▀█ █▄▄ █ █▀█ ▄█
# alias

# Common
alias cls='clear' # clear terminal
alias mkdir='mkdir -p' # create directory

# List shortcuts
alias l='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree

# Dirctory navigation shortcuts
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

# Git
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gp='git push'

# █▀ █▀▀ ▀█▀
# ▄█ ██▄ ░█░
# set

# Path related
set PATH $PATH $HOME/.local/share/bin # add local bin to PATH
set DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock # set local docker socket

# Universal Variables
set -U EDITOR nvim # set default text editor

# █▀ █▀█ █░█ █▀█ █▀▀ █▀▀
# ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄
# source

# [starship]
# starship init fish | source
# [zoxide]
zoxide init fish | source
