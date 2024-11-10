#!/usr/bin/env sh

[[ $(whereis hyprsunset | cut -d':' -f2) ]] || exit 1
[[ $(whereis sunwait | cut -d':' -f2) ]] || exit 1

LAT=$1
LNG=$2

DAYNIGHT=$(sunwait poll civil ${LAT} ${LNG})

[[ $DAYNIGHT == "DAY" ]] && hyprsunset -i || hyprsunset -t 4000

