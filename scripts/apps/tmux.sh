#!/bin/env bash

# tmux config directory
mkdir -p ~/.config/tmux/

# refs: https://github.com/tmux-plugins/tpm
# clone tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# reload tmux environment so tpm is sourced

# install plugins
bash ~/.tmux/plugins/tpm/bin/install_plugins
