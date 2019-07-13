#!/usr/bin/env sh
set -e
ANSIBLE_WORKING_DIR=$1
ANSIBLE_PRIVATE_KEY_FILE=$2
TF_WORKING_DIR=$3

BASTION_ADDRESS=$(cd ${TF_WORKING_DIR};terraform output bastion_address)
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
