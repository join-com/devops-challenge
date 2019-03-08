root@webserver:/kubernetes-course/helm# more README.md
# Helm

# Install helm

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh

chmod u+x install-helm.sh

./install-helm.sh

# Initialize helm

kubect create -f helm-rbac.yaml
helm init --service-account tiller

