#!/usr/bin/env sh

[ -f "$(whereis hyprsunset | cut -d':' -f2 | cut -d' ' -f2)" ] || exit 1
[ -f "$(whereis sunwait | cut -d':' -f2 | cut -d' ' -f2)" ] || exit 1

. "${HOME}"/.profile

DAYNIGHT="$(sunwait poll civil "${LAT}" "${LNG}")"

if [ "$DAYNIGHT" = "DAY" ]; then
	hyprsunset -i
else
	hyprsunset -t 4000
fi

