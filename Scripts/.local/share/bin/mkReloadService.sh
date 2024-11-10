#!/usr/bin/env sh

SERVICE_FILE="sunsetReload.timer"
LAT=${1}
LNG=${2}

systemctl --user stop ${SERVICE_FILE}

cat <<EOF > ${HOME}/.config/systemd/user/${SERVICE_FILE}
[Unit]
Description=Run Reload Script at sunset

[Timer]
OnCalendar=*-*-* $(sunwait list sunset ${LAT} ${LNG}):00
OnCalendar=*-*-* $(sunwait list sunrise ${LAT} ${LNG}):00
OnActiveSec=10s
Unit=sunsetReload.service

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload
systemctl --user start ${SERVICE_FILE}
