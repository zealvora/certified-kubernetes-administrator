
#### Step 1: Create Sample POD with Label
```sh
kubectl run lb-pod --labels="type=loadbalanced" --image=nginx
kubectl get pods --show-labels
```
#### Step 2: Create LoadBalancer service
```sh
nano elb-service.yaml
```
```sh
apiVersion: v1
kind: Service
metadata:
  name: kplabs-loadbalancer
spec:
  type: LoadBalancer
  ports:
  - port: 80
    protocol: TCP
  selector:
    type: loadbalanced
```
```sh
kubectl apply -f elb-service.yaml
```
#### Step 3: Verify Service Logs
```sh
kubectl describe service kplabs-loadbalancer
```

#### Step 4: Delete the Resources
```sh
kubectl delete pod lb-pod
kubectl delete -f elb-service.yaml
```
