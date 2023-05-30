#### Documentation Referenced in Video

https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/

#### Create POD without any commands or arguments.

##### commands.yaml

```sh
apiVersion: v1
kind: Pod
metadata:
  name: command
spec:
  containers:
  -  image: count
     name: busybox
```
```sh
kubectl apply -f commands.yaml
```
```sh
kubectl get pods
kubectl exec -it command -- bash
```

#### Create POD with Command

Modify the POD contents to the following one.

```sh
apiVersion: v1
kind: Pod
metadata:
  name: command2
spec:
  containers:
  -  image: count
     name: busybox
     command: ["sleep","3600"]
```
```sh
kubectl apply -f commands.yaml
```
```sh
kubectl get pods
kubectl exec -it command2 -- sh
```

#### Create POD with Command and Arguments

Modify the YAML file contents to the following one.

```sh
apiVersion: v1
kind: Pod
metadata:
  name: command3
spec:
  containers:
  -  image: count
     name: busybox
     command: ["sleep"]
     args: ["3600"]
```
```sh
kubectl apply -f commands.yaml
```
```sh
kubectl get pods
```

#### Create POD with Arguments

Modify the YAML file contents to the following one.

```sh
apiVersion: v1
kind: Pod
metadata:
  name: command4
spec:
  containers:
  -  image: count
     name: busybox
     args: ["sleep","3600"]
```
```sh
kubectl apply -f commands.yaml
```
```sh
kubectl get pods
kubectl exec -it command4 -- sh
```
