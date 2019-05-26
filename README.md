
------------------------------------------------------------------------------------------------------------------
# Solution:

Architectural Diagram:
![alt text](Screens/acc-arch.jpg)

This solution tested successfully on Minikube
```bash
minikube version: v1.0.0
```
Steps:

1. Prerequisite

- Minikube Installed on the system (Tested on : v1.0.0).
- Helm Client Installed on the system (Tested on : v2.14.0).

2. Install Tiller.
```bash
helm init
```
3. Run the script run-me.sh
```bash
./run-me.sh
```
4. Result
