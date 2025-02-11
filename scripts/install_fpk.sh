#!/usr/bin/env bash

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/global_fn.sh"; then
	echo "Error: unable to source global_fn.sh..."
	exit 1
fi

listFpk=$(awk -F '#' '{print $1}' "${1}" | sed 's/ //g' | xargs)
locale=$(locale | grep LANG | cut -d= -f2)

# Check if flatpak is installed
if ! pkg_installed flatpak; then
	sudo pacman -S flatpak
fi

# Add flathub repo url
if [[ "$locale" == "en_US.UTF-8" ]]; then
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
elif [[ "$locale" == "zh_CN.UTF-8" ]]; then
	flatpak remote-add --if-not-exists flathub https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo
fi

# Install apps from remote flathub
flatpak install flathub ${listFpk}
flatpak remove --unused
