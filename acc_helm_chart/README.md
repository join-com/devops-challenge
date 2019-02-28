# Join DevOps Challenge 

## Introduction

Thank you for the opportunity

This repository creates a Helm chart for a microservices application.

## Requirements

You will need to have the following installed

- Docker for building images
- Kubernetes for MAC or minikube 
- Helm
- kubectl

## Running the chart

You can build the docker images locally by running "./build-docker.sh"  or it is already pushed on docker hub 

```bash
# run  if not initialized already 
helm init
# Install the helm
helm install --name <NAME> acc_helm_chart
# Run a script the monitor the app stability that hits calc every 1 sec will print 'e' if request fails or '.' if request retuerns 2xx
./request_calc.sh
```

## Expected outcome

- The helm chart will deploy 6 pods in total ... 2 replicas per app
- Acceleration-calc app is the only one exposed outside kubernetes with loadbalancer accessible on localhost port 80 

## Issue with code

Application `accelrtation-a` and `accelrtation-dv` both have a flag that is activated after a max of 300000 in the best case scenario.

```typescript
setTimeout(() => {
  status.fail = true;
}, Math.random() * 300000);
```

One of the requirements `Make sure the application is stable` the only practical way is to fix code. I choose not to remove it since I am not sure the objective is to edit the typescript code or not.

I configured the probes to bare minimum to try to recover the app as soon as possible. In reality infrastructure should not mask application issues.

