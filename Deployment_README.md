# The Deployment Instructions

## Prerequisites
- [Docker](https://docs.docker.com/install/)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Minikube](https://kubernetes.io/docs/setup/minikube/#installation)
- [Helm](https://helm.sh/docs/using_helm/#installing-helm)
```
# Helm installation
curl -LO https://git.io/get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
rm -rf get_helm.sh

# Configure helm
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
kubectl get clusterrolebinding
helm init --service-account tiller
kubectl -n kube-system get pods

# create cluster-admin role in case it doesn't exists
kubectl create -f deployment/rbac.yml

#enable the ingress
minikube addons enable ingress
```

## Build and deploy the Environment
- Manually:
Please execute the run function script at the root location of the repository "devops-challenge".
It will build all applications docker images and install helm charts.
```
chmod +x run.sh
./run.sh
```
Usage:
```
	./run.sh [-e|--environment] [dev|prod] [docker-build|helm-dry-run|helm-install|helm-purge]
```
- build Docker: `./run.sh -e dev docker-build`
- helm dry-run: `./run.sh -e dev helm-dry-run`
- helm install: `./run.sh -e dev helm-install`
- helm purge: `./run.sh -e dev purge`


## Testing

- Get Minikube IP `minikube ip`
- Please Insert the below line in `/etc/hosts`
```
<Your Minikube IP>     join.local
```
- Browse the URL: `http://join.local/calc?vf=200&vi=5&t=123`
