#!/bin/bash

#------------ Assign right arguments function ----------#
assign_commandline_arguments() {
  case "${1}" in
    -e|--environment)
      if [[ "${2}" = "prod" ]] || [ "${2}" = "dev" ]; then
        export ENVIRONMENT=${2}
      else
        echo -e "FATAL: Unknown environment: ${2}"
        exit 1
      fi
    ;;
    -h|--help)
      echo -e "Usage:\t./run.sh [-e|--environment] [dev|prod] [docker-build|helm-dry-run|helm-install|helm-purge]"
      exit 0
    ;;
    *)
      echo -e "FATAL: Unknown command-line argument: ${1}"
      echo -e "Please use option -h|--help to get the write syntax"
      exit 1
    ;;
  esac
  case "${3}" in
    docker-build|helm-dry-run|helm-install|helm-purge)
      arg=${3}
      #echo $arg
    ;;
    -h|--help)
      echo -e "Usage:\t./run.sh [-e|--environment] [dev|prod] [docker-build|helm-dry-run|helm-install|helm-purge]"
      exit 0
    ;;
    *)
      echo -e "FATAL: Unknown command-line argument: ${1}"
      echo -e "Please use option -h|--help to get the write syntax"
      exit 1
    ;;
  esac
  if [[  -n "${4}" ]]; then
    echo -e "FATAL: Unknown command-line argument"
    echo -e "Please use option -h|--help to get the write syntax"
    exit 1
  fi
}
#------------------------------------------------#

#-------------- Get the current applications ---------#
get_microservices_names(){
  export apps=(acceleration*)
#  echo "Applications:"
  for app in "${apps[@]}"; do echo -e "\t$app"; done
}
#------------------------------------------------#

main(){

assign_commandline_arguments "$@"
echo ""
echo "###################################################################"
echo "#  #####   ###    ###  #     #         ####    ###    #         # #"
echo "#    #    #   #    #   # #   #       #        #   #   # #     # # #"
echo "#    #   #     #   #   #  #  #      #        #     #  #  #   #  # #"
echo "# #  #    #   #    #   #   # #       #        #   #   #   # #   # #"
echo "#  # #     ###    ###  #     #   #     ####    ###    #    #    # #"
echo "###################################################################"
echo ""
sleep 3
echo "----------------------"
echo "|Environment: $ENVIRONMENT |"
echo "----------------------"
export YARNCMD
if [[ "$ENVIRONMENT" = "prod" ]]; then
  YARNCMD=start
else
  YARNCMD=$ENVIRONMENT
fi

#echo "yarn $YARNCMD"

#get_microservices_names
export microservices=($(get_microservices_names))

for APPLICATION in "${microservices[@]}"; do
  source ./$APPLICATION/.env
  NODE_VERSION=$(cat ./$APPLICATION/.node-version)
  echo ""
  echo "//--------------------------------------------------------------------------------//"
  echo "     Application: $APPLICATION, Port: $WEB_PORT, Node version: $NODE_VERSION"
  echo "//--------------------------------------------------------------------------------//"
  echo ""
  sleep 5
  case "$arg" in\
    docker-build)
      echo "Generate Dockerfile..."
      echo ""
      cp deployment/Dockerfile-template $APPLICATION/Dockerfile
      cp deployment/.dockerignore $APPLICATION/.dockerignore
      sed -i -e "s/NODE_VERSION/$NODE_VERSION/g" $APPLICATION/Dockerfile
      sed -i -e "s/APPLICATION/$APPLICATION/g" $APPLICATION/Dockerfile
      sed -i -e "s/WEB_PORT/$WEB_PORT/g" $APPLICATION/Dockerfile
      sed -i -e "s/YARNCMD/$YARNCMD/g" $APPLICATION/Dockerfile
      echo "Dockerfile: "
      echo "-----------"
      cat $APPLICATION/Dockerfile
      echo "------------------------------------------------"
      sleep 5
      eval $(minikube docker-env)
      docker build -t $APPLICATION ./$APPLICATION
      rm -rf ./$APPLICATION/.dockerignore
      rm -rf ./$APPLICATION/Dockerfile
    ;;
    helm-dry-run)
      helm install --dry-run --debug deployment/$APPLICATION/
    ;;
    helm-install)
      helm install --name $APPLICATION deployment/$APPLICATION/ --namespace join-com
    ;;
    helm-purge)
      helm del --purge $APPLICATION
    ;;
  esac
done
}

main "$@"
