#!/usr/bin/env bash

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/global_fn.sh"; then
	echo "Error: unable to source global_fn.sh..."
	exit 1
fi

chk_list "aurhlpr" "${aurList[@]}"
listPkg="${1:-"${scrDir}/packages.lst"}"
archPkg=()
aurhPkg=()
locale=$(locale | grep LANG | cut -d= -f2)

while IFS= read -r line; do
	if [[ ! $line =~ ^# ]]; then
		pkg=$(echo "$line" | awk '{print $1}' | xargs)
		if [[ -n $pkg ]]; then
			if pkg_installed "${pkg}"; then
				print_log -y "[skip] " "${pkg} has installed."
			elif pkg_available "${pkg}"; then
				if [[ "$locale" == "en_US.UTF-8" ]]; then
					repo=$(pacman -Si "${pkg}" | awk -F ': ' '/Repository / {print $2}' | head -n 1)
				elif [[ "$locale" == "zh_CN.UTF-8" ]]; then
					repo=$(pacman -Si "${pkg}" | awk -F ': ' '/软件库 / {print $2}' | head -n 1)
				else
					echo "Unsupported locale: $locale"
				fi
				archPkg+=("${pkg}")
				print_log -b "[queue] " -g "${repo}" -b "::" "${pkg}"
			elif aur_available "${pkg}"; then
				aurhPkg+=("${pkg}")
				print_log -b "[queue] " -g "aur" -b "::" "${pkg}"
			else
				print_log -r "[error] " "unknown package ${pkg}..."
			fi
		fi
	fi
done <"${listPkg}"

if [[ ${#archPkg[@]} -gt 0 ]]; then
	print_log -b "[install] " "arch packages..."
	sudo pacman -S "${archPkg[@]}"
fi

if [[ ${#aurhPkg[@]} -gt 0 ]]; then
	print_log -b "[install] " "aur packages..."
	"${aurhlpr}" -S "${aurhPkg[@]}"
fi
