
all: images minikube-start minikube-ingress helm-init hosts helm-install test

 images:
	eval $(minikube docker-env)
	cd acceleration-a && docker build -t acceleration-a .
	cd acceleration-calc && docker build -t acceleration-calc .
	cd acceleration-dv && docker build -t acceleration-dv .
	eval "$(docker-machine env -u)"

 minikube-start:
	minikube start

 minikube-ingress:
	minikube addons enable ingress

 helm-init:
	helm init

 helm-install:
	helm upgrade --install join helm/join

 hosts:
	./hosts.sh add acceleration-calc.local

 test:
	sleep 15
	curl 'http://acceleration-calc.local/calc?vf=200&vi=5&t=123' -sSf
