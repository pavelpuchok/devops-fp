#!/usr/bin/env sh
set -e
ANSIBLE_WORKING_DIR=$1
ANSIBLE_PRIVATE_KEY_FILE=$2
GOOGLE_PROJECT=$3
BASTION_ZONE=$4
BASTION_INSTANCE_NAME=bastion

BASTION_ADDRESS=$(gcloud compute instances describe ${BASTION_INSTANCE_NAME} --project ${GOOGLE_PROJECT} --zone ${BASTION_ZONE} --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
SSH_CONFIG_FILE=${ANSIBLE_WORKING_DIR}/ssh.conf

echo "Host 10.*
  ProxyJump bastion
  IdentityFile ${ANSIBLE_PRIVATE_KEY_FILE}
  User appuser

Host bastion
  HostName ${BASTION_ADDRESS}
  IdentityFile ${ANSIBLE_PRIVATE_KEY_FILE}
  User appuser
" > ${SSH_CONFIG_FILE}
