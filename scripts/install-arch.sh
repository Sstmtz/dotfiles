#!/usr/bin/env bash

# Colorful Echo
ERROR() {
  echo -e "\033[0;31m[ERROR]\033[0m $@"
  exit 1
}
OK() {
  echo -e "\033[0;32m[OK]\033[0m $@"
}
WARNING() {
  echo -e "\033[0;33m[WARNING]\033[0m $@"
}
INFO() {
  echo -e "\033[0;34m[INFO]\033[0m $@"
}
SKIP() {
  echo -e "\033[0;36m[SKIP]\033[0m $@"
}

# Check if package is already installed 
pkg_is_installed() {
  local PkgIn=$1
  if pacman -Qi "${PkgIn}" &> /dev/null; then 
    return 0 
  else 
    return 1 
  fi 
}

# Check if package is available in AUR 
aurhlpr=(yay paru)
aur_available() {
  local PkgIn=$1
  if ${aurhlpr} -Si "${PkgIn}" &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Clean and Exit if user interrupte 
cleanup_and_exit() {
  WARNING "Script interrupted by user." 
  exit 130
}

# Check if path is already existed
path_is_exist() {
  local Path=$1 
  if [ -d ${Path} ] || [ -f "${Path}" ]; then
    ERROR "The file or directory ${Path} is already exist."
    return 1
  fi
  return 0
}



set -e 
trap 'cleanup_and_exit' SIGINT


# Update pacman database 
INFO "Update pacman database, please wait..."
sudo pacman -Sy


# Install base packages 
package_list=("wget" "curl" "git" "npm" "tar" "make" "cmake" "ninja" \ 
              "eza" "fzf" "ripgrep" "fd" "bat" "zoxide" "glow" "ouch" "ueberzugpp" \ 
              "neovim" "yazi" "tmux" "zsh" "kitty" "nodejs")

INFO "Installing base packages, please wait..."
for Pkg in ${package_list[@]}; do
  if pkg_is_installed "${Pkg}"; then
    SKIP "${Pkg} is already installed"
  else 
    sudo pacman -S "${Pkg}"
  fi
done 
OK "Base packages have been installed successfully!!!"
sleep 1


# Install plugins 
tmux_dir="${HOME}/.config/tmux" 
yazi_dir="${HOME}/.config/yazi"

INFO "[tmux] Installing tpm..."
if path_is_exist "${HOME}/.config/tmux/plugins/tpm"; then 
  git clone https://github.com/tmux-plugins/tpm ${tmux_dir}/plugins/tpm
fi 

INFO "[yazi] Installing glow.yazi"
if path_is_exist "${HOME}/.config/yazi/plugins/glow.yazi"; then 
  git clone https://github.com/Reledia/glow.yazi.git ${yazi_dir}/plugins/glow.yazi
fi

INFO "[yazi] Installing miller.yazi"
if path_is_exist "${HOME}/.config/yazi/plugins/miller.yazi"; then 
  git clone https://github.com/Reledia/miller.yazi.git ${yazi_dir}/plugins/miller.yazi 
fi 

INFO "[yazi] Installing eza-preview.yazi"
if path_is_exist "${HOME}/.config/yazi/plugins/eza-preview.yazi"; then 
  git clone https://github.com/sharklasers996/eza-preview.yazi ${yazi_dir}/plugins/eza-preview.yazi
fi

INFO "[yazi] Installing ouch.yazi"
if path_is_exist "${HOME}/.config/yazi/plugins/ouch.yazi"; then 
  git clone https://github.com/ndtoan96/ouch.yazi.git ${yazi_dir}/plugins/ouch.yazi
fi 



