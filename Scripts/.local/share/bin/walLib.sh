#!/usr/bin/env sh

S_IN_DAY=86400
S_IN_H=3600
S_IN_M=60

NUM_WAL="$(ls -l $WAL_DIR | wc -l)"
NUM_WAL=$(( NUM_WAL - 1 ))
INTERVAL=$(( S_IN_DAY / NUM_WAL ))

getHH() {
	local i=${1}
	local hours=$(( ( INTERVAL * i ) / S_IN_H ))
	hours=$(( hours % 24 ))
	echo ${hours}
}


getMM() {
	local i=${1}
	local minutes=$(( ( ( INTERVAL * i ) % S_IN_H ) / S_IN_M ))
	minutes=$(( minutes % 60 ))
	echo ${minutes}
}

getHHMM() {
	local i=${1}
	echo $(getHH $i):$(getMM $i)
}
