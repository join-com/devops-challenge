#!/usr/bin/env bash

set -o errexit

function direnv_hook() {
    direnv allow . && eval "$(direnv export bash)"
}

project_directory=$(pwd)

# build docker images for all 3 microservices with DOCKER_TAG=devops-challenge-local
for d in acceleration-*; do
    echo -n "Building docker image for $d microservice..."

    cd "$project_directory/$d"
    direnv_hook &>/dev/null
    docker-build-node &>/dev/null

    echo " done."
done;

# install all helm charts from helmfile.yaml using helmfile
cd "$project_directory"
helmfile apply
