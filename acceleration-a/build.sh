#!/usr/bin/env bash
BUILD_TYPE=${1:-build}
CURDIR=${PWD##*/}

NODE_VERSION_DEFAULT=10.14
if [ -e ".node-version" ]; then
   NODE_VERSION=$(cat .node-version)
fi

NODE_VERSION=${NODE_VERSION:-$NODE_VERSION_DEFAULT}

eval "echo \"$(cat Dockerfile.$BUILD_TYPE.template)\" > Dockerfile"
docker build . -t ${CURDIR}-${BUILD_TYPE}
