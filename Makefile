SHELL := /bin/bash
VERSION = 1.0

build:
	docker build -t renault-digital/crond:$(VERSION) .
