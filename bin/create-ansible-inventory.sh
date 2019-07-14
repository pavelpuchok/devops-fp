#!/usr/bin/env sh
set -e

ANSIBLE_WORKING_DIR=$1
GOOGLE_PROJECT=$2
GOOGLE_ZONE=$3
WORKSPACE_NAME=$4

jinja2 ${ANSIBLE_WORKING_DIR}/inventory.gcp.yml.j2 -D workspace=${WORKSPACE_NAME} -D project=${GOOGLE_PROJECT} -D zone=${GOOGLE_ZONE} > ${ANSIBLE_WORKING_DIR}/inventory.gcp.yml
