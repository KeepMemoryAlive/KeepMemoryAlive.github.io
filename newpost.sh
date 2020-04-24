#!/bin/sh

if [ $# -lt 1 ]
then
	echo "usage: $0 filename"
	exit 1
fi
rake new_post[$1];

