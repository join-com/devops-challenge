#!/bin/bash
case "$1" in
  build)
    echo "Building all images"
    for f in $(ls |grep accel);do docker build -t $f -f build/$f-dockerfile .;done
    ;;
  cleanup)
    echo "Removing devops-challenge"
    helm del --purge devops-challenge
    echo "Removing images"
    docker rmi $(docker images |grep accel |awk '{print $3}')
    ;;
  helm-install)
    helm install --name devops-challenge devops-challenge/
    ;;
  helm-upgrade)
    helm upgrade devops-challenge devops-challenge/
    ;;
  helm-delete)
    helm del --purge devops-challenge
    ;;
  help)
    echo -e "Usage:\n\t./operations.sh (build|cleanup|helm-install|helm-upgrade|helm-delete|help)"
    ;;
  *)
    echo -e "No arguments specified. Usage:\n\t./operations.sh (build|cleanup|helm-install|helm-upgrade|helm-delete|help)"
    ;;
esac
