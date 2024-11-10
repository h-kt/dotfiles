#!/usr/bin/env sh

[[ $(whereis hyprctl | cut -d':' -f2) ]] || exit 1
[[ $(whereis hyprpaper | cut -d':' -f2) ]] || exit 1
 
hyprctl hyprpaper preload "${1}"
hyprctl hyprpaper wallpaper ", ${1}"
hyprctl hyprpaper unload unused

wal -i "${1}" --saturate 0.5 --cols16 lighten --backend colorz -o "${HOME}/.local/share/bin/hyprColourFromWal.sh"
