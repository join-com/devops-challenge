#!/usr/bin/env bash

node_tag=8.16.0-alpine
build_tag=1.0.0-alpine
vm_driver=${vm_driver:-virtualbox}
minikube_profile=udkyo
namespace=udkyo
release_name=jackal

services=( a calc dv )

get_platform_info() {
  os=$(uname|tr '[:upper:]' '[:lower:]')
  arch=$(uname -m)
  case $arch in
    armv5*) arch="armv5";;
    armv6*) arch="armv6";;
    armv7*) arch="arm";;
    aarch64) arch="arm64";;
    x86) arch="386";;
    x86_64) arch="amd64";;
    i686) arch="386";;
    i386) arch="386";;
  esac
}

sudo_sedi () {
  if sed --version >/dev/null 2>&1; then
    sudo sed -i -- "$@"
  else
    sudo sed -i "" "$@"
  fi
}

bootstrap() {
  command -v minikube &>/dev/null || (
    printf "Minikube executable not found in path, downloading...\n"
    curl -Lo minikube "https://storage.googleapis.com/minikube/releases/latest/minikube-$os-$arch" && \
    chmod +x minikube && \
    sudo mv minikube /usr/local/bin
  )
  if [ "$vm_driver" = "kvm2" ]; then
    command -v docker-machine-driver-kvm2 &>/dev/null || (
      printf "KVM2 driver not found in path, downloading...\n"
      curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
      && sudo install docker-machine-driver-kvm2 /usr/local/bin/
      rm -f docker-machine-driver-kvm2
    )
  fi
  command -v helm &>/dev/null || (
    printf "Helm executable not found in path, downloading...\n"
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm -f ./get_helm.sh
  )
  printf "Starting minikube...\n"
  minikube start -p "$minikube_profile" --memory 4096 --cpus 2 --vm-driver "$vm_driver"
  printf "Enabling ingress addon...\n"
  minikube -p "$minikube_profile" addons enable ingress
  printf "Initialising helm...\n"
  helm init
}

teardown() {
  minikube status -p "$minikube_profile" &>/dev/null && (
    printf "Deleting minikube VM...\n"
    minikube delete -p "$minikube_profile"
  )
  printf "Purging binaries...\n"
  sudo rm -f /usr/local/bin/{docker-machine-driver-kvm2,minikube,helm,tiller}
}

build_container_images() {
    eval "$(minikube -p $minikube_profile docker-env)"
    sed s/NODE_TAG/$node_tag/ template.Dockerfile > Dockerfile
    for service in "${services[@]}"
    do
      (
      printf "Building container image: acceleration-%s\n" "$service"
      cp Dockerfile "acceleration-$service/"
      cd "acceleration-$service" || exit
      docker build . -t "udkyo/acceleration-$service:$build_tag"
      rm Dockerfile
      )
    done
    rm Dockerfile
}

remove_container_images() {
    for service in "${services[@]}"
    do
        printf "Removing container image: acceleration-%s\n" "$service"
        docker rmi "udkyo/acceleration-$service:$build_tag"
    done
}

deploy_services() {
  if ! command -v helm &>/dev/null; then echo "Helm not found, run with bootstrap first"; exit 1; fi
  if helm ls --all "$release_name" &>/dev/null; then helm del "$release_name" --purge; fi
  echo "Deploying $release_name" 
  helm install  --namespace "$namespace" "." --name "$release_name" --set global.hostname=minikube.test
}

update_hosts_file() {
  printf "Getting ingress IP (may take a minute)...\n"
  while [[ -z "$ingress_ip" ]]
  do
    sleep 5
    ingress_ip=$(minikube -p "$minikube_profile" ip)
  done
  printf "Updating hosts file...\n"
  if grep minikube.test /etc/hosts &>/dev/null; then
    sudo_sedi "s/^.*minikube.test$/$ingress_ip minikube.test/" /etc/hosts
  else
    printf "%s minikube.test" "$ingress_ip" | sudo tee -a /etc/hosts &>/dev/null
  fi
}

test_app() {
  curl "http://minikube.test/calc?vf=200&vi=5&t=123"
  printf "\n"
}

get_platform_info

case "$1" in
"bootstrap")
  bootstrap
  ;;
"teardown")
  teardown
  ;;
"build")
  build_container_images
  ;;
"clean")
  remove_container_images
  ;;
"deploy")
  deploy_services
  update_hosts_file
  ;;
"go")
  bootstrap
  build_container_images
  deploy_services
  update_hosts_file
  ;;
"test")
  test_app
  ;;
*)
  printf "Usage: run.sh [OPTION]\n\n"
  printf "Options:\n"
  printf "  bootstrap    Download binaries, create minikube cluster, install helm\n"
  printf "  build        Build supporting container images\n"
  printf "  deploy       Helm install\n"
  printf "  go           Bootstrap, build containers, deploy services, update hosts file\n"
  printf "  test         curl \"http://minikube.test/calc?vf=200&vi=5&t=123\"\n"
  printf "  clean        Remove container images\n"
  printf "  teardown     Remove minikube cluster\n"
  ;;
esac