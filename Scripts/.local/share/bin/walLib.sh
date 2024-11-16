#!/usr/bin/env sh

. "${HOME}"/.profile

S_IN_DAY=86400
S_IN_H=3600
S_IN_M=60

NUM_WAL="$(find "${WAL_DIR}"/* | wc -l)"
INTERVAL=$(( S_IN_DAY / NUM_WAL ))

getHH() {
	i=${1}
	hours=$(( ( INTERVAL * i ) / S_IN_H ))
	hours=$(( hours % 24 ))
	echo ${hours}
}

getMM() {
	i=${1}
	minutes=$(( ( ( INTERVAL * i ) % S_IN_H ) / S_IN_M ))
	minutes=$(( minutes % 60 ))
	echo ${minutes}
}

getHHMM() {
	i=${1}
	echo "$(getHH "$i"):$(getMM "$i")"
}
