mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

all: clean prepare prod-image dev-image
assemble-prod: clean prod-image
assemble-dev: clean dev-image

clean:
	rm -Rf dist node_modules Dockerfile 

prepare: Dockerfile.build.template
	./build.sh

prod-image: prepare
	./build.sh prod

dev-image: prepare
	./build.sh dev 

.PHONY: clean all prepare
