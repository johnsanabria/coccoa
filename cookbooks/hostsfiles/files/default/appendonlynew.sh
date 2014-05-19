#!/bin/bash
if [[ ! $#  == 2 ]]; then
	echo "Provide two filenames: source target"
	exit -1
fi
for i in `cat $1`; do
	grep ${i} $2 >& /dev/null
	if [[ ! $? == 0 ]]; then
		echo ${i} >> $2
	fi
done
