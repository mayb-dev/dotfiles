#!/usr/bin/env zsh

REPO_URL="https://github.com/tmux-plugins/tpm"
DEST_DIR="$HOME/.config/tmux/plugins/tpm"

if [ ! -d "$DEST_DIR" ]; then
    echo "tmux plugin not found. Cloning repository..."
    git clone "$REPO_URL" "$DEST_DIR" --depth=1
fi   
