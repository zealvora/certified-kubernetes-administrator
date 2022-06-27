#### Documentation Referred:

https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/#creating-a-service-for-an-application-running-in-five-pods



##### pod-expose-port.yaml

```sh
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  -  image: nginx
     name: democontainer
     ports:
       - containerPort: 8080
```
```sh
kubectl apply -f pod-expose-port.yaml
```
```sh
kubectl get pods

kubectl describe pod nginx-pod

kubectl explain pod.spec.containers.ports
```
