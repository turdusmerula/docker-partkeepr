#!/bin/bash

xpl_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

source /usr/local/share/getopt/getopt.sh

opt_octopart_key=""

getopt_add_help
getopt_add_option "--octopart" "string" "Octopart api key value" opt_octopart
getopt_set_args "$@" 
getopt_read_args || {
	getopt_usage
	exit 1
}

if [[ ! -f partkeepr-1.2.0.tbz2 ]]
then 
	wget https://downloads.partkeepr.org/partkeepr-1.2.0.tbz2 
	tar -xvf partkeepr-1.2.0.tbz2 
	mv partkeepr-1.2.0 ../apache/partkeepr
fi

if [ ! -d /opt/parkeepr/data ]
then
	sudo mkdir -p /opt/parkeepr/data
	sudo chmod -R a+w /opt/parkeepr/data	
fi 

[ ! -f /opt/partkeepr/authkey.php ]   && sudo cp ${xpl_path}/../apache/authkey.php /opt/partkeepr/
[ ! -f /opt/partkeepr/partkeepr.php ] && sudo cp ${xpl_path}/../apache/parameters.php /opt/partkeepr/

if [[ "_$opt_octopart" != "_" ]]
then
	# add octopart api key
	sed -i -e "s#'partkeepr.octopart.apikey', .*#'partkeepr.octopart.apikey', '${opt_octopart}'\);#g" /opt/partkeepr/partkeepr.php
fi

docker-compose up 