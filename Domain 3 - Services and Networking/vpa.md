### Documentation Referenced:

https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler

### Installing VPA

```sh
git clone https://github.com/kubernetes/autoscaler.git

cd autoscaler/vertical-pod-autoscaler/

./hack/vpa-up.sh

kubectl get vpa
```

### Create Nginx Deployment
```sh
nano nginx-deployment.yaml
```
```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        resources:
          requests:
            cpu: "50m"
            memory: "50Mi"
```

```sh
kubectl create -f nginx-deployment.yaml
```

### Create VPA with updateMode to OFF

```sh
apiVersion: "autoscaling.k8s.io/v1"
kind: VerticalPodAutoscaler
metadata:
  name: nginx-vpa
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind:       Deployment
    name:       nginx-deployment
  updatePolicy:
    updateMode: "Off"
```
```sh
kubectl get vpa

Run this after few minutes

kubectl describe vpa nginx-vpa
```

### Update VPA mode to Auto

Terminal Tab 1
```sh
kubectl get pods -w
```
Terminal Tab 2
```sh
kubectl edit vpa nginx-vpa
```
Modify updateMode from `off` to `Auto`

### Delete the Resources Created
```sh
kubectl delete -f nginx-deployment.yaml

kubectl delete -f vpa.yaml

cd autoscaler/vertical-pod-autoscaler/

./hack/vpa-down.sh
```
