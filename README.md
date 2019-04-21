# Notes
This all was tested with MiniCube on
- macOS 10.14.4
- minikube v1.0.0
- helm client/server v2.13.1

Due to running all with default configuration the calc service is exposed to port 30000. Minicube has proxy interface listening to 192.168.99.100
```bash
curl http://192.168.99.100:30000/calc?vf=200\&vi=5\&t=123
```

I've added the separate operations.sh script that allows to automate the build, deploy and destroy process
```bash
Usage:
	./operations.sh (build|cleanup|stop-compose|start-compose|help)
```
Here is how it looks when installed
```bash
NAME:   devops-challenge
LAST DEPLOYED: Sun Apr 21 11:19:01 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/Deployment
NAME               READY  UP-TO-DATE  AVAILABLE  AGE
acceleration-a     0/2    2           0          0s
acceleration-calc  0/2    2           0          0s
acceleration-dv    0/2    2           0          0s

==> v1/Pod(related)
NAME                                READY  STATUS             RESTARTS  AGE
acceleration-a-57d4f5478b-96z2w     0/1    Pending            0         0s
acceleration-a-57d4f5478b-sp4rs     0/1    ContainerCreating  0         0s
acceleration-calc-5788d7df5d-5gmpw  0/1    ContainerCreating  0         0s
acceleration-calc-5788d7df5d-lg7n2  0/1    Pending            0         0s
acceleration-dv-94c5bf7df-92zlg     0/1    ContainerCreating  0         0s
acceleration-dv-94c5bf7df-tk8nh     0/1    Pending            0         0s

==> v1/Service
NAME               TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)         AGE
acceleration-a     ClusterIP  10.102.224.6   <none>       3002/TCP        0s
acceleration-calc  NodePort   10.111.121.35  <none>       3000:30000/TCP  0s
acceleration-dv    ClusterIP  10.99.24.13    <none>       3001/TCP        0s
```

# Infrastructure Engineer (DevOps) Challenge
![JOIN acceleration](https://github.com/join-com/devops-challenge/raw/master/illustration.png)

## The context
This challenge addresses a web application with a microservice architecture to calculate the [acceleration](http://www.softschools.com/formulas/physics/acceleration_formula/1/) of an object.
## The application
- The application contains 3 microservices
- Each microservice takes care of only one arithmetic operation
- The microservices take inputs from the URL query form and return the result in JSON format
- The microservices are not stable and can stop serving requests
## Services:
- `acceleration-dv` calculates `𝚫v=vf-vi`
```bash
curl http://127.0.0.1:3001/dv?vf=200&vi=5
{"dv":195}
```
- `acceleration-a` calculates `a=𝚫v/t`
```bash
curl http://127.0.0.1:3002/a?dv=200&t=5
{"a":40}
```
- `acceleration-calc` coordinates request to `acceleration-dv` and `acceleration-a` services
```bash
curl http://127.0.0.1:3000/calc?vf=200&vi=5&t=123
{"a":1.5853658536585367}
```

# Task
- Using [Helm](https://helm.sh), write the necessary Kubernetes deployment and service files that can be used to create the full application, running 2 instances of each microservice.
- Only  `/calc` of `acceleration-calc` microservices can be available outside of the kubernetes cluster.
- Run the application on a kubernetes cluster like Minikube or Docker for Mac.
- Make sure the application is stable.

# Environment Setup
- Microservices are written on Typescript and Node.js version 10.14.2
- You would need to setup `yarn`
- Run `yarn install` to setup all required components
- Run `yarn build` to build production ready code
- Run `yarn dev` to run a service in dev environment
- Run `yarn start` to run a service in production

# Instructions
- Fork this repo
- The challenge is on!
- Create a pull request
- Please complete your working solution within 7 days of receiving this challenge, and be sure to notify us when it is ready for review.
