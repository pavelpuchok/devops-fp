#!/usr/bin/env sh
set -e
ANSIBLE_WORKING_DIR=$1
DOMAIN_NAME=$2
TF_WORKING_DIR=$3
VARS_FILE=${ANSIBLE_WORKING_DIR}/vars.auto.yml
SWARM_ADDRESS=$(cd ${TF_WORKING_DIR};terraform output swarm_internal_address)

echo "---
domain_name: ${DOMAIN_NAME}
swarm_internal_address: ${SWARM_ADDRESS}
" > ${VARS_FILE}
