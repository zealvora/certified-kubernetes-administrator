#### Verify Default Service Account In Namespace
```sh
kubectl get serviceaccount
kubectl get sa
kubectl get sa -n kube-system
```
#### Create New Namespace
```sh
kubectl create namespace kplabs-test
```
#### Verify if Default Service Account Gets Created in Namespace
```sh
kubectl get sa -n kplabs-test
```
#### Create New Pod in Newly Created Namespace
```sh
kubectl run nginx-pod -n kplabs-test --image=nginx
kubectl get pods -n kplabs-test
kubectl describe pod nginx-pod -n kplabs-test
```
#### Verify if Mounted Token is Available inside Pod
```sh
kubectl exec -it nginx-pod -n kplabs-test -- bash
cd /var/run/secrets/kubernetes.io/serviceaccount/
ls
cat token
```
