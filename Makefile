REGISTRY=ghcr.io
PRODUCT=judahrand/edgetpu-device-plugin

default: build

all: clean build samples

.PHONY: build
build:
	docker build -t $(REGISTRY)/$(PRODUCT):amd64 --platform linux/amd64 .

.PHONY: build-arm64
build-arm64:
	docker build -t $(REGISTRY)/$(PRODUCT):arm64 --platform linux/arm64 .

.PHONY: samples
samples:
	$(MAKE) -C samples

.PHONY: samples-arm64
samples-arm64:
	$(MAKE) -C samples build-arm64

.PHONY: clean
clean:
	$(MAKE) -C samples clean
	kubectl delete --ignore-not-found -f edgetpu-device-plugin.yaml

.PHONY: push
push:
	docker push $(REGISTRY)/$(PRODUCT):amd64
	$(MAKE) -C samples push

.PHONY: push-arm64
push-arm64:
	docker push $(REGISTRY)/$(PRODUCT):arm64
	$(MAKE) -C samples push-arm64
