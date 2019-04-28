# Solution for Infrastructure Engineer (DevOps) Challenge
This solution expects user to have MacOS and latest Docker for Mac version installed because it uses Kubernetes shipped with Docker for Mac.
If you don't have Kubernetes enabled yet - please follow [official instructions](https://docs.docker.com/docker-for-mac/#kubernetes)
on how it can be enabled.

## Install required tools
In order to build docker images for each microservice and deploy them to Kubernetes cluster you need to install the following tools.

### [helm](https://helm.sh)
Install and configure `helm` following instructions [here](https://github.com/helm/helm#install).
If you use [Homebrew](https://brew.sh) then you can just run `brew install kubernetes-helm`.
After helm is successfully installed you need to perform the following steps:
1. Install [helm-diff](https://github.com/databus23/helm-diff) plugin using command `helm plugin install https://github.com/databus23/helm-diff`
1. Init helm and install tiller using command `helm init` 

### [helmfile](https://github.com/roboll/helmfile)
Install and configure `helmfile` following instructions [here](https://github.com/roboll/helmfile#installation).
If you use [Homebrew](https://brew.sh) then you can just run `brew install helmfile`.

### [direnv](https://direnv.net)
`direnv` is a great tool which simplifies development when for example you need to set specific env variables 
or have different versions of cli tools (kubectl, helm, etc.) in different projects.
Install and configure `direnv` following instructions [here](https://direnv.net).
If you use [Homebrew](https://brew.sh) then you can just run `brew install direnv`.
Don't forget to hook it into your shell following instructions in the "Setup" section [here](https://direnv.net). 

## Build and deploy microservices
1. Run `./solution-install.sh` to build all docker containers and install them into local Kubernetes cluster using [helm](https://helm.sh) and [helmfile](https://github.com/roboll/helmfile).
1. Edit your `/etc/hosts` file and add the following lines:
    ```
    127.0.0.1 traefik.k8s
    127.0.0.1 acceleration.k8s
    ```
1. Open http://acceleration.k8s/calc?vf=200&vi=5&t=123 in your browser or run `curl http://acceleration.k8s/calc?vf=200&vi=5&t=123`. 
You can also access traefik dashboard on http://traefik.k8s
