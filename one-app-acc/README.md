HOW TO RUN THE APP

1. Install and make sure  Minikube, kubectl, Helm and Tiller installed and properly configured.
2. Assuming that your current work directory contains the cloned repo, run the next command to start a cluster:

helm install --name acceleration devops-challenge/acceleration-app/
Helm int --it fails if resources not sufficient and Kubectl not running 
Swap off and allocate more resources and run kubectl running 
and install Helm
and Initialise Helm  by Helm INIT 
You can check the status of the deployment using this command:
helm status acceleration

To stop and remove the cluster and its resources, run 
helm del --purge acceleration

3. When the cluster is up and running, we should be able to run a HTTP query and calculate an acceleration value. For obtaining the URL, run:
minikube service list

The required value will be an URL for 'acceleration-acceleration-app' record.

Now we can reach this HTTP endpoint and get the result.
