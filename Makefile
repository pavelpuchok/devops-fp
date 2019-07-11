REG = ${CI_REGISTRY_IMAGE}
TAG = ${CI_COMMIT_REF_SLUG}
UI_DIR = search_engine_ui
UI_BUILDER_IMAGE = ${REG}/ui-builder:${TAG}
UI_RELASE_IMAGE = ${REG}/ui:${TAG}
CRAWLER_DIR = search_engine_crawler
CRAWLER_BUILDER_IMAGE = ${REG}/crawler-builder:${TAG}
CRAWLER_RELASE_IMAGE = ${REG}/crawler:${TAG}

TF_WORKING_DIR = infra/terraform
TF_WORKSPACE := $(if $(TF_WORKSPACE),$(TF_WORKSPACE),$(CI_COMMIT_REF_SLUG))
TF_PLAN_FILE = tfplan
TF_VARS_FILE = vars.auto.tfvars

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
	cd ${TF_WORKING_DIR}; echo project_id = \"${GOOGLE_PROJECT}\" >> ${TF_VARS_FILE}
	cd ${TF_WORKING_DIR}; echo credentials = \"${GOOGLE_APPLICATION_CREDENTIALS}\" >> ${TF_VARS_FILE}
	cd ${TF_WORKING_DIR}; echo ssh_key = \"${GCP_INSTANCE_PUBLIC_KEY}\" >> ${TF_VARS_FILE}

infra-initialization:
	cd ${TF_WORKING_DIR}; terraform init -input=false

infra-workspace:
	cd ${TF_WORKING_DIR};\
		terraform workspace new ${TF_WORKSPACE} || terraform workspace select ${TF_WORKSPACE}

infra-validation:
	cd ${TF_WORKING_DIR}; terraform validate -input=false

infra-planning:
	cd ${TF_WORKING_DIR}; terraform plan -out ${TF_PLAN_FILE} -input=false

infra-applying:
	cd ${TF_WORKING_DIR}; terraform apply -input=false ${TF_PLAN_FILE}

