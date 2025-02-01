#!/usr/bin/env bash

aurList=("yay" "paru")

pkg_installed() {
	local PkgIn=$1

	if pacman -Qi "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

pkg_available() {
	local PkgIn=$1

	if pacman -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

aur_available() {
	local PkgIn=$1

	# shellcheck disable=SC2154
	if ${aurhlpr} -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

chk_list() {
	vrType="$1"
	local inList=("${@:2}")
	for pkg in "${inList[@]}"; do
		if pkg_installed "${pkg}"; then
			printf -v "${vrType}" "%s" "${pkg}"
			# shellcheck disable=SC2163 # dynamic variable
			export "${vrType}" # export the variable // reference of the variable
			return 0
		fi
	done
	# print_log -sec "install" -warn "no package found in the list..." "${inList[@]}"
	return 1
}

print_log() {
	while (("$#")); do
		case "$1" in
		-r | +r)
			echo -ne "\e[31m$2\e[0m"
			shift 2
			;; # Red
		-g | +g)
			echo -ne "\e[32m$2\e[0m"
			shift 2
			;; # Green
		-y | +y)
			echo -ne "\e[33m$2\e[0m"
			shift 2
			;; # Yellow
		-b | +b)
			echo -ne "\e[34m$2\e[0m"
			shift 2
			;; # Blue
		-m | +m)
			echo -ne "\e[35m$2\e[0m"
			shift 2
			;; # Magenta
		-c | +c)
			echo -ne "\e[36m$2\e[0m"
			shift 2
			;; # Cyan
		-wt | +w)
			echo -ne "\e[37m$2\e[0m"
			shift 2
			;; # White
		-n | +n)
			echo -ne "\e[96m$2\e[0m"
			shift 2
			;; # Neon
		-stat)
			echo -ne "\e[30;46m $2 \e[0m :: "
			shift 2
			;; # status
		-crit)
			echo -ne "\e[97;41m $2 \e[0m :: "
			shift 2
			;; # critical
		-warn)
			echo -ne "WARNING :: \e[97;43m $2 \e[0m :: "
			shift 2
			;; # warning
		+)
			echo -ne "\e[38;5;$2m$3\e[0m"
			shift 3
			;; # Set color manually
		-err)
			echo -ne "ERROR :: \e[4;31m$2 \e[0m"
			shift 2
			;; #error
		*)
			echo -ne "$1"
			shift
			;;
		esac
	done
	echo ""
}
