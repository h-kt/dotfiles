export PATH="${PATH}:${HOME}/.local/share/bin"
export VDPAU_DRIVER=radeonsi
export WAL_DIR="/btrfs/persist/home/m9b/Storage/Pictures/Wallpapers/MontereyGraphic"
export LAT="49.8954N"
export LNG="97.1385W"
export TZ="America/Winnipeg"

if uwsm check may-start && uwsm select; then
	exec systemd-cat -t uwsm_start uwsm start default
fi

