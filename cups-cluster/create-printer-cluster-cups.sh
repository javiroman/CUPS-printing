#!/bin/bash

die () {
	echo >&2 "$@"
	exit 1
}

[ "$#" -eq 1  ] || die "1 argument required (the configuration file), $# provided"

source ./$1

sh _do-tier2-queues.sh -q1 $QUEUE_NAME1 \
			-q2 $QUEUE_NAME2 \
			-p1 $ADDR_PRN1 \
			-p2 $ADDR_PRN2 \
		       	-c $COUNTER
