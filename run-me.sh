#!/bin/bash

set -e

prepare() {
eval $(minikube docker-env)
echo "[INFO]: Logged into the minikube docker environment";

docker build -t acceleration-a  ./acceleration-a
docker build -t acceleration-calc ./acceleration-calc
docker build -t acceleration-dv ./acceleration-dv

echo "[Success]: All images are successfully builded";

runmyapp
}

runmyapp(){
sleep 2s;
echo "[INFO]: Starting the Acceleration Application using Helm";
helm install acceleration-helm
sleep 5s;
echo "[Success]: Acceleration App Deployed";
}
prepare
