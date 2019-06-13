.PHONY: all
all: build

setup:
IMAGE_NAME = docker.deveng.systems/paas/kitchen-ansible
IMAGE_VERSION = 0.6.0
CURRENT_DIR = $(shell pwd)

test: setup
	docker run --rm \
		-w="/jenkins-master" \
 		-v $(CURRENT_DIR)/:/jenkins-master \
		-v /var/run/docker.sock:/var/run/docker.sock \
		${IMAGE_NAME}:${IMAGE_VERSION}
