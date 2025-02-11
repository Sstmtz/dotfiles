#!/usr/bin/env bash

set -e

scrDir=$(dirname "$(realpath "$0")")
if ! source "${scrDir}/global_fn.sh"; then
	echo "Error: unable to source global_fn.sh..."
	exit 1
fi

chk_list "aurhlpr" "${aurList[@]}"
listPkg="${1:-"${scrDir}/packages.lst"}"
archPkg=()
aurhPkg=()

print_log -stat "NOTE" " - Fetching the list of packages to be installed ..."
while IFS= read -r line; do
	if [[ ! $line =~ ^# ]]; then
		pkg=$(echo "$line" | awk '{print $1}' | xargs)
		if [[ -n $pkg ]]; then
			if pkg_installed "${pkg}"; then
				print_log -y "[SKIP] " -g "${pkg} " "is already installed. Skipping..."
			elif pkg_available "${pkg}"; then
				archPkg+=("${pkg}")
				print_log -b "[QUEUE] " -m "${pkg} " "is not installed. Queuing..."
			elif aur_available "${pkg}"; then
				aurhPkg+=("${pkg}")
				print_log -b "[QUEUE] " -m "${pkg} " "is not installed. Queuing..."
			else
				print_log -r "[ERROR] " -err "Unknown package ${pkg}"
			fi
		fi
	fi
done <"${listPkg}"

printf "\n"

# Install packages
if [[ ${#archPkg[@]} -gt 0 ]]; then
	print_log -stat "NOTE" " - Installing the required " -b "Arch packages " "..."
	for pkg in "${archPkg[@]}"; do
		install_pkg "${pkg}" "$LOG"
	done
fi

if [[ ${#aurhPkg[@]} -gt 0 ]]; then
	print_log -stat "NOTE" " - Installing the required " -b "AUR packages " "..."
	for pkg in "${aurhPkg[@]}"; do
		install_aur "${pkg}" "$LOG"
	done
fi

printf "\n%.0s" {1..2}
