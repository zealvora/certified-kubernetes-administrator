### Documentation Referenced:

https://kubernetes.io/docs/concepts/configuration/configmap/#configmap-object

### Step 1 - Create Mutable and Immutable ConfigMap
```sh
nano mutable-cm.yaml
```
```sh
apiVersion: v1
kind: ConfigMap
metadata:
  name: mutable-configmap
data:
  config.properties: |
    APP_MODE=production
    LOG_LEVEL=info
```
```sh
nano immutable-cm.yaml
```
```sh
apiVersion: v1
kind: ConfigMap
metadata:
  name: immutable-configmap
data:
  config.properties: |
    APP_MODE=production
    LOG_LEVEL=info
immutable: true
```

```sh
kubectl create -f mutable-cm.yaml

kubectl create -f immutable-cm.yaml
```

### Step 2 - Edit ConfigMap
```sh
kubectl edit configmap mutable-configmap

kubectl edit configmap immutable-configmap
```

### Step 3 - Create Deployment and Mount Immutable ConfigMap
```sh
nano app-deployment.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  labels:
    app: my-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app-container
          image: nginx
          ports:
            - containerPort: 80
          volumeMounts:
            - name: config-volume
              mountPath: /etc/myapp/config
      volumes:
        - name: config-volume
          configMap:
            name: immutable-configmap
```
```sh
kubectl create -f app-deployment.yaml

kubectl exec -it <my-app> -- bash

cd /etc/myapp/config/

ls

cat config.properties
```

### Step 4 - Workflow of New Changes

```sh
kubectl delete configmap immutable-configmap
```
```sh
nano immutable-v2.yaml
```
```sh
apiVersion: v1
kind: ConfigMap
metadata:
  name: immutable-configmap-v2
immutable: true
data:
  config.properties: |
    APP_MODE=production-V2
    LOG_LEVEL=debug
```
```sh
kubectl apply -f immutable-v2.yaml
```
Edit the Deployment to reflect new ConfigMap
```sh
kubectl edit deployment my-app
```
Find this part:
```sh
configMap:
  name: immutable-configmap
```
Change it to:
```sh
configMap:
  name: immutable-configmap-v2
```

Verify if new Pods created
```sh
kubectl get pods
```

Verify if new data is reflected in the Pods

```sh
kubectl exec -it <my-app> -- bash

cat /etc/myapp/config/config.properties

cat config.properties
```

### Step 5 - Delete the Setup
```sh
kubectl delete -f mutable-cm.yaml

kubectl delete -f immutable-v2.yaml

kubectl delete -f app-deployment.yaml
```