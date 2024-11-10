#!/usr/bin/env sh

[[ -f ${HOME}/.cache/wal/colors.json ]] || exit 1

COLORS_JSON=$(cat ${HOME}/.cache/wal/colors.json)
HYPR_COLOR=${HOME}/.config/hypr/colors.conf

background=$(jq -r '.special.background' < <(echo ${COLORS_JSON}) | cut -d'#' -f2)
foreground=$(jq -r '.special.foreground' < <(echo ${COLORS_JSON}) | cut -d'#' -f2)
colors=$(for i in $(seq 0 15); do echo "\$color$i = rgb("$(jq -r ".colors.color${i}" < <(echo ${COLORS_JSON}) | cut -d'#' -f2)")"; done)

cat <<EOF > ${HYPR_COLOR}
\$background = rgb($background)
\$foreground = rgb($foreground)
$colors
EOF

