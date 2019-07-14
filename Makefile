REG = ${CI_REGISTRY_IMAGE}
TAG = ${CI_COMMIT_REF_SLUG}
UI_DIR = src/ui
UI_BUILDER_IMAGE = ${REG}/ui-builder:${TAG}
UI_RELASE_IMAGE = ${REG}/ui:${TAG}
CRAWLER_DIR = src/crawler
CRAWLER_BUILDER_IMAGE = ${REG}/crawler-builder:${TAG}
CRAWLER_RELASE_IMAGE = ${REG}/crawler:${TAG}

TF_WORKING_DIR = infra/terraform
TF_WORKSPACE_TO_SELECT := $(if $(TF_WORKSPACE_TO_SELECT),$(TF_WORKSPACE_TO_SELECT),$(CI_COMMIT_REF_SLUG))
TF_PLAN_FILE = tfplan
TF_VARS_FILE = ${TF_WORKING_DIR}/vars.auto.tfvars

ANSIBLE_WORKING_DIR = infra/ansible
ANSIBLE_VARS_FILE_NAME = vars.auto.yml
ANSIBLE_VARS_FILE = ${ANSIBLE_WORKING_DIR}/${ANSIBLE_VARS_FILE_NAME}
ANSIBLE_EXTRA_ARGS = --extra-vars "@${ANSIBLE_VARS_FILE_NAME}"

build-ui:
	docker build -t ${UI_BUILDER_IMAGE} --target builder ${UI_DIR}
	docker push ${UI_BUILDER_IMAGE}

test-ui:
	docker pull ${UI_BUILDER_IMAGE}
	docker build --target coverage --cache-from ${UI_BUILDER_IMAGE} ${UI_DIR}

release-ui:
	docker pull ${UI_BUILDER_IMAGE}
	docker build -t ${UI_RELASE_IMAGE} --cache-from ${UI_BUILDER_IMAGE} ${UI_DIR}
	docker push ${UI_RELASE_IMAGE}

build-crawler:
	docker build -t ${CRAWLER_BUILDER_IMAGE} --target builder ${CRAWLER_DIR}
	docker push ${CRAWLER_BUILDER_IMAGE}

test-crawler:
	docker pull ${CRAWLER_BUILDER_IMAGE}
	docker build --target coverage --cache-from ${CRAWLER_BUILDER_IMAGE} ${CRAWLER_DIR}

release-crawler:
	docker pull ${CRAWLER_BUILDER_IMAGE}
	docker build -t ${CRAWLER_RELASE_IMAGE} --cache-from ${CRAWLER_BUILDER_IMAGE} ${CRAWLER_DIR}
	docker push ${CRAWLER_RELASE_IMAGE}

infra-vars:
	sh bin/create-terraform-vars.sh\
		${GOOGLE_PROJECT}\
		${GOOGLE_APPLICATION_CREDENTIALS}\
		${GCP_INSTANCE_PUBLIC_KEY}\
		${DOMAIN_NAME}\
		${TF_VARS_FILE}

infra-initialization:
	cd ${TF_WORKING_DIR}; terraform init -input=false

infra-workspace:
	cd ${TF_WORKING_DIR};\
		terraform workspace new ${TF_WORKSPACE_TO_SELECT} || terraform workspace select ${TF_WORKSPACE_TO_SELECT}

infra-validation:
	cd ${TF_WORKING_DIR}; terraform validate

infra-planning:
	cd ${TF_WORKING_DIR}; terraform plan -out ${TF_PLAN_FILE} -input=false

infra-applying:
	cd ${TF_WORKING_DIR}; terraform apply -input=false ${TF_PLAN_FILE}

infra-destroy-planning:
	cd ${TF_WORKING_DIR}; terraform plan -out ${TF_PLAN_FILE} -input=false -destroy

ssh-config:
	sh bin/create-ssh-config.sh ${ANSIBLE_WORKING_DIR} ${GCP_INSTANCE_PRIVATE_KEY} ${GOOGLE_PROJECT}

ansible-vars:
	sh bin/create-ansible-vars.sh \
		${DOMAIN_NAME} \
		${TF_WORKING_DIR} \
		${ANSIBLE_VARS_FILE} \
		${CI_REGISTRY} \
		${CI_REGISTRY_USER} \
		${CI_REGISTRY_PASSWORD} \
		${UI_RELASE_IMAGE} \
		${CRAWLER_RELASE_IMAGE}

ansible-initialization: ssh-config ansible-vars
	pip3 install -r ${ANSIBLE_WORKING_DIR}/requirements.txt
	cd ${ANSIBLE_WORKING_DIR}; ansible-galaxy install -r requirements.yml

provision-docker:
	cd ${ANSIBLE_WORKING_DIR}; GCP_SERVICE_ACCOUNT_FILE=${GOOGLE_APPLICATION_CREDENTIALS} ansible-playbook ${ANSIBLE_EXTRA_ARGS} playbooks/docker.yml

provision-full:
	cd ${ANSIBLE_WORKING_DIR}; GCP_SERVICE_ACCOUNT_FILE=${GOOGLE_APPLICATION_CREDENTIALS} ansible-playbook ${ANSIBLE_EXTRA_ARGS} playbooks/site.yml

deploy:
	cd ${ANSIBLE_WORKING_DIR}; GCP_SERVICE_ACCOUNT_FILE=${GOOGLE_APPLICATION_CREDENTIALS} ansible-playbook ${ANSIBLE_EXTRA_ARGS} playbooks/deploy.yml

gcloud-initialization:
	gcloud auth activate-service-account --key-file ${GOOGLE_APPLICATION_CREDENTIALS}
	gcloud config set project ${GOOGLE_PROJECT}
