
### First Use-Case

##### Step 1: Create POD and Service
```sh
kubectl run nginx --image=nginx --port=80
kubectl expose pod nginx --name first-svc --port=80 --target-port=http --type=NodePort

kubectl get svc
kubectl get svc first-svc -o yaml
```

##### Stpe 2: Verify the Connectivity
```sh
kubectl get nodes -o wide

curl <WORKER-NODE-IP>:<NODEPORT>
```

### Second Use-Case

##### Step 1: Create POD and Service
```sh
kubectl run nginx --image=nginx --port=80 --dry-run=client -o yaml > pod_named.yaml
```
Add following contents under spec.containers.ports:

```sh
name: custom-http
```
```sh
kubectl apply -f pod_named.yaml
```
```sh
kubectl expose pod nginx2 --name named-svc --port=80 --target-port=custom-http --type=NodePort
```
##### Stpe 2: Verify the Connectivity
```sh
kubectl get svc
curl <WORKER-NODE-IP>:<NODEPORT>
```
