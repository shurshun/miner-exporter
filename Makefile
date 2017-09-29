APP=claymore-exporter
TAG=latest

# Metadata about this makefile and position
MKFILE_PATH := $(lastword $(MAKEFILE_LIST))
CURRENT_DIR := $(dir $(realpath $(MKFILE_PATH)))
CURRENT_DIR := $(CURRENT_DIR:/=)

.DEFAULT_GOAL := build

DOCKER_REPO=hub.netbox.ru:5000/mining
MINING_REPO=10.20.0.16:5000/mining

build:
	docker build --compress --force-rm --pull -t "${APP}:${TAG}" .
	docker tag "${APP}:${TAG}" "${DOCKER_REPO}/${APP}:${TAG}"
	docker push "${DOCKER_REPO}/${APP}:${TAG}"

push:
	docker tag "${APP}:${TAG}" "${MINING_REPO}/${APP}:${TAG}"
	docker push "${MINING_REPO}/${APP}:${TAG}"