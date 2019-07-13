REG = ${CI_REGISTRY_IMAGE}
TAG = ${CI_COMMIT_REF_SLUG}
UI_DIR = src/ui
UI_BUILDER_IMAGE = ${REG}/ui-builder:${TAG}
UI_RELASE_IMAGE = ${REG}/ui:${TAG}
CRAWLER_DIR = src/crawler
CRAWLER_BUILDER_IMAGE = ${REG}/crawler-builder:${TAG}
CRAWLER_RELASE_IMAGE = ${REG}/crawler:${TAG}

TF_WORKING_DIR = infra/terraform
TF_WORKSPACE := $(if $(TF_WORKSPACE),$(TF_WORKSPACE),$(CI_COMMIT_REF_SLUG))
TF_PLAN_FILE = tfplan
TF_VARS_FILE = vars.auto.tfvars

ANSIBLE_WORKING_DIR = infra/ansible

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
	sh bin/create-terraform-vars.sh ${GOOGLE_PROJECT} ${GOOGLE_APPLICATION_CREDENTIALS} ${GCP_INSTANCE_PUBLIC_KEY} ${DOMAIN_NAME} ${TF_VARS_FILE}

infra-initialization:
	cd ${TF_WORKING_DIR}; terraform init -input=false

infra-workspace:
	cd ${TF_WORKING_DIR};\
		terraform workspace new ${TF_WORKSPACE} || terraform workspace select ${TF_WORKSPACE}

infra-validation:
	cd ${TF_WORKING_DIR}; terraform validate

infra-planning:
	cd ${TF_WORKING_DIR}; terraform plan -out ${TF_PLAN_FILE} -input=false

infra-applying:
	cd ${TF_WORKING_DIR}; terraform apply -input=false ${TF_PLAN_FILE}

infra-destroy-planning:
	cd ${TF_WORKING_DIR}; terraform plan -out ${TF_PLAN_FILE} -input=false -destroy

ssh-config:
	sh bin/create-ssh-config.sh ${ANSIBLE_WORKING_DIR} ${ANSIBLE_PRIVATE_KEY_FILE} ${TF_WORKING_DIR}

ansible-vars:
	sh bin/create-ansible-vars.sh ${ANSIBLE_WORKING_DIR} ${DOMAIN_NAME} ${TF_WORKING_DIR}

ansible-initialization: ssh_config ansible_vars
	pip install -r ${ANSIBLE_WORKING_DIR}/requirements.txt
	cd ${ANSIBLE_WORKING_DIR}; ansible-galaxy install -r requirements.yml

provision-docker:
	cd ${ANSIBLE_WORKING_DIR}; GCP_SERVICE_ACCOUNT_FILE=${GOOGLE_APPLICATION_CREDENTIALS} ansible-playbook --extra-vars="@vars.auto.yml" playbooks/docker.yml

provision-full:
	cd ${ANSIBLE_WORKING_DIR}; GCP_SERVICE_ACCOUNT_FILE=${GOOGLE_APPLICATION_CREDENTIALS} ansible-playbook --extra-vars="@vars.auto.yml" playbooks/site.yml

