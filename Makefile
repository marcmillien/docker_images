image?=example
repository?=marcmillien
tag?=latest

all: help

.PHONY: help
help:
	@echo 'Available targets:'
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@printf '\nAvailable variables:\n'
	@grep -E '^[a-zA-Z_-]+\?=.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = "?="}; {printf "\033[36m%-20s\033[0m default: %s\n", $$1, $$2}'

.PHONY: build
build: ## Build the given image (options: repository, image, tag)
	docker build -t $(repository)/$(image):$(tag) $(image)

.PHONY: new
new: ## Create a new image (options: image)
	cp -r example $(image)

.PHONY: push
push: ## Push the given image (options: repository, image, tag)
	docker push $(repository)/$(image):$(tag)

.PHONY: sh
sh: ## Get a shell on given image (options: repository, image, tag)
	docker run --rm -it --entrypoint /bin/bash $(repository)/$(image):$(tag)

.PHONY: test
test: ## Run tests on given image (options: repository, image)
	REPOSITORY=$(repository) IMAGE=$(image) rspec -c $(image)/spec
	rubocop
