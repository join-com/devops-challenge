#!/bin/bash

set -e

eval $(minikube docker-env)
echo "[INFO]: Logged into the minikube docker environment";

docker build -t acceleration-a  ./acceleration-a
docker build -t acceleration-calc ./acceleration-calc
docker build -t acceleration-dv ./acceleration-dv

echo "[Success]: All images are successfully builded";
