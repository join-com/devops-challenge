mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir := $(dir $(mkfile_path))

all: clean prepare build-prod-image build-dev-image

clean:
	rm -Rf dist node_modules Dockerfile	

prepare: Dockerfile.build.template
	./build.sh

build-prod-image: prepare
	./build.sh prod

build-dev-image: prepare
	./build.sh dev 

.PHONY: clean all prepare
