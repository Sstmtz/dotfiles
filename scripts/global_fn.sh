#!/usr/bin/env bash

# shellcheck disable=SC2034
src_dir=$HOME/.local/share/chezmoi

# Aur Helper
aurList=("yay" "paru")

# Colored text
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
SKY_BLUE="$(tput setaf 6)"
ORANGE="$(tput setaf 214)"
RESET="$(tput sgr0)"
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
WARN="$(tput setaf 214)[WARN]$(tput sgr0)"
ACTION="$(tput setaf 6)[ACTION]$(tput sgr0)"

# Create Directory for Install Logs
if [ ! -d "$src_dir/Logs" ]; then
	mkdir "$src_dir/Logs"
fi
LOG="$src_dir/Logs/install-$(date +%d-%H%M%S)_base.log"

# Check if package is installed
pkg_installed() {
	local PkgIn=$1

	if pacman -Qi "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

# Check if package is available
pkg_available() {
	local PkgIn=$1

	if pacman -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

# check if aur package is available
aur_available() {
	local PkgIn=$1

	# shellcheck disable=SC2154
	if ${aurhlpr} -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

# Check if at least one of the software packages in the list is installed.
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

# Colored log output
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
			echo -ne "\e[30;46m $2 \e[0m"
			shift 2
			;; # status
		-crit)
			echo -ne "\e[97;41m $2 \e[0m"
			shift 2
			;; # critical
		-warn)
			echo -ne "\e[97;43m $2 \e[0m"
			shift 2
			;; # warning
		-err)
			echo -ne "\e[4;31m$2\e[0m"
			shift 2
			;; #error
		+)
			echo -ne "\e[38;5;$2m$3\e[0m"
			shift 3
			;; # Set color manually
		*)
			echo -ne "$1"
			shift
			;;
		esac
	done
	echo ""
}

# Display installation progress animation
show_progress() {
	local pid=$1
	local package_name=$2
	local spin_chars=("●○○○○○○○○○" "○●○○○○○○○○" "○○●○○○○○○○" "○○○●○○○○○○" "○○○○●○○○○"
		"○○○○○●○○○○" "○○○○○○●○○○" "○○○○○○○●○○" "○○○○○○○○●○" "○○○○○○○○○●")
	local i=0

	tput civis # hide cursor
	printf "\r${INFO} Installing ${YELLOW}%s${RESET} ..." "$package_name"

	# draw loop animations
	while ps -p $pid &>/dev/null; do
		printf "\r${INFO} Installing ${YELLOW}%s${RESET} %s" "$package_name" "${spin_chars[i]}"
		i=$(((i + 1) % 10))
		sleep 0.3
	done

	printf "\r${INFO} Installing ${YELLOW}%s${RESET} ... Done!%-20s \n" "$package_name" ""
	tput cnorm # show cursor
}

# Install arch package
install_pkg() {
	(
		stdbuf -oL sudo pacman -S --noconfirm "$1" 2>&1
	) >>"$LOG" 2>&1 &

	PID=$!
	show_progress $PID "$1"

	if pkg_installed "$1"; then
		print_log -g "[OK] " "Package " -y "${1} " "has been successfully installed!"
	else
		print_log -r "[ERROR] " -y "${1} " "failed to install. Please check the $LOG. You may need to install manually."
	fi

}

# Install aur package
install_aur() {
	(
		stdbuf -oL "${aurhlpr}" -S --noconfirm "$1" 2>&1
	) >>"$LOG" 2>&1 &
	PID=$!
	show_progress $PID "$1"

	if pkg_installed "$1"; then
		print_log -g "[OK] " "Package " -y "${1} " "has been successfully installed!"
	else
		print_log -r "[ERROR] " -y "${1} " "failed to install. Please check the $LOG. You may need to install manually."
	fi

}
