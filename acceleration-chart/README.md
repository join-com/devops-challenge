# Acceleration-chart

This is an acceleration-chart to easy deploy acceleration app to kubernetes cluster

## Prerequisites

* Installed minikube
* Installed helm for minikube

## Init helm

```bash
helm init
```

## Enable ingress for Minikube
```bash
minikube addons enable ingress
```

## Build local images
To build local images for kubernetes run build_containers.sh script from the project root directory. It works only for one shell session so you need to rebuild it for another. 

# Usage

Install helm chart from the project root directory

```bash
helm install --name app  acceleration-chart
```

Get your minikube ip address
```bash
minikube ip
```

The calc method will be avaible on http://${YOUR_MINIKUB_IP{}/calc

Enjoy!
