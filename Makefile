# take current branch name if running locally
CI_COMMIT_REF_SLUG ?= $(shell git rev-parse --abbrev-ref HEAD)
# take USER_NAME env as registry url if not specified explicitly
DOCKER_REGISTRY_URL ?= ${USER_NAME}
DOCKER_IMAGE_TAG ?= ${CI_COMMIT_REF_SLUG}

gitlab-images: build-gitlab-images push-gitlab-images

build-gitlab-images: build-gitlab-ansible-image build-gitlab-terraform-image

build-gitlab-ansible-image:
	@echo "*** build - ${DOCKER_REGISTRY_URL}/gitlab-ansible:${DOCKER_IMAGE_TAG} ***"
	docker build -t ${DOCKER_REGISTRY_URL}/gitlab-ansible:${DOCKER_IMAGE_TAG} gitlab/dockerfiles/ansible/

build-gitlab-terraform-image:
	@echo "*** build - ${DOCKER_REGISTRY_URL}/gitlab-terraform:${DOCKER_IMAGE_TAG} ***"
	docker build -t ${DOCKER_REGISTRY_URL}/gitlab-terraform:${DOCKER_IMAGE_TAG} gitlab/dockerfiles/terraform/

push-gitlab-images: push-gitlab-ansible-image push-gitlab-terraform-image

push-gitlab-ansible-image:
	@echo "*** push - ${DOCKER_REGISTRY_URL}/gitlab-ansible:${DOCKER_IMAGE_TAG} ***"
	docker push ${DOCKER_REGISTRY_URL}/gitlab-ansible:${DOCKER_IMAGE_TAG}

push-gitlab-terraform-image:
	@echo "*** push - ${DOCKER_REGISTRY_URL}/gitlab-terraform:${DOCKER_IMAGE_TAG} ***"
	docker push ${DOCKER_REGISTRY_URL}/gitlab-terraform:${DOCKER_IMAGE_TAG}
