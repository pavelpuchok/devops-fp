#!/usr/bin/env sh
set -e
DOMAIN_NAME=$1
TF_WORKING_DIR=$2
VARS_FILE=$3
REGISTRY=$4
USERNAME=$5
PASSWORD=$6
TAG=$7
SWARM_ADDRESS=$(cd ${TF_WORKING_DIR};terraform output swarm_internal_address)

echo "---
domain_name: ${DOMAIN_NAME}
swarm_internal_address: ${SWARM_ADDRESS}
docker_registry: ${REGISTRY}
docker_registry_user: ${USERNAME}
docker_registry_password: ${PASSWORD}
ui_image: ${TAG}
crawler_image: ${TAG}
" > ${VARS_FILE}
