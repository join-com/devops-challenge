#!/bin/bash
eval $(minikube docker-env)

docker build -t acceleration-a ./acceleration-a
docker build -t acceleration-calc ./acceleration-calc
docker build -t acceleration-dv ./acceleration-dv
