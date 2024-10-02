REGISTRY=ghcr.io
PRODUCT=judahrand/edgetpu-demo

default: build

.PHONY: build
build:
	docker build -t $(REGISTRY)/$(PRODUCT):amd64 .

.PHONY: run
run:
	kubectl apply -f edgetpu-demo.yaml

.PHONY: clean
clean:
	kubectl delete --ignore-not-found -f edgetpu-demo.yaml

.PHONY: push
push:
	docker push $(REGISTRY)/$(PRODUCT):amd64
