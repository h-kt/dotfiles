#!/usr/bin/env sh

. "${HOME}"/.profile

date +%_d > /tmp/sunsetDate

SERVICE_FILE="sunsetReload.timer"
DAYNIGHT="$(sunwait poll civil "${LAT}" "${LNG}")"

thisRise="$(sunwait list 1 sunrise civil "${LAT}" "${LNG}" )"
nextRise="$(sunwait list 1 sunrise civil d "$(date -d "+1 day" '+%_d')" m "$(date -d "+1 day" '+%_m')" y "$(date -d "+1 day" '+%_y')" "${LAT}" "${LNG}")"

thisSet="$(sunwait list 1 sunset civil "${LAT} ${LNG}" )"
nextSet="$(sunwait list 1 sunset civil d "$(date -d "+1 day" '+%_d')" m "$(date -d "+1 day" '+%_m')" y "$(date -d "+1 day" '+%_y')" "${LAT}" "${LNG}")"

if [ "${DAYNIGHT}" = "DAY" ]; then
	onCalRise="OnCalendar=*-*-* ${nextRise}:00"
	onCalSet="OnCalendar=*-*-* ${thisSet}:00"
else
	onCalRise="OnCalendar=*-*-* ${thisRise}:00"
	onCalSet="OnCalendar=*-*-* ${nextSet}:00"
fi

systemctl --user stop "${SERVICE_FILE}"

cat <<EOF > "${HOME}/.config/systemd/user/${SERVICE_FILE}"
[Unit]
Description=Run Reload Script at sunset

[Timer]
${onCalRise}
${onCalSet}
OnActiveSec=3s
Unit=sunsetReload.service

[Install]
WantedBy=timers.target
EOF

systemctl --user daemon-reload
systemctl --user start "${SERVICE_FILE}"
