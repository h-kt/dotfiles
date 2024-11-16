#!/usr/bin/env sh

SERVICE_FILE="refreshWallpaper.timer"

. "${HOME}"/.local/share/bin/walLib.sh

if [ "$NUM_WAL" = 2 ]; then
	onCalendar=$(echo "OnCalendar=*-*-* $(sunwait list civil sunrise "${LAT}" "${LNG}"):00" && echo "OnCalendar=*-*-* $(sunwait list civil sunset "${LAT}" "${LNG}"):00")
else
	onCalendar=$(for i in $(seq 1 "$NUM_WAL"); do echo "OnCalendar=*-*-* $(getHHMM "$i"):00"; done)
fi

systemctl --user stop ${SERVICE_FILE}

cat <<EOF > "${HOME}"/.config/systemd/user/"${SERVICE_FILE}"
[Unit]
Description=Refresh wallpaper

[Timer]
${onCalendar}
OnActiveSec=3s
Unit=setWallpaper.service

[Install]
WantedBy=timers.target
EOF

cat "${HOME}"/.config/systemd/user/"${SERVICE_FILE}"

systemctl --user daemon-reload
systemctl --user start "${SERVICE_FILE}"
