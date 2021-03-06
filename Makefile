.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: docker-login
docker-login: ## Login to docker registry
	./src/scripts/docker-login.sh

.PHONY: docker-build
docker-build: ## Build docker image
	./src/scripts/docker-build.sh

.PHONY: docker-push
docker-push: ## Push docker image to registry
	./src/scripts/docker-push.sh

.PHONY: docker-build-and-push
docker-build-and-push: docker-login docker-build docker-push
