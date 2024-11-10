#!/usr/bin/env sh

SERVICE_FILE="refreshWallpaper.timer"

. ${HOME}/.local/share/bin/walLib.sh

onCalendar=$(for i in $(seq 1 $NUM_WAL); do echo "OnCalendar=*-*-* $(getHHMM $i):00"; done)

systemctl --user stop ${SERVICE_FILE}

cat <<EOF > ${HOME}/.config/systemd/user/${SERVICE_FILE}
[Unit]
Description=Refresh wallpaper

[Timer]
${onCalendar}
OnActiveSec=10s
Unit=setWallpaper.service

[Install]
WantedBy=timers.target
EOF

cat ${HOME}/.config/systemd/user/${SERVICE_FILE}

systemctl --user daemon-reload
systemctl --user start ${SERVICE_FILE}
