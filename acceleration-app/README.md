minikube addons enable ingress

helm install --name acceleration-dv acceleration-app/charts/acceleration-dv

helm del --purge acceleration-dv

helm install --name acceleration devops-challenge/acceleration-app/

minikube service list
