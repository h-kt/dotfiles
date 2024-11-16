#!/usr/bin/env sh

. "${HOME}"/.profile
. "${HOME}"/.local/share/bin/walLib.sh

[ -d "${WAL_DIR}" ] || exit 1
[ "${NUM_WAL}" -gt 0 ] || exit 1
[ -f "$(whereis hyprctl | cut -d':' -f2 | cut -d' ' -f2)" ] || exit 1
[ -f "$(whereis hyprpaper | cut -d':' -f2 | cut -d' ' -f2)" ] || exit 1
[ -f "$(whereis sunwait | cut -d':' -f2 | cut -d' ' -f2)" ] || echo exit 1


HH=$(LANG=en_GB.UTF-8 date +%_H)
MM=$(LANG=en_GB.UTF-8 date +%_M)

WALLPAPERS="$(/usr/bin/env find "${WAL_DIR}"/*)"

getDayNightIndex() {
	[ "$(sunwait poll civil "${LAT}" "${LNG}")" = "DAY" ] && echo 1 || echo "$NUM_WAL"
}

getWalPath() {
	SELECTED_INDEX=0
	for i in $( seq 1 "$NUM_WAL" ); do
		h=$( getHH "$i" )
		m=$( getMM "$i" )
		[ "$h" -eq 0 ] && h=24
		[ "$HH" -lt "$h" ] && SELECTED_INDEX="$i" && break
		[ "$HH" -eq "$h" ] && [ "$MM" -le "$m" ] && SELECTED_INDEX="$i" && break
	done
	[ "$NUM_WAL" -gt 0 ] && [ "$NUM_WAL" -le 4 ] && SELECTED_INDEX=$(getDayNightIndex)
	sel=$(echo "$WALLPAPERS" | awk "NR==$SELECTED_INDEX {print \$1}")
	echo "$sel" > /tmp/currWal && echo "$sel"
}

WALLPAPER=$(getWalPath)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ", $WALLPAPER"
hyprctl hyprpaper unload unused

wal -i "$WALLPAPER" --saturate 0.5 --cols16 lighten --backend colorz -o "${HOME}/.local/share/bin/hyprColourFromWal.sh"
