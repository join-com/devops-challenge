# Infrastructure Engineer (DevOps) Challenge
## The context
This challenge addresses a web application with a microservice architecture to calculate the acceleration of an object.
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
- Using Helm, write the necessary Kubernetes deployment and service files that can be used to create the full application, running 2 instances of each microservice.
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
- Please return your working solution within 7 days of receiving this challenge

