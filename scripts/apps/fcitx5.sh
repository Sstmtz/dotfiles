#!/bin/env bash

input_method='INPUT_METHOD=fcitx'
xmodifiers='XMODIFIERS="@im=fcitx"'  # xim for xwayland support
sdl_im_module='SDL_IM_MODULE=fcitx'  # for sdl2 support
glfw_im_module='GLFW_IM_MODULE=ibus' # for glfw support. eg. kitty
# gtk_im_module='GTK_IM_MODULE=fcitx'  # for gtk support, only for x11
# qt_im_module='QT_IM_MODULE=fcitx'    # for qt support, only for x11

if ! grep -q "^$input_method" /etc/environment; then
	echo "$input_method" | sudo tee -a /etc/environment >/dev/null
fi

if ! grep -q "^$xmodifiers" /etc/environment; then
	echo "$xmodifiers" | sudo tee -a /etc/environment >/dev/null
fi

if ! grep -q "^$sdl_im_module" /etc/environment; then
	echo "$sdl_im_module" | sudo tee -a /etc/environment >/dev/null
fi

if ! grep -q "^$glfw_im_module" /etc/environment; then
	echo "$glfw_im_module" | sudo tee -a /etc/environment >/dev/null
fi

# only for x11
# if ! grep -q "^$gtk_im_module" /etc/environment; then
# 	echo "$gtk_im_module" | sudo tee -a /etc/environment >/dev/null
# fi

# only for x11
# if ! grep -q "^$qt_im_module" /etc/environment; then
# 	echo "$qt_im_module" | sudo tee -a /etc/environment >/dev/null
# fi

# References:
# https://wiki.archlinux.org/title/Fcitx5#IM_modules
# https://fcitx-im.org/wiki/Setup_Fcitx_5/zh-cn
