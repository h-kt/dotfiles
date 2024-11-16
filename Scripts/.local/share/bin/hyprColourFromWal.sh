#!/usr/bin/env sh

[ -f "${HOME}"/.cache/wal/colors.json ] || exit 1

COLORS_JSON="$(cat "${HOME}"/.cache/wal/colors.json)"
HYPR_COLOR="${HOME}"/.config/hypr/colors.conf

background="$(echo "${COLORS_JSON}" | jq -r '.special.background' | cut -d'#' -f2)"
foreground="$(echo "${COLORS_JSON}" | jq -r '.special.foreground' | cut -d'#' -f2)"
colors=$(for i in $(seq 0 15); do echo "\$color$i = rgb(""$( echo "${COLORS_JSON}" | jq -r ".colors.color${i}" | cut -d'#' -f2)"")"; done)

cat <<EOF > "${HYPR_COLOR}"
\$background = rgb($background)
\$foreground = rgb($foreground)
$colors
EOF

