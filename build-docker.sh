#!/bin/bash
set -e
DOCKER_REPO=zakare

ACCELERATION_A_VERSION=0.1.0
cd acceleration-a
docker build . -t $DOCKER_REPO/acceleration-a:$ACCELERATION_A_VERSION
cd ..

ACCELERATION_DV_VERSION=0.1.0
cd acceleration-dv
docker build . -t $DOCKER_REPO/acceleration-dv:$ACCELERATION_DV_VERSION
cd ..

ACCELERATION_CALC_VERSION=0.1.0
cd acceleration-calc
docker build . -t $DOCKER_REPO/acceleration-calc:$ACCELERATION_CALC_VERSION
cd ..