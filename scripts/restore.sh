#!/bin/bash

xpl_path=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

source /usr/local/share/getopt/getopt.sh

getopt_add_param_description "PATH"
getopt_add_help
getopt_set_args "$@"
getopt_allow_custom_command

getopt_read_args
res=$?
[[ $res -ne 2 ]] || [[ ${#getopt_args[@]} -ne 1 ]] && {
	getopt_usage
	exit 1
}

path=${getopt_args[0]}

if [ ! -f ${path}/db/dump.sql ]
then
	echo "$(basename $0): ${path}/db/dump.sql dump file not found" >&2
	exit 1
fi

echo "Restore database ..."
docker exec -i partkeepr_mysql sh -c 'mysql -v -upartkeepr -p"partkeepr"' < ${path}/db/dump.sql

echo "Restore data ..."
mkdir -p /opt/partkeepr/data/
sudo rsync -arv ${path}/data/ /opt/partkeepr/data
