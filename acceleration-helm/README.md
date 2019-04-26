# JOIN Coding Challange

The coding challange was completed using minikube with some of the testing done on Docker-for-mac due to issues with the kube-api crashing while using helm.


To run the test please have minikube with the ingress plugin enabled to use the nginx ingress controller.



1. Install minikube 
2. Run the command to enable the ingress controller 
    ```
    minikube addons enable ingress
    ```
3. Run the build images script
    ```
    ./build-images
    ```
    **Note**
    This is only used for local testing on your minikube cluster to allow the docker daemon to have access to the images inside the VM
    
    For Production an image registry should be used in its place

3. Install helm 
4. Run the command below to install tiller required for helm
    ```
     helm init
    ```
    **Note:**
    Please note for production this should be configured to use encryption
5.  Run  Helm install to setup all the requried infratsture 
    ```
     helm install acceleration-helm
    ```
6.  Once the stack is available it will be available on the ip of the minikube cluster
    
    e.g.
    http://192.168.0.11/calc
    
    
    
   