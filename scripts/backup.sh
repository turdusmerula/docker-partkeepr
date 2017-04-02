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

echo "Backup current partkeepr files to $path"

echo "Backup db ..."
mkdir -p ${path}/db
docker exec partkeepr_mysql sh -c 'exec mysqldump --all-databases -upartkeepr -p"partkeepr"' > ${path}/db/dump.sql.tmp

# remove datetime to avoid same backup treated as changed
sed -i -e "s#-- Dump completed on .*##g" ${path}/db/dump.sql.tmp

if [ ! -f ${path}/db/dump.sql ]
then
	cat ${path}/db/dump.sql.tmp > ${path}/db/dump.sql
fi
diff ${path}/db/dump.sql.tmp ${path}/db/dump.sql
if [ "_$(diff ${path}/db/dump.sql.tmp ${path}/db/dump.sql)" != "_" ]
then
	echo "Db changed, new version backuped"
	cat ${path}/db/dump.sql.tmp > ${path}/db/dump.sql
else
	echo "Db not changed, skiped backup"	
fi
rm -f ${path}/db/dump.sql.tmp

echo "Backup data"
mkdir -p ${path}/data
rsync -arv /opt/partkeepr/data/ ${path}/data

