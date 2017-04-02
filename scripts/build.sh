#!/bin/bash

xpl_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

source /usr/local/share/getopt/getopt.sh

getopt_add_help
getopt_set_args "$@" 
getopt_read_args || {
	getopt_usage
	exit 1
}

if [[ ! -f partkeepr-1.2.0.tbz2 ]]
then 
	wget https://downloads.partkeepr.org/partkeepr-1.2.0.tbz2 
	tar -xf partkeepr-1.2.0.tbz2 
	mv partkeepr-1.2.0 apache/partkeepr
fi

docker-compose build