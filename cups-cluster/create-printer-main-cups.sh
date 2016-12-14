#!/bin/bash

die () {
	echo >&2 "$@"
	exit 1
}

[ "$#" -eq 1  ] || die "1 argument required (the configuration file), $# provided"

source ./$1

sh _do-tier1-queues.sh -q1 $QUEUE_NAME1 \
			-q2 $QUEUE_NAME2 \
			-h1 $CUPS_CLUSTER_HOST1 \
			-h2 $CUPS_CLUSTER_HOST2 \
		       	-c $COUNTER
