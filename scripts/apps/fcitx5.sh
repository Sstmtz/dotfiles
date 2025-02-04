#!/bin/env bash

# set input method variables
echo 'INPUT_METHOD=fcitx' | sudo tee /etc/environment >/dev/null
# xim for xwayland support
echo 'XMODIFIERS="@im=fcitx"' | sudo tee /etc/environment >/dev/null
# for sdl2 support
echo 'SDL_IM_MODULE=fcitx' | sudo tee /etc/environment >/dev/null
# for glfw support. eg. kitty
ehco 'GLFW_IM_MODULE=ibus' | sudo tee /etc/environment >/dev/null

# for gtk support, only for x11
# echo 'GTK_IM_MODULE=fcitx' | sudo tee /etc/environment >/dev/null
# for qt support, only for x11
# echo 'QT_IM_MODULE=fcitx' | sudo tee /etc/environment >/dev/null

# References:
# https://wiki.archlinux.org/title/Fcitx5#IM_modules
# https://fcitx-im.org/wiki/Setup_Fcitx_5/zh-cn
