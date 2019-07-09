REG = ${CI_REGISTRY_IMAGE}
TAG = ${CI_COMMIT_REF_SLUG}
UI_DIR = search_engine_ui
UI_BUILDER_IMAGE = ${REG}/ui-builder:${TAG}
UI_RELASE_IMAGE = ${REG}/ui:${TAG}
CRAWLER_DIR = search_engine_crawler
CRAWLER_BUILDER_IMAGE = ${REG}/crawler-builder:${TAG}
CRAWLER_RELASE_IMAGE = ${REG}/crawler:${TAG}

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

