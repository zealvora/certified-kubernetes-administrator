
#### Step 1: Create 3 PODS 
```sh
kubectl run pod-1 --image=nginx
kubectl run pod-2 --image=nginx 
kubectl run pod-3 --image=nginx 
```

#### Step 2: Show Labels of POD
```sh
kubectl get pods --show-labels
```

#### Step 3: Label PODS
```sh
kubectl label pod pod-1 env=dev
kubectl label pod pod-2 env=stage
kubectl label pod pod-3 env=prod
```
```sh
kubectl get pods --show-labels
```

#### Step 4: Use Selectors to Filter PODS 
```sh
kubectl get pods -l env=dev
kubectl get pods -l env=dev
kubectl get pods -l env!=dev
```
#### Step 5: Check Available Example using Help command
```sh
kubectl label --help
```

#### Step 6: Remove Label of POD from DEV environement
```sh
kubectl label pod pod-1 env-
```

```sh
kubectl get pods --show-labels
```

#### Step 7: Generate POD Manifest to See Location of Labels
```sh
kubectl run nginx --image=nginx --dry-run=client -o yaml
```
#### Step 8: Add a new Label in POD Manifest
```sh
kubectl run nginx --image=nginx --dry-run=client -o yaml > label-pod.yaml
```
Add a new label of "env=dev" in metadata.labels.

Final output of file

```sh
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
    env: dev
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
```sh
kubectl apply -f label-pod.yaml
```
```sh
kubectl get pods --show-labels
```
#### Step 9: Add Label to ALL PODS
```sh
kubectl label pods --all status=running
```
```sh
kubectl get pods --show-labels
```
#### Step 10: Delete All the PODS
```sh
kubectl delete pods --all
```