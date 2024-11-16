#!/usr/bin/env sh

. "${HOME}"/.profile


LAST_DAY="$(cat /tmp/sunsetDate)"
TODAY="$(date +%_d)"

[ "${LAST_DAY}" != "${TODAY}" ] && mkReloadService.sh

systemctl restart --user sunset.service

