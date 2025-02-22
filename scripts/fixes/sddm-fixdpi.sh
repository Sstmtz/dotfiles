#!/bin/env bash

# add the following content to the `/etc/sddm.conf.d/dpi.conf`:
#
# [General]
# GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192

dpi_config="/etc/sddm.conf.d/dpi.conf"

if [ ! -f "/etc/sddm.conf.d/dpi.conf" ]; then
	sudo mkdir -p /etc/sddm.conf.d/dpi.conf
	echo "[General]" | sudo tee -a /etc/sddm.conf.d/dpi.conf
	echo "GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192" | sudo tee -a /etc/sddm.conf.d/dpi.conf
else
	if grep -q "[General]" "$dpi_config" && grep -q "GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192" "$dpi_config"; then
		exit
	else
		echo "[General]" | sudo tee -a /etc/sddm.conf.d/dpi.conf
		echo "GreeterEnvironment=QT_SCREEN_SCALE_FACTORS=2,QT_FONT_DPI=192" | sudo tee -a /etc/sddm.conf.d/dpi.conf
	fi
fi
