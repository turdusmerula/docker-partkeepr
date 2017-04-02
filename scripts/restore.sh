#!/bin/bash

xpl_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

source /usr/local/share/getopt/getopt.sh

getopt_add_help
getopt_set_args "$@" 
getopt_read_args || {
	getopt_usage
	exit 1
}

