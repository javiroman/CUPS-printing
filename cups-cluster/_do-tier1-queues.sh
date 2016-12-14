#!/bin/bash
#
# - lpadmin command PDF testing driver
#
# lpadmin -p JAVI-QUEUE -E -P /usr/share/cups/model/CUPS-PDF.ppd \
#         -v http://localhost:631/printers/IMPREOFI
#
# - lpadmin command for geneneric Postscript driver:
#
# lpadmin -p JAVI-QUEUE -m drv:///sample.drv/generic.ppd \
#         -v socket://localhost -E
# 
# - Create virtual queue (implicit class queue) with two clustered CUPS servers (the tier 2 servers):
#
# lpadmin -p ${QUEUE_NAME}@${CLUSTER_HOST1} \
#         -E -P /usr/share/cups/model/CUPS-PDF.ppd \
#         -v http://${CLUSTER_HOST1}:631/printers/${QUEUE_NAME}
# lpadmin -p ${QUEUE_NAME}@${CLUSTER_HOST2} \
#         -E -P /usr/share/cups/model/CUPS-PDF.ppd \
#         -v http://${CLUSTER_HOST1}:631/printers/${QUEUE_NAME}


display_usage() {
	echo "Usage: create-tier1-queue.sh --queue IMPREOFI --host1 192.168.0.1 --host2 192.168.0.2 --counter 2"
	echo "--mainhost     The printer queue name 1"
	echo "--clusterhost  The printer queue name 1"
	echo "-q1 --queue1   QUEUE              The printer queue name 1"
	echo "-q2 --queue2   QUEUE              The printer queue name 2"
	echo "-h1 --host1    [IP, hostname]     One CUPS server in the cluster"
	echo "-h2 --host2    [IP, hostname]     Other CUPS server in the cluster"
	echo "-c --counter   N                  N iterations for the loop, the number of shops"
	exit 1
}

create_entry_cups() {
    for queue in $QUEUE_NAME1 $QUEUE_NAME2; do
	lpadmin -p ${1}-${queue}@${CLUSTER_HOST1} -E -m drv:///sample.drv/generic.ppd \
		-v "http://${CLUSTER_HOST1}:631/printers/${1}-${queue}"
	lpadmin -p ${1}-${queue}@${CLUSTER_HOST2} -E -m drv:///sample.drv/generic.ppd \
		-v "http://${CLUSTER_HOST2}:631/printers/${1}-${queue}"
    done
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
	    -h1|--host1)
	    CLUSTER_HOST1="$2"
	    shift # past argument
	    ;;
	    -h2|--host2)
	    CLUSTER_HOST2="$2"
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
echo "cluster host 1 = ${CLUSTER_HOST1}"
echo "cluster host 2 = ${CLUSTER_HOST2}"
echo "counter        = ${COUNTER}"

x=1
while [ $x -le $COUNTER ]; do
	# padding zeroes to left
	shop="Tienda-$(printf %04d ${x})"
	create_entry_cups $shop
	x=$(( $x + 1  ))
done

