Infrastructure Engineer (DevOps) Challenge

#install helm chart provided
helm install --name acceleration-calc acceleration-calc-0.0.1.tgz


#info after helm chart installed on Minikube test environment

root@webserver:/DevOps-join-Challenge/devops-challenge/helm-chart-deploy-app-acceleration/acceleration-calc# helm list
NAME                    REVISION        UPDATED                         STATUS          CHART                   APP VERSION     NAMESPACE
acceleration-calc       1               Fri Mar  8 15:36:39 2019        DEPLOYED        acceleration-calc-0.0.1 1.0             minikube
root@webserver:/DevOps-join-Challenge/devops-challenge/helm-chart-deploy-app-acceleration/acceleration-calc#


root@webserver:/DevOps-join-Challenge/devops-challenge/helm-chart-deploy-app-acceleration# kubectl get pods
NAME                                                  READY   STATUS    RESTARTS   AGE
acceleration-a-77d97db658-bms2r                       1/1     Running   0          2m
acceleration-a-77d97db658-t6q97                       1/1     Running   0          2m
acceleration-calc-acceleration-calc-5f54955dc-5zt9j   1/1     Running   0          2m
acceleration-calc-acceleration-calc-5f54955dc-gt5sq   1/1     Running   0          2m
acceleration-dv-d94cc9bcd-d8qqk                       1/1     Running   0          2m
acceleration-dv-d94cc9bcd-vnnhr                       1/1     Running   0          2m


root@webserver:/DevOps-join-Challenge/devops-challenge/helm-chart-deploy-app-acceleration# kubectl get svc
NAME                                  TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
acceleration-calc-acceleration-a      ClusterIP      10.106.237.110   <none>        3002/TCP       2m
acceleration-calc-acceleration-calc   LoadBalancer   10.102.59.178    <pending>     80:30562/TCP   2m
acceleration-calc-acceleration-dv     ClusterIP      10.106.51.220    <none>        3001/TCP       2m
root@webserver:/DevOps-join-Challenge/devops-challenge/helm-chart-deploy-app-acceleration#

