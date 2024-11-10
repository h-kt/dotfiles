#!/usr/bin/env sh

[[ "${1}" ]] && . "${1}" || . ${HOME}/.profile

[[ "${WAL_DIR}" ]] || exit 1
[[ $(ls -l "${WAL_DIR}" | wc -l) -gt 0 ]] || exit 1
[[ $(whereis hyprctl | cut -d':' -f2) ]] || exit 1
[[ $(whereis hyprpaper | cut -d':' -f2) ]] || exit 1

. ${HOME}/.local/share/bin/walLib.sh

HH=$(LANG=en_GB.UTF-8 date +%_H)
MM=$(LANG=en_GB.UTF-8 date +%_M)

WALLPAPERS=(${WAL_DIR}/*)

getWalPath() {
	local SELECTED_INDEX=0
	for i in $( seq 1 $NUM_WAL ); do
		local h=$( getHH $i )
		local m=$( getMM $i )
		[[ $h -eq 0 ]] && h=24
		[[ $HH -lt $h ]] && SELECTED_INDEX=$i && break
		[[ $HH -eq $h && $MM -le $m ]] && SELECTED_INDEX=$i && break
	done
	echo "${WALLPAPERS[${SELECTED_INDEX}]}"
}

WALLPAPER=$(getWalPath)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ", $WALLPAPER"
hyprctl hyprpaper unload unused

wal -i "$WALLPAPER" --saturate 0.5 --cols16 lighten --backend colorz -o "${HOME}/.local/share/bin/hyprColourFromWal.sh"
