#!/bin/bash
if [ "x$1" = "x" ]; then
	echo "needs a configuration file"
	exit -1
fi
if [ ! -f $1 ]; then
	echo "The \"${1}\" file does not exist"
	exit -1
fi
./coccoa.py mpich $1
./coccoa-mpich.py cookbooks/hostsfiles/files/default/hosts attribute.tp
