#!/bin/bash

if [[ ! -f partkeepr-1.2.0.tbz2 ]]
then 
	wget https://downloads.partkeepr.org/partkeepr-1.2.0.tbz2 
	tar -xvf partkeepr-1.2.0.tbz2 
	mv partkeepr-1.2.0 apache/partkeepr
fi

if [ ! -d /opt/parkeepr/data ]
then
	sudo mkdir -p /opt/parkeepr/data
	sudo chmod -R a+w /opt/parkeepr/data
fi 

docker-compose up 