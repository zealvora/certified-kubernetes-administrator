###  Prerequisite: Create a Client Pod
```sh
kubectl run client --image=curlimages/curl --command -- sleep 3600

kubectl get pod
```

### Step 1: Create a Pod with a named port, and a Service
```sh
kubectl run nginx --image=nginx --port=80 --dry-run=client -o yaml > pod_named.yaml
```
Edit `pod_named.yaml` and add name: custom-http under `spec.containers.ports`:

```sh
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
      name: custom-http   # <-- add this line
```

Create the Pod:

```sh
kubectl create -f pod_named.yaml

kubectl get pod
```

### Step 2: Create the Service, pointing --target-port at the name of the container port:

```sh
kubectl expose pod nginx --name named-svc --port=80 --target-port=custom-http --type=ClusterIP
```

### Step 3: Verify the Connectivity (it should work)
```sh
kubectl get svc named-svc

kubectl describe svc named-svc

kubectl exec client -- curl http://named-svc
```