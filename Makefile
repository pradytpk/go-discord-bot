.PHONY: build run logs execute debug

# Get version from constants/constants.go
VERSION := $(shell grep -o 'Version = ".*"' pkg/constants/constants.go | cut -d '"' -f 2)

# Set IMAGE_NAME to the name of the directory containing the Makefile
IMAGE_NAME := $(shell basename `pwd`)
CONTAINER_NAME := $(IMAGE_NAME)-container

build:
	@echo "Building Docker image..."
	@echo "Version: $(VERSION)" # Add this line for debugging
	docker build -t $(IMAGE_NAME):$(VERSION) .

run:
	@echo "Running Docker container..."
	docker run --name $(CONTAINER_NAME) -d $(IMAGE_NAME):$(VERSION)

stop:
	@echo "Stopping Docker container..."
	docker stop $(CONTAINER_NAME) || true

logs:
	@echo "Fetching Docker logs..."
	docker logs -f $(CONTAINER_NAME)

execute: build clean_container run logs

clean_container: stop
	@echo "Cleaning up Docker container..."
	docker rm $(CONTAINER_NAME) || true

clean: clean_container
	@echo "Cleaning up Docker resources..."
	docker rmi $(IMAGE_NAME):$(VERSION) || true

debug:
	@echo "Version: $(VERSION)"
