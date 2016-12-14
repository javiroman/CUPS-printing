#!/bin/bash
#
# lpadmin -p IMPRESD -m drv:///sample.drv/generic.ppd -v socket://10.99.28.48:9100 -E

display_usage() {
	echo "Usage: create-tier1-queue.sh --queue IMPREOFI --host1 192.168.0.1 --host2 192.168.0.2 --counter 2"
	echo "-q1 --queue1   QUEUE              The printer queue name 1"
	echo "-q2 --queue2   QUEUE              The printer queue name 2"
	echo "-h1 --host1    [IP, hostname]     One CUPS server in the cluster"
	echo "-h2 --host2    [IP, hostname]     Other CUPS server in the cluster"
	echo "-c --counter   N                  N iterations for the loop, the number of shops"
	exit 1
}

create_entry_cups() {
	lpadmin -p ${1}-${QUEUE_NAME1} \
		-m drv:///sample.drv/generic.ppd \
		-v socket://${ADDR_PRN1}:9100 -E
	lpadmin -p ${1}-${QUEUE_NAME2} \
		-m drv:///sample.drv/generic.ppd \
		-v socket://${ADDR_PRN2}:9100 -E
}

[  $# -le 1  ] && display_usage 

while [[ $# > 1 ]]; do
	key="$1"
	case $key in
	    -q1|--queue1)
	    QUEUE_NAME1="$2"
	    shift # past argument
	    ;;
	    -q2|--queue2)
	    QUEUE_NAME2="$2"
	    shift # past argument
	    ;;
	    -p1|--printer1)
	    ADDR_PRN1="$2"
	    shift # past argument
	    ;;
	    -p2|--pirnter2)
	    ADDR_PRN2="$2"
	    shift # past argument
	    ;;
	    -c|--counter)
	    COUNTER="$2"
	    ;;
	    *)
		    # unknown option
	    ;;
	esac
	shift # past argument or value
done

echo "queue name 1   = ${QUEUE_NAME1}"
echo "queue name 2   = ${QUEUE_NAME2}"
echo "pirnter for queue ${QUEUE_NAME1} = ${ADDR_PRN1}"
echo "printer for queue ${QUEUE_NAME2} = ${ADDR_PRN2}"
echo "counter        = ${COUNTER}"

x=1
while [ $x -le $COUNTER ]; do
	# padding zeroes to left
	shop="Tienda-$(printf %04d ${x})"
	create_entry_cups $shop
	x=$(( $x + 1  ))
done

