#!/bin/bash

BRANCH=$(git rev-parse --abbrev-ref HEAD)
VERSION=$(git describe)

if  [ ${BRANCH} = 'master' ]
then
	docker tag ${NAME}:${VERSION} ${NAME}:latest
elif [ ${BRANCH} = 'develop' ]
then
	docker tag ${NAME}:${VERSION} ${NAME}:develop
fi
