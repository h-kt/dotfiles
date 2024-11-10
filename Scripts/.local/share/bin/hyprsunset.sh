#!/usr/bin/env sh

[[ $(whereis hyprsunset | cut -d':' -f2) ]] || exit 1
[[ $(whereis sunwait | cut -d':' -f2) ]] || exit 1

LAT=$1
LNG=$2

SUNRISE=$(sunwait list sunrise ${LAT} ${LNG})
SUNSET=$(sunwait list sunset ${LAT} ${LNG})

RH=$(echo ${SUNRISE} | cut -d':' -f1)
RM=$(echo ${SUNRISE} | cut -d':' -f2)

SH=$(echo ${SUNET} | cut -d':' -f1)
SM=$(echo ${SUNSET} | cut -d':' -f2)

HH=$(date +%H)
MM=$(date +%M)

if [[ $HH -gt $SR && $MM -gt $SM ]]; then
	hyprsunset -i
else
	hyprsunset -t 4200
fi
